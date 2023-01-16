Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5FE66BAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjAPJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAPJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:47:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173C14E96;
        Mon, 16 Jan 2023 01:47:56 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 519CE66029A5;
        Mon, 16 Jan 2023 09:47:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673862475;
        bh=93o0gsrzJuP/JbjPwP1VlaNpDSduuvf2Js/VnsKFP5E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jLOoqKC1axP2Z/SRrpfWWfXjFj74GgxeHtvSpNWYx/7hph3dsLDhlDg+0L6HzsTq1
         VPPw5HRUFxqnqtUGmvmm2THCQBy0o7xLnu4a8dLkTNn6BXgrGW9sHUX3Ts8eba+mvo
         lDkT04B2Pe+S7N+VZ7rVmDV3fQ4mWfuU3rbxRRZLqB4Qpo6fGOPa4QGhhKrrHuwUQ0
         h9E6MJCWHrqTR9fhFPH3/LXcu1AV7zL9PKn5whBiet2B53GfNmLtOQiI1UdWFTw7BE
         qmz7pNe8uwsxQM/nRVJUEeBx29v+U5bfjgZR7gPrCjEKe4MZ4vJYd97fJ8QBTAxyhI
         rPWY27O1sX5iQ==
Message-ID: <0e3f3cda-e8d1-6381-ec22-fe917f508112@collabora.com>
Date:   Mon, 16 Jan 2023 10:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 09/10] arm64: dts: mt8195: Remove the unnecessary
 dma-ranges
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-10-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230113060133.9394-10-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/23 07:01, Yong Wu ha scritto:
> After we add the dma-ranges in the parent "soc" node,
> this property is unnecessary for the leaf node.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


