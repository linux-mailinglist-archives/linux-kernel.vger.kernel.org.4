Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544E361FC75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiKGSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiKGSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:00:37 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C200A2AE2F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:56:40 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k19so17501447lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+1OTGPLr40RTs7UQiKVjL95xVhlS4h22/oCSNtX/1s=;
        b=aU0MiPtIi6htieGwjxEs9XgqM7H3DZMLsFQEQ5ILaK9cnWm7AA0OlPjjfs9FJUyyAb
         XMR+qzy3OlpkqNYRpzftvAy53ZvdN020iHfTP42o989KQX3pwIL1AvNMmZ66UMo/q9rz
         SI8GhpW4a1P3ieqAgnNgqpOJcalPmhtAKBGcN2y7PxrlVLG8EzCujicDd8N++ov+jPOD
         CCZlEpLC+1ppX/93RrmaBbB7hlC1MJ4LJStQzpnQf6DcivmKYs0LMyA5EkbXwntmETt5
         y2HqrasmTu7Qve5Cxo/83x/JS3syX+okZyrG97/KjthDdA16+YbVkHO+sHQXB1043m71
         AjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+1OTGPLr40RTs7UQiKVjL95xVhlS4h22/oCSNtX/1s=;
        b=eOtUa771Tr9DW13l/eCz+ImkJwQVH1SJe1ZinblJVxFd6611vdmXg71SLTwvuIQgku
         qYouvMukdSUba/io+sXbCJCANdle5bc0DfVx+vrXqgIjFvzg3seIrCc8W3kRQ6ummu5G
         x3vYpRNMja3jk9G0py5YQJxBDZmDkh0j2fRTJtYWAxMmNJqdfFSCORMrtu1FApYOM+fY
         F3Ew+lyD+jnhdcBdH2NsS5tQuYkCHNppduW+NcS+5OUKmj9J3br8ie7Mv1VbklV7nT4w
         9qdyuundF/fnJchX3gD/2cS8VfiOF3D1sJW8U+fRia1MLw/oK3xXEBP4Sippc7IYo3vK
         u7YQ==
X-Gm-Message-State: ACrzQf1p9F8RP9iGVvzgjXAlPhzDpjrwTZ9OGYCvO8qsrYp86f9v3wqi
        0AFeU77RO5Tx+1J2GjAuKLqHMw==
X-Google-Smtp-Source: AMsMyM5Ix4N+L5Ns3IxsjpyRHGi9QNTdF52sffEooR2p20s0EOBgVLVcq4DxJycHQW0jZt5xmkAJdg==
X-Received: by 2002:a05:651c:516:b0:277:79b9:690a with SMTP id o22-20020a05651c051600b0027779b9690amr8361134ljp.490.1667843798811;
        Mon, 07 Nov 2022 09:56:38 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id cf29-20020a056512281d00b0049496855494sm1352849lfb.104.2022.11.07.09.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:56:37 -0800 (PST)
Message-ID: <186574a8-d2ce-18b7-8e2e-401fc134105d@linaro.org>
Date:   Mon, 7 Nov 2022 18:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 22/23] arm64: dts: Update cache properties for tesla
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
        Chanho Min <chanho.min@lge.com>, Andrew Lunn <andrew@lunn.ch>,
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
        Zhou Peng <eagle.zhou@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>, Li Jun <jun.li@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-23-pierre.gondois@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107155825.1644604-23-pierre.gondois@arm.com>
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

On 07/11/2022 16:57, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).

No. This was applied and subject has wrong prefix.

Trim your CC list because it's impossible to reply (without manually
removing people).

Best regards,
Krzysztof

