Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A75F503E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJEHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:17:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146161714;
        Wed,  5 Oct 2022 00:17:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mj5W56QXRz4x1D;
        Wed,  5 Oct 2022 18:17:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664954258;
        bh=0ja0Pdb7di8zesD+XsNPwAag4Edj4/WtYKkmBFlNNtc=;
        h=Date:From:To:Cc:Subject:From;
        b=jrNyyldbI9us85oXNwaMkiZIn02EpZfmvhU6y2WTRq7iMyUj+xzUpdGW3OQTscQRb
         eVQUGjzoHYx4wUliT3xg8Fz+btCf6RUyC9FliUfGS4vIxDQRHkeV2Xay2nz8tLlbac
         /0Pta5UYuY8EeTBBxq1Ox/LM954xm8mW/9qC7CD7jjfOi+qPvGRBatybjieow7w6t8
         +FUF2CAwRe/Uu73zZ/8xnnItW22y47ftFdnt40p8DlCUSSsz3d7zjur2S+jvZJvVXM
         DtZ4LIvpP1b6ym/4RcZtLO2QaVECww8fBpVYhPwsQ/Bdjp1y8DiK0boseducxN+QZa
         bOnfCVgqMPdSA==
Date:   Wed, 5 Oct 2022 18:17:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20221005181734.08b2f1d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Hw.QCxmD1CBS43ov6D9jU3r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hw.QCxmD1CBS43ov6D9jU3r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/skbuff.h:1051: warning: Function parameter or member 'scm_io_=
uring' not described in 'sk_buff'

Introduced by commit

  0dd99edbfae7 ("io_uring/af_unix: defer registered files gc to io_uring re=
lease")

--=20
Cheers,
Stephen Rothwell

--Sig_/Hw.QCxmD1CBS43ov6D9jU3r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM9L44ACgkQAVBC80lX
0GypuQf/cSR3beUofv5pHVw8oXavjrdNuOR7Cw/+Tqh16jFNs2iWFIxGj/aZOZC7
gmZfnAGVh2sCIPuDLf9/vuPFhFYmEeBFdKvk8RH48TbZkYxiDyqzVXQ6uHNj1Pxe
rafhmrBOP766NlXemvimAEzE9f3WkrAEc432ETmDYA/DWktB/vqkwKbbvtJg3n2o
DaRukyHdHmWuEOur/15C6eMkilAz/kwmTJlGUVmcaMTm6KgATFME0BBGohYi51d8
zXvb/HgYNy4Jqat2T1/VYW4l6L87WmTMXfoYnQ/t6FEiogYzr01cwxn4UBiPl4QW
Wwa2oW8pBqn2AG3L6m/gNlYVE96WFg==
=MTvk
-----END PGP SIGNATURE-----

--Sig_/Hw.QCxmD1CBS43ov6D9jU3r--
