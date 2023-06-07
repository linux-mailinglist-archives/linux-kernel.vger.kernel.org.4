Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1C726799
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjFGRku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFGRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735EB128;
        Wed,  7 Jun 2023 10:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A43764221;
        Wed,  7 Jun 2023 17:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C66C433EF;
        Wed,  7 Jun 2023 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159646;
        bh=5x1EtOELFmRO9NktsOdM5lQT/q9FGsv1ZyUrNKs4x5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5gSo9DrkbgHb+qdJWHgnt9FSbYbLVexi6Zggwplxt/YGImwhEw3y/Tk7Xrl0Bu5r
         tm7ezUjD31fAfK97ettHJOF0KU8j5qGlgS/sqhqgXRr2K6W/9DBdcYUhjIOOYV7CQk
         /ITCUj2yu+sLZlNMZku3xq6LXFrCA8zkoU6jpFMM6Txggbi7kCUhAKXAfwRw5VkLqy
         A3Y9+ef2b5AXqMB+9rJXpVAIgFAZhu2DmbyoOKk0ztTyBw5Z8NjXvieLLZGlu5OHSi
         q/3FsiQA651mCQidHU8M7xB5thXMwjh1U0jwb84SxDIl1+8kjbg3oTutFz6PTU2W4t
         D7QQYJ3Kr9G4g==
Date:   Wed, 7 Jun 2023 18:40:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 7/7] riscv: dts: starfive: Add USB dts configuration
 for JH7110
Message-ID: <20230607-helium-handler-5dc9616ebf2c@spud>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-8-minda.chen@starfivetech.com>
 <20230525-cross-daybreak-24dfed69e5d0@spud>
 <2023052909-speed-cackle-294e@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vgIzego1nIcf0ymV"
Content-Disposition: inline
In-Reply-To: <2023052909-speed-cackle-294e@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vgIzego1nIcf0ymV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 03:46:21PM +0100, Greg Kroah-Hartman wrote:
> On Thu, May 25, 2023 at 10:36:38PM +0100, Conor Dooley wrote:
> > Greg,
> >=20
> > On Thu, May 18, 2023 at 07:27:50PM +0800, Minda Chen wrote:
> > > Add USB wrapper layer and Cadence USB3 controller dts
> > > configuration for StarFive JH7110 SoC and VisionFive2
> > > Board.
> > > USB controller connect to PHY, The PHY dts configuration
> > > are also added.
> > >=20
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> >=20
> > > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/bo=
ot/dts/starfive/jh7110.dtsi
> > > index 71a8e9acbe55..b65f06c5b1b7 100644
> > > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > @@ -366,6 +366,59 @@
> > >  			status =3D "disabled";
> > >  		};
> > > =20
> > > +		usb0: usb@10100000 {
> > > +			compatible =3D "starfive,jh7110-usb";
> > > +			ranges =3D <0x0 0x0 0x10100000 0x100000>;
> > > +			#address-cells =3D <1>;
> > > +			#size-cells =3D <1>;
> > > +			starfive,stg-syscon =3D <&stg_syscon 0x4>;
> > > +			clocks =3D <&stgcrg JH7110_STGCLK_USB0_LPM>,
> >=20
> > Please don't pick this patch, if the rest of the series is applicable,
> > as this will break building the dtb as stgcrg does not yet exist in any
> > maintainer tree.
>=20
> Ok, I'll just take patch 6/7 then.

I think I missed this mail somehow. 5/7 had the binding for the driver
so probably that should've gone via the USB tree too?
Should apply on its own (no deps on the phy patches) & has dt-binding
maintainer reviews.

`b4 am -P 5 20230518112750.57924-6-minda.chen@starfivetech.com` if
that's your cup of tea.

Cheers,
Conor.

--vgIzego1nIcf0ymV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDBGAAKCRB4tDGHoIJi
0vawAPkBNDTHTHPC6w2XGoY5UUHdUCl4RKD8ZVfiHewbpE6lXQEAn+hXtRuVk1F2
vvte4pcKTDdaQXhDYOg7OTeNqQiSHQk=
=R+dc
-----END PGP SIGNATURE-----

--vgIzego1nIcf0ymV--
