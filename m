Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2227405BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjF0Vil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjF0Vij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:38:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324726B6;
        Tue, 27 Jun 2023 14:38:38 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7759D6607165;
        Tue, 27 Jun 2023 22:38:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687901916;
        bh=cWkXTYDt/bMN7/WXTJkUfgfgP3H+Af/AjtPCKz5D3x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSDaRNvc1M2EN3RY1Pq8UC24N8DQTLqgClDJG4ECDz8mb2Hp/onmIpVYPU73ACGZZ
         BR/IV+PWVbp4M/+cMsjrsTL6ZoukxBw4Ooyez+T2EGj/iVkfchk38fRlGSkyBsI4iO
         nEj8Sypo5BAATF8NGPXynu7qwbPfjr1/TXgpdmw1ftakpGZM45RXEU8JtnNDY6i8UK
         2ENTjRp1ltPvIpsMSHXIuD6AYDRfU1hLCaZKVtez/Jnei6h3KfudzohiLfN4DiqMCJ
         QO+xLHpwGDiQPjKP9N+CatPE4mR7GdTrNZJcnPIPM6+07Q6uUBB1B0tQLb5tY8Vj02
         Iq1FaAY15mrHw==
Date:   Tue, 27 Jun 2023 17:38:30 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Message-ID: <51dfbae5-4250-4b89-adb5-ff0ebf52cc52@notapiano>
References: <20230620000349.2122191-4-nfraprado@collabora.com>
 <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
 <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
 <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
 <6b41c5e4-bae9-4c99-8a28-7272c8a598a3@notapiano>
 <9c36cdbb-7204-f9ca-6191-88e0f0f71915@linaro.org>
 <132ec056-2186-4be5-9770-4d8c4d07bd76@notapiano>
 <6af2faf2-8624-948b-6efa-3bf00695293b@linaro.org>
 <aef120c8-bb25-476f-8976-7f699a851334@notapiano>
 <9bf3f3d0-9655-3549-1d1b-02816f51b666@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bf3f3d0-9655-3549-1d1b-02816f51b666@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:30:07PM +0200, Krzysztof Kozlowski wrote:
> On 26/06/2023 15:54, Nícolas F. R. A. Prado wrote:
> > On Fri, Jun 23, 2023 at 06:21:31PM +0200, Krzysztof Kozlowski wrote:
> >> On 21/06/2023 20:00, Nícolas F. R. A. Prado wrote:
> >>>>
> >>>> But anyway this variant comes with some set of regs and reg-names. Other
> >>>> variant comes with different set. In all cases they should be defined,
> >>>> even by "defined" means not allowed.
> >>>
> >>> I'm not sure what you mean. Are you suggesting to disable reg-names on mt8173?
> >>
> >> That's one of the options if for some reason you don't want to define them.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> But in a separate series we could drop vdecsys from mt8173's reg as well,
> >>>>> passing it as a syscon instead, which would solve the warning on that platform,
> >>>>> though some more driver changes would be needed to be able to handle it for that
> >>>>> SoC. The newer SoCs like mt8192, mt8195, etc, should also get vdecsys dropped
> >>>>> from their regs to have a correct memory description.
> >>>>>
> >>>>
> >>>> Sure, but I don't understand how does it affect defining and making
> >>>> specific regs/reg-names or keeping them loose.
> >>>
> >>> We need some way to tell in the driver whether the first reg is VDEC_SYS or not.
> >>> Since so far reg-names have not been used for the vcodec, the simplest, and
> >>> cleanest, way to do it, is to add reg-names when VDEC_SYS is not present. When
> >>> the other SoCs are updated to no longer have the first reg as VDEC_SYS, they
> >>> would also have reg-names added to their binding, to clearly indicate that.
> >>
> >> Don't use reg-names for that. The order of entries is anyway strict.
> > 
> > Since the order of entries is strict, if I remove VDEC_SYS from mt8183, I also
> > need to remove it from mt8173, is that what you mean?
> 
> It's different compatible, so it can have different entries.
> 
> 
> > I would still check for
> > the presence of reg-names in the driver to differentiate whether the old or new
> > binding is used, you just don't want different reg-names between compatibles in
> > the binding?
> 
> I wrote already what I want:
> 
>   In all cases they should be defined, even by "defined" means not allowed.
> 
> Now of course the best would be if the reg-names are always the same, at
> least in respect of order of items. This is what we try to do for all
> devices.
> 
> > 
> >>
> >>>
> >>> For example, for mt8173 we currently have
> >>>
> >>> 		vcodec_dec: vcodec@16000000 {
> >>> 			compatible = "mediatek,mt8173-vcodec-dec";
> >>> 			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
> >>> 			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
> >>> 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
> >>> 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
> >>> 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
> >>> 			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
> >>> 			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
> >>> 			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
> >>> 			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
> >>> 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
> >>> 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
> >>> 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
> >>>
> >>> In a future series, when removing VDEC_SYS from it, it would become
> >>>
> >>> 		vcodec_dec: vcodec@16020000 {
> >>> 			compatible = "mediatek,mt8173-vcodec-dec";
> >>> 			reg = <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
> >>> 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
> >>> 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
> >>> 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
> >>> 			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
> >>> 			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
> >>> 			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
> >>> 			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
> >>> 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
> >>> 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
> >>> 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
> >>> 			reg-names = "misc", "ld", "top", "cm", "ad", "av", "pp",
> >>>                                     "hwd", "hwq", "hwb", "hwg";
> >>
> >> So you want to use reg-names to avoid ABI break. This is not the reason
> >> not to define reg-names for other case.
> > 
> > There will be an ABI break anyway when the first reg is removed (as shown
> > above), I'm just trying to avoid churn: adding a reg-name that will be removed
> > later.
> 
> So remove the reg-name now and there will be no "later"?

OK, I'll send a v4 with VDEC_SYS also removed from mt8173.

Thanks,
Nícolas
