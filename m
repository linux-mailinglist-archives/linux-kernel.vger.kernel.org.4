Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CC73E54E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjFZQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjFZQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B4E58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0675A60EEE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1783C433CA;
        Mon, 26 Jun 2023 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687797469;
        bh=1i7XqBzoj13xzWb3eezHQwHub6Bm84S+qf7dqubxYCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIMqYynh+e4BvY8rhyaUKU6duy7a6cqsct52yzWf8DEwcgjkmsMS8UdOlYP4VxOl1
         Q2vREqz+mZpu3OmWgtZqtX6aY1UGdGxT9DgrTTeVoyQ/8f2PpXS0ve1oUC4BFg+Xss
         n3s+54U0VMIbYGYSwNNMY4Dhu0AI/HS65FWpqarmZLjIw4pFGlldVWkVG7Ykqgya7t
         DYc7mUEjKgMxprkgwpQzdN2OJ5kXjPpOTfONeYKKIVKewo9IVIEeRuZzuAkcsDqrXf
         Uz+K5q7doL6cICN5zEYZ/5Bh2FAH+4HXgh4f6UCi3rPqSVQ7PNpXYqiPPR2KFwIvUT
         cMcw6+DRSsj4Q==
Date:   Mon, 26 Jun 2023 17:37:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH RFC v4 02/13] regulator: add getter for active monitors
Message-ID: <c7ba005c-27ca-4787-a3ba-eda0fb91b584@sirena.org.uk>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-2-4d3734e62ada@skidata.com>
 <4a71b08e-0c0d-a378-7a3a-0cd12912d4d4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FJtQkIrtI0wk0GDO"
Content-Disposition: inline
In-Reply-To: <4a71b08e-0c0d-a378-7a3a-0cd12912d4d4@gmail.com>
X-Cookie: Nihilism should commence with oneself.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FJtQkIrtI0wk0GDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2023 at 04:43:49PM +0300, Matti Vaittinen wrote:
> On 6/20/23 23:02, Benjamin Bara wrote:

> > + * @get_active_protections: Get all enabled monitors of a regulator. OR'ed val
> > + *	of REGULATOR_MONITOR_*.

> I think it wouldn't hurt to have doc stating in which case populating this
> call-back is needed? I haven't read rest of the patches yet but I guess this
> callback is going to be used internally by the regulator core and maybe it
> is not obvious for driver author that this is needed by core to be able to
> support automatic protection handling.

I think this is true for pretty much all callbacks - broadly it's just
the case that if the hardware has a feature the best practice is that
the driver should implement all relevant operations.

--FJtQkIrtI0wk0GDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSZvtcACgkQJNaLcl1U
h9Cm/AgAgGrZhSisrmIkumW02U2K/+3GY8d4MiLn9Vs+TBgpb86N2KdXP7bjQiSl
gCbI3644D7vHr4A2X5P9DB2YmyylAi4Abfu8rI5yc5ACoOqCopXgIxY1pHnxGf80
EypnD3YbaQjMfNuzReQ0GOH0CuOCFD+zKlpxDK2VnElqoHLPwNfiOT3Okmm5PsIv
05ocg6ncP418swTGaQ4xTYICaOqChb1HQb4hJpJjLw85xvvkepVBuuap9k6Apkew
RFo/twdelPpxEsBZRy3BAQO6oe/XEObkfm/pG1ehYpLfJFSErtrVDdiihkfaaAoY
L3rsaP8n8Vrd3tIgecP6hC6oJM64Jg==
=gRrb
-----END PGP SIGNATURE-----

--FJtQkIrtI0wk0GDO--
