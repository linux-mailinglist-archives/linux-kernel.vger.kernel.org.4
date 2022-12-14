Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9956A64CBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiLNN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiLNN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:56:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9A1EEDA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7738DB818BB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA53C433D2;
        Wed, 14 Dec 2022 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671026197;
        bh=LzhN4TtSvv+yIi8w0Twtj6V6GvnC+pvyAq9VUqFWruE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGjewCpgFFFe0NdjJ+OSY4+MZ3d+arj1EoHeoXEu3fG+EUVYvfBvTVojkOstI3oXc
         ygeMvNT2JH8IucUeuI+1b6D26AE/wqt5H5167BBt9FSFdR5dKL0XUV4uW/r0seaD+f
         O6Kn7jIKsP1/viUjlyFmocbAlSLa4vCt1P0rku+O2KVITIG3KRsphv4OwpXvJc+Jx/
         BskfwmOIs47ye+PXJbQnx9b2k939zVawzx7H/jTkzx5McTn+nkW4Epe4LjgzDFswq4
         NbYfGCienskl/Gf5bAIDWzxGHYkOt5HYC1yY5t29rhiy1OL7yDRtxHwFSqoqPtPEmM
         ba/iN5enWqolA==
Date:   Wed, 14 Dec 2022 13:56:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <Y5nWEPTDenOIrXFY@sirena.org.uk>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221214123743.3713843-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jG61M0kgxKMPOPeT"
Content-Disposition: inline
In-Reply-To: <20221214123743.3713843-3-lukma@denx.de>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jG61M0kgxKMPOPeT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2022 at 01:37:41PM +0100, Lukasz Majewski wrote:

> Without this change, the wm8940 driver is not working when
> set_sysclk callback (wm8940_set_dai_sysclk) is called with
> frequency not listed in the switch clause.

Your commit log doesn't actually describe what this change is...

> This change adjusts this driver to allow non-standard frequency
> set (just after the boot) being adjusted afterwards by the sound
> system core code.

This doesn't appear to correspond to the commit.  The change will result
in the driver automatically configuring it's PLL.

> Code in this commit is based on previous change done for wm8974
> (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> @@ -496,7 +505,6 @@ static int wm8940_set_bias_level(struct snd_soc_component *component,
>  				return ret;
>  			}
>  		}
> -
>  		/* ensure bufioen and biasen */
>  		pwr_reg |= (1 << 2) | (1 << 3);
>  		/* set vmid to 300k for standby */

Unrelated (and questionable) whitespace change.

--jG61M0kgxKMPOPeT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOZ1g8ACgkQJNaLcl1U
h9Ce1Af+IKHbY/SQFRzzAd6DFcX9yl+IMOoST7fw2IeXWj/eRDoQY3nhY/8favk/
wC7QDqpbI+HhLtCC8AwTAPfQLwRetyDF4DT4Ns8E/uzt7jfJJYaawrTIxgwJRWtI
sL5cBTCAzXKB/Xn4SvmdUY3rnf5BzVd+snzaU5s6L5QKoBYQQacDZMtbkS8mFiVM
aZuIPbkgTyVzIQJTnD8Hl2cQylU+EOMxKeoj48qEqu2z++nT01FUK1dPSWR4eZg9
X9OH7T7VGiweLhhV6YcrzFu4pEq9viG5Bukelx8/8vXI/OCbJWkrcRzvRPt87Dkg
9xaEv6DPaTM5JInzPTMoQaWrMb4qHw==
=YvQ2
-----END PGP SIGNATURE-----

--jG61M0kgxKMPOPeT--
