Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9462F1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiKRJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiKRJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:52:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5583B9B;
        Fri, 18 Nov 2022 01:52:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so11692636ejb.9;
        Fri, 18 Nov 2022 01:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ4MwuPj2J9tPx2ywv2av72qIqzhlJ3AyHJuDSFMQLQ=;
        b=RrN93dMH+xgqX/U2K/QY+iip6rrTMlsT8HIKYctbL5tgKV2rjBixUiZEjuec8Ctnb7
         KbmjdseKXIlsQZ+5AxVcjnDM9gO7a8OO6cZF8IxdztGbUWzhPrux2STQHFMs4pVn763j
         QCLj04udyfvJ+J08+GO3b7W41G81aAL4Gp14TjaacjKwrGP9DkwJJHag0+W0yoVuNXwv
         ZvZ0tKoTun7XCec0n0FbhXAvgw7JPV9lfkJle1W7GMFxeFSKbhpFjEA8cg9QtyJ76hJD
         dTff0qJs0cq++yDiJyQDj+3YkAvhp2q1gisFnPjfJA6/pcvqEGshBfZP4bcGWJHl2MJy
         H54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ4MwuPj2J9tPx2ywv2av72qIqzhlJ3AyHJuDSFMQLQ=;
        b=Sh5DJ9tU0Eg/HeRGs7j2FfQHYY4UK14IHSz5R1V1+xLvQkBGfEk8VCVlhv/l05hD33
         17yTnBBZHjGKPl/LzF0y3O321m09crDMGmTE0I9neTNr+s9rCwGTk3i/YOme1I4rD3hv
         lbdJMnGFziVmnm1mSrBe3ekohSImlbSRooQHk5KYN3cTt0lKlOMaTMGWMBWlHgLGvuxE
         trxu5MJxvcmSe6Amr8z/M+U35s5T4gmm5e5z0D9V4+NQCdZzyw74ucijDpe4n0hALiNn
         FMXqoPB+HGWkoAZa2MjGEpQT7AqtURz7++r6T1SRtHeNvhwW5epiIoPjlfEGoE26vAAO
         mb2Q==
X-Gm-Message-State: ANoB5pmqiuzPMRs2pYe0A4s6xSv+H5SCLleKDrxaMcaoDYiLgwviYqNO
        wXD+SORrHwaTsLSzh6esi1OdXNVhdVTZFmofThE=
X-Google-Smtp-Source: AA0mqf5IHFnH1qPUezpLU6BT8z9vH94Zy3lc/LoBaa8MHDoq9g07nSO8ueZTfHgt70IX94hKnV0CpHeuL1OoGVn77k8=
X-Received: by 2002:a17:906:aac8:b0:7ae:df97:a033 with SMTP id
 kt8-20020a170906aac800b007aedf97a033mr5549018ejb.344.1668765126082; Fri, 18
 Nov 2022 01:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20221108045300.2084671-1-lis8215@gmail.com> <20221108045300.2084671-2-lis8215@gmail.com>
 <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com> <59EJLR.DQ7KHQEAEUSG2@crapouillou.net>
In-Reply-To: <59EJLR.DQ7KHQEAEUSG2@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Fri, 18 Nov 2022 12:51:54 +0300
Message-ID: <CAKNVLfYpmJjQYFOy__PkmqcftQcQUYEKJ2V2K90MfG-1MBC_uA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some SoCs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 12:27, Paul =
Cercueil <paul@crapouillou.net>:
>
> Hi,
>
> (Ingenic SoCs maintainer here)
>
> Le ven. 18 nov. 2022 =C3=A0 09:45:48 +0100, Ulf Hansson
> <ulf.hansson@linaro.org> a =C3=A9crit :
> > On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com> wrote:
> >>
> >>  Some SoCs have one clock divider for all MMC units, thus changing
> >> one
> >>  affects others as well. This leads to random hangs and memory
> >>  corruptions, observed on the JZ4755 based device with two MMC slots
> >>  used at the same time.
> >
> > Urgh, that sounds like broken HW to me.
> >
> > The MMC blocks could share a parent clock (that would need a fixed
> > rate for it to be applied), assuming there is a separate gate/divider
> > available per block. But there isn't'?
>
> They do share a parent clock and have separate gates, and each MMC IP
> block has an internal divider for the bus frequency derived from that
> shared clock.
>
> >>
> >>  List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b.
> >>  However, the MMC driver doesn't distinguish JZ4760 and JZ4770
> >>  which shall remain its behavior. For the JZ4755 is sufficient to
> >>  use JZ4725b's binding. JZ4750 is outside of the patch.
> >>
> >>  The MMC core has its own clock divisor, rather coarse but suitable
> >> well,
> >>  and it shall keep the role of tuning clock for the MMC host in that
> >>  case.
> >
> > The mmc core doesn't have a clock divisor, but it does control the bus
> > clock frequency through the ->set_ios() host ops. It needs to do that,
> > to be able to conform to the (e)MMC, SD and SDIO specifications.
> >
> > Can you please try to elaborate on the above, so I can better
> > understand your point?
>
> Yes, I don't really understand the patch, TBH.
>
> The "clk_set_rate" call will only set the shared clock to the *maximum*
> clock frequency (host->mmc->f_max) which should be the exact same
> across all MMC IPs.

That's the case I need different "f_max" for my HW, for some reason
internal slot can't do a full rate (48MHz) but the external can, the same
card used for checking. So I want to set 24M for mmc0, and 48M for mmc1
with respect to hardware limitation.

>
> So it doesn't matter if it's set 3 times by 3 different instances of
> the IP, as long as they all request the same value.
>
> Besides, I know for a fact that the mainline driver works fine on the
> JZ4760(B) and JZ4725B.
>
> Finally... even if it was correct, this change would break
> compatibility with old Device Tree files.
>
> Cheers,
> -Paul
>
> >>
> >>  Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> >
> > Kind regards
> > Uffe
> >
> >>  ---
> >>   drivers/mmc/host/jz4740_mmc.c | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >>  diff --git a/drivers/mmc/host/jz4740_mmc.c
> >> b/drivers/mmc/host/jz4740_mmc.c
> >>  index dc2db9c18..d390ff31d 100644
> >>  --- a/drivers/mmc/host/jz4740_mmc.c
> >>  +++ b/drivers/mmc/host/jz4740_mmc.c
> >>  @@ -114,6 +114,7 @@ enum jz4740_mmc_version {
> >>          JZ_MMC_JZ4740,
> >>          JZ_MMC_JZ4725B,
> >>          JZ_MMC_JZ4760,
> >>  +       JZ_MMC_JZ4770,
> >>          JZ_MMC_JZ4780,
> >>          JZ_MMC_X1000,
> >>   };
> >>  @@ -887,7 +888,13 @@ static int jz4740_mmc_set_clock_rate(struct
> >> jz4740_mmc_host *host, int rate)
> >>          int real_rate;
> >>
> >>          jz4740_mmc_clock_disable(host);
> >>  -       clk_set_rate(host->clk, host->mmc->f_max);
> >>  +
> >>  +       /*
> >>  +        * Changing rate on these SoCs affects other MMC units too.
> >>  +        * Make sure the rate is configured properly by the CGU
> >> driver.
> >>  +        */
> >>  +       if (host->version !=3D JZ_MMC_JZ4725B && host->version !=3D
> >> JZ_MMC_JZ4760)
> >>  +               clk_set_rate(host->clk, host->mmc->f_max);
> >>
> >>          real_rate =3D clk_get_rate(host->clk);
> >>
> >>  @@ -992,6 +999,7 @@ static const struct of_device_id
> >> jz4740_mmc_of_match[] =3D {
> >>          { .compatible =3D "ingenic,jz4740-mmc", .data =3D (void *)
> >> JZ_MMC_JZ4740 },
> >>          { .compatible =3D "ingenic,jz4725b-mmc", .data =3D (void
> >> *)JZ_MMC_JZ4725B },
> >>          { .compatible =3D "ingenic,jz4760-mmc", .data =3D (void *)
> >> JZ_MMC_JZ4760 },
> >>  +       { .compatible =3D "ingenic,jz4770-mmc", .data =3D (void *)
> >> JZ_MMC_JZ4770 },
> >>          { .compatible =3D "ingenic,jz4775-mmc", .data =3D (void *)
> >> JZ_MMC_JZ4780 },
> >>          { .compatible =3D "ingenic,jz4780-mmc", .data =3D (void *)
> >> JZ_MMC_JZ4780 },
> >>          { .compatible =3D "ingenic,x1000-mmc", .data =3D (void *)
> >> JZ_MMC_X1000 },
> >>  --
> >>  2.36.1
> >>
>
>
