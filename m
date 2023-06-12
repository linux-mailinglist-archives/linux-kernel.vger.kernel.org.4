Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF38172D4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjFLX3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFLX3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:29:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95607E6B;
        Mon, 12 Jun 2023 16:29:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qg7FN5SSGz4wj7;
        Tue, 13 Jun 2023 09:29:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686612584;
        bh=ss7qmMnE2j7uT1X0TX0WxReRFJXG+6rhykoMBP1uCkY=;
        h=Date:From:To:Cc:Subject:From;
        b=RD6NyqpsZyaY0wQtPWMLVqKyRNQPSzOU8zKp9mLOD7NHrSZQIf+rkQ+5NhjRb/v1O
         N2bCaYcVfdshTB2BxPGmhbYBzfWxPpe5jzc6LNHk6Kz0sWFnWftoQ9aJITRPH7Z3fz
         oMs0HeWeQoDQatmouyQkPyIP/X+KKABjZ+B71AYzl5gR2KU8I1+4VUSInlwfnfWYnb
         kPsgBxXRjvE7b5W9DrUCYP2W7Z/1/6oFBo6kJaTAsXGPFutABl/T2u0ILn6GAkUvwZ
         DeQ5IjBklSp0o07isLOQW8p/7ZthauWjiS2urZQFkvgZAb4nzI7RqGK/DLd9qHLlbN
         0GEu5jkc9RAkA==
Date:   Tue, 13 Jun 2023 09:29:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20230613092943.69ce7d71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y2bH8FsqpgR1YnFXnKAvgvc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y2bH8FsqpgR1YnFXnKAvgvc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6ebd1a1d1f9d ("vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y2bH8FsqpgR1YnFXnKAvgvc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSHqmgACgkQAVBC80lX
0Gw6KQgAgbadEdCRHXK9IFQWMoF8p3EpEHJx7cu5BRc4v2hKeiKOaUeWAnZ1KFAn
nrV4RPa/MDiR4D4mCr1+CbZXUlpOGboVHCdsP/34PrkbK9NcY0Bkg57pCk1ZjLQO
PkjwlgzLugpN7/U4ikB//y7d04PmgTJ3y02jKHioPgkziQPJi3VfkqHOn7bMDE8k
TTebSLvGAINEmONutzK97nb5YCiMbeZdIp2oKpGK5K0Wa3OcVM2iOpOMdukk1tI/
GlUoETS8xLKdesCHt9Merqx3tIrtnM7I7oK5lA0mti6YnMzujINTMeuLez0gMVbp
YjBYd9++wwfeUg2B6LV12y0O7BtGjw==
=Ssgo
-----END PGP SIGNATURE-----

--Sig_/Y2bH8FsqpgR1YnFXnKAvgvc--
