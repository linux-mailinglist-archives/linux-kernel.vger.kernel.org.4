Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10507636371
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiKWP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiKWP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:26:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A559A27D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A9DEB82102
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC14C433D7;
        Wed, 23 Nov 2022 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217156;
        bh=zL0CCT56Xgsxd4SQl/Dl26mTBGpIJpFPMV7Sf5vSiW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbHoBq+mDlW1CD4ianlE4we3e4rnN+mAAJLuJRgJHdz5xBDqDyV8NeR+CbkZVpqc3
         ZbgLNTd2St/C0fASeCDww26vjNpwB0JYFlL1gBiaFC0wYlS4eh6+FaRmFwTrbRK9PB
         w0qWlEzU2+Wfi1Cl5sHG7ZBy6tugvtBwQ3pEw9f5yYHWafQTrStoaVgsOkW45uCQhQ
         ishK2l5NuvFEUnBx4pkiZoY8EwjasbuwSShlq+0jrB+NNFe9CJsn6AhwYDgIy8ryOU
         DeIOLs1khsFqfETj2rnUa/67bcSA18kPTgFMxtFG0nlcqhjROQPnPfvYJkhewhQRd1
         MB0Bm9ojkUSxA==
Date:   Wed, 23 Nov 2022 15:25:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <Y347f24Tx5yZtjLw@sirena.org.uk>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
 <Y3enHzY8XY70/nWR@sirena.org.uk>
 <Y34znr8o9+RceRif@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mO0JegAO4sWomPS/"
Content-Disposition: inline
In-Reply-To: <Y34znr8o9+RceRif@matsya>
X-Cookie: I'm rated PG-34!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mO0JegAO4sWomPS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2022 at 08:22:14PM +0530, Vinod Koul wrote:
> On 18-11-22, 15:39, Mark Brown wrote:
> > On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> > > The Device_ID registers already tell us if a device supports the SDCA
> > > specification or not, in hindsight we never needed a property when the
> > > information is reported by both hardware and ACPI.

> > Acked-by: Mark Brown <broonie@kernel.org>

> sound/soc/codecs/rt1318-sdw.c does not exist for me in sdw/next. Can I
> get a tag for the changes merged into ASoC for this

Not reasonably, that's basically the entire tree since Linus doesn't
like branches.

--mO0JegAO4sWomPS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN+O34ACgkQJNaLcl1U
h9BeTQf/arDxellNcCzUN/glW39lE/e9xse49cq5bOioF02H5Njfsyq3WgvqsGAw
XDC7uiQlMXsyhAlAVTRf4A8ENym66Xa9a7tVl8e3zsrG1RIFIAsrAzsRCw2YfqO5
xoTr4f1qAN6v/l+IMM6mvgFDFf5IlEp68lt04RcUvoBP67hGeiC/H3UcN9BeFhKf
gilZ0E/AqGusU0gYyrzoFHoFOkex1kpLSe7O1XBQBd+sBaD9Jvg/1/bgudMvGVN6
Bp5wWZSjEXdEEf+sab9JVfHBEiUHMtLcFh7e9GUhERuRg9z0EHSM8qUmXuSnFZCq
prAlH54N3Voiz+eg0BkQ42+ZumH3wQ==
=b6cd
-----END PGP SIGNATURE-----

--mO0JegAO4sWomPS/--
