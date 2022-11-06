Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5E661E65B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKFVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:13:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF4635F;
        Sun,  6 Nov 2022 13:13:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N56Xt01j5z4x2c;
        Mon,  7 Nov 2022 08:13:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667769214;
        bh=RvpuggfHK11s5Kb0GsbI0h7Jz/8HynA35oj3XZxU5dQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Zoy0DkG36gZzjpGd1SeiYhQAbVfgqaNzHCo9Ri9GHNcaEx58E4/dMDPwpMc+x70ZO
         Gpz56wz+6+rlQ2M6j0xCG5KcUqIxAqgGjHj+IADpmWRwZ25nnf4bdQ9FXf6rpbD2O6
         zPiL+cSIpKHM011PI6JDW0blDThmwEZ1S8U0x/7yqeGNwNJMQguv8T5GCTLqW8velb
         HEu0ItFX780G8KXlJRb+obiO+hBSZfhiXslnmqtJuU/di5twTOFcRqj71ysQaF2obi
         /0QLFoCBrrplkqAr8m6BLQK5GgvsJZMfzOHQxIeEXvXE5tr/oWvp7/kRzt9IUI4wke
         73Mdk9s2vcRhA==
Date:   Mon, 7 Nov 2022 08:13:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the phy-next tree
Message-ID: <20221107081332.391638fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kmDcqy11Arj+gYGt.v/vb_C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kmDcqy11Arj+gYGt.v/vb_C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3ef54ad3004a ("phy: usb: s2 WoL wakeup_count not incremented for USB->Eth=
 devices")

Fixes tag

  Fixes: f1c0db40a3ad ("usb: Add "wake on" functionality")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/kmDcqy11Arj+gYGt.v/vb_C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNoI3wACgkQAVBC80lX
0GwzKgf+N62tNYZi2NbCgXDKRMazsbD+cLAYI8/QI8cLtlPjvW2mStIL2Wj/HcCr
1ieu4gF2U0t6W8+M29E67Y9VTZ9sJ/cX34uUh/EmW4UJs9SISKgQ+5b4H9xhQ5rB
jTDhPBseijsFe2hwoQG9p3nQwk7YplJ2uhLqwDx6CJK0gDGSp7RdQzVJs4IMLNwp
yoWx8HIU4oL89eKhPZYQlMyVayz71OCgG5ZSuprygjzjp6hkCjbaUhs5AoxJRWS7
fqZ3DMCFs0lhTOaAaqCfcecqg/uVxRRcYcHQ6fzxDPu42U954zOfZQuzWhrisFuP
e6PJi0vLEGTbUvmoHDQXYCvNFOZCWQ==
=LClN
-----END PGP SIGNATURE-----

--Sig_/kmDcqy11Arj+gYGt.v/vb_C--
