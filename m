Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD7602F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiJRPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJRPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:03:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE3EB14D7;
        Tue, 18 Oct 2022 08:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B3F7B81F80;
        Tue, 18 Oct 2022 15:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A651C43140;
        Tue, 18 Oct 2022 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105409;
        bh=VjXD7ZcWcKlQqghmfswBpYjxHHV20g6b5wi+ToAzSCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EpEkKt/e60Hg7YCKjzJqZCtietCjwk0K8wxOMdBE4/PZAFcGDsnWNTUDlkAcoBXjF
         EX9DpJ1ZreQec4+s/Yhb4e3yBp1G4ECbDB2xRFrCFaiKMORE4OFhUdWdV82LEf7Eum
         SZX/72MQXwiCFdsEBawPRWB2pm3LZdDUF7F/5Kb063YeHiDJaUwgJTpTeZIrJHXXqj
         7W50BJZsZ+qiFmj3N12hOKAMQuDn9EmsJzGhfRe1/RkeFesy8tg646lr0JLrTJOfOb
         Se90nHE9VEn1vODdvXHLyX6bKn1M1op0JA0OOhzSekiYVOwKL8IIHak8guwP5lJxE9
         phQatm7kGcoEw==
Received: by mail-vs1-f43.google.com with SMTP id d187so14994509vsd.6;
        Tue, 18 Oct 2022 08:03:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf33SCf5fHh1LzqFQ41G1xhQyMy0rEImESRA6nX17BfsMxbBtozj
        FjjE6NYYfR0xxY9T2kZ2lfEE8/i4RNaKwrnPzQ==
X-Google-Smtp-Source: AMsMyM7K6hComKg5JG6GbuPJ9zm/550Uojuox7IQzMTqQdCy/0irT+8elJkkDnDArj2MYP0m0UYcrfW7NRELwjyYqsA=
X-Received: by 2002:a67:c188:0:b0:3a7:60b:1156 with SMTP id
 h8-20020a67c188000000b003a7060b1156mr1580748vsj.53.1666105408190; Tue, 18 Oct
 2022 08:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220930163631.27040-1-zajec5@gmail.com> <166578177913.2909910.7600034251484225468.robh@kernel.org>
 <Y059lG8ZOXXzc4N+@wendy> <2f5f0c7f-4e1d-2434-51b4-d98d3fa7f49a@gmail.com> <Y06zrIZPZOCV63Vc@wendy>
In-Reply-To: <Y06zrIZPZOCV63Vc@wendy>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Oct 2022 10:03:18 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+u5dG3mHYFC774SE8T+M8ehrw_7qp7-E1q8gaY6EwbRQ@mail.gmail.com>
Message-ID: <CAL_Jsq+u5dG3mHYFC774SE8T+M8ehrw_7qp7-E1q8gaY6EwbRQ@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding
To:     Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 9:10 AM Conor Dooley <conor.dooley@microchip.com> w=
rote:
>
> On Tue, Oct 18, 2022 at 03:58:38PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 18.10.2022 12:19, Conor Dooley wrote:
> > > On Fri, Oct 14, 2022 at 04:09:40PM -0500, Rob Herring wrote:
> > > > On Fri, 30 Sep 2022 18:36:31 +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> > > > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > > > >
> > > > > Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. =
U-Boot
> > > > > stores its configuration in an environment data block.
> > > > >
> > > > > Such blocks are usually stored on flash as a separated partition =
at
> > > > > hardcoded address. Broadcom however decided to:
> > > > > 1. Store env data block inside U-Boot partition
> > > > > 2. Avoid sticking to hardcoded offsets
> > > > > 3. Use custom header with "uEnv" magic and env data length
> > > > >
> > > > > Example (length 0x4000):
> > > > > $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
> > > > > 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu=
.@..4.z.IMAG|
> > > > > 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=3D=
NAND:1M,1024M.|
> > > > > (0x40000 offset is unit specific and can change)
> > > > >
> > > > > Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partit=
ions:
> > > > > support label/name only partition") DT can describe partitions ma=
tching
> > > > > them by a name (without specifying actual address). With that fea=
ture
> > > > > and this binding change it's possible to:
> > > > > 1. Specify DT node for Broadcom's U-Boot env data subpartition
> > > > > 2. Add nodes for specific environment data variables
> > > > > 3. Reference them as NVMEM cells
> > > > >
> > > > > This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL ne=
eds to
> > > > > find environment data early (before it accesses DTB) and it does =
that by
> > > > > looking for an "uEnv" magic. Dirty way.
> > > > >
> > > > > This binding can however be used by operating systems. It allows
> > > > > describing cleanly U-Boot, its env data and variables. It tells
> > > > > operating system about Broadcom-specific env data so it can parse=
 it.
> > > > >
> > > > > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > > > > ---
> > > > > V2: Work on better commit body & add example
> > > > > ---
> > > > >   .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 ++++++++++++=
+++++++
> > > > >   1 file changed, 21 insertions(+)
> > > > >
> > > >
> > > > Applied, thanks!
> > >
> > > Hey Rob,
> > > Maybe my tooling is out of date or w/e but this is breaking
> > > dt_binding_check for me.
> > >
> > > I applied the below to fix the build, which I was about to send, befo=
re
> > > realising that you'd applied it and wondered if I was missing somethi=
ng.
> >
> > Thanks for catching that and submitting a fix!
>
> No worries.
>
> >
> > I guess I didn't run dt_binding_check this time or I did it before
> > adding an example. Sorry for that!
>
> BTW, subsequent to sending the fix I double checked my dt_binding_check
> logs and I saw:
> Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition=
@0: Unevaluated properties are not allowed ('partition-u-boot-env' was unex=
pected)
>         From schema: Documentation/devicetree/bindings/mtd/partitions/u-b=
oot.yaml
>
> I think unevaluated property detection got better in v2022.08 of
> dt-schema so that is probably worth fixing too. I'll leave that one up
> to you ;)

Sigh. The simple fix is add 'partition-u-boot-env' to u-boot.yaml. But
now I have no idea if that is really complete as this Broadcom stuff
is coming in bit by bit. So I've now just dropped everything. Please
resend with it all fixed.

Rob
