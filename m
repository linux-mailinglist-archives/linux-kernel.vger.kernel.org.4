Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC90A690BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjBIOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjBIOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:32:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0456ED8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:32:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0780B82158
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EDEC4339B;
        Thu,  9 Feb 2023 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675953129;
        bh=ygTFga20HK6R/IHSWBx+L6XIycNYcDIL48e+pVyu5g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ss0bN4mWcetvdXVhBzlcEViEd2hlp31AqVrENtG+3YoQXKElGlHH/ePAFWbV8yFqI
         Z/eYejWy0yXZ+FMNEUnR+TDVKVJGXLtRcDizVC92nWfBI9dmpd2sfg4EoeiLi7z5IG
         uAnB5LoIOwePTyyS09R/OW5p01ojhWJF3Vmhw004Jn7qytKHnnX5ls4T0ydJ49wWSx
         paiTeGI6hSkrK2OpfsxkEUFu7i//k9fTqkJqu86E/HyjZl51IKLQW+gjO1nSygErXx
         EldUCvfS54IcXO25++Q0ejiz3ci24/xaQPk1Y9annG/Aue8YElV2z7lMEqtqqEWw8r
         9bAssus5Kf6Qg==
Date:   Thu, 9 Feb 2023 14:32:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        amadeuszx.slawinski@linux.intel.com,
        kuninori.morimoto.gx@renesas.com, ckeepax@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: remove redundant variable in
 snd_hdac_stream_start()
Message-ID: <Y+UD4yg2cgsucnlZ@sirena.org.uk>
References: <20230209121723.14328-1-zhangyiqun@phytium.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3NpgXB+aZuWRLp8s"
Content-Disposition: inline
In-Reply-To: <20230209121723.14328-1-zhangyiqun@phytium.com.cn>
X-Cookie: Anger is momentary madness.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3NpgXB+aZuWRLp8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 08:17:23PM +0800, Zhang Yiqun wrote:
> This 2nd variables are all set as true in treewide. So I think
> it can be removed for easy understanding.

Acked-by: Mark Brown <broonie@kernel.org>

--3NpgXB+aZuWRLp8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPlA+IACgkQJNaLcl1U
h9DVtAf+NTyg8/Upf2huOBExZDpwZ9hASDithXXMiu7yd5HUHCDLIwOJZsfLFUty
COWRiRIxZMjcXwHirN9WIWG7wRolzLScWjtRQlvfv7fQ0CLNLCHqUAlCa2AgGtsk
GBS93uCsCQm6Bg1uMIReTx22tuq1nzYA4PAJsXAw8fEqY3asmoW7aTy5orUBrhWB
GIrNVVBnrrP0tt+0WT+biSslsBxkVmDvGO0ibhn0MQ2IOXCN8FUb2XvXHVnFFt0Z
nfwm+dilzdfqpmmAQLdQarCALr8L/swJBZoa2CY+iEazSGS1/u2eu3fSHQiA/ctG
3yhact4FH88Z+zuUTWB4Bczu0nYqMw==
=gHhW
-----END PGP SIGNATURE-----

--3NpgXB+aZuWRLp8s--
