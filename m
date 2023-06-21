Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484E738DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjFUSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjFUSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:00:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FCB1718;
        Wed, 21 Jun 2023 11:00:30 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B4B36606FA9;
        Wed, 21 Jun 2023 19:00:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687370429;
        bh=P6a2YJJtdgJE1gC8mOAypJJLVdLw7Ezj0uj6ugyTJuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PG5bR4gF4KkhQaqj9WVSAU4fCjAQUEvnZsorE2wLZSUxqvvUPYtBJggaf2uYb9sUV
         5zEf4jbOkf88qWy2NmofztPQXZyHUxMm+NmApNico5ZsFvEKl6NwyHglOqJA0+Q8zw
         gwVW7mFkrOp6TrsRamcC/BqIBiaqcltAC1524BgfuY90RTgwm6q3GTKB+v4D1VG0yw
         JitAArkDC7UiUXxwrvsFhxn68gVc8N+UiTaq+BJrxhXQc9qI5ZfM9WSFYZBEKOGwm/
         LrbWLqccjY0bvTnymni+NKVLRmkQmvVmRtdGUKIzWQcc8rM41cP1VMdlRzZgkto0lf
         7+m4uhta8RGAA==
Date:   Wed, 21 Jun 2023 14:00:21 -0400
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
Message-ID: <132ec056-2186-4be5-9770-4d8c4d07bd76@notapiano>
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-4-nfraprado@collabora.com>
 <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
 <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
 <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
 <6b41c5e4-bae9-4c99-8a28-7272c8a598a3@notapiano>
 <9c36cdbb-7204-f9ca-6191-88e0f0f71915@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c36cdbb-7204-f9ca-6191-88e0f0f71915@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:41:49AM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2023 18:31, Nícolas F. R. A. Prado wrote:
> > On Tue, Jun 20, 2023 at 03:00:00PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/06/2023 14:46, Nícolas F. R. A. Prado wrote:
> >>> On Tue, Jun 20, 2023 at 10:12:14AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 20/06/2023 02:03, Nícolas F. R. A. Prado wrote:
> >>>>> The binding expects the first register space to be VDEC_SYS. But on
> >>>>> mt8183, which uses the stateless decoders, this space is used only for
> >>>>> controlling clocks and resets, which are better described as separate
> >>>>> clock-controller and reset-controller nodes.
> >>>>>
> >>>>> In fact, in mt8173's devicetree there are already such separate
> >>>>> clock-controller nodes, which cause duplicate addresses between the
> >>>>> vdecsys node and the vcodec node. But for this SoC, since the stateful
> >>>>> decoder code makes other uses of the VDEC_SYS register space, it's not
> >>>>> straightforward to remove it.
> >>>>>
> >>>>> In order to avoid the same address conflict to happen on mt8183,
> >>>>> since the only current use of the VDEC_SYS register space in
> >>>>> the driver is to read the status of a hardware controlled clock, remove
> >>>>> the VDEC_SYS register space from the binding and describe an extra
> >>>>> syscon that will be used to directly check the hardware status.
> >>>>>
> >>>>> Also add reg-names to be able to tell that this new register schema is
> >>>>> used, so the driver can keep backward compatibility.
> >>>>>
> >>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> >>>>>
> >>>>> ---
> >>>>> I dropped the tags from this commit since a syscon is now used instead
> >>>>> of an extra clock.
> >>>>>
> >>>>> Changes in v3:
> >>>>> - Removed the active clock
> >>>>> - Added a mediatek,vdecsys syscon property
> >>>>>
> >>>>> Changes in v2:
> >>>>> - Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
> >>>>>   clock for mt8183) to avoid changing number of clocks twice
> >>>>> - Added maxItems to reg-names
> >>>>> - Constrained clocks for each compatible
> >>>>> - Reordered properties for each compatible
> >>>>>
> >>>>>  .../media/mediatek,vcodec-decoder.yaml        | 30 +++++++++++++++++++
> >>>>>  1 file changed, 30 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> >>>>> index 1e56ece44aee..2f625c50bbfe 100644
> >>>>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> >>>>> @@ -21,8 +21,13 @@ properties:
> >>>>>        - mediatek,mt8183-vcodec-dec
> >>>>>  
> >>>>>    reg:
> >>>>> +    minItems: 11
> >>>>>      maxItems: 12
> >>>>>  
> >>>>> +  reg-names:
> >>>>> +    minItems: 11
> >>>>> +    maxItems: 11
> >>>>
> >>>> maxItems: 12
> >>>>
> >>>>> +
> >>>>>    interrupts:
> >>>>>      maxItems: 1
> >>>>>  
> >>>>> @@ -60,6 +65,10 @@ properties:
> >>>>>      description:
> >>>>>        Describes point to scp.
> >>>>>  
> >>>>> +  mediatek,vdecsys:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>> +    description: Phandle to the vdecsys syscon node.
> >>>>> +
> >>>>>  required:
> >>>>>    - compatible
> >>>>>    - reg
> >>>>> @@ -79,8 +88,26 @@ allOf:
> >>>>>      then:
> >>>>>        required:
> >>>>>          - mediatek,scp
> >>>>> +        - mediatek,vdecsys
> >>>>>  
> >>>>>        properties:
> >>>>> +        reg:
> >>>>> +          maxItems: 11
> >>>>> +
> >>>>> +        reg-names:
> >>>>> +          items:
> >>>>> +            - const: misc
> >>>>> +            - const: ld
> >>>>> +            - const: top
> >>>>> +            - const: cm
> >>>>> +            - const: ad
> >>>>> +            - const: av
> >>>>> +            - const: pp
> >>>>> +            - const: hwd
> >>>>> +            - const: hwq
> >>>>> +            - const: hwb
> >>>>> +            - const: hwg
> >>>>> +
> >>>>>          clocks:
> >>>>>            minItems: 1
> >>>>>            maxItems: 1
> >>>>> @@ -101,6 +128,9 @@ allOf:
> >>>>>          - mediatek,vpu
> >>>>>  
> >>>>>        properties:
> >>>>> +        reg:
> >>>>> +          minItems: 12
> >>>>
> >>>>
> >>>> What about reg-names here? They should be also defined and in sync with
> >>>> regs.
> >>>
> >>> That's intentional. As described in the commit message, mt8173 will keep having
> >>> the VDEC_SYS iospace, while mt8183 won't. And we use the presence of reg-names
> >>> to tell them apart.
> >>>
> >>> So, mt8173 has 12 regs, no reg-names and no syscon, while mt8183 has 11 regs,
> >>> with reg-names and the syscon.
> >>
> >> reg-names is not the way to tell apart variants. Compatible is. If you
> >> add reg-names for one variant, it's expected to have it defined for
> >> other as well, because the order of items in reg is always fixed.
> > 
> > But differentiating with compatible in this case would be wrong, since it's not
> > not something inherent to the SoC. We really just want to be able to tell
> > whether the vdecsys iospace is supplied as a reg or as a syscon.
> 
> Wait, you should not have one device or even family of devices taking
> their IO space with two different methods. It's exactly the same device,
> the same bus.

The VDEC_SYS IO space is arguably not part of the vcodec IO space, since it is
declared by a different node. Hence we shouldn't be getting it through reg, but
instead through a syscon, to avoid clashing addresses.

In other words, the VDEC_SYS IO space shouldn't have been in the binding as a
'reg' in the first place. And since we want to:
1. Keep backward compatibility
2. Fix the 'duplicate unit-address' DT warning

We will need to support both ways - reg or syscon - of passing the VDEC_SYS IO
space moving forward.

> 
> > 
> > This series focuses on getting the mt8183 decoder working, and as part of that
> > introduces the binding and DT node for mt8183 with vdecsys as a syscon instead
> > of a reg, to avoid introducing new 'duplicate unit-address' DT warnings.
> 
> I got patches 1, 2, 3 and 6, nothing more so I cannot comment on what
> else you are trying to do here. Since you did not cc me, it's not relevant.

That's ok, the driver changes aren't relevant to this discussion.

> 
> Your DTS change does nothing like switching from MMIO to syscon.

The original downstream DT node used MMIO for VDEC_SYS, but I've adapted that
commit to use a syscon. So the commit is implicitly doing the switch, it just
doesn't show because the node wasn't upstreamed before on mt8183.

> 
> But anyway this variant comes with some set of regs and reg-names. Other
> variant comes with different set. In all cases they should be defined,
> even by "defined" means not allowed.

I'm not sure what you mean. Are you suggesting to disable reg-names on mt8173?

> 
> > 
> > But in a separate series we could drop vdecsys from mt8173's reg as well,
> > passing it as a syscon instead, which would solve the warning on that platform,
> > though some more driver changes would be needed to be able to handle it for that
> > SoC. The newer SoCs like mt8192, mt8195, etc, should also get vdecsys dropped
> > from their regs to have a correct memory description.
> > 
> 
> Sure, but I don't understand how does it affect defining and making
> specific regs/reg-names or keeping them loose.

We need some way to tell in the driver whether the first reg is VDEC_SYS or not.
Since so far reg-names have not been used for the vcodec, the simplest, and
cleanest, way to do it, is to add reg-names when VDEC_SYS is not present. When
the other SoCs are updated to no longer have the first reg as VDEC_SYS, they
would also have reg-names added to their binding, to clearly indicate that.

For example, for mt8173 we currently have

		vcodec_dec: vcodec@16000000 {
			compatible = "mediatek,mt8173-vcodec-dec";
			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */

In a future series, when removing VDEC_SYS from it, it would become

		vcodec_dec: vcodec@16020000 {
			compatible = "mediatek,mt8173-vcodec-dec";
			reg = <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
			reg-names = "misc", "ld", "top", "cm", "ad", "av", "pp",
                                    "hwd", "hwq", "hwb", "hwg";
			mediatek,vdecsys = <&vdecsys>;

Thanks,
Nícolas
