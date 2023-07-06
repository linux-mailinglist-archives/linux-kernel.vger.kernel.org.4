Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2656A7493CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjGFCgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGFCf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:35:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1371B6;
        Wed,  5 Jul 2023 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688610956;
        bh=jlF4B7+FnfF8+N4B+1CI4LvksP0Cf44kNj7LTu98+os=;
        h=Date:From:To:Cc:Subject:From;
        b=iVK4IFpdDqh8Y9PMu/90fwSAp3MOOcyl2NU4ywFsLZIXU+2O/CsvPQGCVNkG2fAQS
         UyIXYypfWOKs05uxov9hqS/qqZ6/IB+qlc56Xfp+Pg1h+6dLxZFOk6biLYL6EfoRAE
         G3YGnh5Y67q+WjfNWKxY7llTEw4j8b6ebEnO4C6T7hmTuQgktiCYvumB/MusqOYc2B
         z0X54WF9EQ/RsR8SunIMo89sX2ov+Ud4xX39mSC4EMyiO3fTwYePL7gjS4u/skbkHK
         Ddh/UoI7PDks9eLCLsP9IHFLhBbBYXLk+YyY2Yu8O64dwyYjgFAOTX3dTea4je3x8V
         k0lGgW5bCJxXQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxLHc1sRkz4wZv;
        Thu,  6 Jul 2023 12:35:55 +1000 (AEST)
Date:   Thu, 6 Jul 2023 12:35:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20230706123554.166ce633@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yt1P=wRK=s6TCX4jp8tXxd6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yt1P=wRK=s6TCX4jp8tXxd6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0d4cc72dd9db ("Bluetooth: hci_bcm: do not mark valid bd_addr as invalid")
  1155a833ed0d ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable")
  14dc3f27c944 ("Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations=
")
  15d74ca10a2e ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_c=
b")
  289bfc8d7dfd ("Bluetooth: L2CAP: Fix use-after-free")
  3945d329465e ("Bluetooth: ISO: Rework sync_interval to be sync_factor")
  41696c5c9627 ("Bluetooth: hci_event: fix Set CIG Parameters error status =
handling")
  49c5fe08def9 ("Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus All=
y")
  5a06716bc727 ("Bluetooth: fix use-bdaddr-property quirk")
  7a26cd876524 ("Bluetooth: hci_sysfs: make bt_class a static const structu=
re")
  8900ccc56ad3 ("Bluetooth: btusb: Add device 6655:8771 to device tables")
  b3d9018d9254 ("Bluetooth: fix invalid-bdaddr quirk for non-persistent set=
up")
  dbc333d3abdf ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
  eee96e90b646 ("Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + me=
mcpy")

--=20
Cheers,
Stephen Rothwell

--Sig_/Yt1P=wRK=s6TCX4jp8tXxd6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSmKIoACgkQAVBC80lX
0GxwGwf7BjG6UNk27tNxK2eVv0Y/ghuhUSCU5z5pU5R3o14hRCLcExXLVl27dy9I
6fIh80HgfKL5LzhbxdS/08bkov0fxSKEvK60EZWp51gA78ciH4dX9tmpeF2XFU5Y
YUvpWSLVWnhkRFfaq8dJbWTORkfcAjnbTMKT0EQxlVbEVG8+GZvD4Elja20xoZsH
AJXDXLGizDiguE44CN5eRZVwpv0ODTQYYqVuU2r91mUlZMTd/de4+7/QI6tKEAv+
SDaZvSKhdmS5+biInZpE3GpABpJdhEV6BVh8upaDlz6XWo486GEEUSf2idRCP+Ch
5Fq/DVEW06BBQoWhc/0y9OihrIyNrA==
=0VcT
-----END PGP SIGNATURE-----

--Sig_/Yt1P=wRK=s6TCX4jp8tXxd6--
