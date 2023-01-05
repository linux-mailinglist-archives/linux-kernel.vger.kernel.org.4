Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2166A65EA1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjAELqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAELqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:46:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83DF1CB02
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 03:46:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E05B81AB1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA372C433D2;
        Thu,  5 Jan 2023 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672919171;
        bh=Cik1RDuh83X3oFwc9w6B7VB1PTN9Hd7TIFEd95DW/3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OG2WD/oueUO8uQD+sD1XijfTHFL/AWRDuHyAfd8ePct23bIa9t2iyTq0Nfo69pGIH
         fbDe/1hEn7NkLwN5AVXUVG8bs9+INhDGc13idZtfrGU7Hqgxc3suxIslqmkCrSoCCn
         i1z8G54FHRDYpkq5zb5jJAL5sDupe/nzL8GxQoPo9l0aOnDkbNe/w8/N1BIUWMWJih
         cNY89Xm8t+miYCoqjoBnTTGPTEOAvs5/vfgVGxeY+wyz1+sNhx0wVDyYd1C1LZB0ZC
         NVIIHYgtxI2Jo05pFApewre4NvjFUIxAvS7/jU648OiDbkgRXR3/bhpIAtFbhTbOiN
         fOE+Mm3S2eW5g==
Date:   Thu, 5 Jan 2023 11:46:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-ID: <Y7a4fVwa9WlYJHS4@sirena.org.uk>
References: <Y7WtywhUZCTx3akM@smile.fi.intel.com>
 <Y7W0VOJKlMtaIp13@sirena.org.uk>
 <Y7XLo8febtiSLGAD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6clIRmAMq5MhY13B"
Content-Disposition: inline
In-Reply-To: <Y7XLo8febtiSLGAD@smile.fi.intel.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6clIRmAMq5MhY13B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2023 at 08:55:31PM +0200, Andy Shevchenko wrote:

> P.S. Tell me if I need to resend with tags applied this time?

No.

--6clIRmAMq5MhY13B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO2uHwACgkQJNaLcl1U
h9B+EAf+I/vPfWxJqkCwPWOm+sJxBlPlaeU6T8geBRQao86QUWShHa3hclugSHnN
LKmbfMhvQga/7WQmaGdd3mHqQb9Km4WQX/vM2hLgdSNgXBIPgbZCWFyOXCK9E41q
J66eg5UqNMFsOAjZS+s4Rr3FLSZPwtbH3uINMhZjo2arW7Cq++iuGrTTlGkjUhtB
cUc12EWyJu3j5Xlqa0sVURmWQtugXLKQZ89lCah04CIkcZGub8KaMwu4qucv2G7a
Kv9k98lkKpwS5JBgFPPuBjzxBI4/pgRkaefuOlDvUcFj+RuGs+7137xofH1fJbnA
AVd6iKKPJezBiTRteFXR8LmFuv2OqA==
=TXc/
-----END PGP SIGNATURE-----

--6clIRmAMq5MhY13B--
