Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD586A9760
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCCMld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:41:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5D6230E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:41:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B77C617D6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A550EC433EF;
        Fri,  3 Mar 2023 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677847288;
        bh=63DyE5JUF6QupKom375epNDwu5fGTFML7abJZ4OIYuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICzPEJL24BmiGVbAYkUJnqwVy3kpf6H4d8Ll5H/Zb7G9WZh0MNCMfOzWuqConTEsg
         8aW7N7KnMyE0DF5xPdIwLkXJKgJJL8GQzJGL+AsHWRgbu+DTtJC2CILM6QRfwqnzda
         6K5H/9hkZ/nswx0+4ocC17czW8EX99/ZEXc3/sRGSmqqHpoDRY53qAk3gBq+FJdu86
         yMiOnr8YL3TjyAVBl2LT735OAAOfoEBad/zdLXn8LZYz9vMKjML+lJ+elKXWceNuiG
         zC7aHhP7FeAVo5oFmJmaIbmqpft0K8apBds8oTrfwMNCkge4hCk9I0H0nimkKTMl6V
         /VijgMgJK07Tw==
Date:   Fri, 3 Mar 2023 12:41:23 +0000
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
Message-ID: <5c47fa1d-f97c-47d6-a4cc-e20032072ad9@sirena.org.uk>
References: <20230303121206.22177-1-quic_visr@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RAA2Ho7H6wvZ57Io"
Content-Disposition: inline
In-Reply-To: <20230303121206.22177-1-quic_visr@quicinc.com>
X-Cookie: You are fairminded, just and loving.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RAA2Ho7H6wvZ57Io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 03, 2023 at 05:42:06PM +0530, Ravulapati Vishnu Vardhan Rao wrote:
> From: visr <quic_visr@quicinc.com>

You're using a different name here compared to in your email and while
it's the same mail address it's hard to relate it to your name from the
sender.  "visr" sounds a bit like it might be a bot too.  Could you
please supply a more clear signoff?

> Actually There is no need to have decimator with 32 bytes.
> By limiting the variable with short type u8 issue is resolved.

Bits not bytes.

--RAA2Ho7H6wvZ57Io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQB6vIACgkQJNaLcl1U
h9DBIAf+O0GEiKa2+I7pScRjDCF/+T54nZH8sgtkemdIQQdR7TPRPkl5R5HISwSd
XqH4yuc0Rn2aNgLhS3Jcs1ulEjSMKHrbwn9i1xj2tShnxP8KnBoDduS4KbFP6obF
nJt7f+bOTHw2Q6iZAdxpr2jMO0RMQ5Ibf7FoR4+e3c/b9KRE+ls9GTuzi5e5Vi5C
QWPWdxkhlObXt0mHehHoBhZR/h1QJZgIDafGCJwsSRkyyQlVM9A4dakDoqGdi+dO
iRlE673TKCcnNsX9dY9Rsvi4+gGhq6WYOe/AL5FH4CeYNIfblQHwaYUduN5vxmtE
mM7FYJ17yaMFC0LLtixWUvp3obpw0A==
=2XE6
-----END PGP SIGNATURE-----

--RAA2Ho7H6wvZ57Io--
