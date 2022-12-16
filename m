Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAC64F30B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiLPVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiLPVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:15:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABF60E8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:15:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B713A6221A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 21:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054ACC433EF;
        Fri, 16 Dec 2022 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671225342;
        bh=sqo9ANetZGAjYyD1DthIIqDxvqdlnjYOUUDoHsgBDRU=;
        h=Date:From:To:Cc:Subject:From;
        b=qdlhETm6oj6CaRw/m4h7oj50L/KMQNeym/qZqi+gpRCz+zdop8bFHb2RLKH493zb8
         hASHsZGH9vd9A3KNE1IQyckLmVtCZqT5Sda0qkZJCcViEiMhNXkKZI5hYLScCt2T+e
         v/z9l3e1Yh1Hov8wbENjS33vU7CzB6krITZ6VvvobOBecw7AyULsJhbo7OTLD6KMed
         tF5aDPmCfodwiJPO+THKpmu5ClaKgTukjZjmkOjnHIC/heckFW3EB8tVvaCsrn0dln
         2oP+ThNu6/JD/aM7zm/a9c9Hi/dumUWOM94w5h85w7XgRqQxBuOgxailF+MUPMQXZI
         JFGpq1Q+ltYXA==
Received: by mercury (Postfix, from userid 1000)
        id 9319D1060F45; Fri, 16 Dec 2022 22:15:39 +0100 (CET)
Date:   Fri, 16 Dec 2022 22:15:39 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.2
Message-ID: <20221216211539.dxnigc2ouatnb4pf@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uf4ra6m7rgir4jgv"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uf4ra6m7rgir4jgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.2

for you to fetch changes up to 3ffa9f713c39a213a08d9ff13ab983a8aa5d8b5d:

  HSI: omap_ssi_core: Fix error handling in ssi_init() (2022-11-25 01:04:21 +0100)

----------------------------------------------------------------
HSI changes for the 6.2 series

 * misc. small fixes

----------------------------------------------------------------
Christophe JAILLET (1):
      headers: Remove some left-over license text in include/uapi/linux/hsi/

Nathan Chancellor (1):
      HSI: ssi_protocol: Fix return type of ssip_pn_xmit()

Yang Yingliang (2):
      HSI: omap_ssi_core: fix unbalanced pm_runtime_disable()
      HSI: omap_ssi_core: fix possible memory leak in ssi_probe()

Yuan Can (1):
      HSI: omap_ssi_core: Fix error handling in ssi_init()

 drivers/hsi/clients/ssi_protocol.c      |  6 +++---
 drivers/hsi/controllers/omap_ssi_core.c | 14 +++++++++++---
 include/uapi/linux/hsi/cs-protocol.h    | 14 --------------
 include/uapi/linux/hsi/hsi_char.h       | 14 --------------
 4 files changed, 14 insertions(+), 34 deletions(-)

--uf4ra6m7rgir4jgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOc3/sACgkQ2O7X88g7
+pqd4g//XXmFvXBH8CADUMgFlCTNSDC7MGGnNl+yYaXJrlHvxjk39vzBqrqv+1Q4
cbC5YEwYaH/G555vZGMMpFmfdFhmID4oF5IxJF+RTmrl/1HSb7vYdvKhEBei5xZo
Or2M55GNv9AvVKkcqjS8rY2UJNfJ7jd2rSP2yoSxGTbxdHF11t5PcmfL6FlB5efP
+7xuoGYzTCk0ciI6XHJImJIeEeQC5pBlljoVxWerocSyc9A1wZ5zRUFdu3HgFhpq
EsU6NcxW1Cep1YnNTcK9QYBlKdbmULwlhPckEElDSTiqGdORlTjajdjsIos6r//F
VLITpgcnjiMQUqEsTKQiflVG65y87U3jfCuuSJAO7Q3qcP2MNGIN+nTv6Dsadcd1
xI6yLZqizWxqUlNgolQqUhfPHVhz8NeGATeavRBNvuGdTz19sKE/ktpWeDkRTqy6
aMrel9dnay5Hn+KAl+DcvcXm2cboT63fVB0fcN69cZKNe9FiF66d9XjK67pxufC3
GWjicqYwkDVdVkcaK3E6W1eVtN0PhZvXwA8UFnhYrqsXnLF3LpLEORv7DDVV/6zb
IKdh4MUevhMVJXn0MjeV7u1F0kqb5h7P6UsvYFrzEyz7KS12j0AFGLwzzauttewe
m2cf0QFLWFp7dqUwiQp1tt1EAZIBA024FeK6dPdYxntCPpzFDxs=
=5yTx
-----END PGP SIGNATURE-----

--uf4ra6m7rgir4jgv--
