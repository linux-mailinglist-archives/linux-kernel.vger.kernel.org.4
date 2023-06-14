Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29D972FE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbjFNMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFNMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D2189;
        Wed, 14 Jun 2023 05:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DB563FFD;
        Wed, 14 Jun 2023 12:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16384C433C0;
        Wed, 14 Jun 2023 12:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686744976;
        bh=KONbjq4rJQQJic1hHon1ie/Ekdj395YZ8PBC63PLpeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRdbC8mQyi1BfZxbcfGcbdMbObXSdrsf9RwceswN5hVqwfT32GTV9pUVM4jWRBMzt
         +wIWm2CG8RNulzEWnADIyPoNve4bgFTusHb1N1iJGc9QL58XcP7aHLEN6M/hfCzxyJ
         baeQxARyeuLWhG1T9dQY57sbRezI+uVYUl/EqSnuU/KZh2dhnZ1ATrFRzWnYqjETom
         XzFiXGIH5Pe/qPsV2zQcEJsqrMNYLYo80BI8ZbKeriWQcgOrzaBJEGdjltNl6+jO8O
         wAAV4EXZT9sfwB9kP3pdoUgmW3+rFZ5D1TqMvLWq8oyl5fWpvrr1VdvnwKUKPnsJSO
         /PLe6lNGN7dpg==
Date:   Wed, 14 Jun 2023 13:16:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] spi: stm32: add spi slave mode
Message-ID: <d0b62ef2-5355-4c00-9ff6-4ea9995ec0e1@sirena.org.uk>
References: <20230614102628.202936-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xsbh6SZE0ffTF5Fr"
Content-Disposition: inline
In-Reply-To: <20230614102628.202936-1-valentin.caron@foss.st.com>
X-Cookie: At participating locations only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsbh6SZE0ffTF5Fr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:26:23PM +0200, Valentin Caron wrote:
> STM32 SPI can operate in slave mode.
> This series add this functionnality in spi-stm32 driver.

The more modern terminology here is device mode.

--xsbh6SZE0ffTF5Fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJr4kACgkQJNaLcl1U
h9Ag3gf+LLqdQq0z4sfFAJOLfVZqO0E38o7KHUE8gSP6VvTWuhZpt6VCzZ9tm5+D
KCcckmQKCsedk6yQAqjyA/udx1gKX2+M6YJzjcdBw+0IlFaar5WfhNHJSFAR6nmW
Ygr69XT2eVRJ+Zefc9vnUyhug6FZyrb4BcjB90kTpIPkGrtQr78v+GADRbU2tMHU
bHjD7lQ6aDYxP3kYjLfz4MHilWV9VctyCT8ryvTZ6Gr1KROhiJ3LECX9DI0QDhCr
GwRBoaCmvNfUD77+AjuRBIyqpR8zBMH4QPoc00jxXwqJky8dLAAknbqbzH9d3czf
jMV62p05IqlFlK/utF7MjJx1DwF6cg==
=YvVo
-----END PGP SIGNATURE-----

--xsbh6SZE0ffTF5Fr--
