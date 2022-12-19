Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D020650E80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiLSPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiLSPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:17:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A425FA;
        Mon, 19 Dec 2022 07:17:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h7so8982022wrs.6;
        Mon, 19 Dec 2022 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kBVJI7OvqWZE9hdBUgh4+a/Q7ktxLZDNcwhb2und9c=;
        b=Ha4Z2OcgAoz2LEInTogCsaKCZXddqQ9UB5FOvc9UhBrIGHDQ+2ZkFlrxvRqbLBHoVG
         NmccLpFL/En5rI+fISPTwcZFN9eMKZ5S2Zo7D9q1K4QlgWyK4vUugMwbsdsDbqGa14Ta
         iQ8G98pXSVLw8Pf5KK43NVJ9n88bwAy5E78bjA69YrccGiyC4UBY1fghpGHCNUKGmWN1
         nvyldkhGNW3si3rVVBodXFmPTPmmesJfW0l4L+vdvG5B/BEqHtfHeKabjTIQJeEioZE3
         YvKidXdeZ5Rp4yp4liSNPLApCteIg/8TS/5m9DhsOIhd3JCvE1j9wZQefnOw/PN0XCYn
         hm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kBVJI7OvqWZE9hdBUgh4+a/Q7ktxLZDNcwhb2und9c=;
        b=ubIV1CRse930XBPqO2HEU+Uv0pXSRThQzm0z2xG/Chl1weke6jPc7qxNuoqXi4AbJy
         ZY/efsd8dnddPS4FpVYc7rpflB+jjBCdY+0R/6d/11TSIkab6HfyKgg235djh5v9QWOj
         vJGJNQdwEKlSgKLSiZzoAzrUCEETaDFL/8Kdv/ed/T36/BUAGjqN6UF6cRLZc5HAm/Pv
         5J/RJFw7J9/Ocj2zv7+Ne+/4mYTtalNG/umT971x+f7rLmBeJsWEMO3MbuPWQnQtZMk+
         Kqdj9HMJZvva+DSckrX0KwVy3sUItPjYwI3tmlqlKXJb+VQQxwskR3vsoSnSPc5a7rA7
         n7pQ==
X-Gm-Message-State: ANoB5plvWcJUgAwar6FHf/OCMYEtsigw7FBFIIc/5OrhILjwDXC5VuHx
        L5qlmri6KTSvNNbQIflcKw4=
X-Google-Smtp-Source: AA0mqf5un/vop7IAv+jq6P5DcAumqLb5kyLRJQKNVxLI2D6Ulm6t0jX3E3Lx3H9oWGLLXMV/u53jTw==
X-Received: by 2002:adf:ef42:0:b0:242:647d:9c57 with SMTP id c2-20020adfef42000000b00242647d9c57mr27045971wrp.36.1671463057586;
        Mon, 19 Dec 2022 07:17:37 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b00241c6729c2bsm10231832wru.26.2022.12.19.07.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:17:37 -0800 (PST)
Message-ID: <dba479ea-968f-89eb-fc59-8235cbb2783a@gmail.com>
Date:   Mon, 19 Dec 2022 16:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221207094921.15450-1-moudy.ho@mediatek.com>
 <5692faa0-6d7e-774f-9d6a-a495b44bdb3e@gmail.com>
In-Reply-To: <5692faa0-6d7e-774f-9d6a-a495b44bdb3e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/2022 13:33, Matthias Brugger wrote:
> 
> Whole series applied, thanks!
> 

And now, whole series reverted, please see comment in 1/8.

Regards,
Matthias

> On 07/12/2022 10:49, Moudy Ho wrote:
>> From: mtk18742 <moudy.ho@mediatek.com>
>>
>> Changes since v3:
>> - Rebase on linux-next
>>
>> Changes since v2:
>> - Depend on :
>>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
>> - Split dts settings into two patches based on belonging to MMSYS or MUTEX.
>>
>> Changes since v1:
>> - Depend on :
>>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
>> - Add compatible names to VPPSYS0 and VPPSYS1 in MMSYS binding file.
>> - Fix VPPSYS's MMSYS and MUTEX dts to pass the dtsb_check.
>> - Rename mtk_mmsys_merge_config() and mtk_mmsys_rsz_dcm_config() to
>>    mtk_mmsys_vpp_rsz_merge_config() and mtk_mmsys_vpp_rsz_dcm_config().
>> - Clean up mtk_mmsys_vpp_rsz_dcm_config().
>> - Add a comment to mtk_mutex_write_mod() and clean it up for use in more
>>    than 32 mods.
>>
>> Hi,
>>
>> This series add support for MT8195's two VPPSYS(Video Processor Pipe Subsystem),
>> under which there will be corresponding MMSYS and MUTEX settings that
>> need to be configured.
>>
>> Moudy Ho (2):
>>    dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS
>>    arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS
>>
>> Roy-CW.Yeh (6):
>>    dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
>>    arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS
>>    soc: mediatek: mmsys: add support for MT8195 VPPSYS
>>    soc: mediatek: mmsys: add config api for RSZ switching and DCM
>>    soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
>>    soc: mediatek: mutex: support MT8195 VPPSYS
>>
>>   .../bindings/arm/mediatek/mediatek,mmsys.yaml |   5 +-
>>   .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  28 +++-
>>   drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
>>   drivers/soc/mediatek/mtk-mmsys.c              |  64 +++++++++
>>   drivers/soc/mediatek/mtk-mmsys.h              |   1 +
>>   drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
>>   include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
>>   include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
>>   9 files changed, 274 insertions(+), 12 deletions(-)
>>
