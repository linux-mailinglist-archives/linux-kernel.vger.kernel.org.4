Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720160BA53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiJXUfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiJXUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:34:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC13F160ECD;
        Mon, 24 Oct 2022 11:45:21 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67746660036C;
        Mon, 24 Oct 2022 17:00:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666627236;
        bh=73mRAt4slxg3WQnhUlKVuGJufrCR8Hql2e3IIojI/es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1hgZPCIEOicahFOn1Bq+bo596EyWAUOwjbcMmFgffNFIHWoRoXgvAYkpl+6TtpCL
         f/I85L1Canirg8SShskHM9QFuQZPVOyiZTqkqH2s0xnS4xCTHvs60WY2JfRwBBmYdH
         BTwsHu/T6WIdGR5XaJKFf+/lWDDkc3IXtXKI3NIIZFr7RKr9JeaZUu9yhPo7tYqd3Y
         lHQaFPey+AMIOUZvwhZW6pECAFSfI6p8KjwhjXfwz+UZ+FEj4+X1y3NAKFKJInmtTs
         7m7l/Jh3YhZoi/leAySkQZtWSGmOhzwPOzlb5XTXdz9ZGqOzo3QZzehtG9kl2DPtkT
         Gwfhl9jc065vw==
Date:   Mon, 24 Oct 2022 12:00:29 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT
 supplies
Message-ID: <20221024160029.cfpyp2cptwig27jd@notapiano>
References: <20221021190908.1502026-1-nfraprado@collabora.com>
 <20221021190908.1502026-4-nfraprado@collabora.com>
 <f7007c75-9c99-902d-170f-383b7347922c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7007c75-9c99-902d-170f-383b7347922c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 12:41:01PM -0400, Krzysztof Kozlowski wrote:
> On 21/10/2022 15:09, Nícolas F. R. A. Prado wrote:
> > The rt5682 codec can have three supplies: AVDD, MICVDD and VBAT. Add
> > properties for them.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/sound/rt5682.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
> > index c5f2b8febcee..5ccf4eaf12a9 100644
> > --- a/Documentation/devicetree/bindings/sound/rt5682.txt
> > +++ b/Documentation/devicetree/bindings/sound/rt5682.txt
> > @@ -48,6 +48,12 @@ Optional properties:
> >  
> >  - #sound-dai-cells: Should be set to '<0>'.
> >  
> > +- AVDD-supply: phandle to the regulator supplying AVDD
> > +
> > +- MICVDD-supply: phandle to the regulator supplying MICVDD
> > +
> > +- VBAT-supply: phandle to the regulator supplying VBAT
> 
> Lowercase.

Actually looks like there's already a DT using these properties before the
binding was added:

arm64/boot/dts/qcom/sc7180-trogdor.dtsi

In this case should we keep them uppercase for compatibility or carry on with
the name changes and also update the DT? (the driver also uses uppercase names)


Also noticed that dai-cells should actually be 1. Will fix in next version.

Thanks,
Nícolas
