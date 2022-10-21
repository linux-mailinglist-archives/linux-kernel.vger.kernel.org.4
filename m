Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7816077F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJUNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJUNMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:12:37 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17A426CDDB;
        Fri, 21 Oct 2022 06:12:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2978D1C09D6; Fri, 21 Oct 2022 15:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666357949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fY/ja3klDb2+M2zY6p6owNPJ2hEPPfqjIAvGs2Ei8vc=;
        b=FJ2cvq5B/u6dLalHE3UKAF/wbLpbXqH/0B8zk5HRc+nXFQwiqDpl5CPPd1G5vVzCShovDU
        703sMd84n64e1ePX2lSoObJ1MH6f3u7jk3EAPKD10KVMvOaWYDAszhNUGt9vmBQXh2AMGh
        F5MpLnqLoelGZPQ/tZL/O+SMouR9yKU=
Date:   Fri, 21 Oct 2022 15:12:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-leds@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: lp55xx: remove variable j
Message-ID: <20221021131228.GC16264@duo.ucw.cz>
References: <20221020210731.45864-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20221020210731.45864-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The variable j being incremented but it is never referenced,
> it is redundant and can be removed.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thank you, applied.
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1KavAAKCRAw5/Bqldv6
8rZ5AJ96BfWfC9Gp8yqE06yvEhlIvy0d0ACZAVk+hk8XCiFdDQrTPzVRKQngIr4=
=kj7N
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
