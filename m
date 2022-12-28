Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21AE658543
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiL1RZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiL1RZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:25:24 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042C1573F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 09:25:19 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 128so16059464vsz.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 09:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hardenedbsd.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEVM5AUDilZJYaQsZd9oVNR1x46s1U+Ak2sstBJ5jV8=;
        b=j8S08/QHYpGAcDHI/4qQdIScYpGuBRltLRMeaq4DGRSTXK38MdlCFAmttEa3pQ2AAR
         NtXln8auiAZjKs5RKITvwiuO1ZOSR0W++0JciEQIn8C56feM5e5AFKcDHtkheALQVVPp
         r7zMAp6ORF1QFUMJpVD7nasWQGh0kL0KtpkZ4C9/ZXMqHbz5BlpuW8H8UFd1MiDW8OKH
         kyiXRFlSRG5m8C3h/8RAgYplVIyX07AKNInN72kjvOFxhk6+rNlOtc5iUW4hXlqJbQBh
         JpCuRo1YLtBeJlbNRlsujRzhTF8G4fVxxPfdmWgN2GVySWxiR8no5Ah1jufjcdqUB1EA
         OrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEVM5AUDilZJYaQsZd9oVNR1x46s1U+Ak2sstBJ5jV8=;
        b=zNZmXzzjq+K8/jKuG/yDpOhOK7OHO571OtJp2yfmV7A5ki0oYF+/a0gblLP9GpLc43
         AirIiPGBZGGMo2DELL25gej9LsTb/qCnkXGVHnuJ8qg7KOaciuFMkbKspG8CFtliIpNz
         4OFy5RPjz1qPl6eKNaaEXTlx0qFotqHLMMZ8TKhlAqFIotTp8esNNe663ayK5pOdiQxo
         nWnLvSCFIa4Hq2faGzIGNJJmF64XwJNtGRw0vnAVj0wm6m0BQOUO1Q2dOiuDzmj+tftF
         hQqVccn2xcukN4h+jhMzaBuMWqgDaCbAT3Yoc056W+nm7owLW01ogPFdccFn0MeOdT2K
         wwIQ==
X-Gm-Message-State: AFqh2kpPkDiSPoU6KMV1z3NdnPvHx836OM4Dw+FdjF3yx0bwY38tQOkH
        cK+Eo7sIoXJ/LZ9Xc7nOTvkFhA==
X-Google-Smtp-Source: AMrXdXubLSWgdRat/lLGOFgWgMfxK3e5HrzYBf27Lx4PdebB/GXsDoRKstMhux3jJ8bNBBTapYhWlA==
X-Received: by 2002:a05:6102:508a:b0:3b1:3a70:ae18 with SMTP id bl10-20020a056102508a00b003b13a70ae18mr13788387vsb.17.1672248318317;
        Wed, 28 Dec 2022 09:25:18 -0800 (PST)
Received: from mutt-hbsd (pool-100-16-219-215.bltmmd.fios.verizon.net. [100.16.219.215])
        by smtp.gmail.com with ESMTPSA id q12-20020a05620a2a4c00b006fef61300fesm11801298qkp.16.2022.12.28.09.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:25:17 -0800 (PST)
Date:   Wed, 28 Dec 2022 12:25:17 -0500
From:   Shawn Webb <shawn.webb@hardenedbsd.org>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
X-Operating-System: FreeBSD mutt-hbsd 14.0-CURRENT-HBSD FreeBSD
 14.0-CURRENT-HBSD 
X-PGP-Key: https://git.hardenedbsd.org/hardenedbsd/pubkeys/-/blob/master/Shawn_Webb/03A4CBEBB82EA5A67D9F3853FF2E67A277F8E1FA.pub.asc
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="53fjlxfw5lfxitvk"
Content-Disposition: inline
In-Reply-To: <Y6xzIR9P+a6uaaEx@itl-email>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--53fjlxfw5lfxitvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 11:47:25AM -0500, Demi Marie Obenour wrote:
> On Wed, Dec 28, 2022 at 10:24:58AM -0500, Shawn Webb wrote:
> > On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/VE6B=
BM) wrote:
> > > Dominique Martinet writes:
> > >=20
> > > > But, really, I just don't see how this can practically be said to b=
e parsable...
> > >=20
> > > In its current form it never will be.  The solution is to place
> > > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > > to get the command+args part (assuming I counted all those fields
> > > correctly ...)
> > >=20
> > > Of course, this breaks backwards compatability.
> >=20
> > It would also break forwards compatibility in the case new fields
> > needed to be added.
> >=20
> > The only solution would be a libxo-style feature wherein a
> > machine-parseable format is exposed by virtue of a file extension.
> >=20
> > Examples:
> >=20
> > 1. /proc/pid/stats.json
> > 2. /proc/pid/stats.xml
> > 3. /proc/pid/stats.yaml_shouldnt_be_a_thing
>=20
> A binary format would be even better.  No risk of ambiguity.

I think the argument I'm trying to make is to be flexible in
implementation, allowing for future needs and wants--that is "future
proofing".

--=20
Shawn Webb
Cofounder / Security Engineer
HardenedBSD

https://git.hardenedbsd.org/hardenedbsd/pubkeys/-/raw/master/Shawn_Webb/03A=
4CBEBB82EA5A67D9F3853FF2E67A277F8E1FA.pub.asc

--53fjlxfw5lfxitvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEA6TL67gupaZ9nzhT/y5nonf44foFAmOse+YACgkQ/y5nonf4
4fqYGw//ei+Kr3PwFtaEm+2Q1h8l2hrnM14W8ORZQWkqtv75yAPUCq6mb4XmSDze
3Z9kMrY4xvdYTMUZa4S1VvXF+tDe7nIqjf4kq6qCOhfyeoozvUm13yXEARvpMsLO
joSrhua4pTi8fCs3ZGebfgM8mNEMl4ZgdZIIpjcRWhVe0XAs7FvwZJyknr6joe8G
HBXB6FzCzbR4AUpp8+MjpwZIoPKw5KVODDGBG2rOvDoCFZceL/d9djmBW0dsI1Y1
EM4dQkx2zUJWBF77sQni1pAK+JJ52Xlwh61PbgHJLzUpUvUl7ZWMZoVn996MEdfF
tD0/V6de9kF6xkyQ+tBI+hRHuAUAAkSuYFR9/1BdLkcgVzaaXbUdTUAJQ/6sD9nt
CRIIhN6sQcYUe2VZbbS+KU+DhFGl6M9P3WPfbMJeaDootxRbkshThvUiXcdlMHIg
q8ce1idlwBxYonLgYdhF2FtOi3kjy0bykabUM3lzHpieadyxfSwP01x8PiOPjRs3
+M48jCecix8LaW8yIzvY42ZhawwsO/7fqr4U373hM6BhkW6HnkzTr0Glkq6pQxVR
8tBkVfaY9+JEqNOb0qU+fO3MVcpbkUnAtbnnGOfEmEaT5aWcaI7m1IvJsN6L+wWP
HNBNpi9Gizl9BbzbIkFxepiN8WsxNK2aEjuSt6YfiUICuguqeeM=
=ZLcQ
-----END PGP SIGNATURE-----

--53fjlxfw5lfxitvk--
