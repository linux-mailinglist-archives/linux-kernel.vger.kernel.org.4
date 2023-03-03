Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B56A995E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCCO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCCO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:27:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74A12597
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1677853636; i=j.neuschaefer@gmx.net;
        bh=n4AWAsnAu9l/SUqiep7OnR9Dao6V+GN042IgQqQPFQk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HO5OXSWJ7qjzq+CPhzBpzcXKjC7jNta1NMWVzaLBocdmXfbNWXs0Q5QxCDHzQdjZv
         LuD7uDrvYXk9k7IiltPKE/dDzy2eGNv5Q0O6CoDeXfH4Lc2xVzPZ59lYkc4rOG1Ahz
         LoebThZgQTzXmrGC4wBT4p8jNMdyb2l+EwXYh4P3TlXF6OuJv/4G2PqVdJk/oGqui9
         bCYkepG9NrR39fczdClnr8zH2jYRJW/aoCSjmcBeVNB7TD5svVgZlpl9BvWzVxVDZ0
         xnwVs4ZLB6UfO2XKtj5OWjAVojWvjueQxJOyyZo95dkv3ctsWVO+o6bv5x+WJ+7tri
         1fIDMWSe+i7bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1q8GLD1n3H-00bJab; Fri, 03
 Mar 2023 15:27:16 +0100
Date:   Fri, 3 Mar 2023 15:27:15 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Nick Terrell <terrelln@meta.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zstd: Fix definition of assert()
Message-ID: <ZAIDw1Qq0W77XQ94@probook>
References: <20230129131436.1343228-1-j.neuschaefer@gmx.net>
 <C1912105-5951-4627-83B6-BA84420FED0D@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kPTYGsB/x7M2pU5I"
Content-Disposition: inline
In-Reply-To: <C1912105-5951-4627-83B6-BA84420FED0D@meta.com>
X-Provags-ID: V03:K1:DAVTiI/2QaDDX/rlOicHG9dDu/qy5g5kgL2bIVVPNmjTGDMFgZp
 sdcqPWxirUpfu0bSf4jekPczrWc8GF5W/ZpiZwGYbT7i0zRy6dM0u9sbaVYSLA791qPyF82
 aKZJH0hPdnN3FN0Ib37P9i653Gi1v7kINu4rk1zEqNHQjoavqoA+RPDxbRspAha34FMRwP3
 D/v3xvqWON2EmggIIK+Xw==
UI-OutboundReport: notjunk:1;M01:P0:rIXYa91AtWc=;tw3ekBJrHaXmWZix1vn+YwuIhiF
 RnyYibSvPC9NEtgDcC1OclLWAshSanZe88viBIHdG6N1qJU9+oVHrSp2ZHCRVqbEKDThb0XKr
 +waGrePwhDZcXy9A5cN+hsWzAeu6i82zxBcOYr1ZeXKCT+4Q3Blex2rrLCCW/W9C/Ys/HYSu8
 tsXdtiySy9xYXwkoyk88rFYvklaQWqiXSpiVO5nXftXFSPfYEZglFvX8VWOdNgiepfBYR1cq2
 qXzahnsoluslhvN0eq3DLbsb3DDqea+IABLKm4+kNkx3aFBmzBnbnwdM/KIA1HlnDZz1p3gdi
 hja56Y3pYJzPEVOoMB0qaIrlxiNRiuT1kawwcQNGeooBPExG5KbhxkMRAOde567T2YBFdbmH2
 t2aQZcXNBCPOsNB++7b0dxGWS1PRnFV+961QnNrIvz0oWHMNcIgbYOU18WhAQrX2LUsp9SRhD
 +L+Rvbqa92pRYRapqh+OCkYWUPmPe64HlqXu7QJxav03q6NSMjoziuu7bKnln4yRfRTvGtDT3
 96QR9GYFCg6JQpf48k0IMJl1MpOXnHWeceIbPX1up+4tOu/fKsMrxZNYpGOXSb0TYEW4+eBvZ
 fqzeC7gadxa5XtqV8fgFLLS9hsM/CtVJvmVnIaFgtsEHDKKm98JZ02v3Q2gHgmsk7bLuPzPwP
 NILlh8oVNyLUM5rfVUToQi6OSq0DkbsGGg4EnKfqZh062XxUyyn/omW3CU5Q4TEgmmgRNF8iW
 bzzzE0ylFEv+r2yH0dgI0nQ7LTxbuIwaYqDOHMNUwg9cmT3+F7N0ZdrfIHaQrkHE2L1DSVV4e
 Xpfh0qpvUcR8BcOTdmxyblJg3nTnADO1ccVI10oRyeU2UrB1fytxLm2ofNzKFTmQEq6ivOIDB
 COwZR15b9Nz2SeGuBnuk3Mdb7LmIMnh6zFyHOtu+eVA5HPTnJBiqjHngu7AhbkR/VMD0FRaNL
 FpAaGPg8GqjHj9yVZ4mjf3di/xA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kPTYGsB/x7M2pU5I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 06:30:47AM +0000, Nick Terrell wrote:
> On Jan 29, 2023, at 5:14 AM, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.=
net> wrote:
> >=20
> > assert(x) should emit a warning if x is false. WARN_ON(x) emits a
> > warning if x is true. Thus, assert(x) should be defined as WARN_ON(!x)
> > rather than WARN_ON(x).
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> Hi Jonathan,
>=20
> I have to apologize, I just submitted my branch for a PR and I realize th=
at
> while I intended to take your patch, I took a different equivalent patch.=
 So
> I wanted to say thanks for sending the patch!

No problem at all, and thanks for informing me!

>=20
> > ---
> >=20
> > Commit e0c1b49f5b674 ("lib: zstd: Upgrade to latest upstream zstd
> > version 1.4.10") mentions that the zstd code was generated from the
> > upstream version of zstd, so perhaps the definition of assert based on
> > WARN_ON should be fixed in the conversion script and/or upstream zstd
> > source code.
>=20
> Yeah, we need to fix it upstream, so if you would like to submit the upst=
ream PR
> the file is contrib/linux-kernel/zstd_deps.h [0]. Otherwise, I will updat=
e it before
> the next import.

Feel free to do it yourself, as I haven't been involed with zstd
developement so far.


Thanks,
Jonathan

--kPTYGsB/x7M2pU5I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQCA6IACgkQCDBEmo7z
X9uvHRAA0A7DlV6QqMBFvRRplfmwXj7kogLk8ffIJW09hNtGQRPBuGoa0JrSQyjj
viStpP9AkF8OHcbABeGQxMe+ywTBvLLK6iqMv/VN7+qNFoItRhyIA6WK3v3N22km
FduWgptSJBwfNDAwKBTn+g01JHr0eZ9dyJXTTwNCKCeJL0aztPnbr04q5/+A7v9K
gwbwtGUKNA+nk2xAvSIALyNbBwl9JmVPi4VKE2nUqq5fzZgv0DzeFeTOwusij5zY
aixfQ0HmpmgQlEjvvsn7AdVyRCckDH75RfXlGK1sLu8EA/rc+kVYJ8kXJnF6DPri
1hm+G7OFMTFcnMdSRLd2dsmOflSlD0SSu5Ck95heubLnNmkz5V00kl5wpJ/qPYxN
mxR7pWAscpzT80jdOj2KNNmBPc+XsayECF9Ps2xByfkD4UYLOenLAxy7KmFjogjG
vXky5wOElg0MMkj2vcmQj2fwZ7KDbnkecBGTYkcEybtg+TlMVsy0qmtsnjg1E9qE
V3reLAKhQNyOuVM72uLD8u6AMNVwG5ph8zbiiPbvE4Yn0zdIjeEzRg20oPf5/TY+
Zl+FTWO7EG4oTVNPTnw1V4bhfo8o7nUWS3Wk1pPPdBj5CcxTV3WoiTzyZ/UrG8TV
O/jHm+gNB8py4qj85qSnsAVNNCWc33TqontWZPU8v552ubYVsGQ=
=/l8b
-----END PGP SIGNATURE-----

--kPTYGsB/x7M2pU5I--
