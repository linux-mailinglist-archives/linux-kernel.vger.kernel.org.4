Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5623465DA48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjADQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbjADQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:42:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9B373AE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48B5BB817B1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F00FC433EF;
        Wed,  4 Jan 2023 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672850561;
        bh=tawCq5rDNts+pHcVIk1xFpMG4ptIp8MdqNAWL9sUCKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpxET4oVPdaev6BWt/DzVoqIPC7DPZGDZ2jVQkbiTKqqCPIqA9jkcJRcgK+Et5n1Q
         9zVJQpC+v+Jh6kTrLqnGWXOUXATlsVrh/ajomkJUCo2TAUJWfmiCyfGSN/ib7GskH/
         HV197Q1A6Zx9wqvkWsuFLb02UcWhJCZcft413EjTzjA1S979VviYyAvrcb3joC3bwr
         QC8dCbgWt01L6T9jC1N4uW6lERAD+XAQkW6tvSmzhCRloOK1HxgRrn+tx7KMdT+mZV
         Tyg+M2tHesqSaoEafgDVQz4If7CN5Q1ZoKqjZjdRhuOw/cIRedhAgelLGGmFxqc+Vl
         sEIqAdfJ3HgbA==
Date:   Wed, 4 Jan 2023 16:42:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <Y7WsdF1rK/JmS01W@sirena.org.uk>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
 <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
 <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
 <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="600BhCXh/yAphDa9"
Content-Disposition: inline
In-Reply-To: <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
X-Cookie: Stay away from hurricanes for a while.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--600BhCXh/yAphDa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2023 at 08:15:27AM -0600, Pierre-Louis Bossart wrote:

> For this series

> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

According to b4 you've only acked the first patch here because Andy
doesn't send cover letters :/

--600BhCXh/yAphDa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO1rHMACgkQJNaLcl1U
h9ABhQf/XFeIxOWyHgbkfokMWdWoAi7UA8p0E70CSx2GVz+PkIITj4yDCJ1eVvE2
ZkGD4qu7K8mTd7VqHIuv6GDsaoU9ombbBEpr+uAIhx3Gu8frwPrbvJLH5/QaKfDa
hZ8zsW9r4AoxrzJi9e0b0VKWQIb0IOYRCs19QBnCxe6w2/mU/cvcSSeumIaT2KD+
f8Zr+MpOq3w7XfoITNPnpjkyJ3eVmWTDFB9OiqbzQrysi5yAOlnap28n7NJTt+da
eflpwmr9HAStbMbzURV2JWlrcioumyfgsPp7GUTfh1U7JWomSRvUk0dK3x9sWou0
iz4/5dGRm/DGOgbd44tPvbf/asPV4w==
=fAp8
-----END PGP SIGNATURE-----

--600BhCXh/yAphDa9--
