Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D357282DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjFHOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFHOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD60E57;
        Thu,  8 Jun 2023 07:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63ED363C34;
        Thu,  8 Jun 2023 14:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B864BC4339C;
        Thu,  8 Jun 2023 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686235104;
        bh=bYW8+a4qfwwbY1/H2JoE/y92zplQa0Eh0wz2Ccj7zIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JLG/iSEA4CCuLKMxN/tIklS3Ub0LSHxsZn6wRrU5rxnT/fl+TyMyHKoCu/4LdNg9T
         0ZiBi+ozmJ3SzIvg8TDdUAd6crNS83rj9tOFV3ZGtvMcJiJNm9jHftE51kglcPobRF
         AxLKGTH3SX60sdYSzVbZbX5bY5yPEDZDRXJxcKXWAL+Uuqs0N2MCmT+0GABNB/VzY8
         9fJKJWsBeQJKhdLkkJU/SeiVycEPDwtdBamvxj4Gnxwq/Tu02yV9bQoIsd4f5gule0
         Ip9peR591kVwDhVswlCf8SzTpij1CETIfp9hwK2gGp5fl9L110f1mTscfA4Z+4+bBM
         mWayAZb5nZk4w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b1a66e71f9so6405881fa.2;
        Thu, 08 Jun 2023 07:38:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDwu9A4ucgaiic3lNN6MvjP5n13Lz+fQ8mofjV/muTM/aJ+b7EHS
        r9q7PdiOoOJYQOwci4Xu05lemDXPc3xppilvww==
X-Google-Smtp-Source: ACHHUZ6TUGPT1kCJwdONdnncE71M3LkuV6NX6cgOSVzB/ikqMi+etrkWSDJh02yA7sBT+8YpCG+fF6r+RRP66cLQqAQ=
X-Received: by 2002:a2e:b0c6:0:b0:2ad:f8d:dea with SMTP id g6-20020a2eb0c6000000b002ad0f8d0deamr3551818ljl.11.1686235102806;
 Thu, 08 Jun 2023 07:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com> <20230524-blizzard-hunting-4da815e634e2@spud>
 <20230607204351.GA3984668-robh@kernel.org> <20230607-refute-acrobat-3b3f645da71b@spud>
In-Reply-To: <20230607-refute-acrobat-3b3f645da71b@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Jun 2023 08:38:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
Message-ID: <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
To:     Conor Dooley <conor@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 2:48=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Jun 07, 2023 at 02:43:51PM -0600, Rob Herring wrote:
> > On Wed, May 24, 2023 at 08:19:08PM +0100, Conor Dooley wrote:
> > > On Wed, May 24, 2023 at 03:35:27PM +0300, Claudiu Beznea wrote:
> > > > Convert Atmel SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC DT=
 node
> > > > (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along with=
 its
> > > > compatible. There is no usage of this syscon in the current code bu=
t it
> > > > may be necessary in future as some registers of SHDWC are accessed =
in
> > > > different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c=
).
> > > > Thus update the YAML with it to make DT checkers happy.
> > > >
> > > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > >
> > > Modulo the license thing that I mentioned on v1,
> >
> > Should be fine given it's an Microchip employee changing a Microchip
> > binding.
>
> Aye, that part I figured was fine - it was the when I looked at the
> blame for the files & they were filled with your name that I wondered
> about the licensing.

For reference, anything done by Arm, Linaro or NVIDIA employees is
okay to relicense to dual license.

Rob
