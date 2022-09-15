Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE50F5B9F77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIOQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIOQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:16:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510988C47C;
        Thu, 15 Sep 2022 09:16:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dv25so43226152ejb.12;
        Thu, 15 Sep 2022 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=63vT8m8MylaPly4euPrd3RMV4XW9rM+F1IN3x8FpSV0=;
        b=M0g5ls1WKDHcioqcss6bp/Y2EM9o688UgiKmwr2miwQidIKxfe8WsHaKBS0QnP19xj
         84b57V36j6Am47XtK0fTE9lCFQrdodANeaCY1bni5gEC/dfCJ80TiBl5e341v5NTrC0D
         650wtgc15NOFZrh8+dap7PRZsUWABj7Tx8uec+gUSCChXzFnBAz+G5wUQdtcfn3xBwee
         DxgKd50+fnKiuSJEIw9dIglUuWFo7G3S3McJAAZMRxOEpQN7gwHyE2qDJeYaycGoz8o1
         hf9SDsn/OaHyNo5ZyIc/Tfi99c9xyyymk+TwGm/k+2ol5tALgglTCwhOwnxQTc+6e34w
         jNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=63vT8m8MylaPly4euPrd3RMV4XW9rM+F1IN3x8FpSV0=;
        b=xPpDxSaJwOKcSf8SERoOK2XV+PZmMqWE4L0mELYRmM3SgH1LkwkZ1yGlcVxAq60Vya
         MHYM/1psbqpskVCVf8o/1IOA62yJsyaKU2p+zXI5uP37dy67Gqr8coPaSjkwxC1jb1UE
         CF7QXD4B84vGnxclpwREYYIfo5UuIwPKSwaAy8vTerLUFRdxmxxuwh/2BNW1TrFAtn9E
         TGaxV8EpPQwQRJpl6LgDwjojaM0rSodJPLm2Gek0hsYjfiEKahZ8TiIMLxO0K0KkRBD1
         g5YCpNu/E/M7eaKDHTr2t/UiHrMM24R3TX0EBh3+lhv71iCJmV6Q0R32eOGgcURpokLg
         7hxw==
X-Gm-Message-State: ACrzQf3U2SbldjDtjU2iPZb6bjlSgoarSxvUWm6iDaaccpaeUVodYwh5
        mElo2mDqfjISEnyp0hldfX8=
X-Google-Smtp-Source: AMsMyM5zyVslz6eL5hQZ2vqtP2XxTO6A1/t93r3hM55bDcfdv6gf3smsa5UfAq06UyXLFCm1A9hnzQ==
X-Received: by 2002:a17:907:3f85:b0:733:3f0e:2f28 with SMTP id hr5-20020a1709073f8500b007333f0e2f28mr504311ejc.376.1663258567816;
        Thu, 15 Sep 2022 09:16:07 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y17-20020a50ce11000000b0044f2afbb1easm12258192edi.27.2022.09.15.09.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 09:16:06 -0700 (PDT)
Message-ID: <cf8ee34d-8be3-b82c-8e93-afbfa97048a0@gmail.com>
Date:   Thu, 15 Sep 2022 18:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/2] MediaTek Helio X10 MT6795 - Display Mutex
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        jason-jh.lin@mediatek.com, rex-bc.chen@mediatek.com,
        moudy.ho@mediatek.com, allen-kh.cheng@mediatek.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/2022 16:01, AngeloGioacchino Del Regno wrote:
> This series adds display mutex arrays and compatibles for the
> MediaTek Helio X10 (MT6795).
> 
> Tested on Sony Xperia M5 smartphone.
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: soc: mediatek: Add display mutex support for MT6795
>    soc: mediatek: mutex: Add support for MT6795 Helio X10 display mutex
> 
>   .../bindings/soc/mediatek/mediatek,mutex.yaml    |  1 +
>   drivers/soc/mediatek/mtk-mutex.c                 | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
> 

Whole series applied, thanks!
