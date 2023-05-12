Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C936A700851
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbjELMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbjELMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:45:18 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68C1701
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:45:17 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-44fd6524c36so3076316e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683895515; x=1686487515;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEVJBPg36YfGHVd65N+50ADOheZJS8325x8ke0EcSFQ=;
        b=Rka/vwNDjAZcFmepxUZJEm2gmaUqid2ccxZkzhXApRIz/DUJIIT2tZIjUKCmneYsBo
         vpvy3zv+ePa6yqzHD9w1HMAHt8Pj5FFZXtSgpGGjxI0ZY851O4MYXiWkZcpxmX6wqQXz
         mYc1rYbIaYzj+qOnjbg6qeoMnJ3jz34768wwTF9gxu8gC4Vc+aM9DWlKzFf9XEEuLqCi
         KPMbQmsz80S7hjLneO0zM6EzfLRmS0zV+ex/XltsvZyNWDEY9+iNN8K1OUs7EGrixaOE
         vSPoE4NpQbJ/fvSzPlEuCVbciRMj2l6CpjTp/FM9VOL7EgwvOgFjypH2lAvA2jVa456I
         WA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895515; x=1686487515;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEVJBPg36YfGHVd65N+50ADOheZJS8325x8ke0EcSFQ=;
        b=L1RgWCvnug/I7AS3tCbvwkUnjQn1SsXIV03AJvrnWARBzzm4q+gF8D1WBgLb8F3sFQ
         MXte428ey1TUANWAMi6qzasyStTDNSR6nEflfAFs5TpfSFeqeNVV0tY8vNxS1W0M6rPI
         MUlwx+Hoqzo2mXH4vlv0ZN652Qqu0t75+Vcn0em+F+tHde+xJhetMuC7G6FEKeKKvttm
         8EatE5emkHkkxRm8tnBlUOWIbhFQNVkxbI/UNnW/WYz/12+LfN1mvgbMa4yF0HPoKvXM
         G0m2vExvpcVrLOtFveqBdCvjIM1fwl7sFHYaEVpzz/veyng9GGeQO9tz+WcQYKbO0oWm
         pzIw==
X-Gm-Message-State: AC+VfDympRZgh7N16mO+VfErPYijjzWd9IdGn5nggnZCj3EPuINJbdMr
        9EH2X1Y5Nn5jlQAQry1rTmOsFInB7BkR1TZc+S6Yd2YnWjwyjInVsRGFTw==
X-Google-Smtp-Source: ACHHUZ48d5rla9GpWmzSqilWl0jFbiS/LtGjBUbEtNtWXGw4wydsM7nFsR/GMHNx6lWAOHKxapP4uJeNku137M7/SO0=
X-Received: by 2002:a1f:c583:0:b0:436:597e:2c85 with SMTP id
 v125-20020a1fc583000000b00436597e2c85mr363322vkf.2.1683895515382; Fri, 12 May
 2023 05:45:15 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 May 2023 18:15:04 +0530
Message-ID: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
Subject: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744 __alloc_pages+0x2e8/0x3a0
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel warning has been noticed on qemu-arm64 while running kunit
tests while booting Linux 6.4.0-rc1-next-20230512 and It was started from
6.3.0-rc7-next-20230420.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This is always reproducible on qemu-arm64, qemu-arm, qemu-x86 and qemu-i386.
Is this expected warning as a part of kunit tests ?

Crash log:
-----------

[  663.530868]     KTAP version 1
[  663.531545]     # Subtest: Handshake API tests
[  663.533521]     1..11
[  663.534424]         KTAP version 1
[  663.535406]         # Subtest: req_alloc API fuzzing
[  663.542460]         ok 1 handshake_req_alloc NULL proto
[  663.550345]         ok 2 handshake_req_alloc CLASS_NONE
[  663.558041]         ok 3 handshake_req_alloc CLASS_MAX
[  663.565790]         ok 4 handshake_req_alloc no callbacks
[  663.573882]         ok 5 handshake_req_alloc no done callback
[  663.580284] ------------[ cut here ]------------
[  663.582129] WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
__alloc_pages+0x2e8/0x3a0
[  663.585675] Modules linked in:
[  663.587808] CPU: 0 PID: 1200 Comm: kunit_try_catch Tainted: G
          N 6.4.0-rc1-next-20230512 #1
[  663.589817] Hardware name: linux,dummy-virt (DT)
[  663.591426] pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[  663.592978] pc : __alloc_pages+0x2e8/0x3a0
[  663.594236] lr : __kmalloc_large_node+0xbc/0x160
[  663.595548] sp : ffff80000a317bc0
[  663.596577] x29: ffff80000a317bc0 x28: 0000000000000000 x27: 0000000000000000
[  663.598863] x26: ffff0000c8925b20 x25: 0000000000000000 x24: 0000000000000015
[  663.601098] x23: 0000000000040dc0 x22: ffffbf424e7420c8 x21: ffffbf424e7420c8
[  663.603100] x20: 1ffff00001462f88 x19: 0000000000040dc0 x18: 0000000078b4155a
[  663.605582] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  663.607328] x14: 0000000000000000 x13: 6461657268745f68 x12: ffff60001913bc5a
[  663.609355] x11: 1fffe0001913bc59 x10: ffff60001913bc59 x9 : 1fffe0001913bc59
[  663.611004] x8 : 0000000041b58ab3 x7 : ffff700001462f88 x6 : dfff800000000000
[  663.613556] x5 : 00000000f1f1f1f1 x4 : 00000000f2f2f200 x3 : 0000000000000000
[  663.615364] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffbf42516818e2
[  663.617753] Call trace:
[  663.618486]  __alloc_pages+0x2e8/0x3a0
[  663.619613]  __kmalloc_large_node+0xbc/0x160
[  663.621454]  __kmalloc+0x84/0x94
[  663.622551]  handshake_req_alloc+0x74/0xe8
[  663.623801]  handshake_req_alloc_case+0xa0/0x170
[  663.625467]  kunit_try_run_case+0x7c/0x100
[  663.626592]  kunit_generic_run_threadfn_adapter+0x30/0x4c
[  663.628998]  kthread+0x1d4/0x1e4
[  663.629715]  ret_from_fork+0x10/0x20
[  663.631094] ---[ end trace 0000000000000000 ]---
[  663.643101]         ok 6 handshake_req_alloc excessive privsize
[  663.649446]         ok 7 handshake_req_alloc all good
[  663.651032]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
[  663.653941]     ok 1 req_alloc API fuzzing
[  663.665951]     ok 2 req_submit NULL req arg
[  663.674278]     ok 3 req_submit NULL sock arg
[  663.682968]     ok 4 req_submit NULL sock->file
[  663.694323]     ok 5 req_lookup works
[  663.703604]     ok 6 req_submit max pending
[  663.714655]     ok 7 req_submit multiple
[  663.725174]     ok 8 req_cancel before accept
[  663.733780]     ok 9 req_cancel after accept
[  663.742528]     ok 10 req_cancel after done
[  663.750637]     ok 11 req_destroy works
[  663.751884] # Handshake API tests: pass:11 fail:0 skip:0 total:11
[  663.753579] # Totals: pass:17 fail:0 skip:0 total:17

links:
------

 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230512/testrun/16901289/suite/log-parser-boot/test/check-kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230512/testrun/16901289/suite/log-parser-boot/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230420/testrun/16385677/suite/log-parser-boot/test/check-kernel-warning-ac79d2ca0f443d407d9749244f1738c9a2b123c609820f82d9e8907c756f5340/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230512/testrun/16901289/suite/log-parser-boot/test/check-kernel-warning-ac79d2ca0f443d407d9749244f1738c9a2b123c609820f82d9e8907c756f5340/history/


--
Linaro LKFT
https://lkft.linaro.org
