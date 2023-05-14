Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0B70209D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjENWzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjENWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:55:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B51BB;
        Sun, 14 May 2023 15:55:02 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21233660574D;
        Sun, 14 May 2023 23:55:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684104901;
        bh=DU/1Wu1hqUE0C6lLNhKSAzwm16Syk8IrmHigAsAJxMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSvlecfGk+9pSL4CPRCynPATN4gIX2BW5Cgx0XnjeoirIqrINuDPIq0OYxmCtV1Ub
         +V62BbePkhFwoARybkfAiSZqPXv08gJWEXKRPs70EzeVVe+FL3L2QnTXyfI+kncCqV
         /zCmabP7PlNDkjC/MUNbMYvlEe195cKmPmC/vPJzxmnNcSUiTFc9nYrNjvHNIDq0eQ
         s3xyf3xL06UBSNig95vMGCwKTTQsxVIOg3ZZEtb41YV8LhnvSvJg1e2KW261KbyBc3
         qBwhTuu1TfU2zT/bu94fbsPFQNFscD1Zb7GQsQyzUqYu9t3jvFqAE0JsWHVyk7Cpkp
         uXfcMNhCk17Jg==
Received: by mercury (Postfix, from userid 1000)
        id 646BD1061381; Mon, 15 May 2023 00:54:58 +0200 (CEST)
Date:   Mon, 15 May 2023 00:54:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     dan.carpenter@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterwu.pub@gmail.com,
        cy_huang@richtek.com
Subject: Re: [PATCH] power: supply: rt9467: Fix passing zero to
 'dev_err_probe'
Message-ID: <20230514225458.nngl45joh4crunal@mercury.elektranox.org>
References: <33c598f3655db56eed13a5b46a1468379f69349c.1683863629.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thiqvn36r3wkqzzv"
Content-Disposition: inline
In-Reply-To: <33c598f3655db56eed13a5b46a1468379f69349c.1683863629.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--thiqvn36r3wkqzzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 12, 2023 at 01:44:23PM +0800, ChiaEn Wu wrote:
> Fix passing zero to 'dev_err_probe()' in 'rt9467_request_interrupt()'
>=20
> Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger d=
river")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202305111228.bHLWU6bq-lkp@intel.com/
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---

Thanks, queued to my fixes branch.

-- Sebastian

>  drivers/power/supply/rt9467-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply=
/rt9467-charger.c
> index 73f744a..ea33693 100644
> --- a/drivers/power/supply/rt9467-charger.c
> +++ b/drivers/power/supply/rt9467-charger.c
> @@ -1023,7 +1023,7 @@ static int rt9467_request_interrupt(struct rt9467_c=
hg_data *data)
>  	for (i =3D 0; i < num_chg_irqs; i++) {
>  		virq =3D regmap_irq_get_virq(data->irq_chip_data, chg_irqs[i].hwirq);
>  		if (virq <=3D 0)
> -			return dev_err_probe(dev, virq, "Failed to get (%s) irq\n",
> +			return dev_err_probe(dev, -EINVAL, "Failed to get (%s) irq\n",
>  					     chg_irqs[i].name);
> =20
>  		ret =3D devm_request_threaded_irq(dev, virq, NULL, chg_irqs[i].handler,
> --=20
> 2.7.4
>=20

--thiqvn36r3wkqzzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRhZsIACgkQ2O7X88g7
+poYAQ/+MFGVHXC+3x6i2hhmnmJI7GuTUczxKXd2FeERNJ2Key71XmCOFt9UgxD0
sq+BhfHzV29tnF/NDVBPdmM8pBfmdphtx7UxTu11aqsc1KaiYP6A1wP0hLHeB++V
4GP0gyipzK89IqYo06qpTpMaKzf1uM1t6wSIqVy7V+Ojx9EIQjN7bVGgMGaZW0w0
2ZnI7LG38mSbujxurQWj4aYMyOoibgfCoTNu4+rVbH+y/9aR0PT2Q/iMuYSN9Dnr
XgfSUzo72KYIEEwTSjThI+dLQ/4Azlec6XXtZSnjF6T+bLQN4yx52nbsS7+z6rlK
ul+4Vu7/OpbMvyCYeLKERbUV3NCKOaURi29kLE5xQpo/Tbi71PXS1A12SQtMFu31
/3rF+v4DbJRZZhf7pz1sGeE8mzqD0Pc1ORlNOf/K8ybruWKaPfJnCpFV3jhv6t6a
bPq/cX+dQ5K0iI7RG5pS2C+SV0pBUUX6NQIN0rqqShmbcp+1KAfd1mhtO0S3mpnT
zvctcuZASIr6rApckX2U9d9f5eMRXOesq7+7/j2nV/9F3w55iRMK7sX/67t5Qg1u
w9t4GGUg3dq4kmwjQeN+RUeL+0Ku3xjLN+27tVpJOnSPy70ph3zdrOm/9Ycq8swa
VgHT7sRNzd7McsJLyeTx5mUm4X5e36ydjEIXEcLPT8DxdKwUCwk=
=2Hby
-----END PGP SIGNATURE-----

--thiqvn36r3wkqzzv--
