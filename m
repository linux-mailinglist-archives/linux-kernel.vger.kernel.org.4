Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B66EAF13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjDUQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DE2704;
        Fri, 21 Apr 2023 09:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7661D651B3;
        Fri, 21 Apr 2023 16:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1789C433EF;
        Fri, 21 Apr 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682094521;
        bh=RCqbQf3FoVtipWV65SHbPWSZI5Lwh+G6EFnVEB8hbLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VogyB5ZRSlSazGpIHv+2+fcp67brgdNiKpTMOyoEFpcxLiAJMSwRajUjw5/LTFTBZ
         DqJak3RRCtECLSRvsq1ccnW0DlDMXzT8Uf0fkah9Ccukr6ATty+ckCG/3o1fipNXaE
         mYQCu9804m5ae8dp2yx+Mvtn6uCjXSpwlwTJpQ6wIU+gggYuyU5wKrM2o97T9kKlHW
         cDlGFkdqHNJI1oxcK8knp4afk+KDT069d26l4QcVAh4rQdWwbqfyov6WjqWFmZsA4j
         ZSw3fjlnNJF+aB5qVD9CTrEbTbMwMQvUHC+Ewq0F8TvOGQS8dxQv9fZUuCfQgtnRPV
         oMmgfPJ4k1VBg==
Date:   Fri, 21 Apr 2023 17:28:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andre.przywara@arm.com,
        conor.dooley@microchip.com
Subject: Re: [PATCH v3 3/3] regulator: axp20x: Add AXP15060 support
Message-ID: <13201fc6-c821-4999-9a13-9f3d9b9bc4d9@sirena.org.uk>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB2611DA5F918F90491A3AA02298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45bLHytBXrBxmUBN"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611DA5F918F90491A3AA02298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Cookie: Hailing frequencies open, Captain.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45bLHytBXrBxmUBN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2023 at 11:08:16PM +0800, Shengyu Qu wrote:
> The AXP15060 is a typical I2C-controlled PMIC, seen on multiple boards
> with different default register value. Current driver is tested on
> Starfive Visionfive 2.

Reviewed-by: Mark Brown <broonie@kernel.org>

--45bLHytBXrBxmUBN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRCubMACgkQJNaLcl1U
h9AKWgf8CsngXR+GXFs1+0YxwrLCsERvcNqgY9zeHy5MTrfYJzjrtF9SfOH2hwwR
gNhC6q7F7ui0G/WGPJTdMbanacGcP5Tq3YHJCkEi9KBw29VZZnSga+DklzCakE+0
9JUdigyaKMdjsE5Z8GqJd1nECl2uqrj2YpBYqqfdh1MnTa4KJ7MsD5CJwCNJspHp
gXjZduK5CdQET5GIfOmqupV7CXW1NdFubGPf7G2Zg0OsNoEqr0N7Nex/omKGJQXS
A/RgeJIF7cteZPYXFjS5+KsgdEgifU0273UogIuckRlhC5dcX/kl9h621iGCQ2z+
5eKaKY3eUQyw86t/XH3jdl9xRJo+fA==
=nJG1
-----END PGP SIGNATURE-----

--45bLHytBXrBxmUBN--
