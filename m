Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8275D74422E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjF3S0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjF3S0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B91611F;
        Fri, 30 Jun 2023 11:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762E8617E3;
        Fri, 30 Jun 2023 18:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7241DC433C8;
        Fri, 30 Jun 2023 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688149559;
        bh=lU5Jax1nzuulLLXk8kmWS/Lwjle6hctsG+z14gG1nZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2zuYPZpxDO7zSPz/R0oLW3+8CTRhOHgWtgagY86H+pzYMyLySRY/nTAi5+yrL6WW
         iXTzsfv3BiXOw6YRhYwr855IKdYMmrLdMQIQx0UZBQ54kpo8M0uUKXo72sFZpiJBe7
         P8OyXKLJp99xlzVzQWRkMmmlyBkaAv4Q2+xQGV2qSWl5axyjVWpvjb9/a3V+77bpQN
         mV9lMWip/gI0Wvh0NzCHmChfanhc2KN2+T49HauZcovxE28f0bFgj358RbyQOHfyRP
         JVyj4s+UWbxawXhXP+kbvjdieCccsAW7WocqgXgU6Z1ftqdctnFR766dDZXCOl5uVg
         sJXTCbKmFQaTw==
Date:   Fri, 30 Jun 2023 19:25:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mchehab@kernel.org, upstream@semihalf.com,
        amstan@chromium.org, ribalda@chromium.org
Subject: Re: [RFC PATCH 3/3] ARM: dts: Add Chameleon v3 video node
Message-ID: <20230630-scrimmage-antelope-7d1f82d491fc@spud>
References: <20230630144006.1513270-1-pan@semihalf.com>
 <20230630144006.1513270-4-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVJXDbSCjEHzrhGM"
Content-Disposition: inline
In-Reply-To: <20230630144006.1513270-4-pan@semihalf.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVJXDbSCjEHzrhGM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 04:40:06PM +0200, Pawe=C5=82 Anikiel wrote:
> Add node for the video system device.
>=20
> Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> ---
>  .../socfpga/socfpga_arria10_chameleonv3.dts   | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.=
dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
> index 422d00cd4c74..5e66363d4ab5 100644
> --- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
> @@ -10,6 +10,60 @@ / {
>  	compatible =3D "google,chameleon-v3", "enclustra,mercury-aa1",
>  		     "altr,socfpga-arria10", "altr,socfpga";
> =20
> +	soc {
> +		video@c0060500 {
> +			compatible =3D "google,chv3-video";

This compatible does not seem to be documented & I did not see a comment
about the lack of a binding in the cover letter. What am I missing?

--kVJXDbSCjEHzrhGM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8eMwAKCRB4tDGHoIJi
0sQqAP9qGyuFMg3O1ddjoQJ4GetsY2vrLNfwliwz+tXxXSQVUAEApgYQJHvRhx58
XF2nPBZjWFy0bZmZq68VroZmLUHWgAc=
=0xdT
-----END PGP SIGNATURE-----

--kVJXDbSCjEHzrhGM--
