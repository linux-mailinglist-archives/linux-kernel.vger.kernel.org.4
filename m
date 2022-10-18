Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927EE602D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJRNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRNwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1C8169A;
        Tue, 18 Oct 2022 06:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAE3FB81F66;
        Tue, 18 Oct 2022 13:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2169C433C1;
        Tue, 18 Oct 2022 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666101165;
        bh=Rpe8fNS7ucIdrriKqnBNEgNQaG9KzJWM0Ibr0zsKMOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CIIJfLtaeJFtKGx9McsAo9g+6AAAGFOqrMWC9JMBlF1r8DoifbvLVnRWqU6Rndbxu
         XG+XsSbVSb37VD0UgPBFEAwA/r9fgbm4DpippgV9V3ZE8wmD7uOFgTXwK2nUKqtdMJ
         /MehBPPIJM7J7neDZHPEanqw5GV+l9hI6IT3m00+VoWH4NvwaQBOmzHg5Vx0EaS1W0
         +eWwDp0uDRDHpdbyeOvNesxBTQThwAblnA18VjREkUWWLfjr6NH83ZEO1obvYIEmAe
         cNTw3ytrPe8bH56J3/JWrxhFOKBjd2PndLHWnF2PC0RWhaf7FDTY8qFUmdy8mb0MyD
         B83/vH2/WSxLw==
Received: by mail-vs1-f51.google.com with SMTP id 1so10492194vsx.1;
        Tue, 18 Oct 2022 06:52:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf0HWxJMCrYXtqK9TokY53F4jMd8JlbK61HCwD8w/pEkU2FeeNDP
        IAhWoYlrS1XVAYg5fa6Bx82jIwx1lfT469yG1g==
X-Google-Smtp-Source: AMsMyM4/B3fnDjWo+mzcsxUH9eX3UfBrB/LooXCAwejl4EWDivaUeEITq+fs76FUyI0FNO9YxRwHm0yfAjMKGdoUfH0=
X-Received: by 2002:a67:c088:0:b0:39b:1bb3:bdd1 with SMTP id
 x8-20020a67c088000000b0039b1bb3bdd1mr1391749vsi.85.1666101164584; Tue, 18 Oct
 2022 06:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220930163631.27040-1-zajec5@gmail.com> <166578177913.2909910.7600034251484225468.robh@kernel.org>
 <Y059lG8ZOXXzc4N+@wendy>
In-Reply-To: <Y059lG8ZOXXzc4N+@wendy>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Oct 2022 08:52:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLKCgW439gUTtXux+_i5ZLwoEF3SzjSg2V27-QpY9EqUA@mail.gmail.com>
Message-ID: <CAL_JsqLKCgW439gUTtXux+_i5ZLwoEF3SzjSg2V27-QpY9EqUA@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
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

On Tue, Oct 18, 2022 at 5:19 AM Conor Dooley <conor.dooley@microchip.com> w=
rote:
>
> On Fri, Oct 14, 2022 at 04:09:40PM -0500, Rob Herring wrote:
> > On Fri, 30 Sep 2022 18:36:31 +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > >
> > > Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Bo=
ot
> > > stores its configuration in an environment data block.
> > >
> > > Such blocks are usually stored on flash as a separated partition at
> > > hardcoded address. Broadcom however decided to:
> > > 1. Store env data block inside U-Boot partition
> > > 2. Avoid sticking to hardcoded offsets
> > > 3. Use custom header with "uEnv" magic and env data length
> > >
> > > Example (length 0x4000):
> > > $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
> > > 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..=
4.z.IMAG|
> > > 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=3DNAND=
:1M,1024M.|
> > > (0x40000 offset is unit specific and can change)
> > >
> > > Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions=
:
> > > support label/name only partition") DT can describe partitions matchi=
ng
> > > them by a name (without specifying actual address). With that feature
> > > and this binding change it's possible to:
> > > 1. Specify DT node for Broadcom's U-Boot env data subpartition
> > > 2. Add nodes for specific environment data variables
> > > 3. Reference them as NVMEM cells
> > >
> > > This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs =
to
> > > find environment data early (before it accesses DTB) and it does that=
 by
> > > looking for an "uEnv" magic. Dirty way.
> > >
> > > This binding can however be used by operating systems. It allows
> > > describing cleanly U-Boot, its env data and variables. It tells
> > > operating system about Broadcom-specific env data so it can parse it.
> > >
> > > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > > ---
> > > V2: Work on better commit body & add example
> > > ---
> > >  .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++=
++
> > >  1 file changed, 21 insertions(+)
> > >
> >
> > Applied, thanks!
>
> Hey Rob,
> Maybe my tooling is out of date or w/e but this is breaking
> dt_binding_check for me.
>
> I applied the below to fix the build, which I was about to send, before
> realising that you'd applied it and wondered if I was missing something.

Indeed, it is broken. I've applied your fix. Thanks.

Rob
