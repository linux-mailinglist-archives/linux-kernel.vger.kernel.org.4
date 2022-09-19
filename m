Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BC5BD2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiISQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiISQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B13DBEB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FED861E69
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14CDC433C1;
        Mon, 19 Sep 2022 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663606696;
        bh=C0nAMxyn3SgqoAnhU2dZuMQuHSZiA5Mv2JW2+3MF/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3djGa8f5Lt/G/69FO79jm3ixnOlkiKcpdKVHcpT7vD7SRRe5KNsx16jMSynu8TWv
         2Urmia4jSSbRhBKnuFIuZTMf6e/Twk+x9SRq/Rh1kO3kFG3mYJMzUh8ya4OtwN7ZMm
         phdTzdJl0HRxzC8UGfApRaJ6vBqVyMpqoIgH+JiDqiYQeLPp2YvqCrN/t7Kwx0gLFU
         a8fVVUkzJ3H9Mq3qQbQ8E+mATcJvep3ohCLv+RHPqTljemXvAf9brKBNJP3BL3GZ91
         zZS0S5N/p5qQZSaTwJQk6Ufyh7FwNx/ggy3UEEU/g3kjfJNmq8slgTSvnpvF9Qyf6R
         JnmSzoRrHEseQ==
Date:   Mon, 19 Sep 2022 17:58:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>, kernel@axis.c,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Astrid Rost <astridr@axis.com>
Subject: Re: [PATCH v2 0/3] ASoC: ts3a227e control debounce times
Message-ID: <YyifmJz1EUZQioDn@sirena.org.uk>
References: <20220915113955.22521-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MMQhPDbTWkSdlB9F"
Content-Disposition: inline
In-Reply-To: <20220915113955.22521-1-astrid.rost@axis.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MMQhPDbTWkSdlB9F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 01:39:52PM +0200, Astrid Rost wrote:
> From: Astrid Rost <astridr@axis.com>
>=20
> PATCH 1 - convert ts3a227e bindings to yaml.
> PATCH 2 - add ts3a227e bindings to support debounce times.
> PATCH 3 - add ts3a227e driver to support debounce times.

In general it's better to put new features before binding
conversions, the binding conversions can require more work than
simple feature additions.

--MMQhPDbTWkSdlB9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMon5cACgkQJNaLcl1U
h9D+uQf/fWSnbD8A4X7r2Xjxroyy/LkMRBRP/NnctY6OgS+lLFESBrnRylKMMU4k
cVmMNqD/UGdJP+pPdrMk8kCd/vu3M9BCupUFraOaHstBiKwknFZCVlBvvi3cYRn5
35RP1kIdXSK1VJLyp3WIkpzolZ3qYZS2VZ6CFzWuVK7shRoV5Sdk7sYLTuGpbpZa
mwhwt+40/yD91RHNZOtUiBkgEYvbDdrSxgzVs4v5EiVRHpO3Sgf5zBhKBcKU+Er+
S9bHm9vEFlYOBEHUQLpugj0uGCza35sZ3QcifTwuDTJqLjkEbcW3Gi3mxT3Wmt9w
8JxRPlInIqZc4U7+PHQqobzOPCuhCw==
=yZTW
-----END PGP SIGNATURE-----

--MMQhPDbTWkSdlB9F--
