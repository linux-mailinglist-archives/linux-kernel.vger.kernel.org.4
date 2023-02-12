Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5C693670
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 09:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBLINv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 03:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 03:13:50 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663BE38B;
        Sun, 12 Feb 2023 00:13:47 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bh15so7956723oib.4;
        Sun, 12 Feb 2023 00:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvROq1Ysin4iKmF7L5qnmUmZE+huLZ31SHq6Mu5DVtg=;
        b=IaRYWpQ6frsgDcsD6edPNdjfb3TkXXkD203hGwxUJrrP8YSzYq8RnvIfgXQzF9iON5
         BLsNdc96tgMCGfADIwaqmZ95eJF85v/VnGTDQIFMvkrHDoJo81Q3sfcSRzlMBwe6Fyu+
         P6991khDl4+CUo5euTWmh4W6XHehUs104R6KRrFuwUkzAIOJM5cy9YwwQmyQucJ6blQC
         9VAksPKdR7Nt7OlYtFRwMoFSawY0Rwj/H9rjznMcZBdmlU5orWtgIpzIFFw6Rwaogyjf
         x2rmyiSGZVesaeFwNUO11MYWzZWBduvP558YTbi6TJ021im6zcCxfWXaY760cX6hetEP
         oFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvROq1Ysin4iKmF7L5qnmUmZE+huLZ31SHq6Mu5DVtg=;
        b=7EOf4MNyeHDcy7igUG5/v+s2h8APq82xa2mc+EKHelfSDx3oq+vuE6HOSTeoE6iQTi
         cM4uk99pAGKI+cl/OlaokzdM6xCX0KTbNiClkGvPtV3GbjUqjUfBSWxr8cRePX9JzES0
         tUX31tf24D4PXa6n8M403ViP4aid2CT89B/6OOTvCSuDvPtlrERFX6CbwMQ/Ipiqxv83
         cLx6Z2xuOMPFb1ETtV9PFFvUdDF3ZOocui48AwvVQVDBCUkpVgmYpfYa6s3ixV7BI2YP
         TFdOsgnoV+rQ7tKzCITXXPhutO+2ZcloyZCu3wpX10aiMXrxvhSuQpP1HVdNr8lSiH9g
         4dgA==
X-Gm-Message-State: AO0yUKVzAWpYfSVF362HD0Gu8pPxB6e9+exk49Mvd2/uw92eLVAaxMxo
        OXt8njNISuZxNoyURiekhfeXx7v42Ob7jjL9ISk=
X-Google-Smtp-Source: AK7set8TnzNOFqImJjPpCHh5tW2QRdderphK8943iNYTmjtSAMNRrq5sZirKjtzelCQLw2PZ/6HszLn+vhUv4VID4Bs=
X-Received: by 2002:a05:6808:60d:b0:37b:7c36:4df8 with SMTP id
 y13-20020a056808060d00b0037b7c364df8mr1570866oih.144.1676189626284; Sun, 12
 Feb 2023 00:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com> <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com> <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org>
In-Reply-To: <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 12 Feb 2023 09:13:35 +0100
Message-ID: <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/02/2023 12:01, Sergio Paracuellos wrote:
> > On Sat, Feb 11, 2023 at 11:47 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@=
arinc9.com> wrote:
> >>
> >> On 11.02.2023 13:41, Sergio Paracuellos wrote:
> >>> On Sat, Feb 11, 2023 at 10:10 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.una=
l@arinc9.com> wrote:
> >>>>
> >>>> Is this mediatek,sysctl property required after your changes on the
> >>>> watchdog code?
> >>>
> >>> I don't really understand the question :-) Yes, it is. Since we have
> >>> introduced a new phandle in the watchdog node to be able to access th=
e
> >>> reset status register through the 'sysc' syscon node.
> >>> We need the bindings to be aligned with the mt7621.dtsi file and we
> >>> are getting the syscon regmap handler via
> >>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Ar=C4=
=B1n=C3=A7.
> >>
> >> I believe you need to put mediatek,sysctl under "required:".
> >
> > Ah, I understood your question now :-). You meant 'required' property.
> > I need more coffee, I guess :-). I am not sure if you can add
> > properties as required after bindings are already mainlined for
> > compatibility issues. The problem with this SoC is that drivers become
> > mainlined before the device tree was so if things are properly fixed
> > now this kind of issues appear.  Let's see Krzysztof and Rob comments
> > for this.
>
> If your driver fails to probe without mediatek,sysctl, you already made
> it required (thus broke the ABI) regardless what dt-binding is saying.
> In such case you should update dt-binding to reflect reality.
>
> Now ABI break is different case. Usually you should not break it without
> valid reasons (e.g. it was never working before). Your commit msg
> suggests that you only improve the code, thus ABI break is not really
> justified. In such case - binding is correct, driver should be reworked
> to accept DTS without the new property.

Thanks for clarification, Krzysztof. Ok, so if this is the case I need
to add this property required (as Arinc was properly pointing out in
previous mail) since without it the driver is going to fail on probe
(PATCH 5 of the series). I understand the "it was never working
before" argument reason for ABI breaks. What happens if the old driver
code was not ideal and totally dependent on architecture specific
operations when this could be totally avoided and properly make arch
independent agnostic drivers? This driver was added in 2016 [0]. There
was not a device tree file in the kernel for this SoC mainlined until
2022 [1]. I also personally migrated this watchdog binding in 2022
from text to YAML and maintained it without changes [2]. When this was
mainlined not all drivers were properly reviewed and the current code
was just maintained as it is. Most users of this SoC are in the
openWRT community where the dtsi of the mainline is not used yet and
they maintain their own mt7621.dtsi files. Also, when a new version of
the openWRT selected kernel is added they also modify and align with
its mt7621.dtsi file without maintaining previous dtb's. If "make the
driver arch independent to be able to be compile tested" and this kind
of arguments are not valid at all I need to know because I have
started to review driver code for this SoC and other drivers also have
the same arch dependency that ideally should be avoided in the same
way. This at the end means to break the ABI again in the future for
those drivers / bindings. So I can just let them be as it is and not
provide any change at all and continue without being compile tested
and other beneficial features to detect future driver breakage.

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/drivers/watchdog/mt7621_wdt.c?id=3Dab3f09fe16d158cb4f84e558c61ec5d6d601=
f2e0
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/arch/mips/boot/dts/ralink/mt7621.dtsi?id=3D7a6ee0bbab2551d7189ce0f5e625=
fef4d612ebea
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml?id=
=3D9023e05b7a5809593a7ea09896eee0bbb6ae1685

>
> Best regards,
> Krzysztof
>
