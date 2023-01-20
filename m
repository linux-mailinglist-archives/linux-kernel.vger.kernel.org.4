Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACBF674948
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjATCVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATCVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:21:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D896F9F3AA;
        Thu, 19 Jan 2023 18:21:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nyjsn3wtcz4xHV;
        Fri, 20 Jan 2023 13:21:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674181277;
        bh=VykjlNEISzH9ES6EM1HIYkl9QZ/VOb+Ao4NZyhFP3RU=;
        h=Date:From:To:Cc:Subject:From;
        b=VvFEEIzNZnBnzRku0jtd2i+oV7GL40GChNbG/CfSMHZj8yoveQeW6uiX4z9ltgNcV
         PtdWcHXtsXlYg3WyglQTx5fO+9VXYKbDhBflYc7B4OEADkBQpSn2l6Yrvv8OPKC1fO
         rns4ABWjf0ZhVvCF20u+yHtL2m1ED7pxvq6gTtEA2JMh48dcaOexOj8oYvMfTIiNQ0
         c2M7/WexWg0s2QHeF+9BeaUh8aj+Hl92CbEHu+zZYr2CfFBvd2KUjC0yzk3A6RFWrK
         k+IYeqo85FdVlweD5DSVET2Njw+NFrEJkOJsiAk/IquWrP+S4Ckojn/FVzH9sGKD04
         EwMS1pVM/TJYg==
Date:   Fri, 20 Jan 2023 13:21:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the accel tree
Message-ID: <20230120132116.21de1104@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IJXco6piQnmevsk4ONz=1yC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IJXco6piQnmevsk4ONz=1yC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the accel tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/accel/introduction.rst:72: WARNING: Inline emphasis start-str=
ing without end-string.

Introduced by commit

  f65c5dac2073 ("docs: accel: Fix debugfs path")

--=20
Cheers,
Stephen Rothwell

--Sig_/IJXco6piQnmevsk4ONz=1yC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJ+pwACgkQAVBC80lX
0GwBdAgAg8IOgZk3/ABJEEmChvKFKqqO8BtF494vtH6QccZo0X1NCvuqaU0bcjIs
FHkaHGaMqinmM9CEe27sAryiy4zLGsvvMUXEG8jFop8uFMc/TU2rMEr9yz3G2nUN
DLunzxnwnyPxaup0ZdM3gXfKy97xYHwuu2u2Mlaa7KSvPF0BbLOeHYzUzmhFIbaC
f/6NN2SeCa/m0mT6wWwfopwSURGr3uXAyQ6QYEPFZ5n8kANoJa7OVAVqmtITX84d
hHVooOtT7kl+T8NCRYMsiIS8w54rZ3w6aZGaAtTR++BKxEYfTS1D0RksoauS6gBq
zV+ldVyLTM6UU3lEKwEPbVcKx9ZBpA==
=U3cu
-----END PGP SIGNATURE-----

--Sig_/IJXco6piQnmevsk4ONz=1yC--
