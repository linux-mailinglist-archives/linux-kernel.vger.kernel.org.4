Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB66541D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLVNYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLVNYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:24:33 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FD25B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:24:29 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a19so1919893ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNFKcj1qpbmt/ipOHNu4Y7YMRQo6qwIPI6XtcYqqxxk=;
        b=h+4khsq2a+yHcK26zB7P+5KylxOjG9Hpm44ZDNteZ29sI9ZPAstX1ADFnbyLDJ1zFf
         WuoZLuEQkAwtUgBcQjLM5FsxSVGZ18DNUGMtyc0bP4UyQf8JjxCAE/uv7t66mr+Eeyiv
         wBMhWondgDZ/b08quadOY72zYaLdfRuEpBGDVpaxC7mKCT/O/5u7LnoG7KTqSLU/oUzN
         UjJ6HBTjK3ANi5+QEvavijJXInuUJA+PG8SlTCjKF6zAO1Q+NV6SvCKYvAUg8BYN/kil
         RQpiquKkN/+M40TFrHFu94o49M5gRvczN7SVuKM8JS97xLHnla4HRyw3y8JX4cxIg4it
         Z2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNFKcj1qpbmt/ipOHNu4Y7YMRQo6qwIPI6XtcYqqxxk=;
        b=NDSZBlajgG9JoSywu6vxVL523XPVxKbTiQBdwCrn2zfNh5db8wyF8Y4BfrnST8fpA1
         /F1ZndYHaYuRlGtYpOS1gAKHQbpgQTGvFSinS/mFdZ5kM8voL+kew3CGYvPUtNxpzx8c
         rlG88cO0tW3gDhxe/WXX9a9QPZ8ZPOMcdD6i2MXlAhX0tRCT8X8dYHmrNHpOg0Rmg6RF
         GXZgeNu5/VmLIP8buFD9ZbuyE9rRpu26bymq4gz9XPRjlKdpkPcLABaXeG5iObjY/ZMo
         bUWUQHXFAXB8q+fvwkfy2h4t7N9WLNUS9YUf/nn9oeUfax1Z9KmM8Y2AsJe2X48cGd+B
         YgOA==
X-Gm-Message-State: AFqh2koP1baOzsE+wyi0DWUyFtyQXRl4zEgNNwrRAmjqT/oFCfkMydYk
        xjr4KNXog8vmPWUUZ00g14PmyIigHLEZixaBKOOSqA==
X-Google-Smtp-Source: AMrXdXv1eTdWh0CylvfGguRVxWq3NHfKHqZBjTAlyC6Jdqa95eu4fD1BQxZQuAqdAgXlBAlSl3TUQ57MpVVZmWIIQIA=
X-Received: by 2002:a2e:9bcd:0:b0:27e:8a84:6c33 with SMTP id
 w13-20020a2e9bcd000000b0027e8a846c33mr486132ljj.404.1671715467262; Thu, 22
 Dec 2022 05:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
 <20221219215431.GB26315@pengutronix.de> <939ce9a0f7f73c0b9f0cf5590f2d8b02e0825fa5.camel@ndufresne.ca>
 <20221221220127.GE26315@pengutronix.de>
In-Reply-To: <20221221220127.GE26315@pengutronix.de>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 22 Dec 2022 10:24:14 -0300
Message-ID: <CAAEAJfAMogQzU_etD2m8vOrkQJxd3jKuFtVU9mewzCsDP-GEQQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        nicolas.dufresne@collabora.co.uk,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas, Michael,

(+Andrzej)

El mi=C3=A9, 21 dic. 2022 19:01, Michael Grzeschik <mgr@pengutronix.de> esc=
ribi=C3=B3:
>
> On Tue, Dec 20, 2022 at 12:00:01PM -0500, Nicolas Dufresne wrote:
> >Le lundi 19 d=C3=A9cembre 2022 =C3=A0 22:54 +0100, Michael Grzeschik a =
=C3=A9crit :
> >> Hi Benjamin,
> >> Hi Ezequiel,
> >>
> >> On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
> >> > On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
> >> > <benjamin.gaignard@collabora.com> wrote:
> >> > >
> >> > > This series implement AV1 stateless decoder for RK3588 SoC.
> >> > > The harware support 8 and 10 bits bitstreams up to 7680x4320.
> >> > > AV1 feature like film grain or scaling are done by the postprocess=
or.
> >> > > The driver can produce NV12_4L4 and NV12 pixel formats.
> >> > > A native 10bits NV12_4L4 format is possible but need more investig=
ation
> >> > > to be completly documented and enabled.
> >> > >
> >> > > It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches=
 and
> >> > > Sebastian's device-tree patches for RK3588.
> >> > >
> >> >
> >> > I thought the AV1 decoder in RK3588 was really a separate hardware
> >> > from the Hantro G1/G2.
> >> >
> >> > Shouldn't this need a new driver for this new hardware?
> >>
> >> Just jumping into this discussion as I am currently working on the rkv=
enc driver.
> >>
> >> In my case I am extending the rkvdec driver to become more generic for
> >> other rockchip specific enc/decoders.
> >>
> >> My first change looks like this:
> >> ---
> >>  drivers/staging/media/rkvdec/Makefile              |   4 +-
> >>  drivers/staging/media/rkvdec/rkvdec-h264.c         | 100 ++++-----
> >>  drivers/staging/media/rkvdec/rkvdec-vp9.c          | 142 ++++++------=
-
> >>  drivers/staging/media/rkvdec/{rkvdec.c =3D> rkvpu.c} | 510 ++++++++++=
+++++++++++++-----------------------
> >>  drivers/staging/media/rkvdec/{rkvdec.h =3D> rkvpu.h} |  66 +++---
> >> ---
> >>
> >> While working on other parts of the encoder I found many places in the
> >> rkvdec driver (e.g. v4l2 and vb2 callbacks) that looked familiar to th=
e hantro
> >> functions but where limited to the decoder case.
> >>
> >> I think there are two options for the av1 codec.
> >>
> >> 1) If the vpu981 is a driver that has nothing to do with verisilicon b=
ut
> >> works with this driver framework, then we should integrate vepu981 int=
o it
> >> but consider rename the verisilicon unrelated parts to something gener=
ic.
> >
> >I've raised in my review the the naming is sub-optimal. This is an unmod=
ified
> >VC9000D AV1 decoder. No other codecs have been included in the package, =
even
> >though VC9000D cores can support more.
> >
> >Stating this driver have no place here seems a bit strange to me, but wi=
th
> >proper arguments, maybe we can make a case and start a VC9000D dedicated=
 driver
> >(that will be a lot of copy paste, VC9000D post processor notably is ide=
ntical
> >to VC8000 post processor, but one could argue we should make a VCX000 dr=
iver ?
> >
> >>
> >> 2) Move the vepu981 av1 driver into the rkvdec instead.
> >
> >That make no sense, its not a Rockchip HW design, and will likely start
> >appearing on non-RK SoC in the future.
>
> Sure. I did not know that it actually is an VC9000.
>
> >> If 1) is the way to go, we can even think of moving the staging code p=
arts from
> >> rkvdec to the verisilicon code. Likewise to the vepu981-av1.
> >
> >Again, I think using RK naming is unfortunate choice. This AV1 decoder i=
s just
> >like the G1/H1 combo you will find on RK3288. And that same combo is fou=
nd on
> >many older SoC (actually even newer SoC un the VC8000Nano brand).
> >
> >Like all generation of Hantro chips, there is an optional dependency tha=
t can
> >exist between encoder and decoders. The question is if this requires a s=
ingle
> >driver to maintain a valid state or not. So far, it seems devs have assu=
me that
> >is it needed.
> >
> >p.s. fun fact, on most HW, the decoder rate is cut in half with running
> >concurrently with the encoder
> >
> >>
> >> I could also keep on integrating the rkvenc on that base instead.
> >
> >Do you know if there is any interaction between the encoder and decoder =
? Shared
> >registers, shared internal cache ? That's basically what differentiate H=
antro
> >here. Also, be aware that some folks are considering starting on RKVDEC2=
 driver,
> >are you looking at RK32/33 series ? or more RK35 ?
>
> I don't know of any limitations or interactions between the encoder and
> decoder.

I believe we should explore separate drivers, and if there is any interacti=
on,
try to model the shared piece through a shared block in the device tree.

In most cases, the decoder and encoder are separate blocks.
Also, the V4L2 stateless decoder interface covers only decoding.

Supporting both in the same driver has been painful, especially
the V4L2 negotiation, is hard to support for both encoders and decoders,
and has led to many bugs (and even worse, regressions) in the drivers.

Thanks,
Ezequiel
