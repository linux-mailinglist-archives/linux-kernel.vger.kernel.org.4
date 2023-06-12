Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C472CEED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbjFLTDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjFLTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:03:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED0B7;
        Mon, 12 Jun 2023 12:03:49 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 598B16606EAE;
        Mon, 12 Jun 2023 20:03:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686596627;
        bh=skSAnaTgSHIV6cwfzXxaMUW4myAnueW+/ns3bFUzy8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJf/h/MKb4PKJ/uT4rymeQgnn0AllhVGqODjBRQDpE57+Wxi/lMfC8ncPQ296ZiQn
         sCiTiqNTX3mlAgBI3bbXccPVVcvUffOrx4pqlPhzh5jIFL2szdnE9tK7ZL3wyTjYyP
         Ksc7VY7cbgFNvKxGgEavDw0NprkEh5aLbX6v7t00uiOW44RAe8n4ReZQtGnfQBVC/x
         hmX2luZj3O21yCQki+gw+Ot3iJz9y0K6niH/NPyjLwxxOzL4GpP8171UilbtnsDh12
         +J4l/Dc4sDW7jGQhSe/7oYvJZwSWb1m/6P7DOo+J06sMZ+KWz26T+k6X5XToMvdDjL
         LBoNvN30WoGEA==
Date:   Mon, 12 Jun 2023 15:03:39 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Enable decoder for mt8183
Message-ID: <e8ddbc54-b929-4363-9bc7-b0f406062f46@notapiano>
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <380c6489-7a3c-778b-5b81-6339b6964b90@xs4all.nl>
 <fda4f196-8466-8290-9072-d80fff367720@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fda4f196-8466-8290-9072-d80fff367720@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:53:51AM +0200, AngeloGioacchino Del Regno wrote:
> Il 12/06/23 09:02, Hans Verkuil ha scritto:
> > Hi Nicolas,
> > 
> > On 07/06/2023 22:53, Nícolas F. R. A. Prado wrote:
> > > 
> > > This series enables the hardware decoder present on mt8183. At first
> > > glance, the only missing piece is the devicetree node for it, however,
> > > simply adding it as is would cause an address collision between the
> > > first register iospace and the clock-controller node, so a rework of the
> > > dt-binding and driver, as well as addition of a clock, were needed
> > > first.
> > > 
> > > Tested that H264 decoding works with the hardware decoder on
> > > mt8183-kukui-jacuzzi-juniper-sku16, giving a fluster score of 98/135 on
> > > the JVT-AVC_V1 test suite. And ensured other SoCs (MT8192 and MT8195)
> > > still work as usual.
> > > 
> > > Changes in v2:
> > > - Merged commit 1 (media: dt-bindings: mediatek,vcodec: Allow single
> > >    clock for mt8183) into commit 3 (media: dt-bindings: mediatek,vcodec:
> > >    Remove VDEC_SYS for mt8183)
> > > - Further constrained properties in dt-binding
> > > - Added CLK_IGNORE_UNUSED flag to active clock
> > > - Reformatted reg-names in DT node
> > > 
> > > Nícolas F. R. A. Prado (4):
> > >    media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
> > >    media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
> > >    media: mediatek: vcodec: Read HW active status from clock
> > >    clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec
> > 
> > Is the clk patch independent from the others? It's not clear to me.
> > 
> > If the clk patch has to go in together with the media patches, then
> > please let me know and post a v3 where the clk patch is also CC-ed to
> > the linux-media mailinglist to ensure it ends up in our patchwork system.
> > 
> > And in that case I need a Acked-by from the clk maintainer as well.
> > 
> > If it is independent, then there is no need for a v3 (at least, not
> > for this).
> > 
> 
> The clock patch is not independent, as in the devicetree changes will not
> work without the addition of that clock (and of course even fail building),

Yes, but that means that the devicetree patch is dependent of the clock patch,
but the clock patch is independent from the media patches, and can therefore be
applied through the clock tree as usual.

So, the media patches (first three) can be merged through the media tree, the
clock patch (patch 4) through the clock tree independently, and the only
requirement is that the DT patch (last one) is only applied by Matthias after
the clock patch is present, to avoid build problems, and also after the media
patches are present, to avoid dt-binding errors.

Thanks,
Nícolas
