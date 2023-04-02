Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249CA6D3951
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjDBQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:52:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1166585
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 09:52:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so18357826wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680454344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFgTnd8uCD9hdangle5ftrUkUS5oCcd9OyJO8+L+8rs=;
        b=Lr/86VKyFxJj0tGI25dYkOewqphKXvklHcSfP3jJPOZ3xbh1EeDfPES8cRltuO6Gfk
         2+jIrD1DHufPCiThQQlkG0o7X2msJMtx2Q1aqwR2bIIYLVedvtiSm5b1gym6Rb97ob/Y
         L5hiVsu+EXAkjw3W2X61qUM/U4lVu2izuF3K5X9x9NqveiiK3ZS7+VFVcsq/McyEMGEY
         GaJWBTY4pNuYZD6Sx2fBE8WSe5Iy74+2TtAiG82+oJ+L1Ljvhm98Kpzk1TeXiX9f16eX
         QANUq4C5mAyOcXk84bgfaIC9Y9KVA9nxlgvvnrBF+G4QAsXIeOH1xv6kmKHtLOMKsE0J
         Wrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680454344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFgTnd8uCD9hdangle5ftrUkUS5oCcd9OyJO8+L+8rs=;
        b=7JyKzu2q3GiF6MVI3p0TZjWA83xtXOj8j6X8p7JR8ufALSY7saPeMFRDQXUAI+kD8R
         FllgqdmC5eMvqh0EfY53cX4N3NUV5gRb7JJc+BPn5lJltfSIFatmEMgvzpRZbwv/LspU
         GfisyWBfwE9nuffSwvH3e/7lJv0+D1mgX599lD5/OEyuPVjcCNWwqoUk5bPnBkA9DzDV
         yR0dVsdSu8EvYGlgO31hsPiIT2q06Hwot5m2CudozPX+caYMgqH2DfhX69VQd84o5A0i
         /3EGkQ8+ArwGNEUz1cHGffTsc62L9MNQfjL7d/OK9y/FMWDRn38VJLem1dADjkVUtra8
         eVNg==
X-Gm-Message-State: AAQBX9dQWdY1/Mw8GLmLrP9J3HHxt29RH6biKZTgbsDhKRx4pLfS27Q1
        c4IhKcF7+0gRVVOngNz34gI=
X-Google-Smtp-Source: AKy350YKoVMhVaqf8Ro4NQlhX4kPKXtf//FlXNVEcXiRnyVwSxlYtfErw7crIn9bvjt5Js8azkkIqw==
X-Received: by 2002:a7b:ce88:0:b0:3f0:3a5a:362e with SMTP id q8-20020a7bce88000000b003f03a5a362emr8413189wmj.39.1680454343617;
        Sun, 02 Apr 2023 09:52:23 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b39-20020a05600c4aa700b003ed29189777sm16375913wmp.47.2023.04.02.09.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 09:52:22 -0700 (PDT)
Message-ID: <5171511b-4021-589e-3606-10a690b48850@gmail.com>
Date:   Sun, 2 Apr 2023 18:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/9] soc/mediatek: Cleanup mmsys, mutex, cmdq header
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2023 10:42, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>   - Rebased onto Matthias' v6.3-tmp/soc branch for VPP mutex conflict
>     on patch [5/9]
> 
> This series adds a proper remove callback for mtk-mmsys, adds light
> cleanups on mtk-mutex and, more importantly, adds a cleanup for the
> CMDQ helpers.
> 
> Special mention goes to the latter: this is just in preparation for
> a larger cleanup that I plan to do as soon as possible on other cmdq
> helpers users, being mediatek-drm and mtk-mdp3; that's not performed
> right now because, in the case of drm/mdp3, the cleanup is not entirely
> trivial.
> 
> AngeloGioacchino Del Regno (9):
>    soc: mediatek: mtk-mmsys: Add .remove() callback
>    soc: mediatek: mtk-mmsys: Use module_platform_driver() macro
>    soc: mediatek: mtk-mmsys: Compress of_device_id array entries
>    soc: mediatek: mtk-mmsys: Add MODULE_DEVICE_TABLE() to allow auto-load
>    soc: mediatek: mtk-mutex: Compress of_device_id array entries
>    soc: mediatek: mtk-mutex: Replace max handles number with definition
>    soc: mediatek: mtk-mutex: Use module_platform_driver() macro
>    soc: mediatek: cmdq: Add inline functions for !CONFIG_MTK_CMDQ
>    soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)
> 
>   drivers/soc/mediatek/mtk-mmsys.c      | 135 +++++++++-----------------
>   drivers/soc/mediatek/mtk-mutex.c      |  80 +++++----------
>   include/linux/soc/mediatek/mtk-cmdq.h | 114 ++++++++++++++++++++++
>   3 files changed, 182 insertions(+), 147 deletions(-)
> 

Applied, thanks!
