Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F388714A51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjE2N1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE2N1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:27:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2B90;
        Mon, 29 May 2023 06:27:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so33986425e9.0;
        Mon, 29 May 2023 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685366865; x=1687958865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CIOFGe7y3rWt6si5E9BP0VcQBh+5HMdpBhv4DRUuO0=;
        b=eCCayJxWUTEimpttr2ZIbM0u+5IGFNEzXBe5ebbmqJZOVQA7YvD5OMZ3XpaGyzpv8D
         QPGqMQo7fTvYkpffVPYW6Nb5WPC255XBC9Hhrbl1TueurluafP1aaMnaP1caBspGYhrp
         ha7p7nl/OLe0NzMUHNa4EyxDreW8AoMDo1c5C8yrtZpyo58+t1HrnJupmB9C0uAK+lvM
         WdvfeiBW4UDeDXgYq8cCD6KOMfKuknVhNEWPkWAwd1Bz/fkmJA5pKPTcFy5l6V5NJR8S
         hcci1Ou6s63JYsKvcWFWyKFl6/Sgtc+r6uEbcV80CwrM9YsvUa0FKoxpCLQEeg6JKbuC
         k5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366865; x=1687958865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CIOFGe7y3rWt6si5E9BP0VcQBh+5HMdpBhv4DRUuO0=;
        b=e1HQAHHlqmifBWXa5ePjmbGpN7X5xu33pf+JxNw01Uw5HRN7DZJH6ZQ1YDY4WYE+Bg
         zwCqOSG8lTOlWNQPBGq61R0V/LMJn8g3cANb6NSO0Dnlz8uASOck0Z+ltq+Wqqz0ABcQ
         8k0Pv5xVESz766/XtEGsQDCNWbst1/1fpKIOl+9bb9GCxhfNckHLtad0+CR64MFiekVq
         ddIH/nM90KjknDMFxPsQAs2C2ebceAmApFF30M1jkPAnO037ayo9aFKJq+q4XNQn7nZZ
         5VkOi/NvX1zyEKYlPwZLtDQbIJTlHx5eICKTpYvovbVrZ/IqZPaMoaI/y6ZPqKX5EXYU
         35/Q==
X-Gm-Message-State: AC+VfDwHOXVRfXzGyKHEHybQwV2PmtWaW3YkBL54AijSESQd3p47lOXZ
        15F/HaN0DK+u4aQh86612Ig=
X-Google-Smtp-Source: ACHHUZ6QGigJaj58LjESMCDN1wlhyA70hT7yuoX/bRK6/8yR/ACx7ZmkK8SgpAOgB3P1CR2icPsNfg==
X-Received: by 2002:a05:600c:208:b0:3f4:271a:8aaf with SMTP id 8-20020a05600c020800b003f4271a8aafmr9529902wmi.38.1685366864884;
        Mon, 29 May 2023 06:27:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n26-20020a7bcbda000000b003f60482024fsm14336309wmi.30.2023.05.29.06.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:27:43 -0700 (PDT)
Message-ID: <b6d2f1cd-1d0c-da86-cef9-38350a2f4d12@gmail.com>
Date:   Mon, 29 May 2023 15:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/6] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC
 Wrapper
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        amergnat@baylibre.com, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 15:12, AngeloGioacchino Del Regno wrote:
> Changes in v3:
>   - Rebased on next-20230412
>   - Changed if branch to switch in pwrap_init() as suggested
>     by Matthias and Alexandre.
> 
> Changes in v2:
>   - Rebased on next-20230323
>   - Changed pwrap.txt addition to new yaml file addition
> 
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support in the PMIC Wrapper for a different PMIC
> topology, which is commonly found on smartphone boards, using one main
> PMIC and one Companion/Sub PMIC, both accessible *only* through the pwrap;
> be aware that this kind of topology is not *specific to* the Helio X10
> SoC, but common across many kinds of MediaTek smartphone oriented SoCs
> and board designs.
> 
> That said, support for the PMIC combo MT6331+MT6332 is provided in this
> series in a form that will be able to initialize the PMICs with crypto
> and DualIO but nothing else: these PMICs are very featureful, so I have
> decided to add this support in more than just one step, as there will
> be multiple patches for multiple different subsystems (..it's a mfd!..).
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> AngeloGioacchino Del Regno (6):
>    dt-bindings: soc: mediatek: pwrap: Add compatible for MT6795 Helio X10
>    soc: mediatek: pwrap: Move PMIC read test sequence in function
>    soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
>    soc: mediatek: mtk-pmic-wrap: Add support for companion PMICs
>    soc: mediatek: mtk-pmic-wrap: Add support for MT6331 w/ MT6332
>      companion
>    soc: mediatek: pwrap: Add support for MT6795 Helio X10
> 
>   .../bindings/soc/mediatek/mediatek,pwrap.yaml |   1 +
>   drivers/soc/mediatek/mtk-pmic-wrap.c          | 292 ++++++++++++++++--
>   2 files changed, 267 insertions(+), 26 deletions(-)
> 

Applied thanks!
