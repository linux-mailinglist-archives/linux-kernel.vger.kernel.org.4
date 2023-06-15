Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AD730E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjFOFUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjFOFUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:20:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ABF26A9;
        Wed, 14 Jun 2023 22:20:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhVwc6DKbz4wj9;
        Thu, 15 Jun 2023 15:20:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686806401;
        bh=B37jTnf/uiM50T05evoq6qUnBgzMlrWR9U536VOwNNc=;
        h=Date:From:To:Cc:Subject:From;
        b=CfoM2MJQTi71XVACFagK3THVZhyaGsKwZ7o+lOvZrRcmH6ztAPgbQshe/4/k8EPHm
         vkcYRCp4putqJqSJvv2LZ3ZRFuha5OBYkqQ4EAWTw5v1kT4E4VwG7lEy1H4Mc3Ba/E
         hCETp+pYtVAOi2hh/bVL+LIsU/AMaANO0Xy2ybrO3nMdGhr5aOx+B99pluOuuZOBME
         +rEu/Oq6u+cwZT6Nq2QbC9qFMaP934GHZN//6eBKTaxXi3cDVUGRzpVngphuUES5rf
         p6pGDIFzHtHKfy7RUwq+rq7pt9zuPT5xA7guFDo+aLKNsWRmVjhD6EJEiiA01A1Cgq
         l6vV5ForDjfjA==
Date:   Thu, 15 Jun 2023 15:19:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Wolfram Sang <wsa@the-dreams.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Wolfram Sang <wsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the usb tree
Message-ID: <20230615151958.46746fe8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WWQg8DWGNK=a4z2H.7._fX3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WWQg8DWGNK=a4z2H.7._fX3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the i2c tree as a different commit
(but the same patch):

  7b7efc925042 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")

This is commit

  a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")

in the ic2 tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WWQg8DWGNK=a4z2H.7._fX3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSKn34ACgkQAVBC80lX
0Gx7bgf/TH2eXtVgtBHBx5sW6+wyr61eKrJqXPpeL/+4L3RKwmHJpf4UMglliXDB
RUIe4c3QMLN3MtMWPkUGxCoZ6gz/WYB4lV1VtPlkhO/HVkVCoE6By6PbW7dwXeHs
to6A/eXIHB2ybQlwpYsSm/BQtUTEql2zOdOkjeePuFJwaBp+a66zRZjv84jFmzGK
ljSSUyXTznlUBj3fiXkXnCCtYdM9QFrNp6VEVpk18lc5K9RUENQK++QPN4sj/1Ul
yjY8DygL4hELT8CFBoKjzh+ax+xg+a0f/TAajQb726jQkxKjxs7ysnyl5P5TDR+u
ayWr1HGKq3UF7LHPLdCkdEUah+Xq3w==
=bi5y
-----END PGP SIGNATURE-----

--Sig_/WWQg8DWGNK=a4z2H.7._fX3--
