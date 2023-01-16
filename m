Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA966B699
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAPE0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjAPE0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:26:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A754C3F;
        Sun, 15 Jan 2023 20:26:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwJqm1rLyz4xwl;
        Mon, 16 Jan 2023 15:26:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673843173;
        bh=JLyMdsKe6tg2YevfQE2Zc4B0aMAZZMDyOb8Eguq4r5g=;
        h=Date:From:To:Cc:Subject:From;
        b=NoOfRv4943y8ntEg8pkTr1ze+iVIVXzzjuj0FZNqBksGgeSPPWwC0YOou4GoAqLlG
         u5OfG05eYOB8pB7tpFuYctjTZHBY0geKvwuPBEujmfIUKb9eoXCoCePJB4LOe6+fo+
         UjNrQ7DNShK7C15YLn6aYsiZ9NAgSLFMFfwNCNhqFpg9VlC2Gj3u1v+KM1F8Dy6UMs
         MGMLoa9C2TS/Rh+7aRLPvg0NAn5hNw3X28SCoFMizmJ+TnERIhd31Ewvu7NlCKIGAG
         jPWYWbxMsuqoMokMkDkoIu0VgHG+lObcSF2eRijRm7+iQ2W2qmsa6guUhlA2k2/+d7
         FVQv4gm3EUAjw==
Date:   Mon, 16 Jan 2023 15:26:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230116152611.0e86adbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v=5.+esw2YbeuzOqZzi6xEU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v=5.+esw2YbeuzOqZzi6xEU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  ca5716c63719 ("kernel/irq/manage.c: disable_irq() might sleep.")

This is commit

  17549b0f184d ("genirq: Add might_sleep() to disable_irq()")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/v=5.+esw2YbeuzOqZzi6xEU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPE0eMACgkQAVBC80lX
0GyfFgf9HSaKw4UstXHqlp+tyU7oYgFesPqg3c/g0SCAgWn4z9Y8yZ//DsE0e4ng
C4mMzj/MGTf/mNloM/WSNEKxCwM0oM/F5QJWk5iCn61hlcEt4nmySm6sR+GLsRZo
p1QTGNJUc1UCiOMYcYIxbHgIjlLGlMtsp39JBMBjFI51SyTEsJnC5En0DwKUMLdi
m5yFPAQL3tzp2yQbCWaYa9WUwbOSpLb9b3HPK5GWTQwNpOPD1EM/0+FrYmp/AGN9
BT+mLk2X9MZKRfdK5uvzlcRkcUrQWR6MHKjhTvYZa4w237YEvgjZAwKXxfl3CEjO
rZrD98Os9QTLVLTspV7j6qDprP3bZw==
=Ws60
-----END PGP SIGNATURE-----

--Sig_/v=5.+esw2YbeuzOqZzi6xEU--
