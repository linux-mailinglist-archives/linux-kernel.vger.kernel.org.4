Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF169403C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBMI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:59:48 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBFDE8;
        Mon, 13 Feb 2023 00:59:47 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r34-20020a05683044a200b0068d4a8a8d2dso3491392otv.12;
        Mon, 13 Feb 2023 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8DWJEO3mtpNA7q0D4H3YS1sJmeVACF/QDAtzNdcs1k=;
        b=DLYPP7tIZaQr6wYy2yphr3aYOpJF/Od4RjBwWQIIMLEienUfUhjcnSphlAkwLNDheB
         bruU1UpCC+34AJUEH93TsBCGHrNvu2nTzgXVko018Jhv/nhLPXAAs8+IQh8oxgBzFdQE
         /SY7nJDzZllHBG5JVokReRm1OeR05/hye9EsiOJk5tfUoAx1roLEVqaKhOd2TE1xBE/t
         5bjRwnnlQXoFOL/+hO6dbtGfdIsQQIfxEsTWEPEzF2DX7uTD1thxSRi8JlLFLg+V99wb
         F2pxGS4EzfqQdDAQOOfbIerVjZWIN0ZQuRYyK1RH9vx0udE0g2af7gVvcx8cLSX3dtKn
         a7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8DWJEO3mtpNA7q0D4H3YS1sJmeVACF/QDAtzNdcs1k=;
        b=zbtndtotOexuuPdmdw32i1d54XDa1QsPVvKm0EPTIzvOtJxSQLvOp5pdG5+A5Q5MFU
         vhLLr8QftCFH5m8I4PKWlwIfkBrgsWfKeb8I+o5menuaFv7aWrYRzRiE5+xE51cJZaxJ
         FqdCfGFyqEA4QJjPJ9Zem9/2Kw9RfhtuWbn5R6IB366jQCrEEb3VUgJoPtQ6LVWx6ly8
         OmO4gc9vWquuC8pkndOANpXIwWm0Wz/JD7rWogVnx682/zRmtw8zk6ej4wmBvCAK2Enc
         VWGID4W4JNm3YsLuvQGTcbsfPfx7qz1cWxbeXBxvpq/rklFZNGkSHnqSrfHlutzxHhIY
         0mdw==
X-Gm-Message-State: AO0yUKWP2Spj5fwfiZXZqVXlBEoY18FvCEadNgQk4J2ZdWxAdWT7cH+i
        05gFzJjRItM9F3qI702hPQMcUY3+H5nCQae1zsQ=
X-Google-Smtp-Source: AK7set8KFfp95AbiwDGBaRYNY5/QDp64TVyTYrvKkcOXQ3ceRSsFU6cWUWAg29g5mFXtUJHdRguD6wHpgTcyZbHE0n8=
X-Received: by 2002:a9d:600b:0:b0:68d:a306:4550 with SMTP id
 h11-20020a9d600b000000b0068da3064550mr2287626otj.91.1676278786692; Mon, 13
 Feb 2023 00:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com> <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com> <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org> <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
 <afe68663-8ade-ae5a-00a1-083b2f263cb0@roeck-us.net>
In-Reply-To: <afe68663-8ade-ae5a-00a1-083b2f263cb0@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 13 Feb 2023 09:59:35 +0100
Message-ID: <CAMhs-H9BkQNwNyYQQgSig9vkW-_+i0+x8CLogXNgkRyi9Un6xw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
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

On Sun, Feb 12, 2023 at 4:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/12/23 00:13, Sergio Paracuellos wrote:
> > On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/02/2023 12:01, Sergio Paracuellos wrote:
> >>> On Sat, Feb 11, 2023 at 11:47 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.una=
l@arinc9.com> wrote:
> >>>>
> >>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
> >>>>> On Sat, Feb 11, 2023 at 10:10 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.u=
nal@arinc9.com> wrote:
> >>>>>>
> >>>>>> Is this mediatek,sysctl property required after your changes on th=
e
> >>>>>> watchdog code?
> >>>>>
> >>>>> I don't really understand the question :-) Yes, it is. Since we hav=
e
> >>>>> introduced a new phandle in the watchdog node to be able to access =
the
> >>>>> reset status register through the 'sysc' syscon node.
> >>>>> We need the bindings to be aligned with the mt7621.dtsi file and we
> >>>>> are getting the syscon regmap handler via
> >>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Ar=
=C4=B1n=C3=A7.
> >>>>
> >>>> I believe you need to put mediatek,sysctl under "required:".
> >>>
> >>> Ah, I understood your question now :-). You meant 'required' property=
.
> >>> I need more coffee, I guess :-). I am not sure if you can add
> >>> properties as required after bindings are already mainlined for
> >>> compatibility issues. The problem with this SoC is that drivers becom=
e
> >>> mainlined before the device tree was so if things are properly fixed
> >>> now this kind of issues appear.  Let's see Krzysztof and Rob comments
> >>> for this.
> >>
> >> If your driver fails to probe without mediatek,sysctl, you already mad=
e
> >> it required (thus broke the ABI) regardless what dt-binding is saying.
> >> In such case you should update dt-binding to reflect reality.
> >>
> >> Now ABI break is different case. Usually you should not break it witho=
ut
> >> valid reasons (e.g. it was never working before). Your commit msg
> >> suggests that you only improve the code, thus ABI break is not really
> >> justified. In such case - binding is correct, driver should be reworke=
d
> >> to accept DTS without the new property.
> >
> > Thanks for clarification, Krzysztof. Ok, so if this is the case I need
> > to add this property required (as Arinc was properly pointing out in
> > previous mail) since without it the driver is going to fail on probe
> > (PATCH 5 of the series). I understand the "it was never working
> > before" argument reason for ABI breaks. What happens if the old driver
> > code was not ideal and totally dependent on architecture specific
> > operations when this could be totally avoided and properly make arch
> > independent agnostic drivers? This driver was added in 2016 [0]. There
> > was not a device tree file in the kernel for this SoC mainlined until
> > 2022 [1]. I also personally migrated this watchdog binding in 2022
> > from text to YAML and maintained it without changes [2]. When this was
> > mainlined not all drivers were properly reviewed and the current code
> > was just maintained as it is. Most users of this SoC are in the
> > openWRT community where the dtsi of the mainline is not used yet and
> > they maintain their own mt7621.dtsi files. Also, when a new version of
> > the openWRT selected kernel is added they also modify and align with
> > its mt7621.dtsi file without maintaining previous dtb's. If "make the
> > driver arch independent to be able to be compile tested" and this kind
> > of arguments are not valid at all I need to know because I have
> > started to review driver code for this SoC and other drivers also have
> > the same arch dependency that ideally should be avoided in the same
> > way. This at the end means to break the ABI again in the future for
> > those drivers / bindings. So I can just let them be as it is and not
> > provide any change at all and continue without being compile tested
> > and other beneficial features to detect future driver breakage.
> >
>
> Problem is that there are (presumably) shipped systems out there with
> the old devicetree file. The watchdog driver would no longer instantiate
> on those systems.

Ok, I will maintain only the PATCH that changes the driver to not use
globals and send v5.

>
> Guenter
>

Thanks,
    Sergio Paracuellos
