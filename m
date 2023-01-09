Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160D4662E16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjAISGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbjAISFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:05:51 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3933AB3A;
        Mon,  9 Jan 2023 10:05:16 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B562C1C09F6; Mon,  9 Jan 2023 19:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673287514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8ixXd9TVQBAyfiGIXH5jnMFIj3jfWX5FStOyjMg1t0=;
        b=kZz+X+m88xTC5wo4EsR6tsPToGsRRkHscnRve1geahx+WhEA/LfOTnjZ6RhN0fQb9jYNTg
        Hy4VkO+wwSInvTRO+q7sF3yBx6IDfb1hpV/UOVED92aRZVN+hV6X1LDGjWd9S2PgDYypc2
        gxSqiKZIaMdEuJfnfrMgxHPRlQXDRrA=
Date:   Mon, 9 Jan 2023 19:05:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     lee@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kabel@kernel.org
Subject: Re: [PATCH v13 1/2] docs: Add block device (blkdev) LED trigger
 documentation
Message-ID: <Y7xXWrR3jD3cUxWv@duo.ucw.cz>
References: <20221227225226.546489-1-arequipeno@gmail.com>
 <20221227225226.546489-2-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pTfp1MHXw0zAMTER"
Content-Disposition: inline
In-Reply-To: <20221227225226.546489-2-arequipeno@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pTfp1MHXw0zAMTER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is the crazy interface I'm complaining about:

>   * /sys/class/leds/<led>/link_dev_by_path
>   * /sys/class/leds/<led>/unlink_dev_by_path
>   * /sys/class/leds/<led>/unlink_dev_by_name
>   * /sys/class/leds/<led>/linked_devices

Echoing filenames into files (with symlink resolution) is quite
strange, is it? As is having two different unlink interfaces.

I believe we do have other places handling similar N:M configuration
problems, so this should be similar to some of them.

Obvious improvement would be having only "link_dev_by_name" and
"unlink_dev_by_name", but then, unlink should really be rm.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--pTfp1MHXw0zAMTER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7xXWgAKCRAw5/Bqldv6
8pVvAJ0flK8MI/FofLXmIrMV1cmW6/qFgQCeKQh+kE0AF57LI1iY2SJ4Wjh7IbM=
=oY/d
-----END PGP SIGNATURE-----

--pTfp1MHXw0zAMTER--
