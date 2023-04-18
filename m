Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5836E5D23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjDRJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDRJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:15:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1ED6580;
        Tue, 18 Apr 2023 02:15:37 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67C256603238;
        Tue, 18 Apr 2023 10:15:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681809336;
        bh=zC/TAZzf2xurSfg4uBALXf9z3Fp/VkEw/HUUOGxXljA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rj9nfVYH09a08kuz3NjQRkdFtge85SZjVxv/6WYw7KTuMe6mfabhLhi1yl7QzLnSi
         xYiPA+lEP+bEezO6kq1bvKm3GySUVuYyJIhvkv5JelUBvLMb/07zcKs5gjmPufstis
         0u0fW5wFE1Xm9eKHZ5j1xlgu14PrR7scMaWLQUMEIGFLQQvA2DBkOOV5uCPVz6zc2E
         xfNe3jsPLLQPmsCEl2Gmvf4HA7PdA0x0mfmvxaGypF1pk/WHF9/8ZhrCgfAghgwwhk
         xep4Pia4E2FiK2GKCc0HPbu8jR8ojGftLlJz3+32DKq08IfOFq5SzzvzFsYz3oXNAG
         UALOGzOpxgklA==
Message-ID: <a3bb307a-8deb-a038-56e7-ded2abb87255@collabora.com>
Date:   Tue, 18 Apr 2023 11:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v11 7/7] MAINTAINERS: iommu/mediatek: Update the header
 file name
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
References: <20230418083514.4379-1-yong.wu@mediatek.com>
 <20230418083514.4379-8-yong.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230418083514.4379-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/04/23 10:35, Yong Wu ha scritto:
> We add the prefix "mediatek," for the lastest ports header file name,
> For example, include/dt-bindings/memory/mediatek,mt8188-memory-port.h.
> Add a new entry for this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


