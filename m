Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3225BC02E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIRVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:45:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1825E15A0B;
        Sun, 18 Sep 2022 14:45:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MW1ZT2Bvjz4xG5;
        Mon, 19 Sep 2022 07:45:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663537538;
        bh=INa/VRswvV4M2ivCXxN4oJ39VeA0e0SE45vPUfM7wEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QpcfC0bAN1kFZHeZl+JiCMdAALMUj0zNk0LH995TZxXSv6R/KMJkyfjx8LHtsAlr4
         APvpo8hhT5wR02tGz1KvjE4s0gImG1FPETFSzrsh1MSjQ3ir3iONMsfi0zKsXw3ct7
         /+phFnYe4iGAyvVa8DO9iYIarW6UDiFyz5ivQC7QDlFRx5WvYqKU2mzi/U+uxT1QAO
         ALXmb1q9iU78DmxYbIJurGb0ErnA0ycrh5qQXxe7Cy5NxesEVqlT9xEOjSvxPhm1sy
         m6pPEMgJFJgAUNp1AFx3JJqbjztFXc6yX6DYUEnT8uGYpahohAiMMSI65IZ+5O293O
         SxNSm+www5TLw==
Date:   Mon, 19 Sep 2022 07:45:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Robert Elliott <elliott@hpe.com>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: [PATCH -next 2/2] crypto: x86: kmsan: disable accelerated
 configs in KMSAN builds
Message-ID: <20220919074521.5c2b22c0@canb.auug.org.au>
In-Reply-To: <CAG_fn=UT24yoY=amdXF5gXQjM9jw8bMamjC-mqJndiXNtNhvLA@mail.gmail.com>
References: <20220909095811.2166073-1-glider@google.com>
        <20220909095811.2166073-2-glider@google.com>
        <CAG_fn=UT24yoY=amdXF5gXQjM9jw8bMamjC-mqJndiXNtNhvLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0xIHfXrGImSDJjA9O9sMX+M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0xIHfXrGImSDJjA9O9sMX+M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Fri, 16 Sep 2022 11:23:47 +0200 Alexander Potapenko <glider@google.com> =
wrote:
>
> Please use this patch to replace "crypto: x86: kmsan: disable
> accelerated configs in KMSAN builds" when merging linux-mm into
> linux-next (assuming arch/x86/crypto/Kconfig is still in -next).

OK, will do from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/0xIHfXrGImSDJjA9O9sMX+M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMnkXIACgkQAVBC80lX
0GxFHggApKBwwoi7fp/rXwJeUEHgOnEh9+zx7yZ57E36g8KXCG/eAxb6tJ3T+1HB
vw2/I+IxngE9Ze5FYpyWB5rsEjmxoECLTRg1Q9K/ftX7QTmrV7GVkga2m+32/GEy
czrBhbhfFz7/f8Fz/lvBXEzg0vaA+2/sN69PqgAKvosBeriJPzjPPp606oY5T7rh
dLjgzrxxoGGPZ0ovDs4EEzgu3DSJQlxKU8QNawcpLxUCZPI7H2cxPfIUfnww58xt
aIWYXaSghtUj4AEvB17JSJp4Hv/COTqeoqkoevVdGqS0i1CrfYUFpKFrEGngIQKN
EIStVCqn3KKryDPmmkips4cqiJfO/A==
=tBet
-----END PGP SIGNATURE-----

--Sig_/0xIHfXrGImSDJjA9O9sMX+M--
