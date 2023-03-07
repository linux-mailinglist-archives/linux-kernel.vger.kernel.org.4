Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9F6ADAF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCGJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCGJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:52:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85597384C;
        Tue,  7 Mar 2023 01:51:42 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C39856602FE5;
        Tue,  7 Mar 2023 09:51:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678182688;
        bh=vkkFYd3loRrOSSOnY088flgwXtY2fsz3MI2px8MiqHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FvjkZSoKncFHS3NEPw0+fU1qd1+2i3EiXrC6U9A1GQ+9sb9zw2STaKQRZaLD63ii0
         Zff6jfIyfc7M3vzAkM0UtGpuFYeDkRWxH6Dn8UwkRadngbfhh0sxFJK9gWWURrp7Ws
         5hOABq0FmfjP1t19KBgpd5Eym35qs3J9xT9zJSgvKwztrdQQTAKn6u2NDA1tuuea3G
         x/g55xmr8/N9BgmPqUZOpE9AZ/r/wsbrSPRr+qt6TlwI8IvdTtiY/jcn28jX3At/zS
         6euu71DP9uXJuT3uKiN2VHx3s+tJhKwQjVu6KFZ7fomQeQugkXe2RLr738NfeV36EX
         s1C1e7kFrsVQA==
Message-ID: <d74bbde8-c419-c906-2df3-7bc31fc6563c@collabora.com>
Date:   Tue, 7 Mar 2023 10:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-2-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230307080555.14399-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 09:05, Yong Wu ha scritto:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> Add descriptions for mt8188 IOMMU which also use ARM Short-Descriptor
> translation table format.
> 
> In mt8188, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>    IOMMU(VDO)          IOMMU(VPP)
>        |                   |
> SMI_COMMON_VDO      SMI_COMMON_VPP
> 
> ---------------     ----------------
>    |     |    ...      |     |    ...
> larb0 larb2  ...    larb1 larb3  ...
> 
> We also have an IOMMU that is for infra master like PCIe.
> And infra master don't have the larb and ports.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Yong, if you're sending someone else's patch, you have to add your own signoff tag,
otherwise it's not going to be accepted.

With that fixed:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


