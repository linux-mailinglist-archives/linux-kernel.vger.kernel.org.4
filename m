Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71C63112A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiKSV5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 16:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 16:57:06 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D13413DCF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 13:57:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f27so20948149eje.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCHWnQkSs4Di/+CXVPDPn8BsM5Kr0cTS9QYcmB5PgoA=;
        b=SgeYC/KWjX8dd+w3D1VJagy/+AaJ7DVLowkRzrjrd11LlVpvDyvv95oLffCro5wQru
         97MIzf7jq9oR2WjAlPz0L1MA3w9gWlQz6TEFh/HXo7/l05DrILkt2WrwLTsrAfSpfMpS
         KCdl0EKkiCmXzaeKK5EU99NWwS26ESsLB0bFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCHWnQkSs4Di/+CXVPDPn8BsM5Kr0cTS9QYcmB5PgoA=;
        b=U0Rjtl8dCyopOgRU99K5Dg5FPoQCB4P2F120pY6ibWd8UMhTKz/dop64YBcYvJFd9I
         NiANP6eNWW11tTzLnmO8bZqm294odQXnPXbyEi/s/tBcCmUjSlPRZrj0OJBGKgph2BpK
         cSE1QYO8NNHvXoJiUnlbcFhT2fmld+gbl3Xl61MiS/DmlF61e4MFaBOo1xcI/jJ2/p1x
         yohIg4tTk1ar4YmPFcloG3I5xmVZCxQ5RrGpwHPELsoAGp86MPGFAP7geqCc4Gyuw4Jv
         sN1U42Isu88ImSmvCiiKKRUVFmXaS5PTyfvOrl82HlgS6V9WuIuBYeGY6YxZ126RvdNv
         C1rw==
X-Gm-Message-State: ANoB5plRUEFXuZgvX+9ifVWiQFkTXt4XKo7dEuqHn9CGG5lZiY3Hr6+Z
        rPRr78aDDNF5d6lAoa+bPpKfrQ==
X-Google-Smtp-Source: AA0mqf4Z0do8zSYV/hSHogE+vrYfVXt350sBuNMnNmBTmQfcCr5tb7VgXLTwL+mKkrXN7bVWS2MUSg==
X-Received: by 2002:a17:906:fa19:b0:78d:9002:fe3b with SMTP id lo25-20020a170906fa1900b0078d9002fe3bmr6946055ejb.769.1668895024021;
        Sat, 19 Nov 2022 13:57:04 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id b15-20020a170906660f00b007815ca7ae57sm3304087ejp.212.2022.11.19.13.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 13:57:03 -0800 (PST)
Message-ID: <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk>
Date:   Sat, 19 Nov 2022 22:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US, da
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <CAOMZO5BPtEU6VCZXRk5FTHXDad6cegF=+oHTTA0wgjBuoh9-rQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAOMZO5BPtEU6VCZXRk5FTHXDad6cegF=+oHTTA0wgjBuoh9-rQ@mail.gmail.com>
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

On 19/11/2022 22.38, Fabio Estevam wrote:
> On Wed, Sep 28, 2022 at 9:41 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> We have an imx8mp-based board with an external gpio-triggered
>> watchdog. Currently, we don't get to handle that in time before it
>> resets the board.
>>
>> The probe of the watchdog device gets deferred because the SOC's GPIO
>> controller is not yet ready, and the probe of that in turn gets deferred
>> because its clock provider (namely, this driver) is not yet
>> ready. Altogether, the watchdog does not get handled until the late
>> initcall deferred_probe_initcall has made sure all leftover devices
>> have been probed, and that's way too late.
>>
>> Aside from being necessary for our board, this also reduces total boot
>> time because fewer device probes get deferred.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> It would probably be reasonable to do the same to the other imx8m* clk
>> drivers, but I don't have any such hardware to test on.
> 
> Agreed.
> 
>> +static void __exit imx8mp_clk_exit(void)
>> +{
>> +       platform_driver_unregister(&imx8mp_clk_driver);
>> +}
>> +module_exit(imx8mp_clk_exit);
> 
> Isn't module_exit() unnecessary here, since we pass suppress_bind_attrs = true?

Sorry, I don't follow. Before this patch, the driver also implicitly had
a module_exit() doing exactly this platform_driver_unregister(), it was
just hidden inside the module_platform_driver() macro. And I think
that's necessary if one wants to test that the module can be loaded and
unloaded (I don't think it's ever useful or even possible to have it be
a module on an actual imx8mp board).

For a modular build, this patch changes nothing since all foo_initcall
levels are translated to module_initcall for those. And when the driver
is built-in, the __exit code, both before and after this patch, is
discarded in the final image.

Rasmus

