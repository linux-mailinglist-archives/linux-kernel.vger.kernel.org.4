Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE57339FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjFPTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345543AbjFPTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:35:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D610D8;
        Fri, 16 Jun 2023 12:35:06 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BD8B11C0E70; Fri, 16 Jun 2023 21:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1686943283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+gFMPS9WwhZRw1F6SzcR7U1vGuPtvHeVgBGYeYYC6A=;
        b=oNRyRkePJgSlMzbW/yS+aAyMbho0lBjCJwyurekTctOfEfRAx15dy6j7FHqSjMevssX0Ql
        1ap5vluAvbu75Qt0nOUHXXQ4PxKRB9G5EVWP0tEG/UYYWcEYLOm0Q7XP/2VPEbSKMRe5wz
        9MBB1tmohhmvRfrxN5nChDwkUiszbWc=
Date:   Fri, 16 Jun 2023 21:21:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, v4bel@theori.io,
        linma@zju.edu.cn, linux-media@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 23/67] media: dvb_ca_en50221: fix a size
 write bug
Message-ID: <ZIy2MxIvrIABE1vX@duo.ucw.cz>
References: <20230525183144.1717540-1-sashal@kernel.org>
 <20230525183144.1717540-23-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hOGZ+jrDjYq/U51m"
Content-Disposition: inline
In-Reply-To: <20230525183144.1717540-23-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOGZ+jrDjYq/U51m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I believe you have typo in the comment:


> @@ -778,11 +778,13 @@ static int dvb_ca_en50221_read_data(struct dvb_ca_p=
rivate *ca, int slot,
>   * @buf: The data in this buffer is treated as a complete link-level pac=
ket to
>   *	 be written.
>   * @bytes_write: Size of ebuf.
> + * @size_write_flag: A flag on Command Register which says whether the l=
ink size
> + * information will be writen or not.

writen -> written.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--hOGZ+jrDjYq/U51m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy2MwAKCRAw5/Bqldv6
8n+aAJ94LmLIJ0u61qZEHYBeFOXVlNJvDgCeJY1rg6J/8A0srzUeUam9rJSfzcw=
=Zt1d
-----END PGP SIGNATURE-----

--hOGZ+jrDjYq/U51m--
