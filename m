Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2AD70E8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbjEWWSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjEWWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:18:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4384683;
        Tue, 23 May 2023 15:18:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQpbx6gPtz4x2k;
        Wed, 24 May 2023 08:18:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684880286;
        bh=NgSmQJ7GpO3XoRPYLfvI7a7Bvqx92irlBcZelJ/lFic=;
        h=Date:From:To:Cc:Subject:From;
        b=nXhzF2ooA6e7qoXYg25RkH1zfnnFftO1QzXIaSAY4IVUIjENME/akP9N6LTZcsn3z
         mQYf15Wsqcp+2V6CCfQHnVxdy1e6WsQitflL0sCgRrQG7IXyJvcDAXF6wJNsMmd+LI
         6MjEY8UdUUkEckRR0nw55FIELkUwC/H8aWkPb5Dbz/nIAEzUJXLUXbKvFgcsBvzi2u
         Rnb3MGlgRoxjs2RmBy7sAa26xkRHW6PFTywlmsxBKXHyCQ36z7IzSb/mhNnM1HESI+
         uemezxCCFMMyHFzeaNjVuu1dU7JQHT5GbgKexazSq/aZGMHIKCrkC4LIrKM6sUeotH
         20eC0oMNfqeKg==
Date:   Wed, 24 May 2023 08:18:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vfs-brauner
 tree
Message-ID: <20230524081805.4c969d7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sapP7NEcPg=wZFQjiIgUWO/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sapP7NEcPg=wZFQjiIgUWO/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ee3b4556cee8 ("ntfs: do not dereference a null ctx on error")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/sapP7NEcPg=wZFQjiIgUWO/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtO50ACgkQAVBC80lX
0GxuwQf/fpXYEcLxiTulnSoTc/ebVvD6oHnAT7WY3fGhxfjyF5wSq529XRICoIwH
25pvHNvvNn3ZFs1Xle2+SJWljU97+7f9q2O1/UC3gp5dWv1Pg6eFgA7UgTBoZsTd
OpNOYNza5mluf4Ovz4sGMNjPo7OLmEPxonu6/8W3K4crSx+g2uS4BUnmolfdqYkw
NHIkENKBT2xTlM334lMnTZnoZFQzKev3LBBjHcZtMg+cK73NwDi7UlpEgh7JHbTE
SbNHRiii87fq+gDgql8tmHHz5y9U20xagg8hMFjnfJ+1DdGoSBTc7dcdkrvS44qb
ZnoDrPLkZK7ePIpCfsghpfobdZjuUA==
=vvuj
-----END PGP SIGNATURE-----

--Sig_/sapP7NEcPg=wZFQjiIgUWO/--
