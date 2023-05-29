Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2A715127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjE2V7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjE2V7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:59:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25547C1;
        Mon, 29 May 2023 14:59:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVTvh5vzTz4x3k;
        Tue, 30 May 2023 07:59:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685397568;
        bh=u/rC09ODihTPtpnM7cGR/asxyCQgZiFQxd1bE49F7q0=;
        h=Date:From:To:Cc:Subject:From;
        b=q+Ix1G9rVQ4bA5PLtGZSsW04b35xvJ7QaQSpLl8/8wTO5G1SICWtI1n8bpBFC3ieC
         X453fDrRc9SB4W7/pGNuw30HplZ8HFUnFikhosCSUiZ6fQsRAopgIcPK8V6FnCvFBG
         ia9isb55hcvkWRda65lFnnQ+Jc84XyeZT5KrtyBhB6Pb+T5+GCECBUM/OF5/WnZU6f
         AwEtH7ZEDkmHAN0Tl71UObzd6QzWkfq2StF3QbgOnPjyEbyceu967zXOUbuzO68qSQ
         V1IAXgNywCwLrRDivg7PIuq0wbOFQTdUfnl7Xk7yh+204ttMSuDFqw6Xc83LbTmVXc
         zliUPg9s9JVdw==
Date:   Tue, 30 May 2023 07:59:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20230530075926.6477f0cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/prPfBAIWGEAV3=5tz3w.Gt.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/prPfBAIWGEAV3=5tz3w.Gt.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  78c8f6e2d7d7 ("Bluetooth: btnxpuart: Fix compiler warnings")
  e6e576ec4e72 ("Bluetooth: Unlink CISes when LE disconnects in hci_conn_de=
l")
  29f883dcbfd0 ("Bluetooth: Fix UAF in hci_conn_hash_flush again")
  38e9b45310de ("Bluetooth: Refcnt drop must be placed last in hci_conn_unl=
ink")
  3214238e9dc7 ("Bluetooth: Fix potential double free caused by hci_conn_un=
link")

These are commits

  6ce5169e05aa ("Bluetooth: btnxpuart: Fix compiler warnings")
  a2904d282553 ("Bluetooth: Unlink CISes when LE disconnects in hci_conn_de=
l")
  a2ac591cb4d8 ("Bluetooth: Fix UAF in hci_conn_hash_flush again")
  2910431ab0e5 ("Bluetooth: Refcnt drop must be placed last in hci_conn_unl=
ink")
  ca1fd42e7dbf ("Bluetooth: Fix potential double free caused by hci_conn_un=
link")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/prPfBAIWGEAV3=5tz3w.Gt.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1ID4ACgkQAVBC80lX
0Gzq2Qf8CJxfVtjjMnUzn2lEG9qMjkJjASh3qwcysdypvc29BBqoYofv2jjaRJ2u
htgWl21Y4pkSadUT+ELO9AAnaFedOkUScnZTrsNlPf6UVZ25auVOrdOnVf10UEa9
788h85o+A8qqHRM6pzZc4eF2KIiq4bcl8Pz/k3B+mA1v5a/j98CN6jTpkrWjH88P
iSQlzscfH0rdF2FZEYQfaPErAFgATY1SIn0ysdJzFj0E4HGGuXqJ0bgIRJjxgLkq
eJDchoCy7a52Sr2JeytRcyXSaNYPmLHpFm2T8838j/6OVNftYGfcHZazP81SnKun
+Vtg/KINPee9eBKEbXZA/YwJMf9ZXA==
=Rbvk
-----END PGP SIGNATURE-----

--Sig_/prPfBAIWGEAV3=5tz3w.Gt.--
