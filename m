Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC0626998
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiKLNfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 08:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 08:35:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770ABBAA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 05:35:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE7B60B25
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA8C433C1;
        Sat, 12 Nov 2022 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668260112;
        bh=hVeujgpbsR+OV5+KCHpDO/ek0DALY7aOLmsd6J8rfNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qh3OumoFGbOnAzu35kkwGg5ppRqSBWdZzlwJ3s+z6MB7BsUoV8yCg8PhnkgM59sqy
         X54DczvP2IAfvmpSnc92o6a+fmA8/Apntn6TbYeDoV8AKt/J/ysM6/wyfyZ773LVNt
         EA++t0H/RPrttGx/YqdXn/tPlgC915EQckWBBjZk28SDupaCt19pe6pU4NSsqqsakT
         6hKKJSvLttMxkIxoKKf7ZSLauOUs95MbrugpyQ0Oyquf9wbxBUMG9tTSX8HXr1QAYX
         4j0uyqTb1xP4NcBdcFfO5ful0CM/QUuBp8qoh4FfGuxQ8JB2w9Hw8KnfvvDbK9sq9i
         TouOJvS704/bA==
Date:   Sat, 12 Nov 2022 13:35:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     syzbot <syzbot+9abda841d636d86c41da@syzkaller.appspotmail.com>
Cc:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        clemens@ladisch.de, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peda@axentia.se,
        perex@perex.cz, rafael@kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
Subject: Re: [syzbot] WARNING in snd_usbmidi_output_open
Message-ID: <Y2+hCnVYWHuROAEF@sirena.org.uk>
References: <000000000000734a7305ed3608ba@google.com>
 <00000000000073937205ed45fe5c@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/RS2WdliLAVa+DOF"
Content-Disposition: inline
In-Reply-To: <00000000000073937205ed45fe5c@google.com>
X-Cookie: Sleep is for the weak and sickly.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/RS2WdliLAVa+DOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 12, 2022 at 05:29:21AM -0800, syzbot wrote:
> syzbot has bisected this issue to:
>=20
> commit 4f8ed19593872b710f27bbc3b7a9ce03310efc57
> Author: Mark Brown <broonie@kernel.org>
> Date:   Thu Jun 2 13:10:58 2022 +0000
>=20
>     ASoC: tfa9879: Use modern ASoC DAI format terminology

This bisection really doesn't seem credible for an issue in a different
driver...  The tfa9879 is neither a USB nor MIDI device, and the commit
in question is a stylistic update.

--/RS2WdliLAVa+DOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNvoQkACgkQJNaLcl1U
h9BMbQf/Tqra5Lp05g+IVNIpqu8jemjvb4459Sw7r0DMv8JsgIgIMOcucoXt0VT0
pZ9x8JXtgM9t61pG+2I6a3OGDrHHHnZxpuEUTkAuGb0yZlh8s71658kiDAvAgQpm
iCl5MEYpl0aoia5oy+VoEJQ3//Y7/8xMM0IKst61OKmod/XcjVOB1qmGexW3ZDBq
e5iy7Hf7M9D6ZzaPmJHOqwUvXEmozUW06G+1wLcqzAQnAxT6Q/HDqMW8HR624KhK
VuPS2iF8JYCvHPiy9kDYuZyKMb1a71VfRYkgR3sn0Zc2KKbQ7WrfEe9yRFjgo0j+
E0FuF257SOTFiyVcKnqSFlxn7WTcuQ==
=7btB
-----END PGP SIGNATURE-----

--/RS2WdliLAVa+DOF--
