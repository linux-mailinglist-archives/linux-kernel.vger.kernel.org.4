Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24346A87C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCBRT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCBRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:19:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A6F1A663
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF6F615C7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AE3C433D2;
        Thu,  2 Mar 2023 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677777589;
        bh=gGcvY9KZIRZWsHC1ETRiPMVBuY9qg/Qwr7bbpu4pnUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmwPdXeG2YzcFW2FgQMdJ5rD3NL5mSe1V0TbXBTgJCc1lgBA2FkYRFXiO/JsRArsD
         +jSK/7ZD3vz5qRmEyNf7z4/xA/ofCNsezui9w6erTFxG0v4CMAedtsoc4pOZkdjflR
         zSuJB2HsxrVSB4eDLpncgW45fd8xSDEGBjPIuJ2hbOqhMnLLNfQO5KZ094oTU4q4tK
         j92GJdxkxmZZL994QCyjGjQ5wh/E3Fadte0W6U5T71j3Bkis11I+H+bJDbSkd05aD9
         401MQpsekKknaHL/JsYBNQs1/giW4SaeiuMlsvQMuPZWHmK7QDoB9xE0HolWJYGseE
         jFZ9YvX0zdzOw==
Date:   Thu, 2 Mar 2023 17:19:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: cs34l45: Hibernation support
Message-ID: <8aef2c0c-9bd0-4c3a-86e1-7732ddedabfd@sirena.org.uk>
References: <20230302171154.2342527-1-vkarpovi@opensource.cirrus.com>
 <20230302171154.2342527-5-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UdbDkV8ZAUZ45riw"
Content-Disposition: inline
In-Reply-To: <20230302171154.2342527-5-vkarpovi@opensource.cirrus.com>
X-Cookie: Who messed with my anti-paranoia shot?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UdbDkV8ZAUZ45riw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 11:11:54AM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
>=20
> Adds support for the amplifier hibernation controlled by
> DSP firmware.

What is amplifier hibernation?

--UdbDkV8ZAUZ45riw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQA2q8ACgkQJNaLcl1U
h9D84Af/VTDcd6XHZp4Z/T2jE5/F1zAjTlm+kuBPBh1p9xIWMLXGZiX7KIMqdOUi
M2YEGgKJJ8NCbt1FX5Z3GBHbzoibXrU77uXCDvQHCkqCWDjabYW2Kzx/E57vEfF8
lvnpDp7x/k2YdGpTQodVAmfZ9CQ4YXk43m0ViWwS5B/Xl0SyA3Zs3PN02pf+iRg8
RthuKfPQbUE7n93lICzy5bFuDIwqB1aZ96JCmekxMdKTzcyZ5r5KEOvu4S3bqtX7
LiwKbXsQwLUfxozL1AvRgsRFjdR+abwHzQS8kCHgV+WVXH+/UvXZX6xmctoY0zKG
yK6G9I+KfDQD7ozLQE9KLyXXyy2VoA==
=XpQh
-----END PGP SIGNATURE-----

--UdbDkV8ZAUZ45riw--
