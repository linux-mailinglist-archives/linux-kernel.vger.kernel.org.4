Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CFA613C61
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiJaRmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJaRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:42:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C519113CFF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:42:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bs21so17026151wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBD58fOU8dXLZw0gU/vFhiLvEwJEGbaxG96W6LE0yWQ=;
        b=DFddqwoKdUK9FiPWro84KHWXNxctg4u0sBQ5fwz4T8ZEHwP3YNl9J0hHY8upp31AiA
         lV4r2INXQUfSRz4zDE4lTuhcZ4DS8axYzPJpvcKEoaDWf8GFpJbzcsXMDI/qiOFsyzdV
         GS0gMt4kjnKnz5I7EFjZODt/hypuOT0cwOlC/mFICA7SDOR3I14QZgt9mjaQeujcHgxC
         i0HOfJ2ufURD3rWCJF7W+7wY765aS1+F+mLngXtA8o79FVF0Yn4TEuZVCkdvaJae4/lV
         Cu1fqms1Sd6zBIJ22vy8f03+RWg8v0fFTOrPNOB3WseIMTjSotENj8LMSEuMfpqkQAjy
         s8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBD58fOU8dXLZw0gU/vFhiLvEwJEGbaxG96W6LE0yWQ=;
        b=i1joR730aGxZRQrkMxEppnhPLilJjWtw8VDxNZJU6xBQnhu1RejGtquMEe7YAWoXjU
         J0caObsmV6/qUp2HQTgHZqQtQa1EDPH8g1U2NdjNGdncGWjeU+u3YkD/Wb2gpLdHfLUB
         gY5VZPaKPxBTCW0pcuarPXDgVL/Vi7NO9VhbRN06j1iXWehKcVsFBOMvCuWebCxodOXb
         ORrStMJSqDI17ZzCHSGmhk9vEUGfWTW14irGfaKzJbuPCK1XGrXwQTCUC28e3hknaqna
         t58IZSsiNEFuZrkHdsz3XDuRQMW/jb1ARJQsLDwBPL5wysE63YfcoiFzSkJKiJam37OU
         ikSQ==
X-Gm-Message-State: ACrzQf1k8miv6t2JyoAIdyHIm3VTbecUwFT4duH82ghedIDO+NKiW+M0
        mpGIJKQpfWaohowHuZa3dYLgVw==
X-Google-Smtp-Source: AMsMyM445eUR2UuTOs0wCe7zoEzp750QBgbl7ZjXyGKXWlj9ASz4sIx6ORMSuR/+TaFi777WdjBRcg==
X-Received: by 2002:a5d:5643:0:b0:236:699c:6cd8 with SMTP id j3-20020a5d5643000000b00236699c6cd8mr9010504wrw.435.1667238160365;
        Mon, 31 Oct 2022 10:42:40 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g15-20020a05600c4ecf00b003c6f426467fsm8585443wmq.40.2022.10.31.10.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:42:39 -0700 (PDT)
Message-ID: <4cec819c-abd9-a9f8-5874-8394b6902bdb@linaro.org>
Date:   Mon, 31 Oct 2022 17:42:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2022 15:52, Patrick Delaunay wrote:
> 
> This serie update the NVMEM BSEC driver to be compatible with STM32MP13x
> SoC and the trusted application STM32MP BSEC in OP-TEE
> 
> This serie solve issue in initial support of STM32MP131
> (using BSEC STM32MP15 compatible) and so it break the DTS compatible.
> 
> I create this serie for more efficient review.
> 
> The 2 first patches of this series are re-sent of patches already sent
> 
> 1- "dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem"
>      https://lore.kernel.org/all/20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid/
>      https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685403
> 
> 2- "ARM: dts: stm32mp13: fix compatible for BSEC"
>      https://lore.kernel.org/all/20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid/
>      https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685815
> 
> This DTS break is acceptable as
> - the STM32MP13x SoC is not yet available outside STMicroelectronics
>    (not official)
> - the same patch is already integrated or modifications are in progress in
>    the other users (arm-trusted-firmware/TF-A, OP-TEE and U-Boot) of
>    stm32mp131 device tree.
> 
> It is the good time to correct this issue before the real availability of
> the SoC and before full support of SoC in Linux kernel.
> 
> This last patch on NVMEM STM32 ROMEM driver in depend on the preliminary
> patch for the driver:
> 
>    "nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config"
>    https://lore.kernel.org/all/20221017174953.v2.1.I95e71328dd654723bd4c57206bd008ff81c726bb@changeid/
> 
> present in the serie
> 
>    "nvmem: stm32: several minor improvements"
>    https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685886
> 
> Regards
> 
> Patrick
> 
> Changes in v1:
> - update commit message to indicate DTS break reason.
> 
> Patrick Delaunay (3):
>    dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem
>    ARM: dts: stm32mp13: fix compatible for BSEC
>    nvmem: stm32: add OP-TEE support for STM32MP13x

Applied 1/3 and 3/3 thanks,

dts changes need to go via the dts maintainer..

--srini
> 
>   .../bindings/nvmem/st,stm32-romem.yaml        |   1 +
>   arch/arm/boot/dts/stm32mp131.dtsi             |   2 +-
>   drivers/nvmem/stm32-romem.c                   | 450 +++++++++++++++++-
>   3 files changed, 448 insertions(+), 5 deletions(-)
> 
