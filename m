Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34057743190
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjF3AVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjF3AVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:21:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5DB2D62;
        Thu, 29 Jun 2023 17:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688084501;
        bh=vt6/RnuSiSReNKf6aSQIzd35ALzFzJ90RoWD7TGrads=;
        h=Date:From:To:Cc:Subject:From;
        b=BsrY9fG7XzuEgXk+vI+SJ1uwmL3NbN1AzafgjXxh5CdAjYbCQpdv/QS3GHGcNpUAa
         OpfdzpZUskyRu5x13mgbZYpxS8D4dmiYdkz/qW6tWxTaTrQhlFBvOlbAZbEDAGP6BB
         FOnwe1LyP537s0DPqZYccoYwa+RgVS5awllhfWZwXf7a+A7Drd82cUVRYa1cmqWPG2
         VJwxhxcXjGGPNbpTvwDXdQS4Eo2qkN6xSbBOPazv9S4OO7AgFVSHNqPDkM8rPPZS+t
         WRQnS6/dIxGW5XTe68ziEb4SUp8wBLMg85EgsZZnD7nn0xygKCKFbeyeI0WRk0RXic
         LZHn0FOAnRLlw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsbbT3phjz4wb2;
        Fri, 30 Jun 2023 10:21:41 +1000 (AEST)
Date:   Fri, 30 Jun 2023 10:21:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20230630102139.12a3ce8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OnCSlzEEdcFJwruZ+pV7ON0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OnCSlzEEdcFJwruZ+pV7ON0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in net tree as different commits (but
the same patches):

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

Some of these are causing unnecessary conflicts when I merge the
bluetooth tree.  Is there anything in the bluetooth tree (that is not in
the net-next or net trees) that is destined for the current merge window?
If not, then please just rename the master branch to something else and
recreate a new master branch to be somewhere in Linus' tree or the net-dev
tree until after the merge window closes.

I am also still reverting "Bluetooth: hci_sock: Forward credentials
to monitor".

--=20
Cheers,
Stephen Rothwell

--Sig_/OnCSlzEEdcFJwruZ+pV7ON0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSeIBMACgkQAVBC80lX
0GzCKQf/d9FIdSbBEeajh5E7cXDzvexU/NBwFh5JHmNv9jTYZTYOuZoryib3gWbj
ZY3PNAPm+MH1ihGaCtgT5MLMNl5s6WBhfajbiMY1mXIhHVYKS1Kk54ox0I47t+9e
QMwrI1ZQBUqFK6CBId5RnaTWcjvoAT+Rru7CVE6Aawp6xrqrhHYsNPSj1mndmrFq
2VI7G04IxTJ9bYVvBxMOok/eqT6hdPq0bdx3OHqH+V+xtY4M+Lz64pmRFSPLKKk4
oOI8dPLve92uonfnblFFlhKwXzIIjhFT3YEfgsLTSfOHNnEbu89GcChOO7eyPWS+
tJoPDIKB7Wpsm3YKLRKjK8VPyQvYTg==
=vHp8
-----END PGP SIGNATURE-----

--Sig_/OnCSlzEEdcFJwruZ+pV7ON0--
