Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C5728A79
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjFHV42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFHV4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:56:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91370272A;
        Thu,  8 Jun 2023 14:56:24 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 488C06606F20;
        Thu,  8 Jun 2023 22:56:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686261383;
        bh=x5VntQaA+tuAFmLXB1rfjBfTidinGnasCptCipBvRqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzVXwdPlvyWcD7ilk1+ueLu+XEOvYVBaSEIcpVQqJmFag7AMKXNuJS/UBu/wA6to9
         fIqKRb7Pd4h3xaGabbSM03YLfZCTyapvxmU9dpXKU8h4xqBXcO6KGLc54OL0YU86Uc
         VKlvLCmsUmhyYGZQMPCWcTN/RydaBxaKHNbo0vhGYYJxe0QCEbWrekrvywrcv6q2Cs
         QNtDqoZSGVbFNHVki2q2KnISyda/lyc+39sGHzDxrwxg5Q7kATVLwByXtPJZ0pV2pS
         NokXtGt6gOuS5xtSoFM8/scwM8lTHdnpegq7IopJdhVlbVrbwmZFyoaex8cl/81Sss
         hIlEvYalAZG6w==
Received: by mercury (Postfix, from userid 1000)
        id 65F571060A24; Thu,  8 Jun 2023 23:56:21 +0200 (CEST)
Date:   Thu, 8 Jun 2023 23:56:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: bcm21664-resetmgr: convert to
 YAML
Message-ID: <20230608215621.yprgpposj7u2vqye@mercury.elektranox.org>
References: <20230527141222.GA5048@standask-GA-A55M-S2HP>
 <b577b194-cd11-fcfd-fe03-87b892047ea5@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="of4pwpxx2iye3ss6"
Content-Disposition: inline
In-Reply-To: <b577b194-cd11-fcfd-fe03-87b892047ea5@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--of4pwpxx2iye3ss6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 05, 2023 at 11:15:59AM -0700, Florian Fainelli wrote:
> On 5/27/23 07:12, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family reset manager bindings to DT schema.
> >=20
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>=20
> Sebastian, do you want me to pick this up in the Broadcom ARM SoC tree?

Fine with me,

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--of4pwpxx2iye3ss6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSCToQACgkQ2O7X88g7
+powCxAAmLtHonaH1KfGQ9EUBVwjFd/aQmSc/Cly1hXMj0XDf3uMI1OAvKh5uicJ
Mr0G+i/RxaVfUkghYcv4AqMYBWC9ZWfyIaNmPjqxvj6YDFdOPFQ9IrA2lrSYcV8G
8LcCTckMALfllZnkNj6MMSs7xGFXwltgFLL8BS2Czjvj5XYAAs6JpWNKQSUkh+95
5lYl81PxPBaAFVpN7Q+dA6yAqPisRLMdAUreNqhK5E+Ti0dURllOtSbylqPlKeiS
4gzttIzUNoqteCouZIoqPIX6pI+wZGRiT+knqUq6IhU+GlZC490JQc38GrTbI497
mUE8NUH/2cUzLinY52bji4zYy5qfg62l4HUlmKahoAYXEd3gUIGrdxMIafKCO36U
KGV7+O4edtIMpEu0NYOAsbZcAc1RgZnZDyuVFFLFYaP0hr/cTn30vJqUQ6lOxU5F
JqS5Npd4W4GT4RiApY/C71JWmUj3mio41/baa926eEY97qD/zN8SPj0pRZ0R0eNV
/snGeCD9A1I047SdC1bzMIvVwWHUGra75sWVQduSGvc+1P2oZFPT6I2FvWKIIfZY
kvDE3hEkQJmA5xCwgSO4j9GtRf7Hu/NYuxSoD4cxP04J03XEikQefJC1Or7PgHTC
zL9MazNDVifw8vtx0UbOS21AXZNj73cSBtXDp6cwzi0qgRD10fI=
=P5uj
-----END PGP SIGNATURE-----

--of4pwpxx2iye3ss6--
