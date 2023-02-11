Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20E569302F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBKLBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBKLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:01:27 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C806A75;
        Sat, 11 Feb 2023 03:01:27 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-16ab8581837so9746887fac.4;
        Sat, 11 Feb 2023 03:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qFBjYKnINBUwcAvlomN5QbVazt7x9QdUUpHsAW6v0k=;
        b=lf48kRdPE36nia7JI2BHXLyioxs15IZnLMTznIjSXmLhqVHgvcl51za1sIbCdefUHO
         R8k8IannWLB3dmQm4wpJnkgHEPTTg8pJupAjXxNLSvmfVkwjrH7XMit6bDuVXFY3r0E4
         8lYMWs3u/TVDkzJSypAeD72sUgNQdLitSA5xZ31eQ9RGyzp0Ngsvom/WI1mVoQi7uadX
         p7kXdvMTqWTvQXD+CXx5LlR8onx7pt2L7slrHdEfbHc9Q/ACyArcgSbXkqiPaYUgsWcz
         8bTEu5U70FbYqNZau3+7l3iieke/tNG+dXp585IAQNb8/g2ns/fa1CKlYcIi81rC5+/h
         kNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qFBjYKnINBUwcAvlomN5QbVazt7x9QdUUpHsAW6v0k=;
        b=EfNVeWwozXxwP//MYOlCPibCj7fADTP5omIgmppyDxMlekUwWvcPsV/gLOkIJjKpI1
         ZyC7Xw3ec0+3E/muenf18F9ehMNwn9xJPE+FZUdYAZyUHXoUHNBu2eVX0tv3maUHkXt1
         ogRX8TSgGqg5zRB+hDz3Ta8bn+dxUNTnfIwOtUYpYTpguYoVFtg6fGDRso7TgMKqF4pC
         AwSZfivmKjz66Z6Q1yLlwJ1qcuSr3Pt6/E+UTXBrR6LYcSA1A9YKbDXcpwrcyn4iaWty
         k2NZgWFadFV67TZHePriyN+NSCLaPdvaQA2sjCl+5wtMkzJPALoM67GFoMqZIbP0DD1K
         a6gQ==
X-Gm-Message-State: AO0yUKX5QNS85siZhrilq8tlz5KTqqHPwQ9aTvxitsM/kOSIS7Q/Vgab
        6zXjXcRmvUkX0TNez6QWadKh6zJz7voWWQnehYQ=
X-Google-Smtp-Source: AK7set8ye2b8mSDG4yJEtRcswHu3yz1TNDVrXheqJU2/38KuC4rF2vPhimYZbsEsJAbNkwkiUJkvbg/Z18AqRD7NVPA=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr2508539oaq.83.1676113286523; Sat, 11
 Feb 2023 03:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com> <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com> <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
In-Reply-To: <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 11 Feb 2023 12:01:15 +0100
Message-ID: <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
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

On Sat, Feb 11, 2023 at 11:47 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> On 11.02.2023 13:41, Sergio Paracuellos wrote:
> > On Sat, Feb 11, 2023 at 10:10 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@=
arinc9.com> wrote:
> >>
> >> Is this mediatek,sysctl property required after your changes on the
> >> watchdog code?
> >
> > I don't really understand the question :-) Yes, it is. Since we have
> > introduced a new phandle in the watchdog node to be able to access the
> > reset status register through the 'sysc' syscon node.
> > We need the bindings to be aligned with the mt7621.dtsi file and we
> > are getting the syscon regmap handler via
> > 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Ar=C4=
=B1n=C3=A7.
>
> I believe you need to put mediatek,sysctl under "required:".

Ah, I understood your question now :-). You meant 'required' property.
I need more coffee, I guess :-). I am not sure if you can add
properties as required after bindings are already mainlined for
compatibility issues. The problem with this SoC is that drivers become
mainlined before the device tree was so if things are properly fixed
now this kind of issues appear.  Let's see Krzysztof and Rob comments
for this.

Thanks,
    Sergio Paracuellos
>
> Ar=C4=B1n=C3=A7
