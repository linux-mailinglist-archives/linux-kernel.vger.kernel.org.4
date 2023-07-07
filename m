Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8174B4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGGPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D7FB;
        Fri,  7 Jul 2023 08:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267EE619D7;
        Fri,  7 Jul 2023 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C65C433C7;
        Fri,  7 Jul 2023 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688745114;
        bh=ud+RnxlEPn/6G3NjSjCC8CHTL6y1Q7k2O1jgtO+8ks0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQObsH7RATPBds3DH6LDXuVhPjKywqbSxxiz1IwhMkjbejU8lZneQH3UzJsWl7vxf
         jgVObjr4QhM+Hyko048DT9dtDHQbRvtuTt+gVKS2/BwW5OhmTClfsmCfgZx7I3CJBn
         Ea6Y3IiqOE2k27eNQINRMXsKv+sveHb4U8FiWcAi9e+Wt9MlezbkmlsANXlgpcV2r9
         qmoTuvf1FBmUCEqk5w5TEi9Wpt13wg+M2h/Wdcv++wCYeqUfjEeftygfRH5UE1TaE9
         OsqjcYmj4qEvDuuyZUli3PCPReH4OT2BOHNxJiZHjN3cXg7T5nuQ6Z/rfqCRLD7ecO
         QnG5zbJ/c3F1A==
Date:   Fri, 7 Jul 2023 16:51:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Subject: Re: [PATCH 12/18] soc: starfive: Move the power-domain driver to the
 genpd dir
Message-ID: <20230707-vexingly-prologue-fea19dd3d962@spud>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-13-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1JzrwQM+ZMUZcr36"
Content-Disposition: inline
In-Reply-To: <20230707140434.723349-13-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1JzrwQM+ZMUZcr36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 04:04:28PM +0200, Ulf Hansson wrote:
> Cc: Walker Chen <walker.chen@starfivetech.com>
> Cc: Conor Dooley <conor@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

If you are not going to write a commit message with an explanation,
the least you could do is CC me on the cover letter.

> ---
>  MAINTAINERS                                                    | 2 +-
>  drivers/genpd/Makefile                                         | 1 +
>  drivers/genpd/starfive/Makefile                                | 2 ++
>  .../{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} | 0
>  drivers/soc/starfive/Makefile                                  | 3 ---

Why not also move the Kconfig entry while you are at it?

Thanks,
Conor.

--1JzrwQM+ZMUZcr36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKg0lgAKCRB4tDGHoIJi
0j83AP9yg2QIJTuavXk/CPW+8i5V36EcXTunxgI9WNvwQfusvwEAn1IRMWozRQk1
ZzQwJ3H4/uGazhD+e34w61SNDCpJxgU=
=rXEk
-----END PGP SIGNATURE-----

--1JzrwQM+ZMUZcr36--
