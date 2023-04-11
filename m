Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1B6DD16E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDKFQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDKFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:16:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECA71BF0;
        Mon, 10 Apr 2023 22:16:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwYwH1Czwz4x1f;
        Tue, 11 Apr 2023 15:16:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681190175;
        bh=Cj6AlODVw/y9CAPgFZFNxLsOj4Q5JjCiGG7y0ObD7RY=;
        h=Date:From:To:Cc:Subject:From;
        b=kOLNOQSeME/7V+RIlpFmIZb3+lYxzcOSEPJRjLZyXaF76aC3FOlp6ZzKyPLY7+oAo
         X4Wr1j/jxSDQtDDyhumrRVR0AeWlOXP/1Z309ULi3iFkDbCuQ/F714zD3PVZ2HOU8M
         xE9JaYShbiqub6KyDtb6QmfFt7OQesYPe6Mme7Sg/67EZBI7nisbca+d0yscFP24Yi
         wDcavap5olAdhsutR+RVVu8HMHTYDj5MxDum6EjRSbw52Hui2CmKsrG8ZVpK8phkui
         XlJ+tJkEfJ4OIIK7PvZ9Svw3OyEjvNSpYoG7b1ytDg0UWoB9qgotCVgeDGQYaa3v4b
         klW6ZV+1MJiRg==
Date:   Tue, 11 Apr 2023 15:16:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Takahiro Itazuri <itazur@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the jc_docs tree
Message-ID: <20230411151613.20bfd5ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X3+9zEG6xzvVIO8uQurvFtt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X3+9zEG6xzvVIO8uQurvFtt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  5562030968d7 ("docs: kvm: x86: Fix broken field list")

This is commit

  fb5015bc8b73 ("docs: kvm: x86: Fix broken field list")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/X3+9zEG6xzvVIO8uQurvFtt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ07R4ACgkQAVBC80lX
0Gy/Cwf/R+s/dAsFsXWaUT7LjaagdTqCEEhr8HttHdpYN7OEypoUA56Izx30C1lc
9QKB1KeV8D8g/IHn5KCbbhanckH+ChbhafvldsrifrLcC0jJomM+OVzBkm3lfCAp
5J0qmjQWOJsupo3qmSaMa/EUSiJBlhnsb+zm4fwtoWxXkA2tX/Vihs8xhdmIvgm0
Lab3strjk9YruPhDa7p2+ktLZbMuSKgqhVpkyJqNBolyUIeYsZl13aBR5JeUKihB
2RMcIKid28IaLofvdXdRsoaYSL8LeVUN0w3ANoJcei/2ZSQ4Zvu98E56845B+GmK
xeilp6Q/U8P/xRlb07PYDhDnaGn+QQ==
=Af2l
-----END PGP SIGNATURE-----

--Sig_/X3+9zEG6xzvVIO8uQurvFtt--
