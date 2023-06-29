Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5183974246C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjF2Kyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjF2Kx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E251FE3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E5C61526
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE11C433C0;
        Thu, 29 Jun 2023 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688036035;
        bh=poSaV7vPCmMGIchCP8KtyYjj33uRe1tp4qJZ5FhuCR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZzqE/WBL7IXD6yWk1Df2Kr25ACGxHt0ko/HvPQBz2R8lxIpjag0evGKbB9BUmBTN
         g3wFcdmD4ofzoGD1XE+mBPL7zKZ+gBfPXTHuHhDRJ/Rx+7WcTqbAf2y9yQgkqZlqe+
         68iKkOJnRV9BayWqHhJri4gmybW/7ikFdQB1lkoOKG1/usNaJXbZLIOz2mFq8fJUfK
         YmVeLxRa/ocv/G5TY+BdhWbHkoKc3e1Vd8svZMFlgh0yqUKFtk9MeOIl+GsIttRDzB
         VkhZpffGMBhvfKThkEwexM1JKiV0KzOr8JgWcwT8QUctGhMjLt6adB3v6V2VBFQCjV
         4wAYbNqcK5phw==
Date:   Thu, 29 Jun 2023 11:53:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Reichl <hias@horus.com>,
        Dom Cobley <popcornmix@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: hdmi-codec: fix channel info for compressed formats
Message-ID: <65adc6e1-c74b-4cba-93de-172a7129228f@sirena.org.uk>
References: <20230624165232.5751-1-hias@horus.com>
 <168803481324.25247.5593448279992144349.b4-ty@kernel.org>
 <87zg4ifsz4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BgVLAPeZ8a3Gk2s9"
Content-Disposition: inline
In-Reply-To: <87zg4ifsz4.wl-tiwai@suse.de>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BgVLAPeZ8a3Gk2s9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 12:44:31PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Applied to

> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

> Oh, I already applied this one together with another fix for HDMI,
> and it's in the ongoing PR to Linus.  I didn't notice that it was
> ASoC-only.  Sorry for confusion!

No worries, two copies won't hurt anything.  I think it was already
running through my CI by the time you applied it and didn't seem worth
it to restart everything.

--BgVLAPeZ8a3Gk2s9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdYr0ACgkQJNaLcl1U
h9CWVwf/XPtSjRfNi9gR3KLwYxvVVSCu4gSX4zsGhbswXhSD/HAWjnguykaz/98g
GwpZyNrod1racSgOeF+EKmy8jxk4POfu/lfuvNqxNL95AUCWgQFh2LIj+9iUcOlU
oIOIOhdTaTJTE8QEb4B9RnkdtrxewdpA493RYmvAY32EMs4EKYF18vm1XM8eF+by
diNPK8xlPg8Nf1L9ubJeQOKnJ/qbrDl0ZJYFQqsDGJPJEiTaAv+U95EffhBHtjzc
7vetrNIf2e1IBoSmP+ymzd/E22fGL7MML6bAf8yaYhNicxvI32or7OvhUlV2zaBy
ehR++q3VfFNJDy/EpbsRK0rUfzX7Yg==
=mgUV
-----END PGP SIGNATURE-----

--BgVLAPeZ8a3Gk2s9--
