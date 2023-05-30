Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8667171A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjE3XZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjE3XZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:25:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BCEC;
        Tue, 30 May 2023 16:24:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QW7ll6v4fz4x1R;
        Wed, 31 May 2023 09:24:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685489092;
        bh=G3t0B5Xt3E6x9AiR3KqrcH9MzzUZUTOm26CJDc2R/64=;
        h=Date:From:To:Cc:Subject:From;
        b=o83jLI6ct/f7+QnMImOw3dUAHGtNgsnL4mqA5UsqH7eDR3K87js+i9VPLHQ++fXXP
         dy2ltCAjhhZMKlSWxF0Zmz3FKxdlT1RNBGZViyXhmgSWuXQ3ktE3uaSFins0QSfHob
         ZfjqgUOylglZmzEiAxLT5DCja5pu9TmlLwju0NbWeOVzKy0u7HTuD1b1oBbvpVklwl
         9oWmp12xDaRtGkXHOj+CoC6n9KTK8d3j5ws/Imw2zZ0F2Zfke/6ulcurVSF0tbV3qG
         jLO+11jCAtfpwvy+3Q1PHJExeBDKMFL6d6SVNpNZIxM1SVZTiJeqwy0Hx36tFUioi4
         mAn/0oZQS6NVQ==
Date:   Wed, 31 May 2023 09:24:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: bad rebase of the tpmdd tree
Message-ID: <20230531092448.5fa4d718@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5F.2VQqhhKRc7O_thQ0K_tj";
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

--Sig_/5F.2VQqhhKRc7O_thQ0K_tj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The tpmdd tree has been rebased onto Linus' tree, but has included some
of the patches from Linus' tree as new commits :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/5F.2VQqhhKRc7O_thQ0K_tj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR2hcAACgkQAVBC80lX
0Gz+jAf9HTHqybtUAYNhVNpkEk8D6wDNWDpm72mtiXVgwgqvNSy/wwaDlV1GyhnR
HG7K6RsidKnRwFgL2/QUjR1uBb9yt2zHcrvWS7alhNn/SJUat1pt0p9P1RBVWuy7
6qjmNoVoQg2kQ0WFu+2IRUffcKr+aQ+GzCByIoKSXJDUnPaBhrNybbJmVT8oBlaf
PWZ3eSBzeuZ2DBciNNEdSOUPzZi3beX5Y/rsMmDOx7iKTqeNTeSsR/XHFBjv3pU4
sKVl4IKGgz2NZv1nPzZjr9/oA0fsSkpzP0o7tOe61MlNyP7GkHeqxecvWsrFGCMv
/Mg517Sll7UCO2gQCiYRmH93fTEzng==
=NlWh
-----END PGP SIGNATURE-----

--Sig_/5F.2VQqhhKRc7O_thQ0K_tj--
