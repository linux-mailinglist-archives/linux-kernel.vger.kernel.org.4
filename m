Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A05FE341
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJMUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJMUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:24:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F412633;
        Thu, 13 Oct 2022 13:24:46 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C919F660236D;
        Thu, 13 Oct 2022 21:24:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665692683;
        bh=/urp6FGOF38ju+OWMwUWjSNprDW/xXAY6n8S22UMNjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTzsoONBYo+04M082a10SMoJtzloBqw3/GwPTVo51uEdStLzkFeuUYZFWXF8I3NEv
         tlgvl0jZFtz0l7OdBweF9gUW9tZ6fWYfPDzHK0JMZYOa3X/eV3tWF6l1t9LTAoc3TF
         D2xklenwKuyf+RYiLzselE6g7nYyww/LxqibW/wUuf/0Fk1axaQG/pmlvYq9MVkBnX
         egA8c89DHqG6B80BxIKeswc3XaD2iOrzTXlLbTdYW4gUN2Nvn1Y3sON9PeGAN46N6G
         SzkrLg1LCx9OjFpj9vAUU904qwZV30EPQDQtid11YeLQxNgxb8XzcJDMxv72NWEGOs
         BOJuw7uy7EcGw==
Date:   Thu, 13 Oct 2022 16:24:38 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 5/5] arm64: dts: mediatek: asurada: Add aliases for
 i2c and mmc
Message-ID: <20221013202438.unfa4fqinwhgvfiz@notapiano>
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-6-nfraprado@collabora.com>
 <CAGXv+5GmJOYnfLsovO_+piuJ1ry1R0ZQqALRGK3MNp=nUO-TNw@mail.gmail.com>
 <CAGXv+5HGodRWbawEpDppZWM_EiuzdvZC9h4XBoAPo=FQ7yNotA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HGodRWbawEpDppZWM_EiuzdvZC9h4XBoAPo=FQ7yNotA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:02:03PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 7, 2022 at 11:51 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > On Fri, Oct 7, 2022 at 5:25 AM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > Add aliases for the i2c and mmc nodes on the Asurada platform DT to
> > > ensure that we get stable ids for those devices on userspace.
> > >
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > > - Added this commit
> > >
> > >  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > index dac2d4f5e670..758ca42a6156 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > @@ -11,6 +11,18 @@
> > >
> > >  / {
> > >         aliases {
> > > +               i2c0 = &i2c0;
> > > +               i2c1 = &i2c1;
> > > +               i2c2 = &i2c2;
> > > +               i2c3 = &i2c3;
> > > +               i2c4 = &i2c4;
> > > +               i2c5 = &i2c5;
> > > +               i2c6 = &i2c6;
> > > +               i2c7 = &i2c7;
> > > +               i2c8 = &i2c8;
> > > +               i2c9 = &i2c9;
> >
> > You should only add aliases for interfaces that are actually enabled.

Ok, will drop the extra ones.

> >
> > Also, I think we can disable i2c6. None of the current products use it.

It's already disabled upstream.

> >
> > ChenYu
> >
> > > +               mmc0 = &mmc0;
> > > +               mmc1 = &mmc1;
> 
> Also, Spherion does not have an SD card slot. It might be better to move
> the mmc aliases to the end .dts files.

Based on the downstream dts, rev0 and rev1 do have SD card slot (or at least the
mmc1 controller isn't disabled on those). However upstream we have a single dts
(asurada-spherion-r0) shared by those two and rev2 and rev3 (which don't have
the SD card slot), given that this way we can have a single dts and there's no
disadvantage to keeping the mmc1 node enabled because the CD IRQ will never be
triggered. With this in mind, I think it makes more sense to keep the mmc
aliases in the asurada dtsi, as there's no harm in having them, and will ensure
fixed ids for the rev0 and rev1 spherion boards.

Thanks,
Nícolas
