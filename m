Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC25E8525
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiIWVwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:52:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCA1323E2;
        Fri, 23 Sep 2022 14:52:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C5C0C5C00F5;
        Fri, 23 Sep 2022 17:52:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 23 Sep 2022 17:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663969954; x=1664056354; bh=48NjErML18
        V8FEC6ma2n9S/WAw7f8GnGxxmF8unyKIQ=; b=ddvDvgBFW/wUPmVfW0yAMGY1vg
        nQKjtal8R2KB5gbNmmb0gEfdbaLtg8WxtQadoR0134uV4fYdOqgfrBNhvmZPPjAY
        Co4rQ7Q8cgvrwsG9BWhIYZF5eSy+CeufoaXT/CDWy1hQo9yP/Lt80GR7WfSgfIvm
        yb1R3OLav9dnU3bCksCiPxm7TibrO0zQ93cLJL3gnUFxkCMlMK6MSwKGWKlO3gVE
        iU7ONK0A7LU7T+EWUmVNjCiluw3LABWF/5bD/DTbaP5DLxzrvNzgJTim14YGsCfs
        8q/BgLzetFQl0RgtNK6tj2GR51V9s/CRnMS5fbF0KKvrYLBSapGh92RqlIiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663969954; x=1664056354; bh=48NjErML18V8FEC6ma2n9S/WAw7f
        8GnGxxmF8unyKIQ=; b=T6apudbidu6svbDifmwwQHsbnK/u4vUnkQJNHNwrI2EN
        KhhjZixhCcbi/lil8Db651j/h7C+296ApPjVCSyCj09xAHMMlDrwMFt6ndaqjMwT
        lLEtPCMJFTzvzF1Q0UGFIIRmHgkNhGadaWsId3s2P12hm9CzrhT/Q9sDi4irjB3o
        kYw7RWXnq0YD2V9dU3RULTFRjb08tNkinf5Cvuyg8J7heeAXxMDG2ANJxaGpRWSR
        n+ynxF+I1+NbL4oF6sVI/kDTvz3ArGPH3GbOKxBWYCsoMHFbw3AO2aoMFKls1rPb
        7TFHBR/tuXsVX89rpRav1b2nifdR/TXY8FnVDeqAJQ==
X-ME-Sender: <xms:oiouY2KziXEte8XQRGu10H_OBYTLdQ-ANjksg7-Hb-SEEbht0Eok4g>
    <xme:oiouY-KIGbHetNhsQAK_x_YcWMZCxRCGdiwNnKMQcWxfWNSG5RTTCwLoFkeG1UJDj
    CfWNARXEcnIPfA1hpI>
X-ME-Received: <xmr:oiouY2usknzNEQraC9wRQTIkD1DTer3dh6XhAakB5PQDdXbdRqqR74sbO8ksf07kv45QE_ajwlpcp9Ujri2eVgQd5tPiWwxf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefjedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:oiouY7b34tLWMVfuI-XeH3hM-SPLJUXSmm1R9HAw9wTklFQfUb2W_A>
    <xmx:oiouY9bAPCE5K1gYZA4zDqKhAPqc3YFYiMP7oFQUDl2VbesrHpIhDA>
    <xmx:oiouY3D7TJYKSkNqSLmCxxnXj15Aq0aBUe1hb1p3fYCSjzPBsxL0GQ>
    <xmx:oiouY7OFwT7R_aZTzzHWB0SamZvjiP7h1a4899y2prrRObLSF3Aqrg>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Sep 2022 17:52:34 -0400 (EDT)
Date:   Fri, 23 Sep 2022 16:52:33 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
Message-ID: <Yy4qofFUIxudLxbS@heinlein>
References: <20220921064309.GA18932@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wHWYLb7Xs2B5C7b+"
Content-Disposition: inline
In-Reply-To: <20220921064309.GA18932@hcl-ThinkPad-T495>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wHWYLb7Xs2B5C7b+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Subject: [PATCH v4] ARM: dts: aspeed: yosemit V2: Enable OCP debug card

Please double-check your spelling of commit messages.  You've misspelled
"yosemite" here, which gives an impression that it is quite likely that
other things are wrong with your commit.

On Wed, Sep 21, 2022 at 12:13:09PM +0530, Karthikeyan Pasupathi wrote:
> Added IPMB-13 channel for Debug Card communication.
> which improve the readability of the machine and makes
> easier to debug the server.  and it will display the some
> informations about the server like "system info",
> "Critical sensors" and "critical sel".
>=20
> ---
> --- v4- Resolved syntax error
> --- v3- Updated the title and commit
> --- v2- Updated the title
> --- v1- Initial draft
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

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--wHWYLb7Xs2B5C7b+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmMuKqEACgkQqwNHzC0A
wRkAfxAAhLE3Aykgvtr1bC+tjK+SlTLbEJx1tviuSQLRCJQiG4svJWTSiVWsukmU
lRYBTtx5wWtTAKTMcltlihOLgUmvhp9WmELC/LlCZqNTvx9CFZk6zwM4LkaFW7SJ
+L/rL3ecLmP4QhAia9j5+pkZH/EVeN5gfuiYgeGFgDTx2cQAJ9614rBUpalcCnBZ
Spc4CmZeOkmMv88RmU0NqvnLEnOXBTATWKpxh+3VbPHFa2xmMqcvleWA4cDAI4li
nAyudDPMpOv/wg8ofjtPypfFNqG+tFZRU7Fdcqd5NJwkFMlGfC49aaNKbpkivy32
EY/95D/rcfl7bQey4BHoUB8CaSMGFsyFw9Z/YalLZ57EiZ4YAKAEWgPAWzQU1yJb
PjDyXwnQh12jvOG79XdVRWELWO3qvjszhcCAknTrBxerCceC8Ga+cA1sm5eoZR1N
VSK2KP3FhL4yST8OEFU2C2yvgKYi9xpRPB12/po5mTMPlxbsPFlJ8IJxGT1NGsqP
Ip4vsiKX7RR1sJ+WAr77gcfNrN8pvScm3gLlluah+JMPr23ZGgBlIGPl4FTk/xgS
VMBGcO9zfcc+8BKmgJZ7Yc8hfu7TEq3XoM3cP0VR38mO3BKwvx+hcHiVO2xSKKDU
S+c0oNAo4Z0oJIveoA8ucTBVHTWs4PZZVCKE9kYRTS1TTpnIuPg=
=mMuK
-----END PGP SIGNATURE-----

--wHWYLb7Xs2B5C7b+--
