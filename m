Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862F272FF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbjFNNBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbjFNNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:01:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53213E;
        Wed, 14 Jun 2023 06:01:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qh5Cg1581z4wgC;
        Wed, 14 Jun 2023 23:01:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686747696;
        bh=8/vsSK2j6rJJIuEb9Y1ZcU2L+LeOGAravlsY6bql24A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RUDKBtp4MGNDMoB7/NhY3y+U137U8yDYroaibQOC7R0hmWm6sggfM3+1/ns/lWDYw
         hVWfduZap1CwD+I5ArO24Co/sxxcJmZKuF5+V15kKb7aWH24iMvRDcudtjH6A4jR39
         xYI6fb6R6oWSSfWe5RgQeWNaIrJ2kAyNmG+Yiz6YloOqeUCJSkj3H7chxQ7ooJolcS
         iLQv4S6M4XQ9ZmzMq8XlONhRB/z884aDb2o1ImMxNlrmP4a3NH0vx1g+Wp3m8moPRY
         yNiF6clPtXceg095GxIUFqSjFIWs246ubFsmC5xIx8QkyE9J66A1yUYvG7ExTbg4hG
         vuYLEsSSMflAg==
Date:   Wed, 14 Jun 2023 23:01:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230614230133.1a238390@canb.auug.org.au>
In-Reply-To: <c473ffea-49c3-1c9c-b35c-cd3978369d0f@tessares.net>
References: <20230614111752.74207e28@canb.auug.org.au>
        <c473ffea-49c3-1c9c-b35c-cd3978369d0f@tessares.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pMwCcmNtf_L0mjZnCMzY/BF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pMwCcmNtf_L0mjZnCMzY/BF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Wed, 14 Jun 2023 10:51:16 +0200 Matthieu Baerts <matthieu.baerts@tessare=
s.net> wrote:
>
> Thank you for the conflicts resolution. If I'm not mistaken, it looks
> good except the last chunk where the new call to chk_rm_tx_nr() should
> go inside the 'if' statement. So instead of this bit you have on your sid=
e:

Thanks for checking this.  I will amend my resolution in linux-next
from tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/pMwCcmNtf_L0mjZnCMzY/BF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSJui0ACgkQAVBC80lX
0GwfEwf/VKXs/ioQ6540MKL131+ZC2deLg3R/5dA226gX/vmIRpmtksGhepbYKCC
3w+RAdFJC2nyWOhOV6vRrwkvygr057HuXkBobCRnxZsoJHubelRFv3nrjWiIHnNv
eUtQcQKo7DqV+T8u0WfuQzIXz3h8yTMd7JnV+FFZV6hasU7LYEbsexxAQ8o4mvWA
hrAV3OuehfTmW/ssrV44OfdDrtuheEIiYAbpcnI6K/5zZeWqLl5BJZgqkFp8AEwj
mivkMUk0P2uubA5cqZzyleuFShlFsK5IMd5mqAxTknsNVIcuTLxi+ck1oPgCkbhX
AA4VJtgqcOv5BftsPUm95gMAqF2m4A==
=gUNb
-----END PGP SIGNATURE-----

--Sig_/pMwCcmNtf_L0mjZnCMzY/BF--
