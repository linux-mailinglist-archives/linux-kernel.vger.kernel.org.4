Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3243D6FE5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEJVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjEJVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169C2103
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E6F63FF5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E69C433D2;
        Wed, 10 May 2023 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751949;
        bh=T5k5//N6a7rC9iSVTg6GYEGc1XCVn1HqOBIf6ccTI5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7CJrnguzb+6iHFO193HHRofxB8yGgLwViFd50H9ZDMZGl34e5jM51dWYRPACvixO
         3PmZkvEM6uxfC7gOHQqSxiVOn8iuCumtJNrSoCs57xXIOXF9NSEFzV3kh+mawsEy+v
         YgsUF3JZHAHau7M/o+awa91aELWS22KNdqCyNp0bF/UZlbHURmLw60oXVMyg2Gpcvx
         vPxw9F2fcNwc0SXUrgqlK+3H2IZqwrp2V0v9fjfFn0Z/dED9H2UcomEa/rGrp4Bliq
         C4zh6avX87gdTEGSM3cuF4sFV47o3Y3oLnmGS34ni/7R/Ne+PRl8VLp2dacv9rvl1y
         BjY3aBMRWvmlw==
Date:   Wed, 10 May 2023 21:52:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Wei Fu <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Message-ID: <20230510-stingy-kilt-9a682f2c9db1@spud>
References: <20230510204456.57202-1-frank.li@vivo.com>
 <20230510204456.57202-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qH5tGjn1QgjNsUSx"
Content-Disposition: inline
In-Reply-To: <20230510204456.57202-5-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qH5tGjn1QgjNsUSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 04:44:56AM +0800, Yangtao Li wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>=20
> Jisheng:
> I would like to temporarily maintain the T-HEAD RISC-V SoC support.
>=20
> Yangtao:
> Wei and me would like to help support and maintain too.

Great, nice to have you :)

I need to point out however, that much of the feedback given to the v1
of this series has yet to be acted on.
This thread on the lore archive should contain the detail:
https://lore.kernel.org/all/20230507182304.2934-1-jszhang@kernel.org/

Thanks,
Conor.

--qH5tGjn1QgjNsUSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFwECAAKCRB4tDGHoIJi
0hE9AQChaXAGTewRrUHpcsKUxxiNIoXE5KP8RFLqTXz5Y6GM2gD/b7TYBv220hSe
bASncQ2vGype9gVzMq4LUpwQG5JmzAI=
=6TF1
-----END PGP SIGNATURE-----

--qH5tGjn1QgjNsUSx--
