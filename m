Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BAF6235A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKIVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKIVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:18:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A2B490;
        Wed,  9 Nov 2022 13:18:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6yWT1901z4xGT;
        Thu, 10 Nov 2022 08:18:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668028725;
        bh=LHWZAqDQ0eQve8sGcLWdUoMHhSNzVDjTtR3sbW3De2Y=;
        h=Date:From:To:Cc:Subject:From;
        b=prvglTDMAegkM02nBDZ1YeRAAqnF4tJzq546w4V3QHsdhwHwGPsmjYWNlPi3klVOH
         3gDPZav4UHV6CNSZZ1dQXR2KZVpRnpvXLE9lU3gGruxnw29uS0bneDdtBt+75C/3AY
         EjIyELWP8WNI8Tz/aIm25HdSerrRbz6ma/bSYMdfA+gOE7e77jR/T4NM7jOvoe2mnB
         ogJQ94zdnSJagR9HFpHuAALteh8vNUMz7DnKqwQAGsnxSn9r/h13fWJHNyNRI44ikW
         B4JVKIVx8N3/C53PCl/eXsUlTNwOZ692LzY9UcVzZrVOJg7jBiM0z8RlNl4pCD8xpC
         5A6F3En6YusLA==
Date:   Thu, 10 Nov 2022 04:39:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20221110043926.66f76057@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DVi7YdxXhup=riNYS8rky7F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DVi7YdxXhup=riNYS8rky7F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  14026a4ed275 ("Bluetooth: btusb: Fix CSR clones again by re-adding ERR_DA=
TA_REPORTING quirk")

Fixes tags

  Fixes: 63b1a7dd3 (Bluetooth: hci_sync: Remove HCI_QUIRK_BROKEN_ERR_DATA_R=
EPORTING)
  Fixes: e168f69008 (Bluetooth: btusb: Remove HCI_QUIRK_BROKEN_ERR_DATA_REP=
ORTING for fake CSR)
  Fixes: 766ae2422b (Bluetooth: hci_sync: Check LMP feature bit instead of =
quirk)

have this problem:

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/DVi7YdxXhup=riNYS8rky7F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNr5c4ACgkQAVBC80lX
0GyvOgf/Y11VNYwsvDqYl1eDP0t3lqAXCXHYY+n+lPopPiRXENi1sQIgomM5qiGM
RpOx65uk0hoLtveN96If4jzYXcVgPEfza+OeaGzFwz/PDcQ6S6gMgub45PU32tyT
QToiuwcjqgYF3+aUzgGR8TfYejN4V9hw1dKDBiAODttyCW3bcgnBxRcs2J4nV0I6
7AEYzb2gWY4hr0lQWad+o/H0SeuL9+qotRFEz3UIPa9kWluJFmtUtBTw6mo/1Q+S
87uJ1wlY9/ETY7V3I2MQJmOhph+mlHComhgEJ7kk69Rg+vywEoxofHYBHLYPlsGD
kST9k1eYNJSHjPJIMaJTFUPlBfCQrg==
=sm3h
-----END PGP SIGNATURE-----

--Sig_/DVi7YdxXhup=riNYS8rky7F--
