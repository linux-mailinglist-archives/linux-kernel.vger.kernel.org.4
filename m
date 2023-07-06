Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31727749B97
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjGFMS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696AE70
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822C661921
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9556FC433C8;
        Thu,  6 Jul 2023 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688645934;
        bh=ozExOu5XO3lfJATKOxCayWXQFV4jBV+bqUwjfldZCR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJX6jVtMI7epnjU7mVdYEesEmctou3qq7gFSxsYGdDaW5xvvWHg5vLRugFljQAAoj
         fwyfoUTZZZfS5+P8/4YrXyMcNkaVhrVFIKTtGxRKYInF3pgGJqzpy5CqizwkYMSiSY
         6HE5nOmLDCmIw1es79aLMSIFHKKxUSdezM62m0OlLTTGQ+vmmpL0CHitXZQD5m2BVS
         88WieJqJuvdFCYwGxoCOm3nbBg/x2645WGG/OrsS+//GaTLYGXX592AM+Scg7/CD4r
         yZTTP+ubVvBLYKklaIBzBgluEkbRm5jGV8Xkry33QeDpz7TNGu5qVtGSXmacEaytAi
         gLtGihTlJVz+A==
Date:   Thu, 6 Jul 2023 13:18:49 +0100
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
Message-ID: <f4bde99b-ac53-4ec6-98ea-e56a4c125a89@sirena.org.uk>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
 <bd265a83-ca5e-4196-936e-0f753ea47a25@sirena.org.uk>
 <CAMuHMdUc-6ga7G5xuXXcKXU0ya3XBBM-tEJ3tZ-BY-oa+wozsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ecJqEW6WQ4xj01qT"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUc-6ga7G5xuXXcKXU0ya3XBBM-tEJ3tZ-BY-oa+wozsQ@mail.gmail.com>
X-Cookie: Don't read everything you believe.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ecJqEW6WQ4xj01qT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 02:15:57PM +0200, Geert Uytterhoeven wrote:

> Well, unless you have CONFIG_REGMAP=y due to some other reason, you
> won't reach the mentioned link error without applying [PATCH 2/3] first.

> It doesn't hurt to apply this patch independently, though.
> Do you want me to resend it (to your sound-persona) as a separate patch?

I've already split it out.

--ecJqEW6WQ4xj01qT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmsSgACgkQJNaLcl1U
h9DiZwf+LRghgiXe8yXcuq0vH3jgiskjra/u/Op609XR6YiFf7mt8xQZvNoZa8/W
H5ypiOqFY+3UMoHkk2liYMaTTXZ3BQFJa/PmhmW+TGW8oG99S4l84OS0ZKwpMDN3
HxBHROB1V1UCdnbKNR7cGxRmuTVKZH7P8beTr4YbH3qJD+sNRqb9fcCbiBOuGPvL
9sMHKYOXPhccChhBOjLlJSESzz0WO8TLxsAHE75pPceweqZD37VDnErV0YQQkyPq
mIcM/uUC5GMVTcqidYv+o6JdwYqK1rvcLrmjjS3LVc5swE1yvX6aOBizPjYId0zu
E30bTGDZ8CBhjKgjPjuriDgAe0Kvqw==
=ZBDx
-----END PGP SIGNATURE-----

--ecJqEW6WQ4xj01qT--
