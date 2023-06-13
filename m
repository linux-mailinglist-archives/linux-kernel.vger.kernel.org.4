Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0334672D7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjFMDEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjFMDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:04:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915EA1FEE;
        Mon, 12 Jun 2023 20:03:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgCzS2Gmkz4x3s;
        Tue, 13 Jun 2023 13:03:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686625380;
        bh=OhZTa/7Qy44Lcts62gAHd1HAb6VNJ7JfqoTSsl9ZKhw=;
        h=Date:From:To:Cc:Subject:From;
        b=RlIA+YNE/WzQ0gy5bKNJbIHkv+ddk1YoPgernsZttU18laV/jOqRBrZ1pH2wTd19X
         +qmtXebwhCJua9H85zQqDrAWxs5jQAvmEYAfab6PD9DLABZhctorYzW2SFSPtECF13
         pcE6km9L44+X3Ijws4LeI9HBYPEajwOf1WVOOB+NBhOvz8A/oC8IM8j+6mZbmrYbhM
         fwpqJaaBNzjEoyum6LVG7rj2Pqo3nZWYTEbdw7h5byPqyxCKJ8d58iM4TCa4CP070t
         w+yoJmbTxtDA6VZS6J1S1T442ypV/DcdZQziRZ7jnQbwVNovhfOf5Ir1l1wep96b89
         fZSTDSP50nBLQ==
Date:   Tue, 13 Jun 2023 13:02:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230613130258.73be7f1b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jsBWKOEx7VWX2Jzy=nBKW7h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jsBWKOEx7VWX2Jzy=nBKW7h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bluetooth tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!

Caused by commit

  817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/jsBWKOEx7VWX2Jzy=nBKW7h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSH3GIACgkQAVBC80lX
0GxQpwgAh6IxuLGV8k3mnZ3ZHS/B3p6YEk0aMZ0VaMcSc77tcG1W5ygikh/1zfEq
6w+mKLOO5dW+o8xRkghWbz+9WTiLqHd7soV+fkj/lMsxPuuNigi6IS0VtJEII08z
9HTonsekHov5qcg+9khyBFVbBJgMLtBm0fVJbnekFUriMOKxikvpNePSquggrcjC
E5vdyZHQQKX+gobFK623+0XFMx6elbJEcLiXPneZf7xgYnMllBlKOb9idFVUQXqd
khjAbeoH++cSdL5jXXEDo4nRBCfMPV5Qs6SOKC/CNv1zG9hizArkRxScW9XK2U0j
4piGheoYLKhEGePDRITS8atvIQWHqg==
=aDrr
-----END PGP SIGNATURE-----

--Sig_/jsBWKOEx7VWX2Jzy=nBKW7h--
