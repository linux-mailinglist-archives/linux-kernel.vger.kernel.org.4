Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4B746530
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGCV4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGCV4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:56:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066D187;
        Mon,  3 Jul 2023 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688421411;
        bh=Hr6zB8bC3uSpPj42M4ctBvJNksnABasf2wmWCoMV9MM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sdn+BpekDxoxHpLuxZXJEqZc3ho5YopKH6MPvUvMZsDa64R3PSceslpBUMcP1Hmn2
         NoKGL0zpmUx6z8CiBAOVMz5Rrw0Y3KLqQKgSe6Fb9B5usDdm22fvLyA4amyUJ2z9Og
         K1Elx1KSY2ybFM+AibZGdaScQKmFT5FifEEeAW1sNAYfRBxXvVOfTXMOCKIKFgoyZU
         va8TW8mrsJMVvR1sRtpkTUW2n0oCYxatSQM8+jt+hRRzqszh37AZxlR9o0xjpTad2e
         7GERpnTIQ2u0ymlsC9O0T4JTZYJg4+OfquNh/a+XD1pjPEPwDBOoR/4RWBwgDIb4rM
         gXgH5T7ZCBmLw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw0BW09qQz4wqX;
        Tue,  4 Jul 2023 07:56:50 +1000 (AEST)
Date:   Tue, 4 Jul 2023 07:56:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error when fetching the watchdog tree
Message-ID: <20230704075649.22ad644f@canb.auug.org.au>
In-Reply-To: <20230602091902.5d191348@canb.auug.org.au>
References: <20230602091902.5d191348@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oziYICJDdwQ5bZ7XLUWPdze";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oziYICJDdwQ5bZ7XLUWPdze
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 2 Jun 2023 09:19:02 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Fetching the watchdog tree
> (git://www.linux-watchdog.org/linux-watchdog-next.git#master) for the
> past few days produces this error:
>=20
> fatal: read error: Connection reset by peer

This happening again (or still?).

--=20
Cheers,
Stephen Rothwell

--Sig_/oziYICJDdwQ5bZ7XLUWPdze
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjRCEACgkQAVBC80lX
0GwPeAf+J3FKI390fykQRvqqEXGL4nJ3831K0xhioDpAq0c0y7A0HK2IQnSK823v
8dewguuMeXH/EQq1WRY1SlnYWB99jlx7tSfMSMbkwRfE6u1hR57IabI0ycgDAxso
ZLIbR+oVpDc9bD/MMw6CrqkrPdyYaG84vIch67hNSamyHNwjJ4qGShT9wWjl6JLx
suMa34Ibugestniol4tYH6BwiL1TVLArO3Q7SkxtMo3vWlHbmBtARNGHze59IEzb
lQkTz4hDzsv+La5XzGeZA7nGy4hr0siJ5wiscQrJP3M3fEecMCOU3FzSGmbjELMQ
y0eVqzRIi2BUlvQeU9uVWILOUOnoAA==
=1Lcf
-----END PGP SIGNATURE-----

--Sig_/oziYICJDdwQ5bZ7XLUWPdze--
