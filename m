Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA367D8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjAZW7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjAZW7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:59:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507F53999;
        Thu, 26 Jan 2023 14:59:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2x3z67CYz4xG5;
        Fri, 27 Jan 2023 09:59:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674773983;
        bh=jbgWxJFg0iY4F1EtEA/2gB+3MCylWqc8FNoAsJhxERU=;
        h=Date:From:To:Cc:Subject:From;
        b=PfAv7XOv7kI/jPVDktLPH5M0cD4SIBN5aVWg+Ica5ehbTFUhxZMmzk9MHDnzlDR6e
         ju9w8M0yJe38al+iIIGS9PuXTsZmgA5MyvGS5eKWQ9bPuu87Rk/dD45S0awxg8S+Fc
         v8AHbdcDBTwYtihzvSTIWl0ouVxYfP5FUITJrWfDSvxi4s8SKR6P0Pr/5VndzJjD3e
         2kAzqgIjMTYP3opvJkL6h1vhKszuL0eF1MKxKVx3qcPGMVu8HtmrzdutBP3X0v1p6Q
         0NOw6pPLpZf0B2ggbma3wrMLbsiZADRxK5k/cLKeDOOgGcEL71dEQQJ8OYuOAJPuI4
         rstItiLSxvtCQ==
Date:   Fri, 27 Jan 2023 09:59:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tpmdd tree
Message-ID: <20230127095942.4269e21d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/INdcaiyVVUg+WCgmQohPulV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/INdcaiyVVUg+WCgmQohPulV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  8a1719d664fb ("certs: don't try to update blacklist keys")
  6e7dadceca39 ("KEYS: Add new function key_create()")
  b4c45ccd5fcb ("certs: make blacklisted hash available in klog")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/INdcaiyVVUg+WCgmQohPulV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTBd4ACgkQAVBC80lX
0Gz3Nwf/b6oTCEgoJm+MJcYmRBI2imjYL+j+dNOGGbdSi24FNHpgaAjBf+OfJRyr
ZAPG3xEDqB89knuf0EyYBYcuauWaK66W6Ogxcl+hKx6jwTadGKL7WcqssHiuO2LS
44rKpYoA8RBo13LlfMsD2Me0TTCrKb0YtGZm6C/urgN1yQeURhhjiiRruaKVKbs4
vEUGEG8O3NAtaUYWSb4rz0TgM43zHI0Ku0WtN5rVZ3Sa+I3hXaRaKR6o96ymWHKs
WfpphXHrHSY5wO5cUH3n37ayznrCtvJKd/+CGoJTMFW7TVv8qIS5dcv4GTIlkU4N
Z1j73tOgCBcXt7ksx3LiY0rQ2Ic1Sw==
=PoJY
-----END PGP SIGNATURE-----

--Sig_/INdcaiyVVUg+WCgmQohPulV--
