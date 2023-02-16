Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58361698A86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBPCbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPCbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:31:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4EE36472;
        Wed, 15 Feb 2023 18:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB6461E52;
        Thu, 16 Feb 2023 02:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C92C4339B;
        Thu, 16 Feb 2023 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676514660;
        bh=u/bsvXIzqor9iuGuHPDp7QXFHLUgCYPJv8kDTJ19dx0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qg4Yx1CTlW7uJOZzQBGoAmXvvtMfsgQlgkbnnoxXpk1RiLLIBnvoc6D5rb3VacjZX
         DALGn+aroOpfwTMd5dFSuR8rIoucYXrwTM23d0vD+fPdoN2wKsC93AmOugyNwdLkqk
         ZZfW03HAH720W/8JYVty20mmIPWvnLFxgY7mKGo1DMbuDaveUqbdz48wubJTdGC/2T
         83jhR3SwY+r0xlcMRzpsP+CcLx327Y2+Wx/nkmobygSSwWwEv0HUkrOOkQa4oGza9Z
         t0ZUfnthGswAuLZkMBFdprwHfsdjA2EmSJxJA/rNS4jyC2CQW5CFWum9sX0ZPZgeCg
         ckmNtbUXhPbKA==
Received: by mail-vs1-f53.google.com with SMTP id g8so523095vso.3;
        Wed, 15 Feb 2023 18:31:00 -0800 (PST)
X-Gm-Message-State: AO0yUKWbFvfye+NAFqOWdIPVmZ7siOLK4kkHCbOLO2q+vXx66vPpkjLQ
        KraIGr2Ud1oV6aQwQeONUB7aczow+2Muh4tOYQ==
X-Google-Smtp-Source: AK7set/UhZadcx+v7m7CiQDl2HFSCVJPIEq7khDXu99TvHakVnEGqht+mmQEIEDWCRfTGq0q+vxgdUGvP+lMzf4BrcI=
X-Received: by 2002:a67:d812:0:b0:412:4fed:e7ad with SMTP id
 e18-20020a67d812000000b004124fede7admr792108vsj.67.1676514659212; Wed, 15 Feb
 2023 18:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20230213155833.1644366-1-frieder@fris.de> <20230213155833.1644366-2-frieder@fris.de>
 <20230215200213.GA467386-robh@kernel.org> <a32979ac-d272-0865-f453-c65d405814c8@denx.de>
In-Reply-To: <a32979ac-d272-0865-f453-c65d405814c8@denx.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Feb 2023 20:30:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3o3Z+jLy-GBJW2i1h7=uN=fPEaC+YTU07P+LbEoq5Vg@mail.gmail.com>
Message-ID: <CAL_JsqJ3o3Z+jLy-GBJW2i1h7=uN=fPEaC+YTU07P+LbEoq5Vg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: regulator: pca9450: Document new usage
 of sd-vsel-gpios
To:     Marek Vasut <marex@denx.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 7:27 PM Marek Vasut <marex@denx.de> wrote:
>
> On 2/15/23 21:02, Rob Herring wrote:
> > On Mon, Feb 13, 2023 at 04:58:19PM +0100, Frieder Schrempf wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> The sd-vsel-gpios property is abandoned in its current meaning as an
> >> output. We now use it to specify an optional signal that can be
> >> evaluated by the driver in order to retrieve the current status
> >> of the SD_VSEL signal that is used to select the control register
> >> of LDO5.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> ---
> >>   .../regulator/nxp,pca9450-regulator.yaml      | 23 ++++++++++++++-----
> >>   1 file changed, 17 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> >> index 835b53302db8..c86534538a4e 100644
> >> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> >> @@ -40,8 +40,24 @@ properties:
> >>       description: |
> >>         list of regulators provided by this controller
> >>
> >> +    properties:
> >> +      LDO5:
> >> +        type: object
> >> +        $ref: regulator.yaml#
> >> +        description:
> >> +          Properties for single LDO5 regulator.
> >> +
> >> +        properties:
> >> +          sd-vsel-gpios:
> >
> > It is a pin on the device, right? Then it belongs in the device node as
> > it was.
> >
> > Can't the direction of the signal tell you how it is used? Assuming the
> > pin is bidirectional?
>
> The pin is input to the PMIC, it is unidirection, i.e.
>
> SoC(output)---->(input)PMIC
>
> > The binding should support any possible way the device is wired, not
> > just what's been seen so far on some boards.
>
> The usage is always the above as far as I can tell.

This patch is saying the opposite though. Something else drives the
signal, but the signal is also routed to the SoC to sample the state.

Rob
