Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F5661FCD4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiKGSIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiKGSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:07:45 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFD2C13E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:03:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s24so17493959ljs.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ir96l+QDjXFux43KwFJhlNV7YT1OSh/8apFuqiZtho=;
        b=nT3CgucQtQ1gVhgea+s6MbSPrlUCSZ6j43gzpB71/IhaN3vIRUyUQg9rFIOQ0EOSOI
         l1p8KXfPEyVrbLHtZU/V0ENKGuD7OmI+eqRCHWED0EpxhpQrOr2ktf7eSoJ7kEhDVEG/
         /VttDUEf6u71RNqAgu4GudNAz+jDgaxFKRVUWIX1Gaax+w43cwBjvhZg0rqSE+RUiNYL
         tC+k2Snids+rFyic656eMYikt5iVJbJujpa4BR9hvfsVPuXxEqNU56ziemfweSeTJ7YY
         r4HHT5C/KL/ROQtuTTbrXmkr8zNarexAeib+Ha6s4u+Wau8hhKauEXzK8HgyEh1HdIhG
         JMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ir96l+QDjXFux43KwFJhlNV7YT1OSh/8apFuqiZtho=;
        b=HEC81NxoV3wjWTFVnLeg9WimB0XpHvuvujHvc0e4JpGovzMk1Y5NEn58OkEJcG2w9G
         gxFgblYwO0ZgJqaaokT39YPxu9ildTzYMx0jzt5E5pEvG2Pa6RsSyK/o7NxPTRlwvLoW
         ftg3+Jl9ihX+ZN6euIYcdv6xw7GJ/3f7550BHNfS+NLq2IWawQwMMzhUVDO1EOVcFzhc
         tbCiwFN/XvBcUeZcSLdZ6lFT66fUz1eyJC7Kcb95eYnAVLiOOZe+2atB60TRd49T0AP8
         TSW8QkdQuCWCD2mvV90xvXm6P3b5c8ejo3+SqjABhqlszdopVg7NTkn8pwJ7qbTv3nNN
         JEyA==
X-Gm-Message-State: ACrzQf0yZAPwsYd5YdnVuXE9BR5H+K31NwLnJAVzxzMAjWysI8PZuZzA
        1xLMw0pbwT82nAJ/eIzDd5+oaA==
X-Google-Smtp-Source: AMsMyM59MymaW14rwcCR//K6Z824DJsWuzy2Lj65+BM7fRjMmwmBrrErq2391fOQILS2QOeD1c70uA==
X-Received: by 2002:a2e:2405:0:b0:277:524c:f83d with SMTP id k5-20020a2e2405000000b00277524cf83dmr5914462ljk.217.1667844232060;
        Mon, 07 Nov 2022 10:03:52 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id z4-20020a056512376400b00499b1873d6dsm1353254lft.269.2022.11.07.10.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:03:51 -0800 (PST)
Message-ID: <e6fbdee5-24b0-ef0f-9cff-1d77220d9d73@linaro.org>
Date:   Mon, 7 Nov 2022 19:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 00/23] Update cache properties for arm64 DTS
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chester Lin <clin@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Ming Qian <ming.qian@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arjun K V <arjun.kv@samsung.com>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107155825.1644604-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 16:56, Pierre Gondois wrote:
> v2:
> - Update/Add patches for missed cache properties requiring to be
>   updated for the following platforns: bcm, amazon, arm, exynos,
>   freescale, marvell, mediatek, nvidia, socinext, tesla, ti.
>   Missed cache properties were detected using Rob Herring's branch:
>   https://github.com/robherring/dt-schema/tree/cache-rework
> - v1 of exynos, tesla were merged.

So you now duplicated the properties... You need to explicitly ask for a
patch to be dropped.

This cannot be sent like this because it is unmanageable.
1. Split the patchset per sub arch:

"Sending of the message failed.
An error occurred while sending mail. The mail server responded:
Your message has too many recipients. For more information regarding
Google's sending limits, please visit:
 https://support.google.com/mail/?p=TooManyRecipientsError
w8-20020ac24428000000b00492ea54beeasm1344368lfl.306 - gsmtp.
 Please check the message recipient "chris.obbard@collabora.com" and try
again."

2. Ask explicitly for dropping already merged patches (I assume they are
incorrect if you send v2 of them).

3. Use subject prefixes matching the subsystem (git log --oneline -- ...).

4. Send such patches only to interested parties, not as part of everything.

Best regards,
Krzysztof

