Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8168C5AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBFSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBFSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:23:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BACE298C6;
        Mon,  6 Feb 2023 10:23:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l14so2673889eds.4;
        Mon, 06 Feb 2023 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyC23soTfwOMq0a8LpZaJG0XUTHUqJMLxjJ6KOaCxeI=;
        b=aEqv+a6iAek+Mh7PCPESa9s+6SwMxQM+pTfGfFLfwpk3nSxF3eyyjqsR0IENA6Gd9i
         B7aupdYEeXz9avN23tbuoDGLWH/H+7zHGbI2GH6UGNjlwlUmkw92STPHWW96OBjX58io
         Atbo+MaHimPqLYKdgBLjNFjyedJwvaDGAV88mNZnDJtQ3vM9hsanYFFDXgE8nsD7HqK8
         4vHbCUSzBfSXpyQamGZm9kyQVIEQlJGT0hKPcgJYrnxQNO4ynGKEYe7+PnKpFwX1Evm6
         F1gIUzceEwhQwM/cCTcY6DPQD0yAgfBqe2RQbmfRsi76egKGkqWU8tfKvVXfwlNsmPfo
         6sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyC23soTfwOMq0a8LpZaJG0XUTHUqJMLxjJ6KOaCxeI=;
        b=hUSTq2C6lWzkfWfangIr/J1INSy4Dos9oIvNcuIMOSKjJj4UW3WhNeFPmMvaUUV5ny
         pqQcPaCBbdbPOXqe+f+NrGnUnXqoX6nfsTOCV9yqv+H53XnoLGXoEy007/V2i3Vt44jZ
         2O6ZQcYwIM1eFSDCBjSpJEuLpBiC4pvxHzEDSD+ltfkhdh9o/ksxwIU72v7z7WU6hCSF
         cfyFmZcjyQug9jrdaYbSg6XEjFlutpcAuoA8YVqfAW5AhBq4MLrJdCP58f0j4iXVkM6Z
         Ev3OAaapN/ttfDMiM0q9s24XFV66bHo5jfcs7BlFnVazLV4C5A+cv7WXVSeKzb/pYJa6
         0CjQ==
X-Gm-Message-State: AO0yUKVLERjjsfigP0E4Dss6TUNj3rXf146IBa3EEpgp0ffRPhuARhI5
        6uJ5yxu+dL0reVAjW3+lC+M=
X-Google-Smtp-Source: AK7set/YLDaJsWv/fhKmEQXf6N5FPSdTQmFx20p81QkshxCM1jPONv6g7IJ9w1QtYiONvuux1hR6UA==
X-Received: by 2002:a50:9b1c:0:b0:4aa:a172:6616 with SMTP id o28-20020a509b1c000000b004aaa1726616mr502027edi.24.1675707821725;
        Mon, 06 Feb 2023 10:23:41 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709061ed300b0088ed7de4821sm5792684ejj.158.2023.02.06.10.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:23:41 -0800 (PST)
Message-ID: <a94c9b8c-d439-b633-d02a-09d36bc11ad9@gmail.com>
Date:   Mon, 6 Feb 2023 19:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 0/6] add support for MT8195 VPPSYS on MMSYS and MUTEX
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230206091109.1324-1-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230206091109.1324-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Whole series queued, thanks!

Matthias

On 06/02/2023 10:11, Moudy Ho wrote:
> Changes since v6:
> - Rebase on linux-next.
> - For MMSYS api changes, fix corresponding functionality in [4/6] patch.
> 
> Changes since v5:
> - Depend on :
>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=713031
> 
> Changes since v4:
> - Rebase on linux-next.
> - Remove MMSYS fallback compatible.
> - Migrate MT8195 VPPSYS0/1 from clock to mtk-mmsys driver.
> 
> Changes since v3:
> - Rebase on linux-next.
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
> Moudy Ho (1):
>    arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS
> 
> Roy-CW.Yeh (5):
>    dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
>    arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS
>    soc: mediatek: mmsys: add config api for RSZ switching and DCM
>    soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
>    soc: mediatek: mutex: support MT8195 VPPSYS
> 
>   .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  26 +++-
>   drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
>   drivers/soc/mediatek/mtk-mmsys.c              |  44 ++++++
>   drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
>   include/linux/soc/mediatek/mtk-mmsys.h        |   6 +
>   include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
>   7 files changed, 249 insertions(+), 11 deletions(-)
> 
