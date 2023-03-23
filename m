Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABBF6C6AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCWOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCWOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:20:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F83756F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCE16B8214A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEF6C43442;
        Thu, 23 Mar 2023 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679581192;
        bh=Ol36h+p/kQjIM0PAXDsM+TBkmxB34eJWpbGDnTLG6pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHzCWLPCePksgmOzxJ9O0dgIkncejQkCg9PpNDXoWOJXsRTjjZU5DzKTFcW5DhyoV
         P0NdomBaAiLi4FEi3N/BRO8trFthV7YiiXmYQaVvvFb/CLtq+bYG7dCVUnPcfMMVZv
         Dqag4HTFmRajrLyBA4RVDpuo+kp7nymjk+ZbD8M9sVsz8vdapjzwQXIpUPjzNFUJRN
         NDa5T2gcoHMBiBHJJs/K0XOECZ6nQdR2NWTRCp2LPpPmqJD13xT6tuefHLGkxR3gVn
         G6eeV/xEf1qrgHAoFs67yBPKZEYRMc18CSOWW+801N+DuX+Jg1ABiylQtJJFpK+P4t
         4NzrJginon2SA==
Date:   Thu, 23 Mar 2023 14:19:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: Re: [PATCH 06/20] ASoC/soundwire: intel: pass hdac_bus pointer for
 link management
Message-ID: <65ac5ea8-1892-469d-ba3d-6c9d66aea001@sirena.org.uk>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
 <20230323054452.1543233-7-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RBVyxDlDYijhSVHm"
Content-Disposition: inline
In-Reply-To: <20230323054452.1543233-7-yung-chuan.liao@linux.intel.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RBVyxDlDYijhSVHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 01:44:38PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The hdac_bus pointer is used to access the extended link information
> and handle power management. Pass it from the SOF driver down to the
> auxiliary devices.

Acked-by: Mark Brown <broonie@kernel.org>

--RBVyxDlDYijhSVHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcYAIACgkQJNaLcl1U
h9AeNAf/cK+pek4AC215/URy8g/8HXIy77j3ginP0+aorOaczHO1jbFaG8qB5jsT
UdLcTyUPxs1STd1Q9B8EEZagv2/JIhnU+01igy454TdP33yYTLwV+dO0DwXWDXs1
GHmg9S6J0HSGp1/GUsWb8AlBoo8z9vXv9Ky/4qTjrnJdvvi1NkNvO54fuRb0YlEA
oAdHWX35mtw1f1+iRR1uTcOea9onujblRbFIXaV+iTIkSCcVwEtEBC/Ic34+zT2o
2TVoA0tIzq6fE2XX6hBMlIhb22d1Wcxv4/fTEVXr+mkt+mpC4dU6vO0eosYLh+D3
OLoAVj1OIuIqUosg2jrWR4i3oUqw7A==
=NHPZ
-----END PGP SIGNATURE-----

--RBVyxDlDYijhSVHm--
