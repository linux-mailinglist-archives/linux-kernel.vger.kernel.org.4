Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716C568985D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjBCMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBCMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319165F1C;
        Fri,  3 Feb 2023 04:16:15 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CC256602F05;
        Fri,  3 Feb 2023 12:16:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675426573;
        bh=2/8e0Bi6BlPo7zgoRGtDZYk0iddWrzwTH9yHoEXA9KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLqABhzF+OTrBrf+4SIewk47JtIP73R7C7NUuuHKAkgQ5nUyTBZf2k9X/saubaoLU
         KVUPyIrV27G74q3xOGKXVpXVJKP4ajFeVP9be9oRX8qvHbeR65i5XCpLuUPc/x/81U
         XiCRum62D7DAh7bAMaccl7sBsoLpQys3E7F8IpY0mfQCZqxVeP0oX65evxMLG+6u3f
         USNamOesu7vrQH7HYm1jEtwFv0Mj54XPZzTjgyA03JlwGsnTQdpqcPuHX91nn28gIf
         GguKFGqke2unYNyplO7IBCfclHt/SU0q4yk2FBQV4NBUlcwUIJPvKDZxKPXkiUdKfP
         whd05nxFI0EpA==
Received: by mercury (Postfix, from userid 1000)
        id 953DE1060930; Fri,  3 Feb 2023 13:16:10 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:16:10 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20230203121610.zung35qrozvoauz6@mercury.elektranox.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
 <20230122112744.vdfho4mzpgm6oucm@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6v3cydzb267bgioz"
Content-Disposition: inline
In-Reply-To: <20230122112744.vdfho4mzpgm6oucm@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6v3cydzb267bgioz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 22, 2023 at 12:27:44PM +0100, Pali Roh=E1r wrote:
> On Monday 26 December 2022 12:45:11 Pali Roh=E1r wrote:
> > This new optional priority property allows to specify custom priority l=
evel
> > of reset device. Prior this change priority level was hardcoded to 192 =
and
> > not possible to specify or change. Specifying other value is needed for
> > some boards. Default level when not specified stays at 192 as before.
> >=20
> > Signed-off-by: Pali Roh=E1r <pali@kernel.org>
>
> Reminder: Any plan how to handle these patches?

Please don't top-post :) Sorry, I'm a bit slow with processing
patches this cycle. Technically this was also throwing a DT
warning reported by the bot, so I expected a new version. Anyways,
I fixed the DT warning myself and applied patches 1-2.

Thanks,

-- Sebastian

--6v3cydzb267bgioz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPc+wcACgkQ2O7X88g7
+pqBTQ//Sfo4YthHHkfczLf2+248kA6+HAwFPeSDbAYlSqTKO/HgnhZScAboYVR0
9EZReLBKQArJsTr/QosEm8J0tLBn0cQMWxhYzwBl7b2nyLLVHtvuTjZSdSigW3+y
WBd90nGP7O64NPMiHF5dZAkco4vsGehSf3ETEW5kAAQh+tK8M2W3t6sKkR8Qb0CB
OKdyem/7HyI2YyNJ5O49UpMTUL9h0um/k0h5x6/N6x7f9cxIBdPEkybCPbhR9+m/
RY6Q5XGaDxvYmA9qD30kUsex0pU+16ImkefnZ1Z0Dl9T4Dnv3slZIRZvJvd1flBA
FRbWVaPrykZnIW3vEYeb+SxRQbXIU+o4TkNcLLFnAwrJoPcRPwulsH3xHI/EDVva
6h+Q3qLmPkjC0liZEJE6QJWaSp+eOVReKn/9Y4/4T7K+8fHEusW7ca3jJ7qa90yc
Gq0X5lOgxzXnhmz11zZzAxhxPyPRSmqe4fOMqsEE3kEfYqLm5SR0OJXSRLI5UStB
jNIwOsPbV1/v1QMS7TJ8OkQ94lyqpyt+3w1tN0Tjv3kY5vOgXNdfxJU7tCD0MmTe
WKCPK1QJwHIpfEjdjbsPAQX55zODum918jhklVuYKnvsJfUZPC6OoxJNfcKqJR7f
8D/WD21618TImkTbCf6hgvtKtdLaJh5AzVOsJBshkxxvuoQG+Og=
=eZFH
-----END PGP SIGNATURE-----

--6v3cydzb267bgioz--
