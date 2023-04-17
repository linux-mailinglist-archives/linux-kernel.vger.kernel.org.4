Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E36E5072
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDQSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjDQSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A230D0;
        Mon, 17 Apr 2023 11:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC6A961B7A;
        Mon, 17 Apr 2023 18:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7015FC433EF;
        Mon, 17 Apr 2023 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681757706;
        bh=a67vqx0zLJeULnY4ySGNK+OdFOK9hdjKSEI9T8MMhD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKtSFaY8Budl3dBXR0jj1QEKyCa3jwo4l1PHQ0jWx0Zh/xJk37SDdUpUiODwm6lfI
         aQ77Z5m5MQUOZZ7XKrrFQjPwvS0/Lsflg0kHWHJj+U0j86zv8F1KdzXGTDh3bQvt5A
         YHXU+u99d0p0d0nn3ehMgKxUXRGEAgUSAUhPNAKW/JiiTog6RSSxEX+tGKNMV7OOmS
         d1Tg1ZMcEXtCPLQHfagd7uzcGx3jENaUOSYu+B7g70iiRjr3pCEbkoeS3aKzIpQN+R
         SFtmag72/Zq5WwmCeuZFszj09rNAO627PodFSNpO6uIUXCSAd7ChGMR4E52OdyLct8
         5VRGo+w+TBgoQ==
Date:   Mon, 17 Apr 2023 19:55:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
Message-ID: <20230417-ramrod-carpool-cd05b0def1a2@spud>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
 <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
 <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
 <20230412-trifle-outplayed-8a1c795fab8b@wendy>
 <d59439c1-bce1-b4a1-0e05-77afc4fc2ebb@linaro.org>
 <84300997-31f8-b36e-e54e-876c266fc953@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m9nc9K7NjCFO2sFe"
Content-Disposition: inline
In-Reply-To: <84300997-31f8-b36e-e54e-876c266fc953@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m9nc9K7NjCFO2sFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 10:20:31AM +0800, Changhuang Liang wrote:
>=20
>=20
> On 2023/4/12 19:29, Krzysztof Kozlowski wrote:
> > On 12/04/2023 11:42, Conor Dooley wrote:
> >> On Wed, Apr 12, 2023 at 04:51:16PM +0800, Changhuang Liang wrote:
> >>>
> >>>
> >>> On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
> >>>> On 11/04/2023 08:47, Changhuang Liang wrote:
> >>>>> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg=
 and
> >>>>> interrupts properties.
> >>> [...]
> >>>>> =20
> >>>>>  description: |
> >>>>>    StarFive JH7110 SoC includes support for multiple power domains =
which can be
> >>>>> @@ -17,6 +18,7 @@ properties:
> >>>>>    compatible:
> >>>>>      enum:
> >>>>>        - starfive,jh7110-pmu
> >>>>> +      - starfive,jh7110-pmu-dphy
> >>>>
> >>>> You do here much more than commit msg says.
> >>>>
> >>>> Isn'y DPHY a phy? Why is it in power?
> >>>>
> >>>
> >>> OK, I will add more description. This is a power framework used to tu=
rn on/off=20
> >>> DPHY. So it in power, not a phy.
>=20
> I found something wrong with my description here, not turn on/off DPHY,
> is turn on/off DPHY power switch.=20
>=20
> >>
> >> Perhaps tie it less to its role w/ the phy, and more to do with its
> >> location, say "jh7110-aon-pmu"?
> >> There's already "aon"/"sys"/"stg" stuff used in clock-controller and
> >> syscon compatibles etc.
> >>
> >> Krzysztof, what do you think of that? (if you remember the whole
> >> discussion we previously had about using those identifiers a few weeks
> >> ago).
> >=20
> > Depends whether this is the same case or not. AFAIR, for AON/SYS/STG
> > these were blocks with few features, not only clock controller.
> >=20
> > This sounds like just phy. Powering on/off phy is still a job of phy
> > controller... unless it is a power domain controller.
> > Best regards,
> > Krzysztof
> >=20
>=20
> So, next version the compatible can be changed to "jh7110-aon-pmu"?

Hmm, is the dphy the only thing that's power is controlled by registers
in the aon syscon? I tried looking in the "preliminary" TRM that I have,
but it's not really got a proper register map so I could not tell.

If there are, it'd help your case I think Changhuang Liang.

--m9nc9K7NjCFO2sFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD2WBAAKCRB4tDGHoIJi
0vyrAP40p9+eWy0HrXzGbRGnh12ucDUKDIndOUg1jtl07fmWDAEAlx5fHF/hyhd+
cM0x7QGv6LiQILIX9j6p+Ha/5wFgKAM=
=A2lK
-----END PGP SIGNATURE-----

--m9nc9K7NjCFO2sFe--
