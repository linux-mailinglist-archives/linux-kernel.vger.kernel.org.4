Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D794A70C10F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjEVO1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjEVO1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F410C4;
        Mon, 22 May 2023 07:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4B562361;
        Mon, 22 May 2023 14:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABE3C433EF;
        Mon, 22 May 2023 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684765615;
        bh=JaJJesILXmSASziQJChjLhKA0/pvakiuE48bkduWv+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBkmxeC7oI/6vr6MTKWwHAwJdrK51tbu0oqaXoaS9SkOUgvKN7+pvAgTcsY9kuAbE
         4YSyUk6FKvItBgAw1K/jVF6V+bf8T+DlbFAYj4MfUXtv27EiX/FV6s7t7uHc5ymW3U
         O08RwWs0RCoOJSNkVVFDx46Q+39OArw8NLKbsrrIUxGcEo8ocg7xjK+ZgKtZW7jAQo
         YB6G8x+Ftm+f/Ui55tilUt3RBT00Klfi5OIVSCHb47c4a2o9PpHMk6KRStQ3497+wn
         TiBrDv/vLuOy22sDTpoirg6O4NG+PhmD6nyH9dDJ/3EmwGtWubl8fK0RSAejTe6EUt
         mK4KXBlKGx0pQ==
Date:   Mon, 22 May 2023 15:26:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     srinivas.goud@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] spi: spi-cadence: Add missing kernel doc for
 clk_rate in cdns_spi
Message-ID: <14d17399-8286-4a67-a94e-16b28e065fbf@sirena.org.uk>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
 <20230518093927.711358-2-ckeepax@opensource.cirrus.com>
 <649d68c4-cd2b-4ec1-ad06-ff42ac5653b4@sirena.org.uk>
 <20230522142106.GB68926@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qVXc52xkdTuARt7M"
Content-Disposition: inline
In-Reply-To: <20230522142106.GB68926@ediswmail.ad.cirrus.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qVXc52xkdTuARt7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 02:21:06PM +0000, Charles Keepax wrote:
> On Mon, May 22, 2023 at 10:52:17AM +0100, Mark Brown wrote:

> > Sending this without the "v2" breaks threading and makes it hard to
> > handle with tooling, versioning applies to the patch series, not to
> > individual patches.

> Apologies do you want me to resend?

Just this patch please, the first patch is still going through CI but I
didn't figure out how to push this into the tooling.

--qVXc52xkdTuARt7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRre6oACgkQJNaLcl1U
h9AmKwf+MbtkD/RghR4yBND2geu0WCSmCVwXpa6vCmOkMJeY4Cf/bExm3UZWpDvV
8KIGzmCZPwUTqUp5JGQp1AAzpzJLD1gcvR3rfyIlXB7tC2zzR7EB7kon+W9W/nO7
RqHRuKT5k/bMONJAmKF0ODuyvrLtpnE0j6G2ED+dBqkNN1dnvBFmmyN/EcdJ5hd0
ZAzHg1/apr5iBZcBgJljJtBCw1kGSn5MVUQzfmoEIsAmtDx6QktDll4tE+Mca4q8
g2nud1DyCbfFT/WMbvVSwlT19cdJCOFwwFucSgLxSz4mbwoEulxvZTqxxJwyrkH8
DuYNWKHR/bLergDcre6B/3qPyUleMA==
=2lVv
-----END PGP SIGNATURE-----

--qVXc52xkdTuARt7M--
