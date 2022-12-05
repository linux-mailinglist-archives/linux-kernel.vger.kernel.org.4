Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17C64256A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLEJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLEJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:07:29 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81333193F2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:05:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a19so12817758ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqNU7BdzxXArJ1hxutAZbvizBnSeo/vOF+Ym8qXlYBw=;
        b=ml1UTgwnXNIPc0W8ib4GfMRsHG60XL9gSKPj/qRbbV6GJkzlUj1At0dMUzoOFb60iW
         tb6annGiyDBjRt7m54+FeXCJAG1k6zyZpV4PZGuHxYm7VptGQ4HE5z/sdf0nd4XNnbM5
         mqZTLznBvYZ9IvNHoVEltgkurJq2dZTDmC3DBg6SerflSf29uDbJtRwzM6t2VzZKZeKH
         W3Hdrx+z2zDRhEmNvWjcF8C5cjMzT8oFOD2s9Yr7hkx7NoDA25fDHiauNl77Q6m3BHlu
         /XzYeQvCP1vLSSqEuf2R0EKAZk20F6w17K7jjdophOvRCEg7i+u82iAK96sKUi78Hro0
         PT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqNU7BdzxXArJ1hxutAZbvizBnSeo/vOF+Ym8qXlYBw=;
        b=1IZRl63EdOtA+o67nu7UKIUBAHWPZ+6u73THCMm2/MB60723uo1JR7lO/sOQUIgsuF
         mzWfolZcmHVUzF5HLGjVKsHncE0YbCnUr9BmUxKjHAg38oZSsCyHWg+1W1o0MBNy08Nv
         OgOhcyEInattJJjcqATIftX41CapjDS/RXSgKlvcDM4U+Ao8zbumrudOm8OHlWKtSV9I
         QJbZUSLCAAycz2IvO3utjdOZPY77rrstwt3wLHBWKwvT9JXodWVZyMgzCFhxpP5Uhbzq
         dp6xaAui6/HKJAot9Y7vpPZbmu0HAy9WY2zc2/BR69GM94PHFrTGel439FxvFwngznZi
         kWIQ==
X-Gm-Message-State: ANoB5pkHaK02JoY5YTBQ5KpvrxjXLxyoW/dQQzAaGEJ6gVCxSI31AcBD
        LDymPQKN9S4HSYNNOBRo52dEuA==
X-Google-Smtp-Source: AA0mqf70Cu3Bsc7Sg6w1pGgBN0DBMF+g70wtdk9SSpETzjM7LJKRxqb71DhL1ffyntt/+W0ANkRx6A==
X-Received: by 2002:a2e:a881:0:b0:26f:a855:c415 with SMTP id m1-20020a2ea881000000b0026fa855c415mr12377855ljq.443.1670231152713;
        Mon, 05 Dec 2022 01:05:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g22-20020a2eb5d6000000b00267232d0652sm1322528ljn.46.2022.12.05.01.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:05:52 -0800 (PST)
Message-ID: <3e141d37-497b-e9dd-44af-22ec57881b04@linaro.org>
Date:   Mon, 5 Dec 2022 10:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 5/9] dt-bindings: spi: mtk-snfi: Add compatible for
 MT7986
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-6-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205065756.26875-6-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 07:57, Xiangsheng Hou wrote:
> 1. Add dt-bindings documentation of SPI NAND controller
> for MediaTek MT7986 SoC platform.
> 2. Add optional nfi_hclk property which needed for MT7986.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

