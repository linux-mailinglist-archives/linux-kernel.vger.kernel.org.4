Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7B6D54A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjDCWTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDCWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:19:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B12273E;
        Mon,  3 Apr 2023 15:19:29 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5631766030F1;
        Mon,  3 Apr 2023 23:19:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680560368;
        bh=MfmeAyMP4kZnUtbedObZ5J3MvrkjTUU/2hwYA1Mdx6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBDhs8F64dEDL9yF4U+vgr0Qx7wzZGhhYKMmrBTgpyflQKR+FKgXbpmO2QUH8zLMA
         ve/hZuMzhviSVvmZQU+kwgqk9e5zC2CWTUjAJpIyuNV9wZC2XP50X7nTakcK9KuNhl
         ijrk+HItTJtFXltBIUHqFsfxyQQY18X0JN26j95u7VKSdoBxNlNxjTE655MSrgyqES
         dav8ToW4kZeyaWNNjEQYeOcT9tdkpFaVXLhDPPNlhJc6Pi8WeTFNRSwRqvtYA8NUI6
         nrTqdIAyh5rOusfsagIrdCFoDcChchq+COk5gwBb4SF61y4BKFXzQm+ZA/7LozXiF4
         nahUY/UinXnVA==
Date:   Mon, 3 Apr 2023 18:19:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: Re: [RESEND 0/6] media: mediatek: Update video decoder nodes for
 MT8195 and MT8192
Message-ID: <4ebd1c9f-0460-4436-8e17-0e46e88f4828@notapiano>
References: <20230303013842.23259-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303013842.23259-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:38:36AM +0800, Allen-KH Cheng wrote:
> This series is based on matthias github v6.3-tmp. Since there is a
> dependence in the following series, I resend a series for them.
> 
> patchwork.kernel.org/project/linux-mediatek/list/?series=702423
> patchwork.kernel.org/project/linux-mediatek/list/?series=702078

Hi Matthias,

this series has been completely reviewed and tested for a while, and the
bindings patches were already picked up by Hans and are on their way to 6.4 [1].
So could you please pick the devicetree patches?

Thanks,
Nícolas

[1] https://lore.kernel.org/all/98c48690-631d-1086-9b7c-004c61cc8dbb@xs4all.nl/

> 
> Allen-KH Cheng (3):
>   media: dt-bindings: media: mediatek: Rename child node names for
>     decoder
>   media: dt-bindings: media: mediatek: Remove "dma-ranges" property for
>     decoder
>   arm64: dts: mt8192: Add video-codec nodes
> 
> Yunfei Dong (3):
>   media: dt-bindings: media: mediatek: vcodec: adapt to the
>     'clock-names' of different platforms
>   media: dt-bindings: media: mediatek: vcodec: Change the max reg value
>     to 2
>   arm64: dts: mt8195: Add video decoder node
> 
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 113 +++++++-----------
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  59 +++++++++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  70 +++++++++++
>  3 files changed, 173 insertions(+), 69 deletions(-)
> 
> -- 
> 2.18.0
> 
