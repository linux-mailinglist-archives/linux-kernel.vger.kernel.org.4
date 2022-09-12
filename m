Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03955B63B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiILWcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiILWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:32:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E159255A5;
        Mon, 12 Sep 2022 15:32:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 134C35C0117;
        Mon, 12 Sep 2022 18:32:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Sep 2022 18:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663021923; x=1663108323; bh=AZbKE7UmIT
        ntCnPauWfZQFO1afu18M8i0kkOP0m6YYk=; b=kahg5emQouho3I+DHXUH2x650V
        e9nt6phkqwyxZy2LadxdRcCfsZuUEcM2OmvlwOXoLxmcPJMTkh+5kq4EBldGeMi1
        y4VsB0i5V2JDvwqHr1pBOfNw0XeM0s83k6izj8zO8i/MKUFxp/C/XxFKWodI+XD8
        4nZF+h0WwPAS8EtOnHE+50ZWuc+8ZT7zAOW8+g/KJymZgGW0UWrEcdlCqKh50uRW
        iXlA+MGWFVWp6F8WWosUQDKUIeTcTASW6MMM3q/yimD+0l6m9ewnNVcS5udEvZTr
        ncG3GcaEVa3hNzH1QHtoMUM84IbXKm1JTAXTEl4TcXyFCUhZpM3ppx6DbEVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663021923; x=1663108323; bh=AZbKE7UmITntCnPauWfZQFO1afu1
        8M8i0kkOP0m6YYk=; b=KtiOHE3wjS50PQWFiHch+k+8r/UfEht2brnm8j7OooIt
        ikdvcF8RMafIviXPfLl0EkDlVAOriTeNvkkkcDuhXGyCWVbUrz64HUnXRohJtGC1
        cyxYlcVGDb9dKrTvHoIN0SXepLwww9NiSjxMj+Q/+bbUtwaSsr28INSk4QW774/r
        9fw8mNeaPFvmq8eYuaB0+qx07Iccua8q8K/K/uGnbt9H2srRsNjP5saeCM6iqs+X
        B9SlwNnf1/OUxTjvdY0FcNgIswpf6qag4478dpJSi2CW6BiNPQ6UP/Acpxh8349D
        U+kC3NLqLnsNeJQwrugxbZvY3ZKlEczsnyZG/lx4+g==
X-ME-Sender: <xms:YrMfY2L47eif0jqzLS30F-e7NsKBdKoohRhwlrMfnbllXc30jALd_Q>
    <xme:YrMfY-LpyDj7ZpgcfiSECoMov5PeJG5LpdhojVGYO7tvfyOhA4FiaJmXh4bm3b5fA
    H_t_2A39l8Arp1gErg>
X-ME-Received: <xmr:YrMfY2v5ZD_WFZQnb9P0FmxYVESYsI9GWe4T5YDXakOVVmUS_zDpMQ4GMERmmjT8wZBvJl3lCXNUaDC1wU0AkyirkmJTB_nq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedufedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:YrMfY7bAm7ME6XQgxnnTyWfwOzCQI4hUSgj8hhdFqa6XIbDq2sfyew>
    <xmx:YrMfY9ZVgCDUSf16lfZswTtQ_qMYHnq4jgz51Ym7RxrlRg9OCdgNKg>
    <xmx:YrMfY3Bs8VkmwXFHPEqUc27FVYqzdQ3jfbN7fU7mihiWQHxXvXgAiQ>
    <xmx:Y7MfY56wqKkDf60c7eVlULcFfgO6Qo_F2qbqbARAxamndnTMaO6CeQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Sep 2022 18:32:01 -0400 (EDT)
Date:   Mon, 12 Sep 2022 17:32:00 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemit V2: Update for Facebook
 Yosemite V2 BMC
Message-ID: <Yx+zYP5qTuDrjP10@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220907125035.GA28461@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wtyQ+jALApv5xxeq"
Content-Disposition: inline
In-Reply-To: <20220907125035.GA28461@hcl-ThinkPad-T495>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtyQ+jALApv5xxeq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 06:20:35PM +0530, Karthikeyan Pasupathi wrote:

Please improve the title and commit message here.  "Update" is
insufficient for a title.  There is no description of _why_ in the commit
message.

> Removed NIC EEPROM driver IPMB-12 channel and keeping it as
> "status ok".
>=20
> ---
> --- v2- Updated the title
> ---
>=20
> ---
> --- v1- Initial draft
> ---
>=20
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/=
arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..2293f10e94d6 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -207,12 +207,6 @@
> =20
>  &i2c12 {
>  	status =3D "okay";
> -	//MEZZ_FRU
> -	eeprom@51 {
> -		compatible =3D "atmel,24c64";
> -		reg =3D <0x51>;
> -		pagesize =3D <32>;
> -	};
>  };
> =20
>  &pwm_tacho {
> --=20
> 2.17.1
>=20

--=20
Patrick Williams

--wtyQ+jALApv5xxeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmMfs18ACgkQqwNHzC0A
wRmF1A/+LnAm86l4J1EwtYo3Jfbg2u5xiUTipuek+MkazVzm/nkL5T6+O6fTauWv
fVPYy4+3d1xFiY8uBcvNgjyiW8Et1Qd1ItBPwLz4185h6KOLavjf+1yvUD4yg8t9
a1qoInbu0F3ctbSsDqeFsZklgBD1A1JQbpt1nGEZ+TgmnLLRI20KiybbZW1MImvR
40hWfChBSUJChimnbHmFNaQtRCJCDvBkmR7mE9yUIa3YZS5S/UgPQmw1yf3cQUaG
8k3G1sSoPfHqCnRHfWOMQLpXvhX2yZ3VPDpBTr5zZXtI9a49+ahyTOwzuc59plpR
bDKA6R3qX09OEFYmH8aP6x3FfQPynYGrt15GsI1lWRkW14e3wh2BCOiqUp9jPtsG
xH6mnlPP6YIx784SSVJ0+9KexYlmgTq5ePkwCjMtnDrc3h2O8uqOzjVeY/9bH2Wp
RIRpIBaD0qYgCmK97MHuN7FphZjkY9ddGhj4Y3YsjsPfR6s79SoeFa/uJzEvdQ2R
1TYQRUTHl9Nyq4IrNp0Lhq22DyyPeE1HG88kYisf3c+03xepva0QcWyx3mTXf+hn
E6S9gnb8gj9w8aXlNNjXdR+gYEtA2Cbp/E1rQ9RbU/CNeiIRtqro7N7UyumjNRMg
VYXbt2+Wn0saWzp2/wq2Ld6PkroRFg8tnXTVOsDZTkJlvIf3QPQ=
=gYOc
-----END PGP SIGNATURE-----

--wtyQ+jALApv5xxeq--
