Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DEC6321FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKUM3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiKUM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:29:34 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59BB845
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id d3so14358069ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9VGbTdcjI69cJd6T5Y29ZL4qR21t3iDewkJqc/IFFM=;
        b=RaIJxLHPHfZLewaejHUmvriS4VxxpBoof7yZWKTrgpjq6Ir/W09iujWKS5p3OiGHS+
         Vx7kc5ntQkhhRmxNIrRjTZk32fghdrZeDHlPDyS1tBCteYLPZ02Cu5G6Tw8zF5htvjwT
         79rZ2t8Ey429gHYI2ahP4bpIXdvn0SprNttDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9VGbTdcjI69cJd6T5Y29ZL4qR21t3iDewkJqc/IFFM=;
        b=miofLql5q3vR2hFsbvKGMc9F0hWQphXESV4Vym8FSG95fvy9WhhgsQLkoMRW/4IdOZ
         poo3O/ToWlJnOt7/0D/TqbUo6hGz9WDYRVxDWgx9n0DqB5LwiQZy7GkBYq1CqTSY86/D
         Qs/WdCrtmclSODW4WOpaywchMD4t4mzfWAp+YptDAchxvBlp/oUFAG/af9wBDkPnwHot
         6K2DrlrLFLLAoZCP8zYYRUJfAVFezgjgW5OwDn99BIfG3a3vfdI/Uuq8K2fH/nQCdpG0
         uS0Mcd6xnkmFNtfAKQOD5QRZqIW5AYvlzHxF5bSF7TPfYmIxQuEDJxqRotfqRDcgBuI+
         HWzA==
X-Gm-Message-State: ANoB5pkEc2aBROcjLzCXjevXCU8qVQ78w/v6786gD5J2Et0vgXq7nqZ1
        eH3XqJvqqqN7xZXmzpC8zS1E0g==
X-Google-Smtp-Source: AA0mqf51hj0SKvLVLo/DraL1FBcN281aZZjpuwKu3knVHO3tQJeb/JyG/6HQAU7XsEVZAAM8y9EvRw==
X-Received: by 2002:a2e:bd17:0:b0:277:50a:bd5c with SMTP id n23-20020a2ebd17000000b00277050abd5cmr5622192ljq.6.1669033771111;
        Mon, 21 Nov 2022 04:29:31 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512200f00b004917a30c82bsm2006521lfb.153.2022.11.21.04.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:29:30 -0800 (PST)
Message-ID: <2cb72f22-3e9d-c146-734a-ec0b306bdeb1@rasmusvillemoes.dk>
Date:   Mon, 21 Nov 2022 13:29:29 +0100
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
 <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk>
 <CAOMZO5AXSSkHpeuHNRQ6qkFoe2uiFLVxndz1u7_y7s9cLD9ppw@mail.gmail.com>
 <8cce4dae-c653-515b-1a5d-024986afbabf@rasmusvillemoes.dk>
 <CAOMZO5CpFXjm1a2C01=uiHLjcNSe4MzgLUyfDvK0LCdQ8+KNEw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAOMZO5CpFXjm1a2C01=uiHLjcNSe4MzgLUyfDvK0LCdQ8+KNEw@mail.gmail.com>
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

On 21/11/2022 11.59, Fabio Estevam wrote:
> On Mon, Nov 21, 2022 at 6:44 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> 
>> That doesn't seem to be true. To test, I just built the imx8mq clk
>> driver as a module, and I could certainly both load and unload that on
>> my imx8mp platform. Sure, no "bind" attribute shows up in the
>> /sys/bus/platform/drivers/imx8mq-ccm/ directory, which is exactly what
>> one expects, but the module can be loaded just fine. And since it can be
>> loaded, it should also have a proper __exit call for deregistering the
>> driver on unload.
> 
> You are right. Sorry for the confusion.

Thanks. Does that mean I can keep your R-b for the patch as-is?

Rasmus

