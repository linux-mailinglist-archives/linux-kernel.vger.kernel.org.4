Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5D71F347
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFATy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFATyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB7D1;
        Thu,  1 Jun 2023 12:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5C96494B;
        Thu,  1 Jun 2023 19:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B9FC433EF;
        Thu,  1 Jun 2023 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685649262;
        bh=GNZB7xf+gzt9G1HsW4ug6gODb4Ew61MDlaJLR+ODT1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzFVxnu6fKshPIHNUrLulid0K2T7/0NocYWkxO+87q+RkwhI20dwOff9KBRE8BbOX
         JdrWew1obngoe6GnlJEjnY5uhFy6yiZJw67ijYwPUxIlAAxPBL8PzTJspyMg6KB4eS
         Gn6zigpvkGCsQOTQTcRf/KkTPK1t5VeXweS+u33sXIPsXDltN6UkYh737WQ8fjbNF9
         H3RWi8Y7Wdf1F9AawdPln20XpT6BmGoAHTWWO2Tz/OQ7m/E7rLx4wKsFbSXZ7eXl30
         ejigl2NgSfMRs18VvGY54ybLT1yMfY4P9LkAbfQIFfdfgBPc0jvUD8S1CwRRzBH/li
         4nR+VCRK61Qkw==
Date:   Thu, 1 Jun 2023 20:54:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: dt-bindings: samsung: drop cs-gpios
Message-ID: <20230601-winking-stole-cf636aa90261@spud>
References: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
 <20230601095908.563865-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7snEvP/FK7QAoJgQ"
Content-Disposition: inline
In-Reply-To: <20230601095908.563865-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7snEvP/FK7QAoJgQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 11:59:07AM +0200, Krzysztof Kozlowski wrote:
> Remove cs-gpios because it is already mentioned by common
> spi-controller.yaml.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7snEvP/FK7QAoJgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHj3aAAKCRB4tDGHoIJi
0syeAQCC1XUHsKhkY5kRLsw4NDkFoPeHyx0uhetVWtQkf0mSmQEAgUnITAbsMbCA
K73QvKFDAvuRdMyy2Pl2c2nNWgI4Xg4=
=32H0
-----END PGP SIGNATURE-----

--7snEvP/FK7QAoJgQ--
