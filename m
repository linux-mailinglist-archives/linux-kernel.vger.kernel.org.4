Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39A73BC85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFWQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjFWQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21B270E;
        Fri, 23 Jun 2023 09:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 840E6619E4;
        Fri, 23 Jun 2023 16:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9585C433C0;
        Fri, 23 Jun 2023 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687537556;
        bh=8BSU1uoOm7hSm6Lmw/MxVj8R8nDMM2P3Woosh1ZcvZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpDW/le3KDwp9SrBMwFLunXeltQLNhKl2U8J0SM7Balu06xLVgppJtCvYuIlUP+1h
         cEmFzUHLYjg3ZptCGYrGWyONt27rSixGJSUn/Zwu6ZSV0zNO7xlq/OhatNyqz9JbWt
         tq4RRRQA+yPhQDYgk5GTMv1gwH/9ouerLgnlWXFtxv0jNRImQbRjpDeTzBtAGi/VMV
         GpePlUptHQyq7H7WpIk/ovn6g7L9lEYHwMMA7nfrvBicbBIoN2JkY0wRv085fawxv9
         n7I7VoaqcDfOeuFV0pUpNFas+NjIyDhudOigZ7AN9EOzJq2ubHxJsaCFtjLL3MCBT9
         eGbmsbr/hXpvQ==
Date:   Fri, 23 Jun 2023 17:25:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20230623-elite-exile-5074bcd2eaf2@spud>
References: <20230623150012.1201552-1-privatesub2@gmail.com>
 <20230623150012.1201552-2-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1gOb5YGhbcjVPxc6"
Content-Disposition: inline
In-Reply-To: <20230623150012.1201552-2-privatesub2@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1gOb5YGhbcjVPxc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2023 at 05:59:59PM +0300, Aleksandr Shubin wrote:
> +  resets:
> +    maxItems: 1
> +    description: module reset

Also, this description doesn't really add any value, resetting the
peripheral is the default meaning pretty much, and should be dropped.

--1gOb5YGhbcjVPxc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJXHjgAKCRB4tDGHoIJi
0jeaAP9fpvlP8uveLMQLZKt0Z7dT2q18NKXE+yLZo2WhRh+eMwD+JOXUIXIzpiIi
ZUc7H1i2K0OmCSMj/Bnbb1EyzhccTAU=
=CZ9F
-----END PGP SIGNATURE-----

--1gOb5YGhbcjVPxc6--
