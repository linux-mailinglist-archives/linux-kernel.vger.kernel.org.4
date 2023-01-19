Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8726674CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjATFxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjATFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD149550;
        Thu, 19 Jan 2023 21:53:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E923B825ED;
        Thu, 19 Jan 2023 18:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63261C433D2;
        Thu, 19 Jan 2023 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153802;
        bh=vF/z5qpyXP/mL10MG7EvPirP8eSE/txoS1bJzYmIYPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzvGBaP/l+y/aBXX3v0npik84cCY1DzBJscI5jxbYKBb3zILhlGtoDoQp2ZMPy+Cy
         WHtoa4ZVFyjrBAqRcpqpiPUejOAx5K2HtT4Qhy+TOtc08TWCeq7VxNz+1oj6ETt6Q9
         ZMgwkoh1km/yo3W5vXjpst8RLohLNfj+t6SpayNbp+9RiQ+/sJ3a/UEg8h62bmU5aF
         xYzqs7MNpc+TcSjmTNx5u3M4S8aSFh2tgDIUGEi/8NUzKpOwaLHXLkg8aO3Y9zqL/G
         aS6I29C1ZmYj99R1kC4TO+c3J50+RlRyQjSYYP95R3+xabEHG/uX2JZsZazmU8POxO
         HkuD0zfSKFb3A==
Date:   Thu, 19 Jan 2023 18:43:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add mmc node
Message-ID: <Y8mPRQnGPpAhpu8C@spud>
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-4-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XKsT41m8CI9UsBxP"
Content-Disposition: inline
In-Reply-To: <20221227122227.460921-4-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XKsT41m8CI9UsBxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey William,

On Tue, Dec 27, 2022 at 08:22:27PM +0800, William Qiu wrote:
> This adds the mmc node for the StarFive JH7110 SoC.
> Set sdioo node to emmc and set sdio1 node to sd.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++

FYI, this file does not exist in the v3 Devicetree patchset sent by Hal
Feng:
https://lore.kernel.org/linux-riscv/20221220011247.35560-1-hal.feng@starfiv=
etech.com

Would you make sure that future revisions take into account that there
is now a jh7110-starfive-visionfive-2.dtsi file instead?

Thanks,
Conor.


--XKsT41m8CI9UsBxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8mPRQAKCRB4tDGHoIJi
0toIAP4zpbU0OLSqlFxJVLB/Y+fIjOaoIFT/p8c4yIjZ70N3XAEA5X6zPiLp8UDG
nNz0GgJfub7PTipxdxFuprUVZpvnkAg=
=roCg
-----END PGP SIGNATURE-----

--XKsT41m8CI9UsBxP--
