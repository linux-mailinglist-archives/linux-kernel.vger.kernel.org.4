Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643E5EE346
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiI1Rht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiI1Rhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:37:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BBF3720;
        Wed, 28 Sep 2022 10:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9990B821A8;
        Wed, 28 Sep 2022 17:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C05CC433D6;
        Wed, 28 Sep 2022 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664386663;
        bh=ECgaTTdtQtgj0B6GlAF3UizrA/LkdiSssPfWpdOdeVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhsSNhCsQZhnvWLeOFBUqZ7nTblu40aDDJr/vsB6x9Cb56GOdwiKYrAdBBJK3Eo7P
         22/NIczfs9U2XjEuTvyPwv1D8SdaQYyppWM2QhdtQNnuo9CrrHDv0OLHusOS+6ebli
         zRaFVjnrZcnyUp8Pz8MyPTbLi2RSBq/dnuMhcEof/nuoglGW0hpVHPAW/YJqvKTkE7
         mZULu9AGyIE5AUpJqoNNN5ne/mQnbF682GHkr8ZB6i4Rv3Fh+2f3cWzEEP2lCVmoWr
         UNj4B2wDtYUuPJXMWYFShwrPkMQ1wxgE6vYzIDakuqwnHpYG++LAeB8A75GZ5NqhBY
         P7D55Jpz0ydPg==
Date:   Wed, 28 Sep 2022 18:37:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 12/14] regulator: expose regmap_find_closest_bigger
Message-ID: <YzSGYZQ8nslb+bLC@sirena.org.uk>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-13-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RbcWQQl80xirt0Ff"
Content-Disposition: inline
In-Reply-To: <20220909175522.179175-13-sebastian.reichel@collabora.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RbcWQQl80xirt0Ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2022 at 07:55:20PM +0200, Sebastian Reichel wrote:

> -static int find_closest_bigger(unsigned int target, const unsigned int *table,

> +int regmap_find_closest_bigger(unsigned int target, const unsigned int *table,
>  			       unsigned int num_sel, unsigned int *sel)

So this will create a function in the regmap namespace in the regulator
code which doesn't seem to interact with regmaps in any way?  I'm a bit
confused.

--RbcWQQl80xirt0Ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0hmAACgkQJNaLcl1U
h9Dd0AgAhHglwkClmkyAa+iAyQuyY1qiQUCN+lhIS4TUbfvB2UPo0KOhIxWmZBCs
Ymo8jnBsQi/gMnptSNquEAEEAnLoGpm1QIP+ENVVpzYA+zstm+/DxlnjeWkPBoPI
+2bBULFVQd7yOYc51SBjZXFKY7h7UuBsBfj0LdO8KcaBPTA8saiJAnORzwjQGBpU
ulm9UzaPUUlFqlENSZXmixk0iEKF0zjdWO8jcVwjllKGoRl//0rGG+p9a9kyiZKv
tEA0wlfXnwrmXBPmYdIWRn7wcOyLaMtb8ARBEZt1V2uoT9mmp4Avl9wJwZloD95B
j21KVEAf4K5o4hHCVvQMZUmPDseoCw==
=W08G
-----END PGP SIGNATURE-----

--RbcWQQl80xirt0Ff--
