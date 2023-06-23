Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D673AE16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFWA7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWA7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:59:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33A19B;
        Thu, 22 Jun 2023 17:59:01 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b71cdb47e1so151589a34.2;
        Thu, 22 Jun 2023 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687481941; x=1690073941;
        h=content-transfer-encoding:subject:to:from:cc:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1hqlN2rkk9juOnusJjPLb68UnsZbLK0NrxyxUniwYY=;
        b=ic8UB/LVDfZz5a3iqRDhNzdvSjLTVAmbvb7p/8soxaiR8WWU90I8PPBhPhNOOzy6Ir
         SakFEGsqvGp0efHr5xMt/tKf4elxcskR94HDxop2cUYKHx4zUcYR5/P6GblPUAWB9wW1
         O+1yo/y0nNqINFIXehbSNvIeio/CMUSUkkGAaOGhjVJOW29QTGdvxaVCir+HaTSiniu2
         JVT0b7dctgmayH29UjCohZi+oFERR/KyEE9C3IenWlIaeA+PI3fLU7FPKPdnrasiMEBS
         jGuIwRCZpZUtHm4jjCUGmC6JaO6TyRyq6OSc2xeGZqkbUk3E7UxhmmgvjeLmgGy5WNqc
         omoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687481941; x=1690073941;
        h=content-transfer-encoding:subject:to:from:cc:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e1hqlN2rkk9juOnusJjPLb68UnsZbLK0NrxyxUniwYY=;
        b=Prc75RgE4mXcgFwOCwOis+4Q76wOUcHJlF53PHm+cqf902JaTXUMMZcxp41ucD2IQW
         /ZIKxSgOQYMOfShTgdWXdeqbjQV/3KhetlJz25zuypkrRN+ifFFVaFlpF55Nh06SLcA1
         qUpJlm9mKzghlTqi5YxxzIG46l6qXqvvPvOvMVOi+Q732DAY8hUnmujyxFCtUbRBiJDu
         Ccs1cWBswIbIFdxUSjAIwmH6z7iMkYm/pYYdDGaPsNzQUFOUrI5qqsnUClGO5jtUWy/W
         PWboAWpHoRFM/PKCxp/yANScUOFt3n9EBx302RwzJZo1XG79s0EJhapeZoyKjus+g4ic
         +cRQ==
X-Gm-Message-State: AC+VfDxUhotZ/q3dEMKKa98C+opwsQA14YsFAJaf0EUCVl7vpG6o7h2V
        ROjZrxdmaoRPspQ07J5z4Rs=
X-Google-Smtp-Source: ACHHUZ5fLkgFatdoPlABYG9MXbzy5NTUeg5b0lmG7cUz1fahVQV6eaFY+BeoqqvsiwQiKt3Ha5r5mQ==
X-Received: by 2002:a05:6358:a19:b0:131:ce9c:9971 with SMTP id 25-20020a0563580a1900b00131ce9c9971mr5359795rwa.29.1687481940720;
        Thu, 22 Jun 2023 17:59:00 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a3-20020a62bd03000000b00669c99d05fasm4396470pff.150.2023.06.22.17.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 17:58:59 -0700 (PDT)
Message-ID: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
Date:   Fri, 23 Jun 2023 07:58:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "J. Avila" <elavila@google.com>,
        Vivek Anand <vivekanand754@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Fwd: High cpu usage caused by kernel process when upgraded to linux
 5.19.17 or later
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> kernel process "kworker/events_power_efficient" uses a lot of cpu power (100% on ESXI 6.7, ~30% on ESXI 7.0U3 or later) after upgrading from 5.17.3 to 5.19.17 or later.
> 
> dmesg log:
> [ 2430.973102]  </TASK>
> [ 2430.973131] Sending NMI from CPU 1 to CPUs 0:
> [ 2430.973241] NMI backtrace for cpu 0
> [ 2430.973247] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted 6.3.3 #1
> [ 2430.973254] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [ 2430.973258] Workqueue: events_power_efficient htable_gc [xt_hashlimit]
> [ 2430.973275] RIP: 0010:preempt_count_sub+0x2e/0xa0
> [ 2430.973289] Code: 36 01 85 c9 75 1b 65 8b 15 a7 da f8 5e 89 d1 81 e1 ff ff ff 7f 39 f9 7c 16 81 ff fe 00 00 00 76 3b f7 df 65 01 3d 8a da f8 5e <c3> cc cc cc cc e8 98 aa 25 00 85 c0 74 f2 8b 15 da 71 ed 00 85 d2
> [ 2430.973294] RSP: 0018:ffffb15ec00dbe58 EFLAGS: 00000297
> [ 2430.973299] RAX: 0000000000000000 RBX: ffffb15ec12ad000 RCX: 0000000000000001
> [ 2430.973302] RDX: 0000000080000001 RSI: ffffffffa1c3313b RDI: 00000000ffffffff
> [ 2430.973306] RBP: dead000000000122 R08: 0000000000000010 R09: 0000746e65696369
> [ 2430.973309] R10: 8080808080808080 R11: 0000000000000018 R12: 0000000000000000
> [ 2430.973312] R13: 0000000000001e2b R14: ffffb15ec12ad048 R15: ffff91c279c26a05
> [ 2430.973316] FS:  0000000000000000(0000) GS:ffff91c279c00000(0000) knlGS:0000000000000000
> [ 2430.973320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2430.973324] CR2: 000055fc138890e0 CR3: 000000010810e002 CR4: 00000000001706f0
> [ 2430.973374] Call Trace:
> [ 2430.973388]  <TASK>
> [ 2430.973390]  __local_bh_enable_ip+0x32/0x70
> [ 2430.973413]  htable_selective_cleanup+0x95/0xc0 [xt_hashlimit]
> [ 2430.973428]  htable_gc+0xf/0x30 [xt_hashlimit]
> [ 2430.973440]  process_one_work+0x1d4/0x360
> [ 2430.973459]  ? process_one_work+0x360/0x360
> [ 2430.973467]  worker_thread+0x25/0x3b0
> [ 2430.973476]  ? process_one_work+0x360/0x360
> [ 2430.973483]  kthread+0xe1/0x110
> [ 2430.973499]  ? kthread_complete_and_exit+0x20/0x20
> [ 2430.973507]  ret_from_fork+0x1f/0x30
> [ 2430.973526]  </TASK>

See Bugzilla for the full thread and perf output.

Anyway, I'm tracking it in regzbot so that it doesn't fall through
cracks unnoticed:

#regzbot introduced: v5.17.3..v5.19.17 https://bugzilla.kernel.org/show_bug.cgi?id=217586
#regzbot title: kworker/events_power_efficient utilizes full CPU power after kernel upgrade

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217586

-- 
An old man doll... just what I always wanted! - Clara
