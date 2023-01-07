Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33920661205
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjAGWaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 17:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAGWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 17:30:19 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C0AE40
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 14:30:18 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 512521C09F4; Sat,  7 Jan 2023 23:30:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673130616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=tHErW2iC04UdcJEn5upStW0sPx+GKCATI1Uf+EESA4g=;
        b=VrMMcDNPsxVvpecM+KZ9npyq+ABvQWX3G12d2txHxzRrnHUBUwo90Or27tlgKT6bQNwQbI
        MYjqfFoxAgwPdGm/y3QygG5PGVTAB7UNyCjeuFl/6sI7V15Ny769cWj7MVEbaxeGfLuT2V
        wdUAMT6UVUf3PutAzeAlm0H2pZQrvt0=
Date:   Sat, 7 Jan 2023 23:30:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        geert+renesas@glider.be, Andrew Morton <akpm@osdl.org>
Subject: Dhrystone -- userland version
Message-ID: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0D+FuVR/cZc+4bbO"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0D+FuVR/cZc+4bbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Distributions do not usually carry dhrystone, and I don't think anyone
really maintains it. It is useful tool, and it seems we'll maintain
it.

I'd like to add enough glue so that it would be runnable from
userspace, too? Userland version is what is actually useful to me, and
it should not be hard.

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0D+FuVR/cZc+4bbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7nydwAKCRAw5/Bqldv6
8vqsAKCZWPBGyzZkbwbdpUHNNjEuvEC6ggCeNmQhXye3koeHmErxF+QM5cC+twA=
=xubs
-----END PGP SIGNATURE-----

--0D+FuVR/cZc+4bbO--
