Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594466525C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiLTRvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLTRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:51:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F5F63B9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:51:06 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f34so4533864lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHl7DUyTvcef1vakQykBmVgLoqu1XzqD5qrW5toutx8=;
        b=UyedfnEMy2lSwu/EBpuJhNdb3wzwTdWwFSC0sXbM3PC/QP1MLNsYgUgAzLnzztmNka
         z+pdmgzehGNKyMT8Rqe+xwh/prIRMsSZtHnu4dxFqgszYUUuYRLtYAybQ3rSkctKs2B+
         uW8TVUuWpPBWnix9cuctglLtFfdc7D3w12JTMDaELW/87Aby32HzrDdH5bvfaA7XCMJi
         /gYr0/mN0cIHe74gF5arbR4mNULIyO+Tt9hW8lcT6/yiWGBrAt5+h4bIimh1aw9gNq+9
         VSjoU6eARQZgp8NCUbVzpS5lKIbMS9euOeidPTfXgh3Di/PT+9oqMhk0q8KEmsZAn06P
         loFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHl7DUyTvcef1vakQykBmVgLoqu1XzqD5qrW5toutx8=;
        b=0PcAwJ4RhOcNFB/W6BnRsNFGnmQT6BT8LKx9EAeQgmA8Hx5bVgTx3mS4C0lSkhXrPp
         9dpUpSUMnR3crKy/7midKZwXSi+McNVnKclHdqKJLDFhvypsIs6o2Ai2CbxAaUwB5Iyj
         EZmzuiu7dZ1xc+7gzGL5uK7vCn0JbwFPWeHOYzJ4u3HQmL+o/2/uE75bq3bl0b3b2wdd
         8ymkLQZuBUEfp/8Ben1qHzR2s5XbJT7jpJ7rFuGNKk7YzYE5sgvM/xUTYlvt6UHQez5q
         ljDeiAx7rc95BHLCeZj52Xw9Olxrj0mh7STMdaebN/xzeKficbbTNsKbD7nYk+GZbxN2
         7OaQ==
X-Gm-Message-State: AFqh2kpjRHkgvKIu4kQ3+dEPtgN5jQLk/KTGOG5s62/xqHMT/ZbkhL8P
        LgFApbg4o3DS8xpy/LSy6UBzZ/stcPQaT/5AhOfoHIq2GRUdjw==
X-Google-Smtp-Source: AMrXdXt+Nku7xH6nEaUhF0SiqYoWvfNx12ABoprTKiUiAMc9hp8K4cjh3AUli4aNe5/k65ZfLHl2dO4nl150orWJVrc=
X-Received: by 2002:a05:6512:251e:b0:4c1:1e10:e36d with SMTP id
 be30-20020a056512251e00b004c11e10e36dmr696127lfb.286.1671558664984; Tue, 20
 Dec 2022 09:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
 <20221219215431.GB26315@pengutronix.de> <CAAEAJfBzZWHu9YE38HzRUQ2xRZohYa19JaK7EOaQDqz5K1sz_g@mail.gmail.com>
 <20221220134003.GC26315@pengutronix.de> <c3f40678b49b137e7caaa51778389caee59d8d6f.camel@ndufresne.ca>
In-Reply-To: <c3f40678b49b137e7caaa51778389caee59d8d6f.camel@ndufresne.ca>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 20 Dec 2022 14:50:53 -0300
Message-ID: <CAAEAJfCOt0SEsLBAL0bK2nY6uChVO5ORfdnmgPWnTwYTy9oGuw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Michael Grzeschik <mgr@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bonjour Nicolas,

On Tue, Dec 20, 2022 at 2:15 PM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mardi 20 d=C3=A9cembre 2022 =C3=A0 14:40 +0100, Michael Grzeschik a =
=C3=A9crit :
> > Hi Ezequiel,
> >
> > On Mon, Dec 19, 2022 at 10:52:02PM -0300, Ezequiel Garcia wrote:
> > > On Mon, Dec 19, 2022 at 6:54 PM Michael Grzeschik <mgr@pengutronix.de=
> wrote:
> > > > On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
> > > > > On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
> > > > > <benjamin.gaignard@collabora.com> wrote:
> > > > > >
> > > > > > This series implement AV1 stateless decoder for RK3588 SoC.
> > > > > > The harware support 8 and 10 bits bitstreams up to 7680x4320.
> > > > > > AV1 feature like film grain or scaling are done by the postproc=
essor.
> > > > > > The driver can produce NV12_4L4 and NV12 pixel formats.
> > > > > > A native 10bits NV12_4L4 format is possible but need more inves=
tigation
> > > > > > to be completly documented and enabled.
> > > > > >
> > > > > > It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patc=
hes and
> > > > > > Sebastian's device-tree patches for RK3588.
> > > > > >
> > > > >
> > > > > I thought the AV1 decoder in RK3588 was really a separate hardwar=
e
> > > > > from the Hantro G1/G2.
> > > > >
> > > > > Shouldn't this need a new driver for this new hardware?
> > > >
> > > > Just jumping into this discussion as I am currently working on the =
rkvenc driver.
> > > >
> > >
> > > The more the merrier, there's always room for developers :-)
> > >
> > > > In my case I am extending the rkvdec driver to become more generic =
for
> > > > other rockchip specific enc/decoders.
> > > >
> > > > My first change looks like this:
> > > > ---
> > > >  drivers/staging/media/rkvdec/Makefile              |   4 +-
> > > >  drivers/staging/media/rkvdec/rkvdec-h264.c         | 100 ++++-----
> > > >  drivers/staging/media/rkvdec/rkvdec-vp9.c          | 142 ++++++---=
----
> > > >  drivers/staging/media/rkvdec/{rkvdec.c =3D> rkvpu.c} | 510 +++++++=
++++++++++++++++-----------------------
> > > >  drivers/staging/media/rkvdec/{rkvdec.h =3D> rkvpu.h} |  66 +++---
> > > > ---
> > > >
> > > > While working on other parts of the encoder I found many places in =
the
> > > > rkvdec driver (e.g. v4l2 and vb2 callbacks) that looked familiar to=
 the hantro
> > > > functions but where limited to the decoder case.
> > > >
> > >
> > > Because stateless decoders devices are very similar in their general =
behavior,
> > > their drivers could be very similar.
> > >
> > > Hantro and Rkvdec could look similar because the same humans worked o=
n them.
> > >
> > > Most boilerplate code, as well as V4L2 format negotiation, VB2 buffer=
 handling
> > > could be shared among all stateless decoder drivers. I think even at =
one point
> > > we experimented with having a shared/common code base for all statele=
ss codecs.
> > >
> > > In other words, it's entirely possible to support Hantro devices in
> > > the Cedrus driver
> > > and vice-versa, you would only have to write the hardware-specific bi=
ts.
> > >
> > > However, there is consensus to have a separate driver for each
> > > different hardware,
> > > even when the hardware is a bit similar. This may lead to some code d=
uplication,
> > > but it's less fragile / more flexible. Maintaining drivers this way a=
llows
> > > developers to evolve, testing on a small family of devices, without
> > > breaking support
> > > for other devices.
> > >
> > > This is important as sometimes it's hard to get the hardware,
> > > but we still don't want to break the support!
> > >
> > > > I think there are two options for the av1 codec.
> > > >
> > > > 1) If the vpu981 is a driver that has nothing to do with verisilico=
n but
> > > > works with this driver framework, then we should integrate vepu981 =
into it
> > > > but consider rename the verisilicon unrelated parts to something ge=
neric.
> > > >
> > > > 2) Move the vepu981 av1 driver into the rkvdec instead.
> > > >
> > > > If 1) is the way to go, we can even think of moving the staging cod=
e parts from
> > > > rkvdec to the verisilicon code. Likewise to the vepu981-av1.
> > > >
> > >
> > > The Hantro driver should only support G1, G2, and VC8000D;
> > > which can be said to belong to the same family.
> > >
> > > The RKVDEC driver supports Rockchip vdpu34x core. I have to admit
> > > I'm not exactly sure if we support anything else than vdpu34x.
> >
> > Currently the rkvdec is only supporting vdpu34x. My work would integrat=
e
> > vepu54x into the rkvdec boilerplate and so it would support encode as d=
ecode.
>
> Which CODEC do you currently work on ? We are about to send a first RFC f=
or a
> VP8 stateless encoder API (with a rk3399 driver to test), but haven't wri=
tten
> the Stateless Encoder API spec yet, so still some work there. And was pla=
nning
> to make an H.264 Sateless Encoder soon. Would be nice to avoid duplicatin=
g the
> effort.
>
> >
> > > I'm not familiar with the AV1 support provided by this patch,
> > > but looking at the mpp code:
> > >
> > > ...
> > >        "rk3588",
> > >        ROCKCHIP_SOC_RK3588,
> > >        HAVE_VDPU2 | HAVE_VDPU2_PP | HAVE_VEPU2 | HAVE_RKVDEC | HAVE_R=
KVENC |
> > >        HAVE_JPEG_DEC | HAVE_AV1DEC | HAVE_AVSDEC | HAVE_VEPU2_JPEG,
> > >        {   &vdpu38x, &rkjpegd, &vdpu2, &vdpu2_jpeg_pp, &av1d, &avspd}=
,
> > >        {   &vepu58x, &vepu2, &vepu2_jpeg, NULL, },
> > >
> > > Seems RK3588 supports a Hantro core (VDPU2), a vdpu38x core and this =
AV1 core,
> > > which according to this patchset is vdpu981 (?)
> > >
> > > If the vdpu38x device interface, configuration, buffer handling and
> > > registers are
> > > similar enough with vdpu34x, adding vdpu38x to the Rkvdec driver
> > > should be straightforward.
> > > If the vdpu38x core differs, it may be reason enough to consider a ne=
w driver.
> > >
> > > As for vdpu981 (AV1), I'm inclined to think it deserves its own drive=
r.
>
> Well, it has its own driver, Hantro (which is not rkvdec). But maybe you =
could
> extend on why you think VC9000D decoder have no place in the hantro/veris=
ilicon
> family ?
>

Oh good, then the AV1 core in RK3588 is actually a Verisilicon VC9000D core=
,
I didn't know that.

Maybe the naming in the driver should be vc9000? Or maybe it should be note=
d
in comments and documentation. If that was already documented somewhere
in this patchset, then I definitely missed it.

> > >
> > > Again, I'm far less worried for a little code duplication in the
> > > boilerplate (which can be solved
> > > with helpers, etc.) and more worried about making sure we can evolve
> > > drivers easily,
> > > while minimizing regressions.
> >
> > Thanks for the explanation.
> >
> > As I agree that not breaking current drivers is a strong argument. Also
> > rkvdec is still in staging, which makes it less harmful for the
> > integration of the encoder path.
>
> We are working on unstaging patches.
>

Rkvdec can be unstaged.

Sebastian: I remember you were working on Rkvdec.
If you want to unstage this driver now, and work on features later,
I believe that would make a lot of sense!

Thanks!
Ezequiel


> >
> > Since we can not ensure that the rkvenc/rkvdec is not another unknown
> > verisilicon core, going the way of working on a common rkvpu driver is
> > probably the best for now.
>
> We can collectively share our knowledge (to the limit of our legal rights=
 to
> share) make the right call. In the case of this VC9000D decoder, there is=
 a
> massive amount of registers that aren't AV1 specific, and existed in VC80=
00
> cores as it, same offset, same size. Hantro designs have this very specif=
ic
> style, which is to share register, giving it a meaning for multiple CODEC=
s.
>
> I've commented about that in my review, but until we have more codecs sup=
port on
> VC9000 cores, generalizing the register definition is premature.
>
> Though, an typical example of things that are Hantro specific and common =
to G1,
> VC8000 and VC9000, is the handling of references for H.264 decoding. This
> differs massively from how it works with rkvdec here.
>
> >
> > Also, since I have already done some work into that direction, it sound=
s
> > good for me. :)
>
> Great. For you interest, the modified Hantro H1 encoder is an information=
 that
> Rockchip disclosed to us directly. And that whys vepu121 (if my memory is=
 right)
> is implemented in Hantro driver. The register layout have been altered by=
 RK but
> that's all there is, it does share semantic (and a lot of code) with the =
"real"
> H1 found on RK3288, IMX8M Mini and others.
>
> >
> >
> > > > I could also keep on integrating the rkvenc on that base instead.
> > > >
> > > > Regards,
> > > > Michael
> > > >
> > > > > > The full branch can be found here:
> > > > > > https://gitlab.collabora.com/linux/for-upstream/-/commits/rk358=
8_av1_decoder_v1
> > > > > >
> > > > > > Fluster score is: 151/239 while testing AV1-TEST-VECTORS with G=
Streamer-AV1-V4L2SL-Gst1.0.
> > > > > > The failing tests are:
> > > > > > - 10bits bitstream because 10bits output formats aren't yet imp=
lemented.
> > > > > > - the 2 tests with 2 spatial layers: few errors in luma/chroma =
values
> > > > > > - tests with resolution < hardware limit (64x64)
> > > > > >
> > > > > > Benjamin
> > > > > >
> > > > > > Benjamin Gaignard (9):
> > > > > >   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
> > > > > >   media: verisilicon: Add AV1 decoder mode and controls
> > > > > >   media: verisilicon: Save bit depth for AV1 decoder
> > > > > >   media: verisilicon: Check AV1 bitstreams bit depth
> > > > > >   media: verisilicon: Compute motion vectors size for AV1 frame=
s
> > > > > >   media: verisilicon: Add AV1 entropy helpers
> > > > > >   media: verisilicon: Add Rockchip AV1 decoder
> > > > > >   media: verisilicon: Add film grain feature to AV1 driver
> > > > > >   media: verisilicon: Enable AV1 decoder on rk3588
> > > > > >
> > > > > >  .../bindings/media/rockchip-vpu.yaml          |    1 +
> > > > > >  drivers/media/platform/verisilicon/Makefile   |    3 +
> > > > > >  drivers/media/platform/verisilicon/hantro.h   |    5 +
> > > > > >  .../media/platform/verisilicon/hantro_drv.c   |   54 +
> > > > > >  .../media/platform/verisilicon/hantro_hw.h    |  102 +
> > > > > >  .../platform/verisilicon/hantro_postproc.c    |    3 +
> > > > > >  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
> > > > > >  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++=
++++++++
> > > > > >  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
> > > > > >  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
> > > > > >  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
> > > > > >  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
> > > > > >  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
> > > > > >  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
> > > > > >  14 files changed, 8291 insertions(+)
> > > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip=
_av1_entropymode.c
> > > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip=
_av1_entropymode.h
> > > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip=
_av1_filmgrain.c
> > > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip=
_av1_filmgrain.h
> > > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip=
_vpu981_hw_av1_dec.c
> > > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip=
_vpu981_regs.h
> > > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > >
> > > >
> > > > --
> > > > Pengutronix e.K.                           |                       =
      |
> > > > Steuerwalder Str. 21                       | http://www.pengutronix=
.de/  |
> > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917=
-0    |
> > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917=
-5555 |
> > >
> >
>
