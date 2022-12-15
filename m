Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC564DE16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLOPvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLOPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:51:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC6C2EF3B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:51:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2056781wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2cRcfojGiF9qQEX9U8QFOzZLig/2FAjtxG+CBJEBFo=;
        b=bVgJyDTvQ2d+crPVf0qEjj/SXvuxIZeFKQITUxl2atDfl2hEcbxwgt9LyrHVid2lUS
         uIF78Zw09fK3Za5eMw03H0Tfgf6xXFVAtee5guOt6PU2dIgML8wI/QVuit8Kpmhi6p+1
         7bUZH4srlxGuaBfE+k/GGTcv8bnM0yct37Jn0ECFYZBNGKN+iTW6Ywj/ZylY81SWbP2V
         QpkDpq3+HsdbmHK82gn970aupr7h8L9oJ1NUJJ+/MMGtzIzYOKxxDYdOiBJcCyjpEMpG
         kHPXwZUDFjkvO7DfXHxYcIdZZRWmVCvGHASdRW2D4gDqAFhfKzhuwUguMqzgVE/38a7Y
         bqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2cRcfojGiF9qQEX9U8QFOzZLig/2FAjtxG+CBJEBFo=;
        b=G3uOCbOJ+My+U/XgarNAkUjI4aVUCcF74CJoMXKh1OyAbHSaB3bXf5dvxZ35bmnMy/
         6/kFQywNbWgjUy0/Yg7sNkE7xnRtjFIC4kJPaJXjAoMXohmi6ffu3bXMKcRhwsShY3OD
         NBw7jKr2F3kjCAjczsoN9nzfxRlgC7cNSJ04rt8RyqdqJKsGblocGGGg3ViVQBeHnEtw
         Rug4Gvmnxro5CPhYMS9vGKni1wm5e/20zIgzE8hQ3ln1MX1IplLPs0c2jH9Tn13e2KVz
         TsjyWVn3PnqeBJLSL+ihFbs2fLF+c12uZA5VYBOsXE+EyCVGKT+S1lToPpv43cFGQnsT
         rq4A==
X-Gm-Message-State: ANoB5pkt/uoEyIgfK+O82Kw2sRPB7k1u2Y33JTaP9wXgCSvgz1ajrQWQ
        BtsVwkptaP6DjpI3NADdpKSx7w==
X-Google-Smtp-Source: AA0mqf5T28A1fwwJEdZX35EQu5OSksBT6KKYLBeLzZpR+52DmK8gZxNd3JNVBBNn8gPpdSKSQ71WGQ==
X-Received: by 2002:a05:600c:2101:b0:3cf:e850:4451 with SMTP id u1-20020a05600c210100b003cfe8504451mr22559864wml.9.1671119502537;
        Thu, 15 Dec 2022 07:51:42 -0800 (PST)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003d1e90717ccsm8522883wmq.30.2022.12.15.07.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:51:41 -0800 (PST)
Message-ID: <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
Date:   Thu, 15 Dec 2022 16:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Content-Language: en-US
To:     Wadim Egorov <W.Egorov@phytec.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>
Cc:     "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2022 16:09, Wadim Egorov wrote:
> Hi Jerome,
> 
> is this setup working for you on the AM642 SK board?
> 
> I am testing your PMIC patches on a AM62 based board with a similar setup and
> running into the following error
> 
>      VDDSHV5_SDIO: bypassed regulator has no supply!
>      VDDSHV5_SDIO: will resolve supply early: ldo1
>      VDDSHV5_SDIO: supplied by regulator-dummy
>      VDDSHV5_SDIO: failed to get the current voltage: -EINVAL
> 
> Have you noticed problems with LDO1 and bypass mode?

Wadim,

I did not noticed this on am642 board but IIRC this rail was not used. I 
heard about similar issue reported to me by Nishanth M with a fix 
proposal here:
https://gist.github.com/nmenon/e4dd6ef6afe31bc9750fa6cbee8d3e25

I did not have time yet to investigate on this but will do soon.

Regards,
Jerome
