Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF5673076
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjASEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjASEkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:40:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B1938B53;
        Wed, 18 Jan 2023 20:38:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny8pp6GmRz4wgv;
        Thu, 19 Jan 2023 15:31:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674102707;
        bh=8sgL+0WrHH0oRXdlizNsRhTKf7NZ+7de5hI8FWY/hQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=LgQcXAUwwnilgGomL6EeN8kUHBZnqqobipr98x1nca1H7Ck3lrrEZvOinwhKyPEj1
         9y7/5EjASOwVKQS2LbJA5xBPdKRUtFI1aIc62uB6NfIRLO2RjuhDNYq0TIqyTV6MqV
         gqPh1o0oYlc+IC5HyvPRR4ciE7yv945xKLYYVb88pZrWguXu2puAANlkEFZFBkSYgi
         3Ltpf1Uk5hxQAkIFhxAb4MT6aS6mvNpV7zD3qvgWvUhVRR6V3CCGGAdR7VMnS0Pg3F
         RUGQ2KoN8sTi87GfSKqVpioZIt9i+srh8hEVqea2nWJseY1SDOMMIMe0wL5EY52uH2
         UtL8m/kcTpVjg==
Date:   Thu, 19 Jan 2023 15:31:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Greg KH <greg@kroah.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the phy-next tree
Message-ID: <20230119153145.598885cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I9K2rl9YXn4x7U78Jl8W/0b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I9K2rl9YXn4x7U78Jl8W/0b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the usb tree as different commits
(but the same patches):

  5c7f94f8bad8 ("phy: tegra: xusb: Add Tegra234 support")
  e5f9124404d0 ("phy: tegra: xusb: Disable trk clk when not in use")

they are commits

  d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
  71d9e899584e ("phy: tegra: xusb: Disable trk clk when not in use")

in the usb tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/I9K2rl9YXn4x7U78Jl8W/0b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIx7EACgkQAVBC80lX
0Gzz9wf+MzFQF4IfuRKaj/8386BSABRuQD8bHuvh6Kseo65jATXNVDhqOpsUave6
we0mgGtDZtJHLTk1ZsFHnZh0gqGHPWO2P7iTK8OZZdDhMyBNCfFmT7B/48BOCW5n
Ay855QdaIKZL2/c9gHnnynXcMOB2EjaT6ySwwbVsK8P/MPdn1YlTy37kYtf5NStS
3aQfj52WcV3jZkRlR/RPYx4B8/EYoXbrVqaYhe8Xn7VSEttoWhMHtWP82abvEt52
0WWIm73jKqt5YhoHwk8SGquZN5eXvaC/JhLWrAMS42s9obrjEFv7TS7HXk8Fpg+R
lfUnvuFlFzaJVoFMA9B4VZEsNmQQwA==
=qx8Q
-----END PGP SIGNATURE-----

--Sig_/I9K2rl9YXn4x7U78Jl8W/0b--
