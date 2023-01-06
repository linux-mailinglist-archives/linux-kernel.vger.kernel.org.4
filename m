Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9465F862
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbjAFA5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjAFA5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:57:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0148B95AD;
        Thu,  5 Jan 2023 16:57:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np4fy0TRmz4xMy;
        Fri,  6 Jan 2023 11:56:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672966618;
        bh=C8Qxjj86/heBN8tJOhLinS6BtqkTtssdmzgAOXLQ/yI=;
        h=Date:From:To:Cc:Subject:From;
        b=iaHQrii07bnh0lkHCQ86o3FkI/JJrHzMHhXGuY2MoWI0h2UzICp/+m2Z9nvLH0tQ7
         Uy+REBA5Ey37t598L9cR/PvCr0nWu5hVV4ffhB0U6xaGb8FkBAHkPWvgEryaOqnzzp
         8JAJK2wjrzF7JC4Nc2MPBjT9KwsuTvfaLKQj1fMLoAods0DtLcm0R7PwreHaiI/ayJ
         M6FRekKnM2h5gWnxDf9O/tdJ7dYGqxGymxIIqN/JJnRMravVktHymiYcqvbSuM4wzK
         t6DkTMzJSk67LKt0D3b2nbyjPMoeR+vwTdMstmKD2/FjkygibszDey7pe+8bc3bURg
         hlFbWbXkO5ivw==
Date:   Fri, 6 Jan 2023 11:56:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Teigland <teigland@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the rcu tree
Message-ID: <20230106115656.2f2845bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bxxRbD0/.E+h8F5.hwRXD0_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bxxRbD0/.E+h8F5.hwRXD0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in other trees included in linux-next as
different commits (but the same patches):

  5ae8fe77d8fe ("block: Remove "select SRCU"")
  5707ec3b444f ("fs/dlm: Remove "select SRCU"")

The first is in the block tree and the second is in the dlm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/bxxRbD0/.E+h8F5.hwRXD0_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO3cdkACgkQAVBC80lX
0GzzsQf9Gd17G9FPwhMzI2IUC4E8Ej+FtgxQpj0W+G7noqwEnUDfYYb55UcDL/bs
peArw5P9gRNB1wRCrOgTgLMPzYvHgiBKV+GNBRYSr0w0IbDPuACUqVDkqiHkgXiU
hkvYlOyZle1+04l1kz1gXMGUI5jHBa/zlqLp1pIjJ2vy/bwMIOlrt2NyNlXNHJUI
Z1GvaVrGubR0OP0hN+TdPScutBMIsDfi9p/x0D8KhJ8qRHcWJbNSp/jhHpB9k9pI
ntQqGUnk7WRn4oqZ4BT3lmYdtZh6DBzRhcSfmbwhhHZATYa1qGTHeyOy4wjtazg+
w1FQ72Ub7dVMCo1+3rjseAHUhe2oGA==
=0A7R
-----END PGP SIGNATURE-----

--Sig_/bxxRbD0/.E+h8F5.hwRXD0_--
