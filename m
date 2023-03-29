Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E06CCF74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjC2BXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2BX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:23:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6249123;
        Tue, 28 Mar 2023 18:23:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmTMY3LP1z4x91;
        Wed, 29 Mar 2023 12:23:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680053001;
        bh=d4caQHIzts+YhSFj+t5PMn7ntcVmLcqixpuHIBaPki4=;
        h=Date:From:To:Cc:Subject:From;
        b=ejZrtqpOZCULKffJgH2Hr914bbtmnh1Ta4YbdIfrtszVLC/BsmKvM3VxQ4yIGToiM
         Jz+W/VjzWKEWVsCFl3RoNOWXbmgDGYZzftRu6NRbq3mf2zFJXn2tQxBvinec9zDEXQ
         CGK50OqZv825ICsDNpvNAg9urB2xdSW2qOu48Ac8cB8IQ3UmtHTo+XebPNqdz4O90K
         iwr7Xr1Xn1ciXf+K2cAPAQ58CIIwMH2/S6kK3o8FithlpWAMGz25Qx28nuMI+rDeFs
         FAqFidqGGaYMafysMxJ8i4DfDN+DLU69+ztxQzrFvA510KfaYbNBhD7ZA0ipdPkXcm
         g/ARIuopsBBOQ==
Date:   Wed, 29 Mar 2023 12:23:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kselftest tree
Message-ID: <20230329122319.76b73d11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LXsYJm3YKJImD3in5uepYj9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LXsYJm3YKJImD3in5uepYj9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  c83f320e55a4 ("selftests: cgroup: Add 'malloc' failures checks in test_me=
mcontrol")

This is commit

  afea51f8cf60 ("selftests: cgroup: add 'malloc' failures checks in test_me=
mcontrol")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/LXsYJm3YKJImD3in5uepYj9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQjkwcACgkQAVBC80lX
0GwXOwf/c1z2/efCBwn6nt53cDxztcz1tOfH8Gr+/Un5lyJj3QudcgDQ4W9IAfQ0
vlOwdChw7mLqkaoEATCvz6Xxdk3XDtM7NJUPUQ7n8em8h4IlddNY609tVuEESXB0
fJ5KV8rDKB0FbN2MDcRHvGpS3N8oNgUa58QGWyr7rYf6EieUqe01vgJ33lT7bmeq
Z3Ygk67wTa0yPA2CfwJlTElafiwhzym8s62aJiwjrJrkgnUUwvdnWM0J+TfeywW5
MARGV2MpIXd9meNg4a/SdvVsi1DB9m9Sc0l7OI6H0kQy3KWN76OKZuPcu5CIO+i5
blsIYGDzFlHnW7YGJ/iiptxYJ+UhYQ==
=0hRd
-----END PGP SIGNATURE-----

--Sig_/LXsYJm3YKJImD3in5uepYj9--
