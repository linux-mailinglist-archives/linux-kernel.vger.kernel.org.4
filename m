Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C9D66A3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjAMT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAMT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:57:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E87D256
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D2DDB82097
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508EDC433D2;
        Fri, 13 Jan 2023 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639839;
        bh=psMGJdgXEDhHqs6+nx8XQ26BP+2CjFD7qZ/x59x3SEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZbdrdxa58jGYYcx35JnYbKGRyS3ok+Lutba8s3nrkDWWQrDUXk+IZs+POhfcPxKG
         TVPR35D7bzqQDNsqS09UaY3VxR3j6CrPC9jGeXcdll0V/W8fgX2//7LXaSZv+0G9JO
         VJF343kc83gNHPzu6I6YAjE2fwoJ7qnEMo/6jgFGBWBNu8xIaWa60Ey1pJPUsJ+vAK
         h963STHp4Jn6JLEtPeXS8fFfRbDVfoCGR0gJThEqQ/7t5kXGQOIA2nnwtzv/G0omdx
         8m0QVzvctvN0n6z6FjxARsFPDGnnp3L0IrCf4BVikulslqRWjc6JhEk3Rqbkmwpqh9
         SkoYYfHd4nxww==
Date:   Fri, 13 Jan 2023 19:57:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org, Mastan.Katragadda@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Message-ID: <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
 <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
 <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
 <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5R3mQI7755N2isNj"
Content-Disposition: inline
In-Reply-To: <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5R3mQI7755N2isNj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2023 at 11:33:09AM -0600, Pierre-Louis Bossart wrote:

> I do recall some issues with the codec jacks, where if the card
> registration happens too late the codec might have suspended. But we
> added pm_runtime_resume_and_get in the set_jack_detect callbacks, so
> that was solved.

Right, I would expect that whatever needs the device to be powered on
would be explicitly ensuring that this is done rather than tweaking
timeouts - the timeouts should be more of a performance thing to avoid
bouncing power too much, not a correctness thing.

--5R3mQI7755N2isNj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBt5cACgkQJNaLcl1U
h9Amowf/TSY2DBZY7eTxdtVv9af5yNvLjFgJfNge3+K83ylW64H/9hLJV15RoHdI
c9BdxzTIyxZucV8SLW0lYqG477MQzg/kSsASsPbETcSI77Qwm2lsVHSJC/nXU0N2
PlhS/r8x+j/hVtX0B6d8p5mciXfAqI4KRXo3+P0BAddr1dT4FwQOHkeftzIEoU1z
EHv5wVGPidIEjCnJraBzFCPtiqlQeelMQWUsAyBWWuiHjthhuHscuXTD0iH4vM82
tLrSmopJFk8O23yQgICI+zBrUb/W46sXGf8JAbBvZBGmwwMuf+TEipFLfaJ8FP1F
HcSufqSJhFfUnOIV0YB1sFWIUQSqqQ==
=rznC
-----END PGP SIGNATURE-----

--5R3mQI7755N2isNj--
