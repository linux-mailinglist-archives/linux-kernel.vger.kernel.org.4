Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B06A9916
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCCOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCCOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:07:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30236153C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F2BC61835
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E7C433EF;
        Fri,  3 Mar 2023 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677852441;
        bh=VfujaCEcuTjqsOwacRiHH+dYgyio9vgq+qn9GPO8IW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1Tzn0f4fSwObk20ywknY5A8LPQNkYi21AYRVDczCvuZ8o3Hx4VrwzYPpxhOhCji7
         wdRqBVMirDzMIY5vrVJBETz/7hU4lPex2gnQkgjqNof36X+6eU84TsBePoUJFCiS5V
         QzsDL4jKyBDQW5G/AvIIFFGgwbKi+ufa8wiRh/l0FLu08pOsY2hWdJH48Awo6U1lNp
         F6wGn1AY03PCTUB0B/BQCf10QNiyHhAR6KowqIvu9eOU60D/+un3T8zEwj3LXuBvpV
         V5NcObozuI6zkR/dtrGSve8++Iw2h/9v7iRzhWEeeKr5sKDrKjghGAg7a9CQLYhe6p
         iIqbde4QzHbOg==
Date:   Fri, 3 Mar 2023 14:07:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: tx-macro: Fix for KASAN: slab-out-of-bounds
Message-ID: <92201fe8-cea6-4ca6-8548-bec883337e80@sirena.org.uk>
References: <20230303125717.29196-1-quic_visr@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iGSIgbO6ukbqtcFV"
Content-Disposition: inline
In-Reply-To: <20230303125717.29196-1-quic_visr@quicinc.com>
X-Cookie: You are fairminded, just and loving.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iGSIgbO6ukbqtcFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 03, 2023 at 06:27:16PM +0530, Ravulapati Vishnu Vardhan Rao wrote:

> From: visr <quic_visr@quicinc.com>

> Signed-off-by: RAVULAPATI VISHNUVARDHAN RAO <quic_visr@quicinc.com>

Now the From doesn't match the signoff...

--iGSIgbO6ukbqtcFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQB/xMACgkQJNaLcl1U
h9BhuQf7ByNTjIoHAnJhyg0ugxS4CZ/zVpW9ijZICFug3NJJ1BnJi+zwcEJrvDPN
66oI2S9v01GNQwMF9ktJkFfg5UW/wDW+VARpWAMt8jZEh3uDIjocec2CIIx2V1Zk
OPXsdTbFqI05bSEy+iydYNrASmWLBKiH8/tXRMTh4tZtdF3dC29Xu49qZEpGrjJ6
dYkG6UgqmaIdw7QTnn5vEy5PwhInJt3OelNvXU6+quQ5XWKHQNhUa/EslzP8dGwX
uXkyPIOg4u9kwv5z7ntohqu4RJAjFPvOtmRFLGuMqJR6Y47YkUoEbcGSDFR1xX//
jTvjbXeoXn//DxPLPKSWYC6uKUaO6A==
=BrNI
-----END PGP SIGNATURE-----

--iGSIgbO6ukbqtcFV--
