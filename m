Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3E6BE5B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCQJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCQJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:35:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22296DF72F;
        Fri, 17 Mar 2023 02:35:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35953660309E;
        Fri, 17 Mar 2023 09:35:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679045747;
        bh=nOzJwrg70k6TQ8N3v6z0ztOceAdYD1WfNSV65qWEcis=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AztsVHJmKtbFxgdhXMu7cSIc+B5KBsDEzl2QrT0s7ZjZPj7mtQWs48nFiOJzqLU/s
         11wkGp5L/cJ97/BE5tpA3mP9lYiwMIRzoRK3pg+0yl8+6HyJnhXhlfU/UlzzZYv9p7
         L2tKh894VGTlSXxva12+UvKmH8Uzha5JoN/s6mGddh9kGhUMhCiyQpdCx4KxL5bZRZ
         DaQY73lZHJjd8QhitLqBR1FQihBHYEoxOfOwjsZo34OhIAdnn//EnIZje/vsHYu00f
         fTRpfAdpLUuwS2+30M6it+OOQ6gxSTGvdXEtHIVg61ygzYVCeeG2Y8wVSVX5+RdK3q
         wqgzkHlPGLU+A==
Message-ID: <d931a368-b379-3dfa-8140-f9cb5ac74c0f@collabora.com>
Date:   Fri, 17 Mar 2023 10:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 4/7] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA masters
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
        chengci.xu@mediatek.com
References: <20230317085541.20447-1-yong.wu@mediatek.com>
 <20230317085541.20447-5-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230317085541.20447-5-yong.wu@mediatek.com>
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

Il 17/03/23 09:55, Yong Wu ha scritto:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> Prepare for MT8188. In MT8188, the register which enables IOMMU for
> INFRA masters are in the secure world for security concerns, therefore we
> add a SMC command for INFRA masters to enable IOMMU in ATF.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


