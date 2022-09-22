Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE35E5E69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIVJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIVJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:22:26 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D11164;
        Thu, 22 Sep 2022 02:22:24 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 01E4E1C0004;
        Thu, 22 Sep 2022 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663838542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sNNs6mkshJUfVhodqkvh+WxLUvE+EftG/ZXnoTujoc=;
        b=n5mx3gyqVEaoFkx7UXA7ki7OtX+uxGsMbc77DZthlrjl8y/RK5vXVhKyfF/i0vsqdpNPlQ
        gPXxlfSfnevJDDlJQ7CagKDHZTsRkpwdu7KScFjxsTukzyNRlcWz7KmVrDYQiUF2LWlJpL
        DE8LHAOJPnD0Z/IwUFXWFVy0h/s/StHPzTi5xNQlFalHt2xr7KXwsQxUhtcnaGli4m91pl
        f8PeEA92OPVkPfqkilNbcHYb0sT/HXgwYLjSxpXp6rtE5F0/kHVLqSB5T0v+l312Nq2K7R
        0xyPr4mvGNO9wHycYtu3jvGHgHkgPtkOmTYk3uzptfbFB75H1ZUPUrNAHk11Fw==
Date:   Thu, 22 Sep 2022 11:22:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh@kernel.org>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the
 sl28 vpd layout
Message-ID: <20220922112218.3aff146f@xps-13>
In-Reply-To: <aa53a858e362ae747a2cbd28caa3fa78@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
        <20220901221857.2600340-16-michael@walle.cc>
        <20220912192038.GA1661550-robh@kernel.org>
        <aa53a858e362ae747a2cbd28caa3fa78@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob & Krzysztof,

michael@walle.cc wrote on Tue, 13 Sep 2022 16:21:24 +0200:

> Am 2022-09-12 21:20, schrieb Rob Herring:
>=20
> >> +  base-mac-address:
> >> +    type: object
> >> +    description:
> >> +      Base MAC address for all on-module network interfaces. The >> f=
irst
> >> +      argument of the phandle will be treated as an offset.
> >> +
> >> +    properties:
> >> +      "#nvmem-cell-cells": =20
> >=20
> > You can't just add a new #.*-cells buried in a device binding. I'm fine
> > with the concept though having more than 1 user would be nice. =20
>=20
> I was under the impression the tooling will handle it, but as you
> pointed out below, this isn't the case for a missing default. The
> statement above should only be to validate that there is one
> additional argument if the base-mac-address node is used in a
> phandle.
>=20
> > Any case that doesn't match foos->#foo-cells or has a default # of
> > cells if missing (as this does) has to be added to dtschema to decode >=
 it
> > properly. It won't really matter until there's a user with 2 or more
> > entries. I'm happy to do update the dtschema part, but I'd prefer to > =
see
> > the schema in dtschema rather than the kernel. =20
>=20
> Ok, but I'm not sure I understand you correctly here. You will
> update the dtschema tooling (I guess it's about fixup_phandles() in
> dtb.py) and which schema should be in dtschema? nvmem.yaml
> and/or nvmem-consumer.yaml? The entire schema or only a
> subset of it?

I currently see this as the main "blocking point", although Rob told he
was happy with the overall idea, so let's try to move forward together.

We discussed on IRC with Michael, I guess what's remaining is:
- Michael: Move #nvmem-cell-cells to nvmem.yaml in the core dtschema.
- Rob/Krzysztof: Add the necessary tooling to use this new
  property and enforce the right # of cells cells (may be added later
  as anyway for now we only have single consumer cases).

Is this what you meant?

Thanks,
Miqu=C3=A8l
