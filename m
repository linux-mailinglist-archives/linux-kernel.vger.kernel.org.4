Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BCE7508B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjGLMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjGLMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:49:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9461712;
        Wed, 12 Jul 2023 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689166173; x=1720702173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHerdfplQxVzMVmIE7yitFw6DX49G+yaoHF+TRw2CtE=;
  b=qbgxSDGGVLoo1rLxAnKPL69WmAc710bdrbphTuBs0hfEm3dIBUaBmhVK
   O4D4z9dXZ2EKTwwNQDkxbs/DfSkHj/HkhA2VXxyreRmgZkHaMU1Zc2oLS
   9Zvqs31NTG3/ZDdm37cz3GePsU+LSiztl7b+mpgfMlqw0uTqV4vHMkosJ
   qPAcbmCSaSRGL3Pto9w1UggLEUi2fY6veeb48asklWa+XXKi6S8+2Vwvt
   Dgrk3QWdQUQBk7JNOYdVz+aL4uMHwY4wDCSAt8ks7NjzZBaWmj2oLzDav
   cQKNCOfY/g3DP0fdfPvvHmCx/VBdbMwWfAc86AaSuIdUaANn4C1Ar25+Z
   w==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="161005954"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 05:49:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 05:49:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 05:49:29 -0700
Date:   Wed, 12 Jul 2023 13:48:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Eric Lin <eric.lin@sifive.com>, <conor@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dslin1010@gmail.com>,
        Zong Li <zong.li@sifive.com>, <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230712-parking-acting-e91f24204467@wendy>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
 <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
 <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
 <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org>
 <20230712110908.GA23216@hsinchu16>
 <0865b422-d587-c1c7-9463-510832ddddf4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CU9LDp6QRihEXXU7"
Content-Disposition: inline
In-Reply-To: <0865b422-d587-c1c7-9463-510832ddddf4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CU9LDp6QRihEXXU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 02:30:06PM +0200, Krzysztof Kozlowski wrote:
> On 12/07/2023 13:09, Eric Lin wrote:
> > On Sat, Jul 01, 2023 at 10:22:25AM +0200, Krzysztof Kozlowski wrote:
> >> On 28/06/2023 18:31, Eric Lin wrote:
> >>
> >>>>>>
> >>>>>>> +      - enum:
> >>>>>>> +          - sifive,pL2Cache0
> >>>>>>> +          - sifive,pL2Cache1
> >>>>>>
> >>>>>> What is "0" and "1" here? What do these compatibles represent? Why=
 they
> >>>>>> do not have any SoC related part?
> >>>>>
> >>>>> The pL2Cache1 has minor changes in hardware, but it can use the same
> >>>>> pl2 cache driver.
> >>>>
> >>>> Then why aren't they compatible?
> >>>>
> >>>
> >>> The pL2Cache1 has removed some unused bits in the register compared to
> >>> pl2Cache0.
> >>> From the hardware perspective, they are not compatible but they can
> >>> share the same pl2 cache driver in software.
> >>
> >> So they are compatible... If they were not compatible, you wouldn't be
> >> able to use the same match in the driver.
> >>
> >>> Thus, we would like to keep both. It would be great if you can provide
> >>> some suggestions. Thanks.
> >>
> >> I propose to make them compatible, like every other piece of SoC. I
> >> don't see any benefit of having them separate.
> >>
> > Sorry for the late reply.
> > The pl2 cache is our internal platform IP and is not part of any SoC.=
=20
> >=20
> > The reason why this driver is compatible with the hardware "pl2cache0" =
and hardware "pl2cache1"
> > is that it doesn't program the different parts of the config register
> > However, our internal software (e.g., bare-metal software) will program=
 these different parts,
> > so it needs to rely on the different compatible string to identify the =
hardware.
> >  =20
> > Additionally, we would like the compatible strings to reflect which har=
dware is being used Thanks.
>=20
> I don't understand how does it contradicts anything I said. So you do
> agree with me? Or what?

I probably should've been keeping a closer eye here, sorry.

I assume what Krzysztof means is why do you permit both
"sifive,pL2Cache0" and "sifive,pL2Cache1" appearing in isolation. IOW,
both of
compatible =3D "sifive,pl2cache0";
and
compatible =3D "sifive,pl2cache1";
are valid in your binding.

The hardware for both might be different, and their full featuresets may
be incompatible, but they implement a compatible subset of features. I
would expect that the following would be the permitted compatible setups:
compatible =3D "sifive,pl2cache0";
and
compatible =3D "sifive,pl2cache1", "sifive,pl2cache0";

A consumer of the DT that does care for the differences should be
looking for the specific compatible, and OS code that does not care can
always bind to the "0" version.

Do the "0" & "1" here refer to the IP version, as in
sifive-blocks-ip-versioning.txt? I didn't think the compatibles
containing those IP versions were supposed to appear in isolation,
without a soc-specific one?

Thanks,
Conor.

--CU9LDp6QRihEXXU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK6hOQAKCRB4tDGHoIJi
0u6kAQDnxOYwgeV+62r679GBsIIYf5NNa99MaO9EeUMAlI+TNQD9G3vpXDAUE94T
A/l9b6xBjLKF8+2Ag3R54+tIC9OqEgc=
=dQpf
-----END PGP SIGNATURE-----

--CU9LDp6QRihEXXU7--
