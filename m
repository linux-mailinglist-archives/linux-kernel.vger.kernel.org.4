Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7E60B16D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiJXQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiJXQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:22:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D227DED;
        Mon, 24 Oct 2022 08:08:45 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73C7F6602261;
        Mon, 24 Oct 2022 16:06:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666624016;
        bh=a+0l+LUieWCZmrTxkABAo7G3RJjD6TBzF2qMpoeot0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkAHqwl+gmnr1C2LmiLEiW4FWHa5ABtkJd1/j9NX4JV9VKV/5nr1wN5uUH52ZVsbg
         SxS0oNtxTGkUoshk/1bOzBcmbKmG0q8JfP/NQ0UWW14Stz4O5HaLx85nHo5QvJktJP
         JoHX1GUOcT3ukiANEgW45A4pEBGib3CHQHn8U7f/8kj4JP8WiIxgMHqMJ7srbGQHDF
         wh4aQlcgtsjPn3PkAbTJGk40uOP28OriL58RQTcFyrN/6NKIqA5PIjD7rr7DJsZE0e
         cQxQ7uIztL+uY/32qfYDOQg9ID2Ic6Xby/AHaKmOB9Ye6D2yNReQhCiR+J2ahVdSiF
         OPoTmjxte6Ddg==
Date:   Mon, 24 Oct 2022 11:06:49 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <20221024150649.wbd54lcvgrj4kxgu@notapiano>
References: <20221021190908.1502026-1-nfraprado@collabora.com>
 <20221021190908.1502026-3-nfraprado@collabora.com>
 <ae460461-5c20-9180-456c-8c01a4b1a7f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae460461-5c20-9180-456c-8c01a4b1a7f1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 12:39:56PM -0400, Krzysztof Kozlowski wrote:
> On 21/10/2022 15:09, Nícolas F. R. A. Prado wrote:
> > The rt5682s codec can have two supplies: AVDD and MICVDD. Add properties
> > for them.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> > index ea53a55015c4..ca1037e76f96 100644
> > --- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> > +++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> > @@ -90,6 +90,10 @@ properties:
> >    "#sound-dai-cells":
> >      const: 0
> >  
> > +  AVDD-supply: true
> > +
> > +  MICVDD-supply: true
> > +
> 
> How about keeping some order in the list of properties?

The current properties don't seem to follow any particular order and keeping the
supplies grouped together seemed reasonable. What ordering do you suggest?

Thanks,
Nícolas
