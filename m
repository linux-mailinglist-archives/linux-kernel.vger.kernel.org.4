Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442073AE75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjFWCBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWCBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:01:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310121FEF;
        Thu, 22 Jun 2023 19:00:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnL793MbLz4x0G;
        Fri, 23 Jun 2023 12:00:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687485654;
        bh=SpJ9v5qGf6lWpDJ7Zt2Xy0V9JjqsIL/EcwEDdTIom6k=;
        h=Date:From:To:Cc:Subject:From;
        b=gyao03g8jxyUseYJ//9d6MALd5VHfEzMgjuYJutkkXkXGoRSGWMBD7x6P5taLsYcs
         nNdhG5mQukuM0LAjOKBgqwQwyQKIZs6PVRkP8pmbKL+GyFCdg+qUudc695eRgKssB7
         yLQdAklFF+3p9/SuTxj/Sc0He9D7Yd+PlEv0XBirPyj3NIqCcQEpg/lTg0QECaIzlS
         I6PpvAlYjAGnWV+roT0Lx2/E8YlRDP63Fr7ZLiXhxJIeMsm1VWkPOkKOxNxsVV47d4
         DsBNzpqNMbY2PruQFqtMNmJ+vGlhlnx3al5KCDz22jXZSvwIFW1sBM1KZtwVtvd+o6
         eE4/nHug9n4Dg==
Date:   Fri, 23 Jun 2023 11:56:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: linux-next: manual merge of the clockevents tree with the tip tree
Message-ID: <20230623115649.3736ac66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/omUKAtpTa+BbNjWlgI_/gH4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/omUKAtpTa+BbNjWlgI_/gH4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the clockevents tree got a conflict in:

  drivers/clocksource/hyperv_timer.c

between commit:

  e39acc37db34 ("clocksource: hyper-v: Provide noinstr sched_clock()")

from the tip tree and commit:

  f23dab716a66 ("clocksource/drivers/hyper-v: Rework clocksource and sched =
clock setup")

from the clockevents tree.

I fixed it up (the latter removed a function changed by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/omUKAtpTa+BbNjWlgI_/gH4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSU++EACgkQAVBC80lX
0GwZPAf/SdH+O4RKbk+El3ql4r9yiOvkttSw2OZLyenetsq2hiVsa3D2/N65rMAN
NEHfa06rDsDfOCG6PgC9FhNGccydoCYUc/Uoesnp8a2vcIbIKKWqHoMvThkCrOhF
S5SgUjqurdaM/rXfZPtsc+47MM3wr1bsjEWPfRw5X+LvCSNqcMkvp/Ot0eH8fl6j
g++HecMVVP9WwVdjHeUBVlt/NH3sYMY488jSRUCifznmyx/OvJg/oMdWvBLVC6VS
8yc/fbArsSfSILUIBh9Afu/2c2ixpQQgbrBzWnPmER3q5LZLtFgu/oWG+wHc6xiD
A0X/PkU92XztSy5N29sMDIcfGIftjg==
=lVpJ
-----END PGP SIGNATURE-----

--Sig_/omUKAtpTa+BbNjWlgI_/gH4--
