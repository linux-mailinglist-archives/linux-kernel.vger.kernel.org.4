Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903B6F06FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbjD0OIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243371AbjD0OIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:08:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314AB93
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:08:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-506b20efd4cso14441923a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682604529; x=1685196529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDVPbB4cbDPN+tvnZTEmrx6KIXqzDTSeZfB1ppLbXmg=;
        b=QBwSHc3Dz3srMXZNvIyh//l7YRkzVarnD5Y+5t1vcWgEbZwzXMbzaTO0lnUTS6+rOK
         5yYcV2jgESD9U1YrMtEWVk2AmJnY2DLZNvecgCFSeqXyZ9jAyP7amUdlCuNRgDl7t3u9
         Z+yuYOb7ICthH7KX/9PChM4j+ZqDFIFRPgmrAc+ljU0gUpW0mUhAf1k91TIhJWEZiHC3
         ync5MzexAnw7JIfmV1W8oXZWYSefwr23F2r34WCJYgHhX+G0Qe6lW9lUgYoHE1J8LGTf
         B277Z3Ls4kG/ZWLY3q48xBRYMe8AQiPIeILMQ2XMlm+nkZfifwu2qTn05Y4ztwvmF1HY
         ZMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604529; x=1685196529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDVPbB4cbDPN+tvnZTEmrx6KIXqzDTSeZfB1ppLbXmg=;
        b=VCDLFR4/CZ7M185uncGAfFwymI8VE9lCJcTb43kzZFlNe7uIYZ7Lo0FH0k/z2WUOcB
         4+0b2k/qtKwdBpEtWtumurD+UgXTqSndYxhGzA/eWmm7YwOrRpeviRl482OU6AyuhWV8
         /I2N1BuRREFh1AiDcaBBYDGSY6qfHGp7LvWSMHJDsQ8+iEy6DxdtytF7aIsOgoQreSpo
         TpvMqB+E854CS8gOk0h/EHutnYlXBg42PDGYzcs0I/5UDyYh5TqKdf6z3I0ZjKofJSBO
         7Oz/inxfX1GYOZGgQsmcijCaI+s/ChHGnXg+fa6/DeeD12qPNwxbXBW1h1ib9x3OfmCS
         I6Qw==
X-Gm-Message-State: AC+VfDwE+2VrQNEAdr/cUfTJErWgBT58nJ+OUQutvd3PLeZczvQwhFID
        UKNN5eAqcjusaIfPfN3Q9DQP+2AuD2dsfg31pvDa1nVAkS6RnLF4UEzhhFPU
X-Google-Smtp-Source: ACHHUZ7CEMh3fwxTQ4zHqXl5d3SwmPzb30WFXBGaftLZN2Lus97dMKq7+b5aHGMhdHRItwoZAx2Ky4I6Ret8wXSjlo8=
X-Received: by 2002:a05:6402:18c:b0:509:ee5c:6bf1 with SMTP id
 r12-20020a056402018c00b00509ee5c6bf1mr1753567edv.1.1682604529555; Thu, 27 Apr
 2023 07:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
 <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
 <fab67eef-4dc9-420d-b127-aedc6f54cad0@notapiano> <CAGXv+5E0rzByZBn91d60MQ7P0=GbAQUH=PK9EYDu3Upr33td6A@mail.gmail.com>
 <CAGuA+oo0w8n9zEKdd1UfYx+F08wK4CcUGqRbBi4C-xNYp+vtDA@mail.gmail.com> <28e50e45-53cf-4a34-a81c-10f1faab2d4e@notapiano>
In-Reply-To: <28e50e45-53cf-4a34-a81c-10f1faab2d4e@notapiano>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Thu, 27 Apr 2023 16:08:13 +0200
Message-ID: <CAGuA+oprz06WS0reC1Edqr1fMn-TjSrCgoO_M54JYQ4x8UnTOg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, Alexandre Bailon <abailon@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 1:20=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Apr 25, 2023 at 01:28:39PM +0200, Balsam CHIHI wrote:
> > On Tue, Apr 25, 2023 at 12:00=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> > >
> > > On Tue, Apr 25, 2023 at 6:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > > On Tue, Mar 28, 2023 at 02:20:24AM +0200, Balsam CHIHI wrote:
> > > > > On Sat, Mar 25, 2023 at 5:33=E2=80=AFAM Chen-Yu Tsai <wenst@chrom=
ium.org> wrote:
> > > > > >
> > > > > > On Wed, Mar 22, 2023 at 8:48=E2=80=AFPM Balsam CHIHI <bchihi@ba=
ylibre.com> wrote:
> [..]
> > > > >
> > > > > Hi Chen-Yu Tsai,
> > > > >
> > > > > Thank you very much for helping me testing this suggestion.
> > > > >
> > > > > Indeed, calibration data is stored differently in the mt8192 comp=
ared to mt8195.
> > > > > So, the mt8192's support will be delayed for now, to allow furthe=
r debugging.
> > > > >
> > > > > In the mean time, we will only continue to upstream the remaining
> > > > > mt8195's source code, so it will get full LVTS support.
> > > > > A new series will be submitted soon.
> > > >
> > > > Hi Balsam,
> > > >
> > > > like Chen-Yu mentioned, the calibration data is stored with 4 byte =
alignment for
> > > > MT8192, but the data that is split between non-contiguous bytes is =
for the
> > > > thermal controllers (called Resistor-Capacitor Calibration downstre=
am) not the
> > > > sensors. The controller calibration isn't currently handled in this=
 driver (and
> > > > downstream it also isn't used, since a current value is read from t=
he controller
> > > > instead), so we can just ignore those.
> > > >
> > > > The patch below adjusts the addresseses for the sensors and gives m=
e reasonable
> > > > reads, so the machine no longer reboots. Can you integrate it into =
your series?
> > >
> > > Not sure what I got wrong, but on my machine the VPU0 and VPU1 zone i=
nterrupts
> > > are still tripping excessively. The readings seem normal though. Spec=
ifically,
> > > it's bits 16 and 17 that are tripping.
> > >
> >
> > Hi Chen-Yu,
> >
> > Thank you for testing!
> >
> > As the readings are normal that proves that calibration data offsets
> > are correct.
> > would you like that I send the v2 of series to add mt8192 support?
> > Then we could deal with the interrupts later in a separate fix,
> > because the interrupt code in common for both SoC (mt8192 and mt8195)?
> >
> > Does N=C3=ADcolas also have tripping interrupts?
> > On my side, I've got no interrupts tripping on mt8195.
> >
> > Any other suggestions (a question for everyone)?
>
> Hi,
>
> sorry for the delay.
>
> Indeed the interrupts are constantly tripping on mt8192 here as well.
>
> I do not see the same bits as Chen-Yu mentioned however, I see
>
> LVTS_MONINTSTS =3D 0x08070000
>
> which corresponds to
>
>         Hot threshold on sense point 3
>         high to normal offset on sense point 2
>         high offset on sense point 2
>         low offset on sense point 2
>
> and it's the same on all controllers and domains here, which is weird. I =
noticed
> we have offset interrupts enabled even though we don't configure the valu=
es for
> those, but even after disabling them and clearing the status register, th=
e
> interrupts keep triggering and the status is the same, so for some reason
> LVTS_MONINT doesn't seem to be honored.
>
> I also tried using the filtered mode instead of immediate for the sensors=
, and
> that together with disabling the extra interrupts, got me a zeroed
> LVTS_MONINTSTS. However no interrupts seem to be triggered at all (nor
> LVTS_MONINTSTS updated) when the temperature goes over the configured one=
 in
> LVTS_HTHRE.
>
> I tried the driver on mt8195 (Tomato chromebook) as well, and it has the =
same
> LVTS_MONINTSTS =3D 0x08070000
> even though the interrupts aren't being triggered, but in fact I don't se=
e them
> triggering over the threshold either, so I suspect the irq number might b=
e
> incorrectly described in the DT there.
>
> Do either of you have it working correctly on mt8195?
>
> Anyway, I'll keep digging and reply here when I find a solution.

Hi N=C3=ADcolas,

Thank your for your time testing and investigating the interrupt issues!

I only have an mt8195 based board (i1200-demo), and I could not
trigger any interrupt on it.
I whish that MediaTek could reply to this thread to give us more
information (I avoid disclosing MediaTek's internal information).
And now, it's clear that mt8192 interrupts does work at least (but not
properly, may be we could fix it at driver level).

It's been a couple of days since I sent a v2 of the series that adds
LVTS support for mt8192 SoC (+ Suspend and Resume, + Doc update):
"https://lore.kernel.org/all/20230425133052.199767-1-bchihi@baylibre.com/".
I wish that it will be applied very soon, then we could patch the core driv=
er.

My colleagues "Alexandre Mergnat (amergnat@baylibre.com)" and
"Alexandre Bailon (abailon@baylibre.com)" are now part of this
project.
Please let them know of future information.

Thanks again for suggesting solutions!

Best regards,
Balsam

>
> Thanks,
> N=C3=ADcolas
