Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A761DBA8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKEP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKEP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:29:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8201219F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:29:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so6914881pji.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00DgZK523D85M1Nxb+SV9yF5Q1ORrXLgMLtTtYVrNsc=;
        b=6uxrNprQAkuiiFB+406C419VH5INIIfvNDj+0MqFaUi+WS0bfJgqoBYFjp/BvqcgYs
         3KyAMG4ai1oAeSeRh8JCqJgXSyRgpXYDvxZs23oqTmjeXAQ+F/kpFBwJM4TpnLDwmUvd
         LQ0InLZ6YtKG8mE1LQE4bn5R5gCo00u5byrQZxR8Yl3D4IepfHVRSnL8DH4vewkjmK7j
         MwwQceHcI/j2cCI1vMY1uluMC0+/k2rQuTOHU6XUAoZFTQzSONMW5SMbJhmJFtKCjM2a
         R8ng9u805xB03aqZYObr7HVChXTqa4NGdAifdLG0qDronSPr1muWorpl2u3xbyI+8fjV
         fhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00DgZK523D85M1Nxb+SV9yF5Q1ORrXLgMLtTtYVrNsc=;
        b=C0/LSuvXbBJnGJXXuilGj5nT6pdR/Wd8MJYgP5kIn2cBFwnv6tZhhJwVmJTLVThyoq
         AHHVvgG+nq2ooCWokUsk5MWLDvXjLnaaeESc4byImneb1WknUx1q/B/J9T7tUTr6ylVh
         Rd0kDa0rJXCYdFJ433KraeHq6UbQJEeLba6w5jmNgHv/Gimh7tzRBJGqaFWYkOHqVRfV
         1c1On3h7MZA9Qc/aiBnmNiAadqPyt5GjJb1+kiHa6wxynQHDSdZCnkYeqP9a699X3Adj
         lhYmIzSn1o0SSHUMOfxraw8bmlwhwop9T5o9J6pqtsLH5x+LhCB6ksGMzdwcYtVdB+6M
         ma4w==
X-Gm-Message-State: ACrzQf3slDOL+K4iIEKI1dV4vbAdPGwMCNxAB9IM0iVeHW9mvhlYgxzq
        f9ZtrjOYNNbTYSeKxk4wPe7sPg==
X-Google-Smtp-Source: AMsMyM6JO8zTiT8iMAGyHmnIKor4JTWRni4grNxW7u/NyVE9Y57eH89vTUaZo48S46y07+915pAEXw==
X-Received: by 2002:a17:90a:c691:b0:212:fd5f:1ab8 with SMTP id n17-20020a17090ac69100b00212fd5f1ab8mr58076257pjt.11.1667662161211;
        Sat, 05 Nov 2022 08:29:21 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001754064ac31sm1799451ple.280.2022.11.05.08.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 08:29:20 -0700 (PDT)
Message-ID: <c4ed4e2b-ea79-70e8-2722-137dfa9bbab3@kernel.dk>
Date:   Sat, 5 Nov 2022 09:29:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] io_uring: fix two assignments in if conditions
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>, asml.silence@gmail.com
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        kernel test robot <lkp@intel.com>
References: <20221102082503.32236-1-korantwork@gmail.com>
 <630269a9-29a3-6b75-0a67-449ec36e7e5e@kernel.dk>
 <EF99381C-E842-49AE-A683-B8EABD1612A0@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <EF99381C-E842-49AE-A683-B8EABD1612A0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 8:50 PM, Xinghui Li wrote:
> 
> 
> ?? 2022/11/2 22:19??Jens Axboe?<axboe@kernel.dk> ??:
> 
>>    On 11/2/22 2:25 AM, korantwork@gmail.com wrote:
>>    > From: Xinghui Li <korantli@tencent.com>
>>    > 
>>    > Fixs two error:
>>    > 
>>    > "ERROR: do not use assignment in if condition
>>    > 130: FILE: io_uring/net.c:130:
>>    > +       if (!(issue_flags & IO_URING_F_UNLOCKED) &&
>>    > 
>>    > ERROR: do not use assignment in if condition
>>    > 599: FILE: io_uring/poll.c:599:
>>    > +       } else if (!(issue_flags & IO_URING_F_UNLOCKED) &&"
>>    > reported by checkpatch.pl in net.c and poll.c . 
>>
>>    I'm not super excited about this patch as the previous one
>>    wasn't even compiled? Did you test this one, compile and runtime?
>>
> 
> First of all, I'm really really really SORRY for the last stupid
> warning and my careless. But I did make kernel and install it in my
> device. Also, I did the fio test with polling. However, there is no
> warning be reported by 'make' command. But when I check the patch code
> with 'smatch', I did find that warning. I realized how stupid that
> mistake was.... So, in addition to compiling and installing this
> kernel, I also checked the code using the static analysis tool this
> time. There is no new error or warning.
> "
> make -j64 CHECK="~/workspace/smatch/smatch" C=1
>   DESCEND objtool
>   CALL    scripts/checksyscalls.sh
>   CC      io_uring/net.o
>   CC      io_uring/poll.o
>   CHECK   io_uring/poll.c
> io_uring/poll.c: note: in included file (through io_uring/io_uring.h):
> io_uring/slist.h:138:29: warning: no newline at end of file
>   CHECK   io_uring/net.c
> io_uring/poll.c: note: in included file (through include/trace/events/io_uring.h):
> ./include/linux/io_uring_types.h:151:37: warning: array of flexible structures
> io_uring/net.c: note: in included file (through io_uring/io_uring.h):
> io_uring/slist.h:138:29: warning: no newline at end of file
> io_uring/net.c: note: in included file (through io_uring/io_uring.h):
> ./include/linux/io_uring_types.h:151:37: warning: array of flexible structures
> ...
>   BUILD   arch/x86/boot/bzImage
> Kernel: arch/x86/boot/bzImage is ready  (#10)
> " 
> 
> Again, I am ashamed of the previous mistake. And I totally understand
> if you reject this one.

All good, thanks for doing the due diligence this time around for v2.
I'll get it applied for 6.2, thanks.

-- 
Jens Axboe
