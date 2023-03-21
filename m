Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF66C319B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCUMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCUMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E91EFD0;
        Tue, 21 Mar 2023 05:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A05061B69;
        Tue, 21 Mar 2023 12:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473A1C433D2;
        Tue, 21 Mar 2023 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679401453;
        bh=tcd7yaaSbLBTzRt6IyfgIG6JothCMgLPcwm2QB3qXoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hi/8DH0D2NyG8n/LkRvM5diGPgA5A+q8i8agx2Audtsx9u9EjLXhWpPPGAapF25qG
         JDY5b+hLiOQHZNq0NoBO1Yy8cwC8TkJTZZcN62E6kGA/wObK5NQWjBp1Rcv4GGkey0
         OibxC8iWf+E6o9CEEwzVYX9LAN/GESmLtdSaBJhzhgVlH4EG6xY6CfW7Fe1Rr9eGL5
         Lsvt/078uUxOboFsUj52Cju5RbbbgafyRULmIYqL++Ri8YYsvowHkuMuH36DDPRyo7
         kuJMid/YnPnEXtORQNJ1HqMbzcBc+uFYH2ARvL0wTonEERK+9dWwOrZbSqG4PDddIL
         tUqBOkVU5LzpA==
Date:   Tue, 21 Mar 2023 12:24:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ASoC: cs35l45: Support for GPIO pins
 configuration.
Message-ID: <ad7e366a-6bbd-4968-a3ec-d2d7422c576a@sirena.org.uk>
References: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ax8ctbVVBfyuXjTU"
Content-Disposition: inline
In-Reply-To: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ax8ctbVVBfyuXjTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2023 at 10:47:18AM -0500, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>

> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>

Your From doesn't match your signoff which upsets tools if nothing else.

--ax8ctbVVBfyuXjTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQZoeUACgkQJNaLcl1U
h9CxCwf9Gm/7GxnadvWCNfTU+SVT7JYGyLF0H+7QshC3Z3aRRi+YnXcvTAaQhNs3
jN8jqtMYShWymLCL0Nu+qn5n7f+qWdzfzhw80TRU1FXWU6qZ1jyixTHuNDuHu8tA
gTkkMoVCAn6lwEXmgGXbPjosI5/7dM5v6HsJ8xFD7+2WNMUKIfJ+yjdFL3UIviMJ
TXf3yPqUKttSgxB6cCah2Ps8K5FyVL4B21QCgODQv013fFc569/vORL+gtEiNpCQ
gbBbVyZy8FBAT64qWFdF1tHIwCMTkUPggRQKt0xvudy1HmBsiV+0KWS+sCHFhy6k
QC/WbyDOYhePoiclsrgvGvtXO6IlGw==
=YcLG
-----END PGP SIGNATURE-----

--ax8ctbVVBfyuXjTU--
