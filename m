Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F35B7720
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiIMRDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiIMRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:03:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732848E444;
        Tue, 13 Sep 2022 08:53:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az6so9807478wmb.4;
        Tue, 13 Sep 2022 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=x+OvlGvA0YgoD25hE/RBeJOSl8R0fjbyJIDSe7KWLpc=;
        b=KuuPU3qCJJaqBEXAewIGvSz2z+Fv5JjSS/XkzMRyESkunK9ehw5l+NIXXddxaJUvPZ
         zBr6M1iAJp2fdRDhGrE9g7YTV5AmdPNlKiXy0QACGRIbk9Oqh3vWNdeqtFZOHr5x3jGv
         TzuoBRRr/sh379Vl5VHQUcVvxJ3SDik8Npx6EC1axWwst5Gb877ZE0LmLu0shewlSnrZ
         OzJf73mev8wrKhp7cr4bhS8c7ehsquMt3QJ1qFq3O/6dsBPKRxbDxaEOyR5Lu5BMiRxS
         s4y/39vHyWLOdKWy+PqGmcgb8HZhz6vwPsQ2kMHo6rYRn9j/uYfiSZrW/yPD05WMFdIZ
         msWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=x+OvlGvA0YgoD25hE/RBeJOSl8R0fjbyJIDSe7KWLpc=;
        b=rweP+uc7AJjhgI+7IeJtNKZJ8sc9WF6emYQsn64vS14KKP6BgjqvKyAVmuZ1Dcfw1C
         M0Jq2zP0NAiYBSyFu+OJ06uYS9O3SbU98vu5dijSkUbnHI00frbm84TZqY8do/ZcXhhj
         BlIwGqhBztCJ2nHvxVpBv3Vwp4Y2tPyx+jYLxf00/w0SVB363X6mbEFSSeQYKOM8xJNF
         33CN4Rp8KVEq48yQSKh3tREeJnxSxieBM5Z8cgABhPduqhJgGMKOxX3Dn8+NBjydkhOQ
         +KjxMOvnMs6SHZcs1VyvUNB35B7rgOBFR9U8Kc6mGMdba6PRjgryXjuGqw1tgXokRlnY
         WJpg==
X-Gm-Message-State: ACgBeo1WaX97g91sJmdTv6eyUHtlx7WITDa9jXDqVq94d7cq85K88c8b
        d8I/roJ645IPTdmkeRHaP9S2y+h0wd4=
X-Google-Smtp-Source: AA6agR4Wau7001C6apUNfVYL7NfB2RY0GfBXdrtkoDtoiRpzgxAxENutqX4G8O9vqAmtXjLBB9xKMA==
X-Received: by 2002:a05:600c:19c6:b0:3a5:ffb3:d527 with SMTP id u6-20020a05600c19c600b003a5ffb3d527mr2963647wmq.106.1663083717615;
        Tue, 13 Sep 2022 08:41:57 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003b47a99d928sm10704548wms.18.2022.09.13.08.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:41:56 -0700 (PDT)
Message-ID: <8ca1574f-a8b8-9482-3129-922f6f85216c@gmail.com>
Date:   Tue, 13 Sep 2022 17:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 0/3] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org
References: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

On 13/09/2022 17:11, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support for the IOMMUs found on this SoC.
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> Changes in v6:
>   - Fix rebase mistake in patch [2/3] (dropped unrelated change)
> 
> Changes in v5:
>   - Rebased on next-20220912
> 
> Changes in v4:
>   - Retitled mtk_iommu commits to iommu/mediatek as suggested by Yong Wu
>   - Removed unused M4U_LARB5_ID definition
>   - Rebased on next-20220624 and
>     https://patchwork.kernel.org/project/linux-mediatek/list/?series=650969
> 
> Changes in v3:
>   - Added new flag as suggested by Yong Wu
>   - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=648784
> 
> Changes in v2:
>   - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=642681
> 
> AngeloGioacchino Del Regno (3):
>    dt-bindings: mediatek: Add bindings for MT6795 M4U
>    iommu/mediatek: Introduce new flag TF_PORT_TO_ADDR_MT8173
>    iommu/mediatek: Add support for MT6795 Helio X10 M4Us
> 
>   .../bindings/iommu/mediatek,iommu.yaml        |  4 +
>   drivers/iommu/mtk_iommu.c                     | 21 +++-
>   include/dt-bindings/memory/mt6795-larb-port.h | 95 +++++++++++++++++++
>   3 files changed, 118 insertions(+), 2 deletions(-)
>   create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
> 
