Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45096668A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAMDXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjAMDXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:23:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4648A3AB12;
        Thu, 12 Jan 2023 19:23:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtRZN10wRz4xG6;
        Fri, 13 Jan 2023 14:23:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673580189;
        bh=KI4s/ygW2LTMTkbMeEGJEf6R331iJ6vQzU9J+48ujNU=;
        h=Date:From:To:Cc:Subject:From;
        b=KOtnrFrcvHk0CVlftw1tjj62SLF8AZvZ2S1cFXXIFsCcVuWiK8l+sgwc+W8bM5NWh
         cqaXToHwyWb3NOD92OHs6+G1FAHUcVrU+0uov0dEuSeigJpoK/hl5Vft5gcUOBdiBd
         XkDqlcrkhXE47O2N+GWTry0OJNWEi9EoHyB5tcz0cMV09W4a0kfhQx1WS3eDunllIT
         DBdcIlzX1E2gBYzTYrtn/jNMA3ZHUPN9U4MVMI6t58gCpap7C+4dF/S6DfThMmO9u+
         VmWFEmlGU8nJLyyNzI8OmJQkDDgUWutIbZpxa5+O7IQSNNc1CXVv0yIlu7m5nOHqpE
         TLQxN9HyItMyQ==
Date:   Fri, 13 Jan 2023 14:23:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm tree
Message-ID: <20230113142306.27e2ee60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wz3phH9AlH+0O_kvTMTlbHu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wz3phH9AlH+0O_kvTMTlbHu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in other -next trees tree as different
commits (but the same patches):

  280691a45437 ("mm/slab: add is_kmalloc_cache() helper function")
(commit 61df28eb7788f in the slab tree)

  a8197833a9d3 ("kernel/irq/manage.c: disable_irq() might sleep.")
(commit 17549b0f184d ("genirq: Add might_sleep() to disable_irq()")
in the tip tree)

--=20
Cheers,
Stephen Rothwell

--Sig_/Wz3phH9AlH+0O_kvTMTlbHu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAzpoACgkQAVBC80lX
0GzdSQf+OoH5gcGscWigXbU9KYKIGro/YcZcogzYvPw2ht7v1zyP2eLN5PAnZ+cR
5hPEDdktQkaOvxM7f3jEOhd3jo52UU1p/jk6cEDs1HegZYU81aEyTquQgZtxeESx
enXJ1IPvPWNbfx9JEBufH/BLjTMVzrGL0U8EhTAhUuUAjkbp72/UulgzffTLutGK
D4SXH/HCpnZcTFaXB3GaHON2PYbXMETpMl4ioucG9N5poCYcMspdvEkVmZ9X52YN
iKskswn35yYbSX5jqN/XtpbnGjniDoDis1f6rh2yHLGubVdu0aqutyNwKgygk4eK
3wHFbYsABz2zWPtW1hCd9615LdGqVw==
=TpRP
-----END PGP SIGNATURE-----

--Sig_/Wz3phH9AlH+0O_kvTMTlbHu--
