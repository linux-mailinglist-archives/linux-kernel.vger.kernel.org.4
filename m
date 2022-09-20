Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDF5BE7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiITN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiITNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:55:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB786374
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:54:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g20so1888673ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wBzI+FDP/xHbpMc4ZR1RvLoZ+WufA1CKuPKcPQeIWxs=;
        b=jKP4O2Vs5dgzrrV3QjJGsS/tq+4AAw9Cn0UMg7Z6+RT5/S8x55GBEmciQyE2xBxHNl
         cLEOAq+ndnid9UY81L7XfUzwUAOo5jDRyRbeCuYPY4Tm4U3mlu4CWwBBwhg6yjKuY1Jg
         9/naHdgqElN1RZGaH9ErYL6Lbtjo/zvZy/0qP6+HwVfM0DbxeNYkgLTWVFrIGPUwFGrI
         R0bywwdc02ZDYB1rk27nDWXxeczPZ1gBsH9WcfAzC6Ow2y/Kw1wuwAjBfNKDdUDUbFO6
         /1vcUU8n1TN/qwbOJ2Tg1l9doC45MY9Axh2lDP5oq2E16JdYboriwb0t9iRscsBIKRCs
         Z+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wBzI+FDP/xHbpMc4ZR1RvLoZ+WufA1CKuPKcPQeIWxs=;
        b=DS/00dmbTm7rZ3l+Or4f4VpLuw0YA9XWvPc9BI4lzdkg9FyNRTxWQrYqlrDycOZAQ8
         DkkjreBKjBkhItvQIa9KVSYWcezrvr8Kyuvu8rO8DvyrwCZvyuaH9SqRorXxbs7wt063
         Dp2zhpte5V3nJcV9gyotOPBT70iVlRPbwm9PesaC2Qj/7xIhQZ38wo+wD8yk4GAePAgg
         7FFhwZURXJ6LYL4uiDomow+Xt6nicmL0+L4+I5yaA0zOlVXGXTFhVaZDEk4anK41WhTR
         c4to/qLO3rnky5XKeJVi9lmLLFlXHP5uo6YxiIJtXXwDiZCJq6kSBCDtLn5w5jn1F4O7
         PBzQ==
X-Gm-Message-State: ACrzQf3bCyhhmk5TPEAczv+hQNzvkrEdw/BNNxT/epf/YQYDyFwDBB/p
        LYH+AFJowaMyBZpB2TAB972Dlw==
X-Google-Smtp-Source: AMsMyM7qwNQsEBzVzh51pbKzZ073N0bCU/uLTdwj8t+B9IR78GGUWgkfjRPrW7ec6ftreXNBIXP7qw==
X-Received: by 2002:a2e:964b:0:b0:26c:5a42:ed99 with SMTP id z11-20020a2e964b000000b0026c5a42ed99mr1310939ljh.169.1663682071302;
        Tue, 20 Sep 2022 06:54:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u22-20020a05651c131600b0026c4113c150sm8590lja.111.2022.09.20.06.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:54:30 -0700 (PDT)
Message-ID: <18828928-415f-2faa-8069-b4d01fa38fc6@linaro.org>
Date:   Tue, 20 Sep 2022 15:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: task hung in port100_send_cmd_sync
Content-Language: en-US
To:     Rondreis <linhaoguo86@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-nfc@lists.01.org" <linux-nfc@lists.01.org>
References: <CAB7eexL3ac2jxVQ70Q06F6sK9VdwY2aoO=S6OqYu7DTgFMg6tQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAB7eexL3ac2jxVQ70Q06F6sK9VdwY2aoO=S6OqYu7DTgFMg6tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2022 15:22, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> triggered.

Hi,

Thanks for the report.

> 
> HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
> git tree: upstream
> 
> kernel config: https://pastebin.com/raw/xtrgsXP3
> C reproducer: https://pastebin.com/raw/hjSnLzDh
> console output: https://pastebin.com/raw/3ixbVNcR
> 
> Basically, in the c reproducer, we use the gadget module to emulate
> attaching a USB device(vendor id: 0x54c, product id: 0x6c1, with the
> printer function) and executing some simple sequence of system calls.
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
> the trick.
> 
> I would appreciate it if you have any idea how to solve this bug.

You can try to bisect. Or you can build kernel with lockdep and try to
reproduce.

> 
> The crash report is as follows:

It's not a crash, but a blocked task, so there might be deadlock,
incorrect synchronization or some missing cleanup path. Actually quite a
lot could lead to this.

Best regards,
Krzysztof
