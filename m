Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E85BCA39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiISLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:05:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3777653
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:05:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so13087854lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A1FM6FAoiEC7PRrQXFWOsfGGjoGMqEaUpaQkuBnp1+0=;
        b=E+e2zAkBBAYbfP4FR7CDEDZL6ZBO3HanynU8QYzX2dHuxE/7jtOkzzGnboB92pZKlz
         CfolEkfmNq200LVMY9y1ZqenAfdaLjzzhMUb5izdzqtRETRUDlYv0kAqWmNvj/j7juma
         kRUBzqcdD2LODp1Gjs0eDSFfkB2H8Qxa3IAglVyEdxWB9p+3CXVprVCEVJtcGNhRnTJ3
         QLPUphIs8bDk4Ky+7g1R/98hE2H5KAh2uTVlhK6lzbHNmpjG+hMCtGYAquKu3GPrWq4J
         lbgQ0OeAEqYYxWAJ/RX7KQdfyGCEjvnE4DmlvxMY17PGaONt+jgncae3EoEDHB1KarrC
         CneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A1FM6FAoiEC7PRrQXFWOsfGGjoGMqEaUpaQkuBnp1+0=;
        b=G6ycpuPzhXcgoIFzR+ICNtyYVuLjBqwKezMvyOsyu3B74in08XLvH0bebqjAdafTM0
         FiOsR0rxw/uw3xfIFZ6x2zeu73fRkXR1ZuG4fQiVwOny6MEsomAmzn1/f67ucNUudAse
         CkYJBeDcGsO14ILOUgORrbRxqAo4/jJt1TBGWqMuzaTctFrLvI6mYf3Zu75AMEhlcszW
         6Izvwkd1JHxXwsg7HjA2jaDLdB0LZUW+r7+idUJKzW/hMQCg30Aq58NXON61hIFvz9Ii
         oZyBBkpBC/dvswqx1V85Xi39TN04dxAwp9obIuswKdIT+Acpy+5GtNz02EjBW4Pyr0Vp
         6yTg==
X-Gm-Message-State: ACrzQf1DIA19aa7k/imnuIBv/N/09gKu8JqAMdeNW3nkkqqHwVGGdntH
        K98M1QI6H7vUz1D7jMnNslK4Ow==
X-Google-Smtp-Source: AMsMyM6YrKPdqb1UqOzTNjT+xjVxRozWKcwrIhZa5ApEvR1bc0UP6/cShGl5qisCorV5ckrazWZ4Bg==
X-Received: by 2002:ac2:4c35:0:b0:497:ae09:11b with SMTP id u21-20020ac24c35000000b00497ae09011bmr5900342lfq.507.1663585517490;
        Mon, 19 Sep 2022 04:05:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651234c900b00499bf7605afsm5010369lfr.143.2022.09.19.04.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:05:17 -0700 (PDT)
Message-ID: <2e2a7dbb-ba8a-3406-b54d-0ca135193c3c@linaro.org>
Date:   Mon, 19 Sep 2022 13:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220919082611.19824-1-chengci.xu@mediatek.com>
 <20220919082611.19824-2-chengci.xu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919082611.19824-2-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 10:26, Chengci.Xu wrote:
> Adds descriptions for mt8188 IOMMU which also use ARM Short-Descriptor
> translation table format.
> 
> In mt8188, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>   IOMMU(VDO)          IOMMU(VPP)
>       |                   |
> SMI_COMMON_VDO      SMI_COMMON_VPP
> ---------------     ----------------
>   |     |    ...      |     |    ...
> larb0 larb2  ...    larb1 larb3  ...
> 
> We also have an IOMMU that is for infra master like PCIe.
> And infra master don't have the larb and ports.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
