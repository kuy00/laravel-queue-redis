<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Jobs\ProcessCreate;

class TestController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->all();

        ProcessCreate::dispatch($data);

        return 'Job Created';
    }
}
