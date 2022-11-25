Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713E9638866
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiKYLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKYLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:14:18 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04324958
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:14:15 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d128so4696399ybf.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tR6n285CjGjiEweDZ5Rpr+M2GTjNH/qXmtQMPjMs0+c=;
        b=c99ikx49ox7ps1gMjRcvBxZCxMF1Q2X426RlWzGPErFaS2/JGYC+WE0VtkEkdWIyD6
         z88xRAh6GX2/MFFFdrU6Ihb8gAAup+C6XRg27ULRjJBDkodEII/XjVG/RiC9D9qPFQsn
         TYJN4FgikG1xUO5VRg3yAYazReVLHxnbkkhpUqOFkWSOVPRTjPEMf9rbE+EmvJFajtrD
         FAgnyYlCCjUByqaUwxA9O4HO08lt22EX/hsxJi60T/LmHq4ZbdD59G5mIj8x94D7k+/o
         x0pHSOalKNBHHlMC59N42eRhe9cW2TA57ujHkaQIRcVvJgxofT7gqkd+d9LUWnCIdjbN
         kTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tR6n285CjGjiEweDZ5Rpr+M2GTjNH/qXmtQMPjMs0+c=;
        b=PD4fJmtlAHvO13fmhHMBY4cIrSNaYM7UydaTC+/iTBM7nnUXqvJVJpOeVyX5eZSRFw
         axWzu/3BgZN3hoVo+ZKu6JZ1zBrWPGq9M3QdhDcQKqPg2Dtx56qD4/Vea0Gd0uZdIoh6
         mzyH1cOx8NlJSKRXaYlJgxMsu7RmvmfvPXMoCvEy4S54DTz3o43yHX7HBx+8KtujfUKr
         KmKMntxkYi1ai9CDiyP/O40P5SQSVB0JB+O1Hom6pRaoGopTET2s1xQaH4pDH2tnghoT
         tkA5CYMZIgUroX1/5tvZniG+k+DM6YDbpyRjUHZYaQPA3wKjRXCeEybVJIaeniFqCyRz
         ov3g==
X-Gm-Message-State: ANoB5pm+h7KIVNRXogdXOCUKRqjeBLV4hcOVoMU0gDFqaIwS20KtCl50
        D4pfDLPCIrTIP+OrTVRJZr4X6TKWKusndc84P0PtZg==
X-Google-Smtp-Source: AA0mqf4SbZz4MHCM6eYS/GQWVWxtFtQtXAM37B3lS2YcupS0l9TAFw0bzAoymEKP6IXA6txZtMTI5FJU7IPL9YrcSUw=
X-Received: by 2002:a5b:f0f:0:b0:6d2:5835:301f with SMTP id
 x15-20020a5b0f0f000000b006d25835301fmr25099494ybr.336.1669374853963; Fri, 25
 Nov 2022 03:14:13 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Nov 2022 16:44:02 +0530
Message-ID: <CA+G9fYt9W2h31bSquJ7Jj7jsP=4OEhF9WMB=NwdR2WcavvPusA@mail.gmail.com>
Subject: perf: list of failures from LKFT CI
To:     linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf stat JSON output linter test and few more failed on next-20221125.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on qemu_arm64:
    perf/perf-stat-JSON-output-linter
    perf/perf-stat-CSV-output-linter
    perf/perf-all-PMU-test
    https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221125/testrun/13178580/suite/perf/tests/

Regressions found on qemu_x86_64:
    perf/perf-stat-JSON-output-linter
    perf/Watchpoint-subtest-2
    perf/perf-all-metricgroups-test
    https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221125/testrun/13178612/suite/perf/tests/

Regressions found on x86:
    perf/perf-all-metricgroups-test
    perf/perf-stat-JSON-output-linter
    https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221125/testrun/13181129/suite/perf/tests/

Details of perf test failures.
Good case: Expected output,
Linux next-20221124

 92: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 3067
Checking json output: no args [Success]
Checking json output: system wide [Success]
Checking json output: interval [Success]
Checking json output: event [Success]
Checking json output: per thread [Success]
Checking json output: per node [Success]
Checking json output: system wide Checking json output: system wide no
aggregation [Success]
Checking json output: per core [Success]
Checking json output: per die [Success]
Checking json output: per socket [Success]
test child finished with 0
---- end ----
perf stat JSON output linter: Ok

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221124/testrun/13170208/suite/perf/test/perf-stat-JSON-output-linter/log

Bad case: failed output.
 92: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 2268
Checking json output: no args [   65.101948] audit: type=1701
audit(1669350899.408:21): auid=4294967295 uid=0 gid=0 ses=4294967295
pid=2277 comm=\"perf\" exe=\"/usr/bin/perf\" sig=6 res=1
Test failed for input:
{\"counter-value\" : \"0.531160\", \"unit\" : \"msec\", \"event\" :
\"task-clock\", \"event-runtime\" : 531160, \"pcnt-running\" : 100.00,
\"metric-value\" : 0.425336, \"metric-unit\" : \"CPUs utilized\"}

{\"counter-value\" : \"0.000000\", \"unit\" : \"\", \"event\" :
\"context-switches\", \"event-runtime\" : 531160, \"pcnt-running\" :
100.00, \"metric-value\" : 0.000000, \"metric-unit\" : \"/sec\"}

{\"counter-value\" : \"0.000000\", \"unit\" : \"\", \"event\" :
\"cpu-migrations\", \"event-runtime\" : 531160, \"pcnt-running\" :
100.00, \"metric-value\" : 0.000000, \"metric-unit\" : \"/sec\"}

{\"counter-value\" : \"43.000000\", \"unit\" : \"\", \"event\" :
\"page-faults\", \"event-runtime\" : 531160, \"pcnt-running\" :
100.00, \"metric-value\" : 80.954891, \"metric-unit\" : \"K/sec\"}

{\"counter-value\" : \"1264746.000000\", \"unit\" : \"\", \"event\" :
\"cycles\", \"event-runtime\" : 531160, \"pcnt-running\" : 100.00,
\"metric-value\" : 2.381102, \"metric-unit\" : \"GHz\"}

{\"counter-value\" : \"1711188.000000\", \"unit\" : \"\", \"event\" :
\"instructions\", \"event-runtime\" : 531160, \"pcnt-running\" :
100.00, \"metric-value\" : 1.352989, \"metric-unit\" : \"insn per
cycle\"}

{\"counter-value\" : \"<not supported>\", \"unit\" : \"\", \"event\" :
\"branches\", \"event-runtime\" : 0, \"pcnt-running\" : 100.00, Fatal
error: glibc detected an invalid stdio handle

Traceback (most recent call last):
  File \"/usr/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py\",
line 93, in <module>
    check_json_output(expected_items)
  File \"/usr/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py\",
line 54, in check_json_output
    raise RuntimeError(f'wrong number of fields. counted {count}
expected {expected_items}'
RuntimeError: wrong number of fields. counted 5 expected 6 in
'{\"counter-value\" : \"<not supported>\", \"unit\" : \"\", \"event\"
: \"branches\", \"event-runtime\" : 0, \"pcnt-running\" : 100.00,
Fatal error: glibc detected an invalid stdio handle
'
test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221125/testrun/13178580/suite/perf/test/perf-stat-JSON-output-linter/log

Test results comparison history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221125/testrun/13178580/suite/perf/test/perf-stat-JSON-output-linter/history/

--
Linaro LKFT
https://lkft.linaro.org
