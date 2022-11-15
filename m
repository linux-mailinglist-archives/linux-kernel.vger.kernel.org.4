Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39C629FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKOQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKOQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:57:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C213FB5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668531443; bh=JqFmmT4jOT08u7gcmawos3JRsGqtjs7EjVxMQTb54D0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=drAR8l/Oxs5q/nTW2SCPA0Tt/cO7GwgH2RY451sY7+HcAbcJMSGriFfOQHrVcxpz2
         o1H8gOxZTYG3gaOXtQAq/ZJZqzNMXuXa/VBacadwgzr6M2QePVB8KsvCNCwdmiTImN
         nbFLfSX/pgcYxuftHDKyAyTno4ucZprGhL1IX65Pl5w1Pf4PzPMe7XEKRXOHmmYcq0
         G0v3MTWZJMT4BysDpStWCnGUjr1Hg2Gs0IdACnvSloLN5MMbYR18NTrchJk076jAT3
         JP6Z2phT4YUEa+H/1+geAjiheNqqEljMT7oX8qjDmovJMQhgtQmb3wEBaWlniJwWPv
         PBOZJf7XZzPuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1oePln1dZs-00IosT; Tue, 15
 Nov 2022 17:57:23 +0100
Date:   Tue, 15 Nov 2022 17:57:18 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] irqchip/wpcm450: fix memory leak in
 wpcm450_aic_of_init()
Message-ID: <Y3PE7vU6nfe4fqHU@probook>
References: <20221115092532.1704032-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CRF5/JpvIrJ8HkWI"
Content-Disposition: inline
In-Reply-To: <20221115092532.1704032-1-weiyongjun@huaweicloud.com>
X-Provags-ID: V03:K1:7SWXaIVLQW3BPw6lyv01VmqAHBSKln6AlUvNLKAxMMCexV/uz7x
 ttcHWKsWi9BTiu4xIsuyOu9zDxCvyktLw17+vGSVbH1tUHmSxVPVmZHA0XNxQ60WwKysj0i
 j+SoTtw1xGPoQroz1FoptxYG/QZxYp+So/l1Oj8ln8Z8Y4o9xNSLN03nxS2yRASbXlDUPrv
 PNAx5Z1InpIFto8BSU6Og==
UI-OutboundReport: notjunk:1;M01:P0:WKGNLr0BtDE=;/XdxevZdyrjTKJjxoYlnZJZV06A
 8LaQNsYZzY3aajOhAbx5wG/9lFXiJkEU6wc/MyoohTJ+FML1jwBqS8q0sD63OlLR/MZHAcGgW
 WVI40yLcKaczM2OU1SzbpE89zfTcaEkV9xrRbdkgU9weuY0c4rOKHRxW32vXXVa091VpC6jRX
 PPlnDccGZJsH/hF0wfv4YbgWZfpmt7kwQxSuoG8r82WV+CBPtw44tXGVRnBb0eHvuo4KPZGfz
 IesZiJFU/DUv9ufDuC33NeGMCrWCWE14mKR7J0VB22UIEDs4OqujhkYqMPNHX8wIkk2spxPg1
 4LgC5mZGyTUkvzPejehyTPgdHkSxhV01PCms76M9EXrX5+WmlR67YnCWWMW6seRTpZS7Bxg6A
 ZFzVmWLo7yfy61fp51/CPOpQMGtotC1nv7z39Fss0eLOwuQ/Bwfb/TrQUxoNSiGcWuGHzr5O6
 CLByK/KUYc6wG1FKfNnPN92tvBdaGkGtthZjPkAaax1VRpkxaix9xVFDKiRIqupPP0d9Stb24
 5B/hXHsqaLLHtDwVUj3MCAinchb1+HYODxAa+ZloGZKwUrLK6sbQTXqqVK1/LB0JWOTzim54D
 3AEZ7HdlUjABuB4ZNsgYVBR3afBivi7YQ/qy8XDwurR7y86l7ql4fBkDKQeH8v18RZiZ/m6L9
 5M+W2FtZ7+E6n57S/7AS4BRmopBKs/x+to+qnyvCybdERJWueYB+Wcc5PcLkUA8IxEDo+OAqp
 l/AONCZDKJgkHky1XRFY/5aU9MtZoI2VjRqoN2FZphpIJIBojbCRkZdU7lj39AiQ7mgf41hSg
 LtH9F5pWZG8A2mXxIH8EBArbnDczyKoSr0wpHt+HdZc6z+EGUSNhvM8R6IgAN95YKzM/9cOYB
 QQgqm6VxuiMy5zhI5bHBvRnCciLfrhFEMiSti6FGVVE3PWrNCFQvy6qlXn6w7nl3ZEzN49Yet
 Ddzlmw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CRF5/JpvIrJ8HkWI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 09:25:32AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> If of_iomap() failed, 'aic' should be freed before return. Otherwise
> there is a memory leak.
>=20
> Fixes: fead4dd49663 ("irqchip: Add driver for WPCM450 interrupt controlle=
r")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Thanks.

> ---
> v1 -> v2: fix function name in subject
>=20
>  drivers/irqchip/irq-wpcm450-aic.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm=
450-aic.c
> index 0dcbeb1a05a1..91df62a64cd9 100644
> --- a/drivers/irqchip/irq-wpcm450-aic.c
> +++ b/drivers/irqchip/irq-wpcm450-aic.c
> @@ -146,6 +146,7 @@ static int __init wpcm450_aic_of_init(struct device_n=
ode *node,
>  	aic->regs =3D of_iomap(node, 0);
>  	if (!aic->regs) {
>  		pr_err("Failed to map WPCM450 AIC registers\n");
> +		kfree(aic);
>  		return -ENOMEM;
>  	}
> =20
> --=20
> 2.34.1
>=20

--CRF5/JpvIrJ8HkWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNzxMsACgkQCDBEmo7z
X9vfJA//UEjUxljWwWoootQ5VqT+v8/148V/tb4cCscqxrIb/JtdO7sxMoSeLoCP
mrFbyzdcRYQb3eP96Xor5DwNmR/kpgqE2qeNRaAXndmIwydz53fCEsWLvIrPTtM7
w2xbsreQsXnLv6D/V/qxUy6IWiO0d0de3Yorus3TY/aDz3HnMMaONpBU0hhZofsZ
ugMkcomXVOD8PQ794JpfGtxkDQZDH1Wr/cqnVM9/w3fMemZWddUNGf3yeYjJx7WF
MDMGLZSWUL7VPbIrQsXgGmAF9BKfUcFTnArMnbIExZSIMA+LEbHksEpIrFaLhiei
r1DeX1MbXB+LAsImByCp4HGWDFO9kUSw7/uKUcaDyhOTR2o3w/MzeNOHFk8AhXtW
yVh/lIFcgvks9PcdLicihmrPl/dOAEwQ9cMHldpqQ9PTI1qUqNo0b3twt1pUiozS
OlfQBDfgySjNLzvFYY1WNw+DPs1jFAcUps09y+PV0//POiyVX0JbrbySS1vuW5JU
HanHv2NtxqxZCrDD2XCHtWTJiUtBWvV8HmTPpzuWNqUcc+ZSC3Ew51mWmA9+FD8f
/kvS3VLzS72XAqgFkJFI7+Z3GGszfNV8HSa+J7k0euJLtHR9SWluVR165xClGCGF
iURewKEz6m2uq0S/IztE/cHvK3QeTEWugLKj91YJvocXumvU8ms=
=6d8q
-----END PGP SIGNATURE-----

--CRF5/JpvIrJ8HkWI--
