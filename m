Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B971B64EB72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiLPMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPMdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:33:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899AF4AF09;
        Fri, 16 Dec 2022 04:33:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h10so2358392wrx.3;
        Fri, 16 Dec 2022 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mY6hvYGx7u+jk29wg+M7U2/g98Fn1qPUIlj1RP+5vA=;
        b=kJLYLpYrHfoGVjP1cZeR6X2VGPLRZwIe29aHbmv2eFnDizp2j5/Ny8/k3J/Bt2Pipu
         wvPiFlmNVAGuoFb3yHGT2Wm08XDr/n3qVRUq55Ko5SJl3lOfkJC1ijoxJmqaHBHexjhX
         CWnRwhwOaLecC5UmlcJxLonCS9S1AYEj1tuqfdGsc2fKZmdHQ3z+LcvIG3cSBtJXL22B
         9cPrAXx66Dvq9KaOvHQcJFJICYONOAabiOIJzGoL2UrKhtFSe23oQGqaps/vWoyXWvWw
         3kDMGxAtmn8O6YFNvAMds41TyMf69qg1/fkg3pH5yk4HzFjjZXrQFX5sxWdCmBqfDq7u
         si5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mY6hvYGx7u+jk29wg+M7U2/g98Fn1qPUIlj1RP+5vA=;
        b=T61XCZkCo6OOa44MXne8+M67bWTjlA2peeuMvzi+P5TOimEJop/mSWX2awubz6drvD
         jLRwrkU/vqkLrGLEeDsf+HeiUTY4AA3dxvy+sjBbZoUwd3DUqCB/QiExAjI6ho0xZ7xN
         Ndzl3aMS+cf9wwX+ihUbTMTufVIgx50gC2wzvLmj/CoLMpH8UT7F8bCgPkbdevckCoi1
         d0cQoPsFhwrngCjuCFPvtKdEv/eMPn5AjnbbfR5W7aSLHVgNTBATig5iSR2CmZFk0rlh
         bS3Gy1ZX5yclWp75rJYm/4nPgkhixsQ0OwrXdZFs0GH/YYqP6USRp5Zv85Xl/EuGBNdx
         Rgtw==
X-Gm-Message-State: ANoB5pnTC5KtU/boJmB+FFCAZO5wQ+yZs1OHbRwRWrO+CATzM0juP3Zg
        mOSk08zLfZzbT8XwBganOZCHB5nJ9H8=
X-Google-Smtp-Source: AA0mqf55vRtatDTlwaKTgKD5DnqowdBO7bXUP96iLxcg9l1yFDr/VSB+vMbcLVk2+WtfVL7Y+m90xA==
X-Received: by 2002:adf:f645:0:b0:242:1e1f:2d89 with SMTP id x5-20020adff645000000b002421e1f2d89mr19712565wrp.60.1671194009946;
        Fri, 16 Dec 2022 04:33:29 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id ba12-20020a0560001c0c00b002549b649b62sm2213551wrb.50.2022.12.16.04.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:33:28 -0800 (PST)
Message-ID: <5692faa0-6d7e-774f-9d6a-a495b44bdb3e@gmail.com>
Date:   Fri, 16 Dec 2022 13:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Content-Language: en-US
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221207094921.15450-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Whole series applied, thanks!

On 07/12/2022 10:49, Moudy Ho wrote:
> From: mtk18742 <moudy.ho@mediatek.com>
> 
> Changes since v3:
> - Rebase on linux-next
> 
> Changes since v2:
> - Depend on :
>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
> - Split dts settings into two patches based on belonging to MMSYS or MUTEX.
> 
> Changes since v1:
> - Depend on :
>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
> - Add compatible names to VPPSYS0 and VPPSYS1 in MMSYS binding file.
> - Fix VPPSYS's MMSYS and MUTEX dts to pass the dtsb_check.
> - Rename mtk_mmsys_merge_config() and mtk_mmsys_rsz_dcm_config() to
>    mtk_mmsys_vpp_rsz_merge_config() and mtk_mmsys_vpp_rsz_dcm_config().
> - Clean up mtk_mmsys_vpp_rsz_dcm_config().
> - Add a comment to mtk_mutex_write_mod() and clean it up for use in more
>    than 32 mods.
> 
> Hi,
> 
> This series add support for MT8195's two VPPSYS(Video Processor Pipe Subsystem),
> under which there will be corresponding MMSYS and MUTEX settings that
> need to be configured.
> 
> Moudy Ho (2):
>    dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS
>    arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS
> 
> Roy-CW.Yeh (6):
>    dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
>    arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS
>    soc: mediatek: mmsys: add support for MT8195 VPPSYS
>    soc: mediatek: mmsys: add config api for RSZ switching and DCM
>    soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
>    soc: mediatek: mutex: support MT8195 VPPSYS
> 
>   .../bindings/arm/mediatek/mediatek,mmsys.yaml |   5 +-
>   .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  28 +++-
>   drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
>   drivers/soc/mediatek/mtk-mmsys.c              |  64 +++++++++
>   drivers/soc/mediatek/mtk-mmsys.h              |   1 +
>   drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
>   include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
>   include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
>   9 files changed, 274 insertions(+), 12 deletions(-)
> 
