Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF0631A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKUHmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKUHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:41:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4116BDE6;
        Sun, 20 Nov 2022 23:41:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFzpT56WHz4wgv;
        Mon, 21 Nov 2022 18:41:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669016466;
        bh=WoDlGBoS29qxjgF9Z+KNRm1e62BRle2upMwNn+cB2To=;
        h=Date:From:To:Cc:Subject:From;
        b=hI9J/Cce73BUSRpS7OjMsDhQEbEMAfWDei9bBHrc8cAkWfGZoJC6FYJHj19oKyFTZ
         IS1A+2pNxJW+9skv20mQ1pMs9H96VZ7mWC1ptFphleEHYIifMHruup3uynjrsndvX7
         V61W0/xEKSVLxEc62UVwb7yxwY/niAFUyd4loYYok8SkUsyC36KbmJclFfKFeiXlbD
         2R5ejWXTlz10KQRuhWT6jDyYT9rJbJmPQZJBHCZLRBO6Tk2Z9ypiNzNeWkKKcVqIWW
         R7MU3eYVK9iK3+9Zv/+YaVwgvIdkSjoL3Zq5JtHFvjNGPMXPwC94lLi65SoDP9PLWI
         R/wiIbHfNIk1g==
Date:   Mon, 21 Nov 2022 18:41:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20221121184100.0974cc35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MWSinmO0Fo9tHpwAzHhsglN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MWSinmO0Fo9tHpwAzHhsglN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:148: ERROR: Unexpect=
ed indentation.
Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:149: WARNING: Block =
quote ends without a blank line; unexpected unindent.
Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:236: ERROR: Unexpect=
ed indentation.
Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:259: ERROR: Unexpect=
ed indentation.

Introduced by commits

  5c0997dc33ac ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
  017239c8db20 ("PCI/MSI: Move pci_irq_vector() to api.c")
  be37b8428b7b ("PCI/MSI: Move pci_irq_get_affinity() to api.c")

--=20
Cheers,
Stephen Rothwell

--Sig_/MWSinmO0Fo9tHpwAzHhsglN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN7K40ACgkQAVBC80lX
0GwuTAf+JkrdYNmYMF9R2vG/oSeSt+7o6DyxVcL3JXDkEa6ytNDO1/VH8Ak33c2j
yJxkP5CfPdubu+SIws89mXO+k/r3yzhg4C/m0o2Y0c6rCuT4mQHxcuIGN8zgAHHl
sybFzqHEExe3fAXO7KX9V40mr0oZraEvQ3NDHXWHI93hRtlIfwdMAcEHEkM8TGdz
bzcw26JnnN0moEOFZxIYBgYRG2TicfOhObjmYn77rRHKLCrLbGYplpO11WXR+IK9
LyNTVyxEpS7zfZeku3qHO63IVS/TH8k8X82yjPzc7yz4INTeyzjnn7IpBApo0DoQ
DXfnodi7XOJT5P7lyr0qLpj353kAsg==
=zGSn
-----END PGP SIGNATURE-----

--Sig_/MWSinmO0Fo9tHpwAzHhsglN--
