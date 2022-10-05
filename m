Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C65F4CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJEASp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJEASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:18:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC736F249;
        Tue,  4 Oct 2022 17:18:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhwCf1zggz4x1D;
        Wed,  5 Oct 2022 11:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664929119;
        bh=7f1AXE1iUXy2l6gsLJ4y4MkrI3wQwUDAHctr6YT3VpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iLBNvDjpDBHFDY5CHOIvUe58ruf7yvulDeGzaY6dOpY/Z5nid9r6tz/Se9MrYvxmQ
         T4bGEkD1nkMshjwOrr3QiSqlBao5LzlSulPgIBxtEHicP/UZp1kXJcRiGOyh5xwXvA
         8ZpJyiY3OtlhRU0uGdy+iR8aBrUUw/R77rRY62mlOfqlBn0uS3I1/qeX6DICvnz7DB
         YTqPAH0bgS/B4zZ5IvkdGsj5eyUNumnS2eLSxac3IMfpK4KDNdid/CP2urgnWw63ya
         +GmJepq1RnO8WQftgoyIL8qwF5+Rct9qHItWb1LnVbpeWWsDkbGcK8J5QbOifZ4AC+
         qauxhbEIa6rDA==
Date:   Wed, 5 Oct 2022 11:18:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     broonie@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the pm tree with the i2c tree
Message-ID: <20221005111836.1d43b228@canb.auug.org.au>
In-Reply-To: <20220929121853.100271-1-broonie@kernel.org>
References: <20220929121853.100271-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CLTNpKS0jBQ_rQVV2IB/Hax";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CLTNpKS0jBQ_rQVV2IB/Hax
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 29 Sep 2022 13:18:53 +0100 broonie@kernel.org wrote:
>
> Today's linux-next merge of the pm tree got a conflict in:
>=20
>   drivers/platform/x86/intel/int3472/tps68470.c
>=20
> between commit:
>=20
>   ed5c2f5fd10dd ("i2c: Make remove callback return void")
>=20
> from the i2c tree and commit:
>=20
>   06a659d1f0a0a ("platform/x86: int3472: Support multiple gpio lookups in=
 board data")
>=20
> from the pm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/platform/x86/intel/int3472/tps68470.c
> index 5dd81bb05255b,49fc379fe680a..0000000000000
> --- a/drivers/platform/x86/intel/int3472/tps68470.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> @@@ -178,13 -227,18 +227,16 @@@ static int skl_int3472_tps68470_probe(s
>   	return ret;
>   }
>  =20
>  -static int skl_int3472_tps68470_remove(struct i2c_client *client)
>  +static void skl_int3472_tps68470_remove(struct i2c_client *client)
>   {
>   	const struct int3472_tps68470_board_data *board_data;
> + 	int i;
>  =20
>   	board_data =3D int3472_tps68470_get_board_data(dev_name(&client->dev));
> - 	if (board_data)
> - 		gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
> + 	if (board_data) {
> + 		for (i =3D 0; i < board_data->n_gpiod_lookups; i++)
> + 			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[i]=
);
> + 	}
>  -
>  -	return 0;
>   }
>  =20
>   static const struct acpi_device_id int3472_device_id[] =3D {

This is now a conflict between the i2c tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CLTNpKS0jBQ_rQVV2IB/Hax
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM8zVwACgkQAVBC80lX
0GwQngf/WF8wXmsfi5kUfnXMK94ra2tDNX5ggeeBNpWXltiuOa9/lWZ6SFdHSYI9
oCQHBgUWd/is0mxr4l0+lHFyu0RDUFOeYXWyXKb3RW+fbHiHiAtfG3PZMV2fDLaK
RDXY0f5GfgwHYKeWOlRs/qwOpfwEBOswE2RG+dWQi5Sq7Rk1SRnWTtBq2OXXLHj9
pBWaDyqyUjSRdoPPo+Vk+MBfvefXgYWCDGKH3vYN1lrWTkyILOdJprEiI57Wtixj
aUaBkuGeygKvSkTw0W/8yYLIF2uE4h27Ln58CVhcy6gMdXbfz6iKfX9U87U4tboT
/oY1jKfnn6QoHEUfVe2B4HkQp4QeoA==
=WEGa
-----END PGP SIGNATURE-----

--Sig_/CLTNpKS0jBQ_rQVV2IB/Hax--
