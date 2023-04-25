Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D36EE51B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjDYP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjDYP6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A3C17A;
        Tue, 25 Apr 2023 08:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8BB4627EB;
        Tue, 25 Apr 2023 15:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4722BC433AE;
        Tue, 25 Apr 2023 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682438290;
        bh=itrfj1uL7ULKhIO/qSGGwopdMhHtcuGv7fowY1MDPYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EgTh2lVlpMtQ5px5R+jV+EfXPM/vMd0vZZcesoDR/dZgys7DryqsRrWS2pdpS9uas
         OYd9yTEmElOVrIZbn0OqVscAcdbafdiKbG9xGY95F+dXOVKPpAW5UFqkaPFQaikMgo
         aWZCYgp15j+P/IiGD62g++flweL1qEmmRIyA46J9ZxdgcgQr67x7Q3TlACfNIAqEWA
         ybnHZqICC3N6Bh2h/8vZ/QwOp/oM5lTZZiMl9J1LI5jXGxCqVcLQ5wSHavpOM+9lzJ
         GcWe9oPB1zz3J6OXPcR6ftsIf9jN3vnmyzPm8qTrcAX6jvM8Z/Yhdc9tzdb3LHV6hX
         cc5h5IH4H4Nww==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b8f510fecf4so8839269276.1;
        Tue, 25 Apr 2023 08:58:10 -0700 (PDT)
X-Gm-Message-State: AAQBX9emzZf9PORKzjyHfI5irsQQKf8MEyvZsMuWVRFxGXK0/SrZpWgE
        A34Q+tos0Tb/oPdrg5JeObgsZsyFUvrEKoiU8g==
X-Google-Smtp-Source: AKy350bpts/PPga3+dzd9vak+rbAaLdXpa4DHHS4UXvr1kLSlKfqR897O6l7AESMOVdvAuhJNuLkwu1gSc/085IiOR0=
X-Received: by 2002:a25:b097:0:b0:b97:f46:a2b8 with SMTP id
 f23-20020a25b097000000b00b970f46a2b8mr12284894ybj.17.1682438288965; Tue, 25
 Apr 2023 08:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
In-Reply-To: <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 25 Apr 2023 10:57:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
Message-ID: <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 2:28=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Tue, Apr 25, 2023 at 12:16=E2=80=AFAM Rob Herring <robh+dt@kernel.org>=
 wrote:
> > I have a script[1] that does the conversion written the last time this
> > came up. Just have to agree on directory names. I think the easiest
> > would be for Arnd/Olof to run it at the end of a merge window before
> > rc1.
>
> "emev2" and "sh7" are missing for renesas.

No doubt it's been bitrotting (or I may have missed some).

> Does your script also cater for .dts files not matching any pattern,
> but including a .dtsi file that does match a pattern?

I assume I built everything after moving, but maybe not...

That's all just "details". First, we need agreement on a) moving
things to subdirs and b) doing it 1-by-1 or all at once. So far we've
been stuck on a) for being 'too much churn'.

One nice thing with subdirs is 'make CHECK_DTBS=3Dy
arch/arm/boot/dts/foo/' can build everything for a platform family
without having to mess with the kconfig. Maybe most folks don't care,
but I do. My CI job running schema checks looks like this to deal with
grouping the arm dts files (this list is probably out of date too, but
less so):

        if [ "$ARCH" =3D "arm" ]; then
            VENDOR_LIST=3D"alphascale alpine artpec aspeed axm bcm cx9
(ecx|highbank) \
              efm ep7 imx1 imx23 imx28 imx27 imx5 imx6 imx7 ls vf qcom \
              (am3|am4|am5|dra|keystone|omap|compulab|logicpd|elpida|motoro=
la-cpcap|da|dm)
\
              nspire armada dove kirkwood orion mvebu mmp2 berlin pxa
(arm-|integ|mps|ve) \
              (at91|sama|usb_|tny_|mpa1600|animeo_ip|aks-cdu|ethernut5|evk-=
pro3|pm9g45|ge86)
\
              exynos s3c s5p gemini (hisi|hi3|hip) mt meson moxa nuvo
lpc owl ox8 \
              (r7|r8|r9|emev2|sh73a|gr-|iwg) (rk|rv11) socfpga stm
(sti|st-pin) ste \
              spear (sun|axp) tegra uniph (vt8500|wm8) xen zynq"
        else
            VENDOR_LIST=3D$(ls arch/$ARCH/boot/dts/ | xargs)
        fi

Rob
