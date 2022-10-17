Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423386014A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJQRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJQRUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:20:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB1D4B4BB;
        Mon, 17 Oct 2022 10:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FA4FB819CD;
        Mon, 17 Oct 2022 17:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8958FC433D6;
        Mon, 17 Oct 2022 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027198;
        bh=z54rkF4UOtVFeBgyLjiUmL7hvvBxUd3T++Un7SGW4F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryeIxb+CMvxLWZU4HEJxRp0WPAJ59dkKkS5pm1RPyz6vSIgB2TMILLGl45XNaNKf8
         z+pGoMOEln0rbeN2bBAujoVXx0+BeSCjIGAOaY3uPbhTUg7DQT8V3oa9C0oBJfP5Uq
         I29JGOE4G6RgrgSSX7vMPHqVIIUFVNIr4vQh2dMvD9lLfcyHf07TOHFr+0OFzxFRz3
         w9dFMeNpVwn+eoolfY0tnKKn6V8z2gP+lq8efpmJKoX/etRIJGc8sAFATqcCH7bsGR
         VCXgCZSGXw7QB+4O3lx3piqdYaJHs80PQbTGh5ot0nhrjR0OeVgPnDgpzGL7mV+G4g
         05uoJdu8j/D1Q==
Date:   Mon, 17 Oct 2022 18:19:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 6/6] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
Message-ID: <Y02OuQVTxqm5mRtK@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V9S8SQ5cUoONv9dP"
Content-Disposition: inline
In-Reply-To: <20221017171243.57078-6-andriy.shevchenko@linux.intel.com>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V9S8SQ5cUoONv9dP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 08:12:43PM +0300, Andy Shevchenko wrote:

> Cleaning up the driver to use pm_ptr() macro instead of ifdeffery
> that makes it simpler and allows the compiler to remove those functions
> if built without CONFIG_PM and CONFIG_PM_SLEEP support.

Are you sure this works cleanly and doesn't suffer from similar problems
to of_match_ptr() when PM is disabled, leaving some unreferenced statics?

--V9S8SQ5cUoONv9dP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNjrgACgkQJNaLcl1U
h9Dz4Qf/cKh3nwp5Mo7NR0eiTkI4J5KQ7WkEMgIyw75YiI7z1RL2yBwGdRqXo0y1
LEgVrOjMQAxLmDo6mWG4DwBfwmO1EE787uut6T1mGAxqxlavCfkrXo0Jq2GonSv7
c9u7DHNEkicF6exOfwEG6WYsqJZikxUb+vqCMzedAZMLYP2Wa574jtVYszI1c8Gb
+dLe0itdeP3RKQU+tBTXxcboYkpqYfEuCz23WP8egCbsDQiwMv5mpOfKbJ0Oe/Sb
AVhfYh3lC5GLV00br+KLrdF1EOtdeBKVmMOTp75u7+ptb6M0KRCbG32GYiOSAq+4
CsqKcbqK3vqKy7ulDB9xVTkSFjKeEA==
=eiYH
-----END PGP SIGNATURE-----

--V9S8SQ5cUoONv9dP--
