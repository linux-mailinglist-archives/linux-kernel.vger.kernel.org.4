Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF56A3480
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBZWOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBZWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:14:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC25D51D;
        Sun, 26 Feb 2023 14:14:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PPybN6BNmz4x7s;
        Mon, 27 Feb 2023 09:14:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677449665;
        bh=Fy9JCJshPELDsqM1YTg5jr0bM4/vRUB5yCdzcze1YNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Whd6hq+mpy7yD+oa/TADp3t8QXLLjR6UXuqZc91yjgtU9NmJhtLfIrcbqzm91ur43
         hmszaPwMFEk3YfRlGWThU1qPwmqIs4BUSSx6BDewA/Uv5PEu0nspRB7BKNds5Af9Xo
         vQ9vGgAINDTkiFP+XW8EyuD912Rw2gXPcjKZhpJJXQPRKzSINfDSnKZtEkaPXP2jJ2
         pis3eruobQGVXB/852iJdTUT6X5MR85NbJJYeCPysZCY4/JAsuj6mNtQItWnhLVKVs
         /1R14KLS0/2CVRNi9zFc2LGkn6dpvMendPgot1C7Kx10ewjVn8xh+X6bLBhvhyOiwN
         FGOPs0MkQX1+Q==
Date:   Mon, 27 Feb 2023 09:14:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: nvme boot problems after merge of mm-stable tree into
 linux-next
Message-ID: <20230227091423.3797ba8e@canb.auug.org.au>
In-Reply-To: <02f796c7-c1d5-2f2b-3385-e72298f5f470@gmail.com>
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
        <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
        <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
        <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
        <20230214172040.60657882@canb.auug.org.au>
        <07c870d3-5d98-ca51-5de8-034abc631673@roeck-us.net>
        <02f796c7-c1d5-2f2b-3385-e72298f5f470@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XBeQ_.dmMB0+zTAdbWQVRVr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XBeQ_.dmMB0+zTAdbWQVRVr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 14 Feb 2023 14:29:29 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
>
> On 2/14/23 13:49, Guenter Roeck wrote:
> > In next-20230210, the crash happened after the merge of mm-stable.
> > In next-20230213, the crash happens after the merge of mm-everything.
> > That means both the merge of mm-stable and mm-nonmm-stable are now fine.
> > So I would suspect that something in the merge of mm-everything
> > interacts with the rest of -next.
> >  =20
>=20
> OK, thanks!

Did this get resolved?

--=20
Cheers,
Stephen Rothwell

--Sig_/XBeQ_.dmMB0+zTAdbWQVRVr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP72b8ACgkQAVBC80lX
0GyKcgf/aTUj/AKsGrzggZZIBX0TK3oVzIjoMeNieyx2+anpk4fFcU+zuaTyLDBH
zrXpBZ5AJp/3UNBTOo8tFmIaCCsUuCI45v3wSslQsVok/5Tk787nXR3iGc4yFjNJ
/ZIyCmFwxD+/6OjrcZaZ9k1Yqq//UuoT1Eiz6TwL+CzPRF8PHmKA2gh6OaZXT4bw
KTYn3JOBG1H9hY9Ni1J4N8C9ucIaZ+bQY1xykz3x3mwBIgWeRLImkz3gqRu0j0dI
wAO6A6BBhP6ZOl/AU3oP60NWTTb6p3JeiMautz9fEthNNf1O5OxpGNE7UdIntbW8
Mt+xkenpA0Cgnqgg7knkeiwvDJk+kg==
=GcEQ
-----END PGP SIGNATURE-----

--Sig_/XBeQ_.dmMB0+zTAdbWQVRVr--
