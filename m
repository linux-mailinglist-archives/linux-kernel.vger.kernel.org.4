Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478FD67305F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjASEat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjASE1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:27:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6802369209;
        Wed, 18 Jan 2023 20:26:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny8hG2CFVz4xG5;
        Thu, 19 Jan 2023 15:26:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674102367;
        bh=sKiPb+hJuV9kvsCN8Nze1icqrIj365SG7+AJwResrVc=;
        h=Date:From:To:Cc:Subject:From;
        b=JydZF0aOrb6gM+d/Rksd2AoxShP7UGnSdsaRUNGHTXh8bgHtSA7hc9A1cV3fv5M+r
         S5N6aC23rXS+OlGcly2NVeNHVNIBzw9h72v91DcQwWOiU3HUosX6+gN2dJlbZ/oQNk
         p9Zbpfv3+Up3L+J/JC0ZJE5bj7ENSQ2Df6VByBLrsXY3YWhgYqngLAHzpmzcdJSkn9
         8r2MWIqGPWYdEvS9hQsgO1yDnkUd6sONoWQ0tAuOPtx2rLtdwTkMk7F/0GtQ4vgWXa
         Aa/VqpFgBnki7pUyTl/QdrZq3PzhGUpm+sR8NSQoFr5JuZ2g4KDdzdoDhpcNFEQBRu
         Y1FC730c5Zb1w==
Date:   Thu, 19 Jan 2023 15:26:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the usb tree
Message-ID: <20230119152605.03588e9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ppeLoDsFsgbD.ooY/.g3L89";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ppeLoDsFsgbD.ooY/.g3L89
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tegra tree as a different commit
(but the same patch):

  2648f68bd0ac ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller=
 binding")

this is commit

  20cdc1607ea0 ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller=
 binding")

in the tegra tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ppeLoDsFsgbD.ooY/.g3L89
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIxl0ACgkQAVBC80lX
0GxS1ggAgo+m4fx1jsJSih8X8HyrLJXQyH3mgUNeuD2jVKiI/KbEs//iTEKDFEXT
aLMKhYcxxiSGhf5iMDmlU38LE5iyAQRtn/GwE9B7UIL/X3Z83s521TI9tFfAZEVK
ZcqqpeCHRZIaTo1qKf13TPCszJ9bn82T09GqowICNZRo7P4ONg8dcsiqK55AUpSu
Gg0Iobc8RAOZTIPueEH3ceFQGdHYZkE0ciApcGpHtG4OMBcpD4IHJ+PGXQn7pFKb
p/3O/K2J4j32LlzY/HhmaigOi0l2foDVb+pPPIFTsj5jD8IhHl9JGTCqU5gH8Bsz
QtrqkLJRo+X0nwICiepDNUi8CqGjDg==
=mdkO
-----END PGP SIGNATURE-----

--Sig_/ppeLoDsFsgbD.ooY/.g3L89--
