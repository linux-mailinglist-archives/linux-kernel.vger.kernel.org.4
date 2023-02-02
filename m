Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728D687DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBBMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:41:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699188DAFD;
        Thu,  2 Feb 2023 04:41:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a2so1301920wrd.6;
        Thu, 02 Feb 2023 04:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqbgRqyTVLRbe/zevz7M7Ult5EWX7ZO+3KY6VnfNffA=;
        b=ixgo/Ztz3YhqK1Tx+im0ksvpFeC9dnwA2/UW2untG+lMVxspfHWYpARW9LxbP9SRts
         dDuJjo4jT7LYiDN5FDwL9k2ZZJAgWMl2dOdNBwmm5puMrGvO0v3F957GfhPrvSBnxP40
         irwbeX9UEowPJxusMiZOQt4qGQhijxzzU+J1PmoQ5xeIAdc8pTSAmyUv6Yl9CFq9G/5F
         xhraGrt7MeUNKrfWB89vrdxMCswvQeFEKJiJfRMD6Rfohrm8OpdfexlubS+WBNT3ypHF
         V5fGeF84hG13oEEhUcn6gfk+xftOtDgUtyavflq//SV9lOfxLdRadIXCvi0eFXfD+G76
         8OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqbgRqyTVLRbe/zevz7M7Ult5EWX7ZO+3KY6VnfNffA=;
        b=tAolWi2wzVUDf9oZPjgHotgFVFcJJUEjFOheGHT8vMXX022xZlNue+YAGye+IX1Gia
         kInzfT2Z+CbSrMmcx1x6+r4COqPY/RmDyyLoWoCqbgQxXRDOBr1otk5PghZVbzIVom3L
         lBNv0UGdiZ9gFUpZwygL2SUccQnaYy+TMk6KmUnMUYv5xKDhPxZ17XbMLYJ12OsUyETe
         mIotDOPa2Z1Orb6zTtoMmddYnrTvCRyxwk7t9nKz5/b49FIyWvcsHWr4o2cVnFDIxYZz
         W8nXnBN+8jsD/bgD8O9dkngk6soydk3il8q1Y8+B49z2ybaTeZB6S5jqSB7S68ME+WIH
         Tncw==
X-Gm-Message-State: AO0yUKVfouS0YOhRhzqcwaNvhA3LW3onDjJx8mDWyPUfuGSSVzJ/SM9C
        LBH/qi31mccf1yzEefRrPN8lF223lXBgSg==
X-Google-Smtp-Source: AK7set9aEuxXXfoNrQHqYo270n4J50ZYLhNmtpJb/+iD6yWf6MxfBT/EoBt7tbs96HbAiffh857HzA==
X-Received: by 2002:a5d:6ad0:0:b0:2bf:9527:ce62 with SMTP id u16-20020a5d6ad0000000b002bf9527ce62mr4907395wrw.60.1675341642666;
        Thu, 02 Feb 2023 04:40:42 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r28-20020adfa15c000000b002bfd137ecddsm18017534wrr.11.2023.02.02.04.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:40:42 -0800 (PST)
Message-ID: <cd82e2a1-dbf4-88ee-f658-f695ae9ef56a@gmail.com>
Date:   Thu, 2 Feb 2023 13:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 0/6] add support for MT8195 VPPSYS on MMSYS and MUTEX
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118032122.29956-1-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118032122.29956-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whole series queued for the next merge window.

Thanks!

On 18/01/2023 04:21, Moudy Ho wrote:
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
>   drivers/soc/mediatek/mtk-mmsys.c              |  42 ++++++
>   drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
>   include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
>   include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
>   7 files changed, 245 insertions(+), 11 deletions(-)
> 
