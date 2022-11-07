Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9961F4A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKGNyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKGNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:54:10 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B441CFD9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:54:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d3so16371634ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JE5T0seOQt35vnitPnZ86nKCKhAUPHXiTmRe5O7UgnQ=;
        b=dr4k9KGvIsl2RMvfseVNbi/gfAqp/2XOsCKXmaZe4tuWKF+m23uXi2jPp5va0laZZH
         aVdJuqROMvojn4rbQ7sfTZxAfiqWeLQmAiDhVBKkTKMn6lYqOQcULJgE1qCZCuo0yVkB
         SV0NEWaXGK2u5RWXXk0TbFuGCkNLM6Yzb6wjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JE5T0seOQt35vnitPnZ86nKCKhAUPHXiTmRe5O7UgnQ=;
        b=ul9y/b+WK5SSywuyoiavrBBKurdPvrAWdSfUJd+GTJMswITrWAZAKA7yqbQGHuD0Ju
         VRxHXCTtZyq6FVJ+3nzboEZrBSLIxwMF6WJ5G15meHth4bc6KrYffbw7oIt23nb+oTQh
         m23NgFKABvKJ9qwKRILvEem7Vs2mGAqC89pSYEV8ET1lVbSlSnY1Y0sbbQmnWthnzxUx
         tV46WjGwUdUToQSV9JaC6CKZlx4Cm3aq91YGRvoVRxmUTcDYn6yycQswITcH5tBd10Ez
         KTWZRlryf1YZ4KLsBkgUQSyopW01IR6VHjtB6cDQCexHW4l3yPDk6jnrDgDo4J/hbk1k
         pOTw==
X-Gm-Message-State: ACrzQf3r9bBvm8zrsqoJUbaPk++g0KKwGUuYajO0a/2chU+EHef7+D3z
        KRqF/y2qmpnsScamdQ11W2+MmTEI19lrPizdpdw=
X-Google-Smtp-Source: AMsMyM48rERCdJEUu3F/vG1o670fBnUPEqP/H+Cu9hXSKljLeH7V0SgBpz/OPFioxHLXDQOiyCO7AQ==
X-Received: by 2002:a2e:8ec3:0:b0:277:4b35:d94a with SMTP id e3-20020a2e8ec3000000b002774b35d94amr5039712ljl.21.1667829247131;
        Mon, 07 Nov 2022 05:54:07 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i13-20020a2ea36d000000b00277074c12ddsm1241712ljn.125.2022.11.07.05.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:54:06 -0800 (PST)
Message-ID: <08df1f08-1eea-0ee5-8e7b-6c427aa11d02@rasmusvillemoes.dk>
Date:   Mon, 7 Nov 2022 14:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US, da
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 14.41, Rasmus Villemoes wrote:
> We have an imx8mp-based board with an external gpio-triggered
> watchdog. Currently, we don't get to handle that in time before it
> resets the board.
> 
> The probe of the watchdog device gets deferred because the SOC's GPIO
> controller is not yet ready, and the probe of that in turn gets deferred
> because its clock provider (namely, this driver) is not yet
> ready. Altogether, the watchdog does not get handled until the late
> initcall deferred_probe_initcall has made sure all leftover devices
> have been probed, and that's way too late.
> 
> Aside from being necessary for our board, this also reduces total boot
> time because fewer device probes get deferred.

Please advise on what I need to do in order to make progress here.

Thanks,
Rasmus

