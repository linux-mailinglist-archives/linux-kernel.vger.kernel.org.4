Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7E724985
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbjFFQvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFFQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE710C2;
        Tue,  6 Jun 2023 09:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F298862579;
        Tue,  6 Jun 2023 16:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08A6C433D2;
        Tue,  6 Jun 2023 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686070281;
        bh=GsAcMf51raeYsV6vbOG1tdCBiEHjMvNKUg6I9eW5Tp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ou587+Cv554NFbAyUpcwffzNVuQtVFLdrhV0U/wQwy1dq1HSlG3OL7lq3U8TsyJUr
         nMZBLp87YQGpjLiUz1n3AkYPRv/R/aUuJBm8/k+8lI4rB7EkPpTYwIHXgboqVI2abW
         FEAlCaBiRfxhTT/SOivNvkP3puFrpjrnpYC3DrzAf0iY7AsJjXMWqeuPLO0+xY2b1w
         fFws9e7Gy20itKZGg4YvjdOxAxkVR+sJayrYHSJqyEvxk4n1PJjfRqXf0AoavIstNS
         qWxPlkkGFwMDXrgixFjlkCrgqUiiH5zSd5FAZSTvl+d23z1lN5BeU/nMDVBHpopQrF
         pJDfCFR8aWNUw==
Date:   Tue, 6 Jun 2023 17:51:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
Subject: Re: [PATCH v5 0/3] TI TPS6594 PMIC support (RTC, pinctrl, regulators)
Message-ID: <82930e05-70f7-45fd-908c-37d39fe9151e@sirena.org.uk>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32WbtcUJdsBajjrX"
Content-Disposition: inline
In-Reply-To: <20230522163115.2592883-1-eblanc@baylibre.com>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32WbtcUJdsBajjrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 06:31:12PM +0200, Esteban Blanc wrote:

> This should be applied on top of other patch series:
> - https://lore.kernel.org/all/20230511095126.105104-1-jpanis@baylibre.com/
>   For core MFD driver

Please if you're doing this in future just post a single series, it
makes things much easier to follow.

--32WbtcUJdsBajjrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/ZAIACgkQJNaLcl1U
h9CgVQf/TucnhXI6ll0vuM+yZlKN8P03c9Mx/4NTo0P4VglS1m/6V2NMZZy+aySY
vjfQktzTXOcmuqEz2HMZGNJk3DlgPm/poBqFetJvPvc+8MGDwbXYoCMBs74gamEJ
MFGPdwT9RdfE55xVpXNaLMwJdMAd5i+qhZBa/iWITQCdCzes6MHWTT0KtWfgRdM/
aQozxxufxZhVYjUgh6Y1JM0GXPzc1DeixC5+YMEn12L1Jo1NED3U7Kd+Eq8HEZwv
0+7d6EgY30S+Bxqkgmji8EV3YgF05mmkMuk3ZYB0lsA5i8s2sJVEqu8FfVv/222J
Fh9ZzbSlR0wPLuoUBGzG+Bfz3/vF+Q==
=iGYQ
-----END PGP SIGNATURE-----

--32WbtcUJdsBajjrX--
