Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B964D458
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLOAJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLOAId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:08:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDBA188;
        Wed, 14 Dec 2022 16:00:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXXLN4R4mz4xP9;
        Thu, 15 Dec 2022 10:55:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671062140;
        bh=jTiFP2XNbwDthCNXXc3y/X/RTHO54rMp2llmP7AuAv4=;
        h=Date:From:To:Cc:Subject:From;
        b=guRFkS1DcmCSAWMfxzKRcaAkjfiW4CyV5Xy8D/f+zltu2C1CusGcMkc0pEal03hBE
         6v1GxefbOG7wKReZFs1DeXLJ4wfmCg2OZklafqg+ZVRWghRNnk81O1LQWIwL9gX+uF
         JHj1s2XtXkuTppHwZhOkViDVyQAq+sr8bU+W9xRmzk/mlOCZo2liQ489vNy/lheBZO
         4C+rk+dz5HDkGGkoNW3YJ4Uxel5m3YIP0XZB2JNc4zyPkUNz9vKQglF3kBbvQCIDYn
         UPAS41Wx5UILvvNYaq6F/PSiSsoG8XMmnSEWnd+u2BeAUABuNl7o+AjBQ8oYRRuoNd
         Zz7rK7shQ00Rw==
Date:   Thu, 15 Dec 2022 10:55:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: please clean up the folio tree
Message-ID: <20221215105539.72da7ceb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m/5RI9o4xePV=SssdNMeTRZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m/5RI9o4xePV=SssdNMeTRZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The folio tree seems to contain a number of commits that duplicate
commits in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/m/5RI9o4xePV=SssdNMeTRZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOaYnsACgkQAVBC80lX
0GxXEgf+O7qP8dCM8we1DzXyzqpuUBhbhh1FyIeFErFCJjnFGRW1uvxsbzSklH6a
b8/tlzmTV9taSFLcNFGSKT9MDOoBE5KJaHWQt2mBcivOJWMhtGkUJGTU73Dl5qdt
DMXUi+B43rIqV8jTOuvcDPwAAtkacpeWRBrsn3RIs6rDz+LVYjaM8+1+s/cQeTh4
vRPZUwXzLmuu0L2W9H+5c8VucRIMbnWFAgBRfU1zRrTrfaNGzVjDXDxiQ//GyABI
y8R2jnTCzZYwKgc9b6UaQRg3BKNUSm6dZxcOOUlNwUFTvAsaQtJDMTW+qFJDd149
cNybCzjDCrc8DrfcYPlpEjyDp6n8zw==
=FyEd
-----END PGP SIGNATURE-----

--Sig_/m/5RI9o4xePV=SssdNMeTRZ--
