Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACA672C988
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjFLPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbjFLPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A198;
        Mon, 12 Jun 2023 08:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8481861E2D;
        Mon, 12 Jun 2023 15:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8ACC433D2;
        Mon, 12 Jun 2023 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686582905;
        bh=dGC149c5x01RTzK/Vu79dUHLei19YO73aaltgb70V8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yz7WOJ9+2MdrrAB7Pu166c9/NWzPb/G53ppcA3TywMNI0ghx0CvTLpr2SkwqeMS/l
         zJuAc95rD8LjN4nwHGn0O7wmSH0uxEp+M9z56ZPfhIjkzMtVW7xYq7Bbbg9WuGKqIa
         ViB9KeD13dEkiLDGZwqGZaaz4my+ePX5gH/HhI7XflKDZmweXD2VPXdgoPLlO475Ni
         JATJY/Uea9wMGDT6BSa1Di3EBpewvTORQMx8sg2RwpoUf3Eb95VPiMAp/CMbNyu7QT
         F3RzcJsHxY/yku5H8fFk1c26LoChFrHz+CySAOjRtJRxDDDnzxVKBxZU0NAmBJm7CD
         lrHA6UZlJ/kuA==
Date:   Mon, 12 Jun 2023 17:15:03 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm: gem: add an option for supporting the dma-coherent
 hardware.
Message-ID: <lebytp7civogcw3eluwja74g5w4jvpnjug7jp4ec5rzuch6wu6@inmzzvnaozuq>
References: <20230607053053.345101-1-suijingfeng@loongson.cn>
 <d4378aad1cf179d308068ef6072c5c7ff2bf2502.camel@crapouillou.net>
 <6db23d14-652e-4b13-24cb-bfb92fa3faed@loongson.cn>
 <e9714a0c29b1c4268081827571ad2545b0e6d5ec.camel@crapouillou.net>
 <d5494751-0af0-42f6-bcad-f75415e4a6bd@loongson.cn>
 <2dd4c870a5605a79105fb621c97a5f59a18c8c24.camel@crapouillou.net>
 <ae085320-c93c-5d96-58ef-c5ee8b58c306@loongson.cn>
 <i2odidvev3ztxit4iv4ndxcuk4opckgs5fg4jjjfrq5nike35u@mlo7hshexe2n>
 <f9cef1ed-fc46-bad5-e2d7-b734aaeb16c1@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtzbhhtxjptopns7"
Content-Disposition: inline
In-Reply-To: <f9cef1ed-fc46-bad5-e2d7-b734aaeb16c1@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtzbhhtxjptopns7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 04:17:52PM +0800, Sui Jingfeng wrote:
> Hi,
>=20
> On 2023/6/8 15:39, Maxime Ripard wrote:
> > On Thu, Jun 08, 2023 at 01:18:38AM +0800, Sui Jingfeng wrote:
> > > Hi,
> > >=20
> > > On 2023/6/8 00:12, Paul Cercueil wrote:
> > > > Hi Sui,
> > > >=20
> > > > Le mercredi 07 juin 2023 =E0 22:38 +0800, Sui Jingfeng a =E9crit=A0:
> > > > > Hi,=A0 welcome to discussion.
> > > > >=20
> > > > >=20
> > > > > I have limited skills in manipulating English.
> > > > >=20
> > > > > It may not express what I'm really means in the short time.
> > > > >=20
> > > > > Part of word in the sentence may not as accurate as your.
> > > > >=20
> > > > > Well, please don't misunderstand, I'm not doing the rude to you.
> > > > No problem.
> > > >=20
> > > > > I will explain it with more details.
> > > > >=20
> > > > > See below:
> > > > >=20
> > > > >=20
> > > > > On 2023/6/7 20:09, Paul Cercueil wrote:
> > > > > > Hi Sui,
> > > > > >=20
> > > > > > Le mercredi 07 juin 2023 =E0 18:30 +0800, Sui Jingfeng a =E9cri=
t=A0:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 2023/6/7 17:36, Paul Cercueil wrote:
> > > > > > > > Hi Sui,
> > > > > > > >=20
> > > > > > > > Le mercredi 07 juin 2023 =E0 13:30 +0800, Sui Jingfeng a =
=E9crit=A0:
> > > > > > > > > The single map_noncoherent member of struct
> > > > > > > > > drm_gem_dma_object
> > > > > > > > > may
> > > > > > > > > not
> > > > > > > > > sufficient for describing the backing memory of the GEM
> > > > > > > > > buffer
> > > > > > > > > object.
> > > > > > > > >=20
> > > > > > > > > Especially on dma-coherent systems, the backing memory is
> > > > > > > > > both
> > > > > > > > > cached
> > > > > > > > > coherent for multi-core CPUs and dma-coherent for periphe=
ral
> > > > > > > > > device.
> > > > > > > > > Say architectures like X86-64, LoongArch64, Loongson Mips=
64,
> > > > > > > > > etc.
> > > > > > > > >=20
> > > > > > > > > Whether a peripheral device is dma-coherent or not can be
> > > > > > > > > implementation-dependent. The single map_noncoherent opti=
on
> > > > > > > > > is
> > > > > > > > > not
> > > > > > > > > enough
> > > > > > > > > to reflect real hardware anymore. For example, the Loongs=
on
> > > > > > > > > LS3A4000
> > > > > > > > > CPU
> > > > > > > > > and LS2K2000/LS2K1000 SoC, peripheral device of such hard=
ware
> > > > > > > > > platform
> > > > > > > > > allways snoop CPU's cache. Doing the allocation with
> > > > > > > > > dma_alloc_coherent
> > > > > > > > > function is preferred. The return buffer is cached, it sh=
ould
> > > > > > > > > not
> > > > > > > > > using
> > > > > > > > > the default write-combine mapping. While with the current
> > > > > > > > > implement,
> > > > > > > > > there
> > > > > > > > > no way to tell the drm core to reflect this.
> > > > > > > > >=20
> > > > > > > > > This patch adds cached and coherent members to struct
> > > > > > > > > drm_gem_dma_object.
> > > > > > > > > which allow driver implements to inform the core. Introdu=
cing
> > > > > > > > > new
> > > > > > > > > mappings
> > > > > > > > > while keeping the original default behavior unchanged.
> > > > > > > > Did you try to simply set the "dma-coherent" property to the
> > > > > > > > device's
> > > > > > > > node?
> > > > > > > But this approach can only be applied for the device driver w=
ith
> > > > > > > DT
> > > > > > > support.
> > > > > > >=20
> > > > > > > X86-64, Loongson ls3a4000 mips64, Loongson ls3a5000 CPU typic=
ally
> > > > > > > do
> > > > > > > not
> > > > > > > have DT support.
> > > > > > >=20
> > > > > > > They using ACPI to pass parameter from the firmware to Linux
> > > > > > > kernel.
> > > > > > >=20
> > > > > > > You approach will lost the effectiveness on such a case.
> > > > > > Well, I don't really know how ACPI handles it - but it should j=
ust
> > > > > > be a
> > > > > > matter of setting dev->dma_coherent. That's basically what the =
DT
> > > > > > code
> > > > > > does.
> > > > > >=20
> > > > > > Some MIPS boards set it in their setup code for instance.
> > > > > >=20
> > > > > This is a *strategy*, not a *mechanism*.
> > > > >=20
> > > > > In this case, DT is just used to describing the hardware.
> > > > >=20
> > > > > (It is actually a hardware feature describing language, the
> > > > > granularity
> > > > > is large)
> > > > >=20
> > > > > It does not changing the state of the hardware.
> > > > >=20
> > > > > It's your platform firmware or kernel setting up code who actuall=
y do
> > > > > such a things.
> > > > >=20
> > > > >=20
> > > > > It's just that it works on *one* platform, it does not guarantee =
it
> > > > > will
> > > > > works on others.
> > > > If you add the "dma-coherent" property in a device node in DT, you
> > > > effectively specify that the device is DMA-coherent; so you describe
> > > > the hardware, which is what DT is for, and you are not changing the
> > > > state of the hardware.
> > > >=20
> > > > Note that some MIPS platforms (arch/mips/alchemy/common/setup.c)
> > > > default to DMA-coherent mapping; I believe you could do something
> > > > similar with your Loongson LS3A4000 CPU and LS2K2000/LS2K1000 SoC.
> > > >=20
> > > The preblem is that device driver can have various demand.
> > >=20
> > > It probably want to create different kind of buffers for different th=
ing
> > > simultaneously.
> > >=20
> > > Say, one allocated with dma_alloc_coherent for command buffer or dma
> > > descriptor
> > >=20
> > > another one allocated with=A0 dma_alloc_wc for uploading shader etc.
> > >=20
> > > also has the third one allocated with dma_alloc_noncoherent() for doi=
ng some
> > > else.
> > And it will work just fine.
> >=20
> > struct device dma_coherent, or DT's dma-coherent property define that
> > the device doesn't need any kind of cache maintenance, ever. If it's
> > missing, we need to perform cache maintenance to keep coherency.
> >=20
> > dma_alloc_* functions provide guarantees to the driver. With
> > dma_alloc_wc and dma_alloc_coherent, the buffer is coherent, and thus
> > you don't need to perform cache maintenance operations by hand in the
> > driver.
>=20
> BO returned by dma_alloc_wc() doesn't works on some platform.

What do you mean by "it doesn't work" ? Because then, it's definitely
the platform that's broken if it doesn't provide a coherent buffer.

> This may only guarantee for the CPU side. There is no guarantee for
> the GPU side.
>=20
> For example, the GPU always snoop CPU's cache. The GPU fetch data from
> the CPU's cache if hit.
>=20
> if not hit, the GPU fetch the data from the system RAM.

Right, that's still a coherent buffer.

> But when call dma_alloc_wc(), the BO at cpu side is marked as write
> combine property.
>=20
> The write buffer within the CPU will gather the CPU side write access.
>=20
> This is to say, there may have some data reside(stall) in the write buffe=
r.
>=20
> while the GPU will fetch data from the system RAM or CPU's cache.
>=20
> the GPU will fetch wrong data.

If that's the case, your buffer isn't coherent, and your platform
probably breaks the expectations of the DMA API.

> This is the condition for our hardware, I don't know how does the ARM
> platform guarantee
>=20
> the coherency in this case.
>
> If it relay on software to guarantee, then it is still non hardware
> maintained coherency.
>=20
>=20
> When it relay on software, I called it implement-dependent.
>=20
> there are some archs without the implement or don't know how to implement.
>=20
>=20
> If it can't even snoop cpu's cache, I don't believe it can snoop cpu's wr=
ite
> buffer.
>=20
> I not sure dma api can do guarantee for all arch.
>=20
>=20
> > With dma_alloc_noncoherent, the buffer is non-coherent and the driver
> > needs to perform them when relevant.
> >=20
> > How those buffers are created is platform specific, but the guarantees
> > provided *to the driver* are always there.
> >=20
> > A buffer allocated with dma_alloc_coherent might be provided by
> > different means (at the hardware level with a coherency unit, by mapping
> > it non-cacheable), but as far as the driver is concerned it's always
> > going to be coherent.
> >=20
> > Similarly, a driver using dma_alloc_noncoherent will always require
> > cache maintenance operations to use the API properly, even if the
> > hardware provides coherency (in which case, those operations will be
> > nop).
> >=20
> > So, yeah, like I was saying in the other mail, it looks like you're
> > confusing a bunch of things. dma_alloc_* functions are about the driver
> > expectations and guarantees. DT's dma-coherent property is about how we
> > can implement them on a given platform.
>=20
> That is ideal situation.
>=20
> You don't have seen the actual bugs.

Probably not :)

> Yeah, I do have a bit confusing about the DMA api.
>=20
> Maybe you and Paul can continue work on this.

As far as I'm concerned, there's nothing to fix but your platform
support. I won't work on that.

> But DT's dma-coherent property is definitely not a system level
> solution.
>=20
> drm/amdgpu, drm/radeon and drm/i915 don't support DT.
>=20
> If ARM is dma-noncoherent, I suspect drm/amdgpu, drm/radeon will not
> works on ARM.
>=20
> there no function call dma_sync_for_device() dma_sync_for_cpu() etc
>=20
> These driver assume dma-coherent hardware.

No, these drivers assume they have a dma-coherent *buffer*. Which on
devices that don't get hardware coherency mean that they probably get a
non-cacheable buffer.

Maxime

--dtzbhhtxjptopns7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIc2dwAKCRDj7w1vZxhR
xX+KAP0f01Nyls5VR0A4BOxlsfmnHMEa2CQZB8CAewfcNEhfwgD9GFfwHIQI4Wy1
nJs179eAwl3YIf5EMc3ffWlphla2SQU=
=SfdS
-----END PGP SIGNATURE-----

--dtzbhhtxjptopns7--
