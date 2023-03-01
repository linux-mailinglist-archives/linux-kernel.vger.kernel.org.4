Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618646A6452
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCAAhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCAAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:37:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528682C676;
        Tue, 28 Feb 2023 16:36:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PRFfx1s27z4x5X;
        Wed,  1 Mar 2023 11:36:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677631017;
        bh=E4RJy62x18p2UWCOcu/vxYRmmohdsB2Rv6NApQsZECc=;
        h=Date:From:To:Cc:Subject:From;
        b=f4W9lctilDsvAKcycTcXQYfsoM2Ja7aNuIHmqv05PrZ0YG9yQ8N6+BBLfjsYQ1zD0
         Q3NVjXrLsNBZUuw7HjNP8F4xEG2KgWwVbOpEnmWNo+qiD7JxPa2lUvX5ZTe5LApAcH
         rzKDfFJu4GsolMl9ylz+0UqWsFyAGXBIwVBWRaCVtiGt+OSQYZTzaPtV6BVoWyqezH
         OWzavF6J7IsQDbEWJZMQWgEuh66yhscIKE2TixvmShik5SjMYn5FKAFhqqVbXzb+8l
         zYlL7RbMMSFsLiQGiM+2j3qvoEFfOThMosL1OLINctWYM8YEMs+NG2D2pv7s4hT71Z
         g02remYZ/rH3g==
Date:   Wed, 1 Mar 2023 11:36:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230301113648.7c279865@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ed52X1gqHQ_n2JvD4=49qzS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ed52X1gqHQ_n2JvD4=49qzS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/mm_types.h:1105: warning: Enum value 'FAULT_FLAG_VMA_LOCK' no=
t described in enum 'fault_flag'

Introduced by commit

  5827f16cffd6 ("mm: add FAULT_FLAG_VMA_LOCK flag")

--=20
Cheers,
Stephen Rothwell

--Sig_/ed52X1gqHQ_n2JvD4=49qzS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP+niEACgkQAVBC80lX
0GxIbwf/fVeS6W1T/qVSahQKAf5TPDD5rvfabPkSdTqi92/FmxIfnZasIRah4ZaF
dbsgoofVkPqYL/LcFlQE+Gyozf4SXKCCi5gKm2NIYLOGpwoghqs+n79mFAPdsS2C
B85tz3kOc73hc2QiIm9koEOGtnm7Iw3wLHG8K5COP3YNiroXi2xF/RQGhLS0jfii
EbgN67nkL/qwFn1JyAXjsnGAKYiHFbrn2N8aLHPpn5eUcMgslUpGGSdci7t/9dH3
NAnznEJ9HkTCwqgJGobs4NzhdHQV2MVBW84aDpBZTvPE+3nkNVMWEQkHv7yVxiJC
T2dKCbG0qaRDqhkRfHuE8oJSuI8cyw==
=8CME
-----END PGP SIGNATURE-----

--Sig_/ed52X1gqHQ_n2JvD4=49qzS--
