Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9583D70E305
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbjEWQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbjEWQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518FDD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D72161626
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0243AC4339B;
        Tue, 23 May 2023 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860945;
        bh=pomwoSPiBagnqeBo1aMvvY7T/pCTXzc7pVKQDxkbTdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ0MuBn8tEKDAW+Ohjeh71k2Z/7EieejwAIdQ7soPsQyLyaqBKuRhd9TX4x/w5XmB
         qNRZJAH0VWH+Gz7ha0agE97H0Z4A1AxQ2JQNLE0DYtrOQWziAmMoxUlBvXpF+fu6h8
         wg3Flh+X5sjlC1GdNZXFfUdGhddTXMzvQ/iolm1McnIdrn/HgRy7DVYHk3R8MVGbHm
         QqM+etwfEE2M2cAEyV2qfwO/W4Tq6By4WAtf5V/w6WbS+ps3Xaq4tBZ38saaRcM/vX
         wjOaQMp1e2iKN3TMR8OAWbPpx4lRxbx98ccKOEJ4cgvxdeCTxk2L0dX6xUwPOvpmWo
         rs9rfEjuZWA7A==
Date:   Tue, 23 May 2023 17:55:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2MlvJV6gocLMBKO+"
Content-Disposition: inline
In-Reply-To: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2MlvJV6gocLMBKO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 04:46:04PM +0100, Srinivas Kandagatla wrote:
> regmap-sdw does not support multi register writes, so there is
> no point in setting this flag. This also leads to incorrect
> programming of WSA codecs with regmap_multi_reg_write() call.

> This invalid configuration should have been rejected by regmap-sdw.

Does the CODEC support mulitple writes?  If so it seems better to leave
the flag set and just do the appropriate fix in the regmap code until
such time as it's updated to be able to exercise it.

--2MlvJV6gocLMBKO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRs8AoACgkQJNaLcl1U
h9AWNQf+IPYCRW1gnzWLgW1rC4g+MrykjJLRYtWWmcSWeEZXIsXOZOOTd+SIspbF
xq5Zao7SjZqfhKbAzBKNw7KCRc65si32UyccKO+iIhrRUQ3kKn3cCuX4sOuiCWmk
H22WwBb93WnP51cQAMiTMtBa1x+i/W05l4f155sDsj5g/FrP8CqQK/TFxTrGYGLd
nysG9PKq74NEmvYUeOMkGxprnyGeRbfeT7PWTtQJMCfkkNc7DK3mvCWiCrmX2X7k
xDPMDocsnGHBs8b0/sw/+e7w40F77Jxn/vlZQs7jiURWnyocxMGcW9qOMhv/aZhb
GbCKKHEDuCLpeEFOQlarMbKJXRsSiw==
=qDCW
-----END PGP SIGNATURE-----

--2MlvJV6gocLMBKO+--
