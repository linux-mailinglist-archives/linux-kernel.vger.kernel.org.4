Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51748749B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGFMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3362100
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A618B6171E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C49C433C7;
        Thu,  6 Jul 2023 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688645381;
        bh=xNVGuKAKGspfO0U3AqsxNnqpZ8lzvY8FFZk/ZAZuwzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G30kiem5FA0LlI4gL/FBgc6dht72xhbSl6QyMqsYEAvPuERBPYOKDdVA4hgsnfbgW
         lhFdORvVkPjlyew91k7g6kZqvXdWzfqoRFx7elOGwqGqVoGkzmZCH94NxMWrqERcw6
         mLJzkpazq1OmPmpSLFR/FDT8NsRosy+Ur9+VBjVwsb0DCxedCBt8/wfkkx9BtbbstW
         oT91uM7OE1WS72/+hqOk5t5YftJjo8/Yh1KEKxrvipVC0KZNhEtpU1e/FTyI8kJhYP
         5lZV6tcSeiaEDK4zAmjSLDb+Kell4/7JatdMAMRlrHELYMBd7g2kBkxn7CllBlgAvK
         F6XcK7QZwmOYg==
Date:   Thu, 6 Jul 2023 13:09:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: codecs: SND_SOC_WCD934X should select
 REGMAP_IRQ
Message-ID: <bd265a83-ca5e-4196-936e-0f753ea47a25@sirena.org.uk>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lzh0BKmrl/zHqQZM"
Content-Disposition: inline
In-Reply-To: <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lzh0BKmrl/zHqQZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 01:42:04PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
> CONFIG_MFD_WCD934X=n, CONFIG_REGMAP_IRQ=n:

There appears to be at best a marginal relationship between this and the
rest of the series, please don't group things needlessly like this, it
just creates spurious dependencies which complicates getting things
merged.

--Lzh0BKmrl/zHqQZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmrv4ACgkQJNaLcl1U
h9Do3gf/RdOeKYR2p5jpUgp2fzowEi29dDeXA7QxNNDwLM3AndW4VvXWuL/yUnQN
ANNBVINGMcytkLwWVKQ+QRLgUeowpA2Psh2hMWCWL6dOKF3LJwqd8WwrKBsMEtql
CYXXiNr8MPstrJJlrLRCgt33gjuC5p9SVirtQvay4uKRIwCfr1HLs5SmNcYBKy6L
2FbbJyybWgPK0RcVIqJozCb95gIJokDUa00tA0kq4nZ6vYrgbyV9zbDtLYg7D8P6
JX53lCywA3/jkuaXZ8r2D3StOUxNKM01L0HXS0lw5g1KPTgCbWu3/z3/ojqYGN88
9M5/sT3be61ZdYNXKiBPs07yaaI72A==
=BVyP
-----END PGP SIGNATURE-----

--Lzh0BKmrl/zHqQZM--
