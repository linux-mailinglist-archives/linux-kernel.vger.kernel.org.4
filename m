Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FE633C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiKVMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiKVMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:23:41 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84ECDFEE;
        Tue, 22 Nov 2022 04:23:40 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 673F61C09F2; Tue, 22 Nov 2022 13:23:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669119819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/qC9A+c96fltWQ0jx0zekHGH7vfyaOxpjrp7KPGnco=;
        b=dNtpYE+qkWfkXFeXDHTrkXuU3GRbui8evW9J4sSqQByyflRCrzVux6dZZzvbFHkzctn+Kw
        BRiIfk3xEDSIfqnsBsUn9jaB+VHHguxxSlgYrSFJIoXlGtsH8deAuvIbfS69OCFiSiKm7B
        MZeL/aeaYneFGR4lrSv/OjO6vA3SaNw=
Date:   Tue, 22 Nov 2022 13:23:39 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Message-ID: <Y3y/S5COG7VPbsqL@duo.ucw.cz>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VyfgN6AwUCzyVCrs"
Content-Disposition: inline
In-Reply-To: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VyfgN6AwUCzyVCrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Mark the label property as deprecated as it is mentioned
> in the description.

Lets do it the other way around. Functions (etc) don't really provide
good enough description of LED, and label is still needed.

Best regards,
								Pavel

> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -52,6 +52,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
> =20
>    label:
> +    deprecated: true
>      description:
>        The label for this LED. If omitted, the label is taken from the no=
de name
>        (excluding the unit address). It has to uniquely identify a device=
, i.e.

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--VyfgN6AwUCzyVCrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3y/SgAKCRAw5/Bqldv6
8obHAJ4rdy+92y95pekz/iaFXd8abIXxLgCgtN2eCbZ/5S8XCtmWj8JwCw2wQXs=
=e4f1
-----END PGP SIGNATURE-----

--VyfgN6AwUCzyVCrs--
