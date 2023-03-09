Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40186B231A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCILdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCILd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:33:26 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D73E24C99;
        Thu,  9 Mar 2023 03:33:14 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17683b570b8so1914300fac.13;
        Thu, 09 Mar 2023 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678361594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVWBr/nHRC2tYP4GHz+Q26dc8LouI1/mTHjWjyy5lJY=;
        b=E3Y8S/UvtydBi2xb90Ub5S4kXSGQdXRmiDm6/T3ti5CjjF4yk3XqDiG2BQoYthSZeO
         mxCLl3BdDex+MGfAk9hkp/FpWcZrlTDnxaZCaC4I3v6fw+kKXRqBZP5ZDa5wOsmZlPLD
         AzGcnuh4h3IRpeeaD5q43gZbfVKIXIHgkPCi+2yEMrPqxFGsyviR99270l6z81M1U4RC
         nU6zDqwT7dxUWdz9abqEOwMH/o/sX3ldZ1UVhiysDTeWZDWhZeBkgxeelHe/yODPhvdY
         juJ4EF2KNrVW6cAyuDX99w0UHVJi1G/6CeMPT8r8PBc+A8xbxhckcsQEQTNFzZXBxosG
         bHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678361594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVWBr/nHRC2tYP4GHz+Q26dc8LouI1/mTHjWjyy5lJY=;
        b=SIf1KeMIYBB/fZv09gDoGt5jqMkiEgZebbSp5XCts1xRxQyRpwBWFuFSZ+dDiwEZkK
         HA2gqF6yc/Oa6ODOprgHTGfbC1BWs5wW3/uv2jq55IrTe8pBpqCI/ieeJCYxAEUE7gsV
         xjHmMFCOG/A76sjCQC+u6BLtPXKD+8swWGyeXBJMLznXoB+cEJ9lovWiSh15X8hyTcUk
         XlKDOGhLRboX2ALrdu4sTuQYr8EOl1mgOjhotPRFvwFMtYn+byJYH+4qjG7RtSs3IYaA
         8wwMW/1+jAFV0/x1YBxehLO0s67DmfQ6aOruXWQkDVIWFxBlPQGHdPDGJLEWnus3AvvN
         NtZw==
X-Gm-Message-State: AO0yUKWDbdUDrnhghTIXVG7+wU98H9qWFCWLVpK2cCQuTy9qSSEemqFk
        Kk7ZvEoWeOkvtiLUgaDM+gd4HG0ILpAAl97jvNw=
X-Google-Smtp-Source: AK7set/XSrA5enE/PH73VS6AKR9JL5gUiLM25aDZOjVqo4Juj983qp5aKuXczEDYDKwriek9TOjLmAn4vC6x4VmkCfw=
X-Received: by 2002:a05:6870:8c28:b0:16d:fb8e:3ba with SMTP id
 ec40-20020a0568708c2800b0016dfb8e03bamr7334038oab.0.1678361594135; Thu, 09
 Mar 2023 03:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-10-arinc.unal@arinc9.com>
 <20230308210514.GA3767521-robh@kernel.org> <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
 <ccdfd262-eaf3-dbbe-7a3c-a911a5ec0fc4@arinc9.com> <9663817e-7f6f-c3b1-8bf9-321f9b067e96@linaro.org>
 <deca532a-bdf5-c49e-1422-ce6124b61882@arinc9.com>
In-Reply-To: <deca532a-bdf5-c49e-1422-ce6124b61882@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 9 Mar 2023 12:33:01 +0100
Message-ID: <CAMhs-H8M3ir+DshHF60W=QMn9WG3Jgbo8GgXZnDKCLhs=+WBoQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
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

On Thu, Mar 9, 2023 at 11:34 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> On 9.03.2023 12:52, Krzysztof Kozlowski wrote:
> > On 09/03/2023 08:53, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >> On 9.03.2023 00:19, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>> On 9.03.2023 00:05, Rob Herring wrote:
> >>>> On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wrot=
e:
> >>>>> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>>
> >>>>> This platform from Ralink was acquired by MediaTek in 2011. Then,
> >>>>> MediaTek
> >>>>> introduced these SoCs which utilise this platform. Rename the schem=
as to
> >>>>> mediatek to address the incorrect naming.
> >>>>
> >>>> I said we don't do renames due to acquistions, you said that wasn't =
the
> >>>> reason, but then that's your reasoning here.
> >>>
> >>> It's not a marketing/acquistion rename as the name of these SoCs were
> >>> wrong from the get go. The information on the first sentence is to gi=
ve
> >>> the idea of why these SoCs were wrongfully named as the base platform
> >>> that these new MediaTek SoCs share code with was called Ralink.
> >>>
> >>>>
> >>>> To give you another example, *new* i.MX things are still called
> >>>> 'fsl,imx...' and it has been how many years since merging with NXP?
> >>>
> >>> Ok this is a point I see now. Though, I fail to see how this is calle=
d
> >>> renaming when there's only new SoCs (from NXP in this case) to be add=
ed.
> >>
> >> If I understand correctly, i.MX is a family from Freescale so the name
> >
> > It's the same "family" as your platform, because as you said:
> > "introduced these SoCs which utilise this platform"
> >
> >> was kept the same on new SoC releases from NXP. I believe it's differe=
nt
> >> in this case here. There's no family name. The closest thing on the na=
me
> >> of the SoC model is, it's RT for Ralink, MT for MediaTek.
> >
> > It's not about the name. NXP took Freescale platform and since many
> > years makes entirely new products, currently far, far away from origina=
l
> > platform.
> >
> > That's the same case you have here - Mediatek took existing platform an=
d
> > started making new products with it.
> >
> >>
> >> On top of that, mediatek strings already exist for MT SoCs already, at
> >> least for MT7621.
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tr=
ee/Documentation/devicetree/bindings/mips/ralink.yaml?id=3Ddd3cb467ebb5659d=
6552999d6f16a616653f9933#n83
> >
> > NXP also has compatibles with nxp, thus still not that good reason.
>
> Ok, makes sense. Am I free to call the SoCs MediaTek, change the schema
> name from ralink,mtXXXX-pinctrl.yaml to mediatek,mtXXXX-pinctrl.yaml
> whilst keeping the compatible string ralink?
>
> I plan to do some cleanup on ralink.yaml as well. From what I
> understand, I should change the mediatek,mt7621-soc compatible string to
> ralink,mt7621-soc?

You have to take care of these SoC strings since they are used in the
very beginning of the ralink startup platforms for any single ralink
SoC. See for example [0] and [1] (but they are in all soc init code).
I think it is better to maintain the ralink.yaml file as it is.

Best regards,
    Sergio Paracuellos

[0]: https://elixir.bootlin.com/linux/v6.2.1/source/arch/mips/ralink/mt7621=
.c#L200
[1] https://elixir.bootlin.com/linux/v6.2.1/source/arch/mips/ralink/rt305x.=
c#L161

>
> Ar=C4=B1n=C3=A7
