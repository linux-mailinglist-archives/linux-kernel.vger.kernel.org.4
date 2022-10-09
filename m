Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A05F8A22
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJIIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJIIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:32:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58321249;
        Sun,  9 Oct 2022 01:32:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MlZzV6bkBz4x1F;
        Sun,  9 Oct 2022 19:32:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665304343;
        bh=+nhQ0dj8aFjYXJqSybc6sKvdvigo4xUve8yqIzxVm+0=;
        h=Date:From:To:Cc:Subject:From;
        b=UKrnmY6JNdNEsdIIE1TYWGE/IozVNcjiCBfpzX0CIUtjQiDkvhx7nHk2Q1ajR/k0+
         2Ic7Rm7yAHzM8u9ilN9NyZrfdN4cWwYfRktA9h+170U2mnL/wsk7kTBrvanXOsm7FO
         4MJhccojOqSxzsl/yY5G76g8qBTQ4TC6KuW+tv57gJxj8PcRtPWAMQR8pwKpnsemd0
         NTma8aPSFVlfvuBGtIoMdCkzjukOVjorlHCR7150f6C7KxANpFkitZj9QuTbOVSUCd
         xav3A9wZT8omfzjiQgHtQE2ikK24LeGR+wniZw0O9UF+7CoRgvF2boWbVBKrkGpAGS
         PKtZHBORqCUgQ==
Date:   Sun, 9 Oct 2022 19:32:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20221009193217.6cca2f8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tFhaPhz9E4.ucv1FkUhgMuD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tFhaPhz9E4.ucv1FkUhgMuD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")

Fixes tag

  Fixes: "hugetlb: clean up code checking for fault/truncation races"

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: fa27759af4a6 ("hugetlb: clean up code checking for fault/truncation =
races")

--=20
Cheers,
Stephen Rothwell

--Sig_/tFhaPhz9E4.ucv1FkUhgMuD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNChxEACgkQAVBC80lX
0GxENAf9G8ppEkb5JJ58KxAxY9zrmvFrD934hIkQag/K/lubzfMHtjlUT5Bbt2lD
v2PkF0L2V/WnOe16qco06pIxcAH630AzS5KqOGEIS2nL8Fua8iU5VE/YcURHNVyT
EOT0W8GbfKxWmst9bDSwCl/7gHDDT/SK6XKYVL0BSLaXW3Vlj0lUPchJSMPknZhD
c65lEUWahLFEN9+0IfFXhFv+sxYzp/4J6NVPrraRhw6AUg40jZwS+T3eUob07Bfb
w5ZzZ71ROQNtewCcS1gVxjBwy8GsfwIy7WQDJEs8RGfWVWigVU1w6WJucjMiHzbL
lXw5CdskiAF8yOO0K3sN2Cn95CZS3g==
=a5V+
-----END PGP SIGNATURE-----

--Sig_/tFhaPhz9E4.ucv1FkUhgMuD--
