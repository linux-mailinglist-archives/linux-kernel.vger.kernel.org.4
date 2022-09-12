Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846B85B63BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiILWdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiILWdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:33:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077225E98;
        Mon, 12 Sep 2022 15:33:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AAC75C0086;
        Mon, 12 Sep 2022 18:33:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 12 Sep 2022 18:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663021997; x=1663108397; bh=BlGpyGNetH
        0dfu+MS0Zcjr8kjhe2OqZ2zMEm7PaX9oc=; b=fqatqgOuwf9G2nKhRG+hWQjz9d
        tc8rMU//RxhIcAuW45zXjsJO3S9vZRbK/Xl4fgfh8sW3gAuG8ttc/O/iVsFXOuNt
        LZWVT0MD2fX/LzvygJl+4K8x35j8MHq61lrtPsBcSPvhA6Zxg0nzERUCojoStaym
        iGXuCdsUfpEzzsdGn1CCTGGceVQv0bPwJP6EaauqLk0q07Y3gBJN0AtaAzegX7pi
        l2Ubwg9VvakVRGNTStWcV+8HjCNX5hURjx74zLKJR93a2A2MIcgOLjXwVz+Htiil
        2RZ+sbyDigpbjWRaAZHTRd7UEWkJ+eylz3ZKl7ToEl4I8Yqo3fScktj6seuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663021997; x=1663108397; bh=BlGpyGNetH0dfu+MS0Zcjr8kjhe2
        OqZ2zMEm7PaX9oc=; b=M3+yPT0yGtaeO8xyZAHQf6ksS7DJ+YTaqJMtskXz/Jw3
        WXB4wwlbIcM0wHTZgLQUsSbPoqjem8zsxMNJ5eIDcmbzyRzqoIow0pcGuzFxzIyn
        ah9pRQcO5LdYIIaJVis2hQd9a6ez7kJ3ERLads1kMcpzaoyU/IYVNM7FQpNftpYD
        t2qEIhhgJJcbFU740JBS9ERI3vG64jricrQAAnoDiCwFG1xLzB0F0RqJGMcPqWCW
        Zmdc/0KTks/m45iHdNt4tQ1qaK9Kg728lVCc2ZyaaGs7agJ5VKLINvvBUU7tZvMR
        j6mPCkTG4ZazzDt5up4s9E0Q8jhPj6MOLjK9kNCacA==
X-ME-Sender: <xms:rbMfY1A_m_I59xBEX9iQ7Msrd0RJ0MDTFJw-gWebhyRmqjbIi10VTA>
    <xme:rbMfYzjxscxxknWDC2FSbn1nIlCKIwHXOsMo-qLxJokicB3B_dnbrkxJNXELwiX3P
    TcklqKBVofTEhi7IzI>
X-ME-Received: <xmr:rbMfYwldfO1GyylafwOey24_yWDzmu2yJRsnQNiD7K08kWq8iTSsES6MWQzG8duIxJrSM7tDD5gy5meua9CGjmExNxq3rfET>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedufedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:rbMfY_weubAiLYS5-0pn8RA1C_pBJUY9UlLyRu9uAug1yC53H-9Qpg>
    <xmx:rbMfY6RdPOXfJ-1Mich6_IuyiIeggzZ4O7KeP6Km3pj0S98R2pbUaw>
    <xmx:rbMfYybT6-K1a8mJAuMG4zARYT5nHFkLYH5BaQHc9sHL3iYfqCGRZQ>
    <xmx:rbMfY3Q52pzHX0mH3AJQcWSvP5_gpKEmSVEC250coAB9Gxhf0pHDlw>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Sep 2022 18:33:17 -0400 (EDT)
Date:   Mon, 12 Sep 2022 17:33:16 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemitev2: Enable i2c13 controller
Message-ID: <Yx+zrEViePskgaWq@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220907123810.GA27621@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yDAZokfzATjmbX/8"
Content-Disposition: inline
In-Reply-To: <20220907123810.GA27621@hcl-ThinkPad-T495>
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


--yDAZokfzATjmbX/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 06:08:10PM +0530, Karthikeyan Pasupathi wrote:
> Added IPMB-13 channel for Debug Card communication.

Wouldn't this be better to be the title?  'enable OCP debug card'  Might
need some reference to what an "OCP debug card" is in the commit
message.

>=20
> ---
> --- v2-Updated the title
> ---
>=20
> ---
> --- v1 - Initial draft.
> ---
>=20
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/=
arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..84236df522dc 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -215,6 +215,17 @@
>  	};
>  };
> =20
> +&i2c13 {
> +	status =3D "okay";
> +	// Debug Card
> +	multi-master;
> +	ipmb13@10 {
> +		compatible =3D "ipmb-dev";
> +		reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
>  &pwm_tacho {
>  	status =3D "okay";
>  	//FSC
> --=20
> 2.17.1
>=20

--=20
Patrick Williams

--yDAZokfzATjmbX/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmMfs6wACgkQqwNHzC0A
wRmHKBAAlNXFcJtu9yCVKhFfr7GFurgvb0K/iScj3nGp1R13ZouYN4V5ud9h9jtI
8KNzlfq1Rt7FnSWSejfGlty0dOQQViEnmz463uBRmNM4KTfMl+9P5MAGg+FJzNq9
PUxnEIkKtOtC+rRq2PHXmbntqtkquE7q+cxkC8qVsgpUqDrAuDMA1W2cuc2kjZqz
4Ork/zI3eSf/xP9jtvCXvIsqgKwPiXdtk5TMoftWYUAPatS3SCUN83ycKTLIfVEZ
fFCcDlSpqPH5TeZYeOswMIPRQS+imyCUWaQOlEdbYEQlwFmzlgG6LV8/pFjkheoQ
HgxsRKSL6xfVpCRPG5lnds5PKUdvLCpHi5YLnBb6Y5qg+5vt7BvLGqgjeZVc9AFZ
u+t3FPIgmQ+v2CL/2P9/hff50cFFvYIyR2Vn+drH/ML1WOFNd380NQy3RtcPj+Fw
eQZuln4EE3ShoQHme8zHVkmAtjXx9jLEt44ZpBnlkvT9PwVwX+rNm+Cj8MprFU+b
RHMahDMNcf/HE4oT4M84YSW79N1ZWsBOctPC2Z1f23WTWf0Eywv4arqRZN45S0Vj
G/KVJJZGzevDLdYUDuSi/b2UzKZa9u0xwDwtkV7iKqXkiKc+qcOyoY62S2avaf5p
4UKD9C3Daw+CTDmfe89RdTYfLplB8Fk/czldTiyi5sRQychzpf4=
=kf/G
-----END PGP SIGNATURE-----

--yDAZokfzATjmbX/8--
