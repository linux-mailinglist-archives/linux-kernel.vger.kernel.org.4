Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB3728D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjFICJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbjFICJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:09:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B6530FF;
        Thu,  8 Jun 2023 19:08:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QckyF6vPLz4x4H;
        Fri,  9 Jun 2023 12:08:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686276503;
        bh=NIszPXRk3qHLJzPQeo2lhi/iY+O826ijY8OrUUoadcM=;
        h=Date:From:To:Cc:Subject:From;
        b=dXWhVUKisOD0UgPf9rdcOn8WHCbknA+UrjTfveGyLpqobrDYMMebdUqxHvnVMkt8z
         7jZm4gQnedhACeGmC6GU8TotPXl+iMNqEEEkWI7HSj9y/Fzq0tWs2tssxU78f9/sZ3
         TEFqPUV1nXSje0JLeeheGlS6NM6GgnkpE6dT8s4Xni7/hLBSzild+VQuwUevv1k7c3
         M93rpNFb5R7QlJESzKxFEaXgfSPv6HmezYL5EMVg69iTGqMJV74wH+Vde4944oAuML
         6BTfzf5cD7XrU3lTQOilmEXaRHP0CgCf3x7jdyS+Rc9hzPfwFnodHRugZMCjwUL23R
         kQxIRk2p1gF1w==
Date:   Fri, 9 Jun 2023 12:08:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     David Sterba <dsterba@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the btrfs tree
Message-ID: <20230609120819.7e8e18c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zpveZ/ZE0wm6.npdQCRGTqj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zpveZ/ZE0wm6.npdQCRGTqj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the tip tree got a conflict in:

  tools/objtool/check.c

between commit:

  7e786ec9bdaa ("btrfs: print assertion failure report and stack trace from=
 the same line")

from the btrfs tree and commit:

  6245ce4ab670 ("objtool: Move noreturn function list to separate file")

from the tip tree.

I fixed it up (I used the letter version of this file and applied the
following patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 9 Jun 2023 12:02:56 +1000
Subject: [PATCH] fix up for "objtool: Move noreturn function list to separa=
te file"

interacting with "btrfs: print assertion failure report and stack trace fro=
m the same line"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/objtool/noreturns.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 1514e84d5cc4..e45c7cb1d5bc 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -14,7 +14,6 @@ NORETURN(__stack_chk_fail)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(arch_call_rest_init)
 NORETURN(arch_cpu_idle_dead)
-NORETURN(btrfs_assertfail)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/zpveZ/ZE0wm6.npdQCRGTqj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCiZQACgkQAVBC80lX
0GzX6wf+J9jaDksE/RmMBlhlBJraY2G9hrH8rduby5abUkw+gkDSccyEaGG21MGZ
PRdTlaf/PfctPD72z3dcRnj8eFqjiC0gPgLxLD0Sr/pJL8lo70hi+qbLjQ2agq83
Q9TFkJoCJlZJRbMzDtmQ4y6oYiEYARJYcFVxrVcZXECVnqGuNu++pgixJOYTWuah
XSd3P6+CUzeMOzBm7In6iyqqU1oouGzuYmTW1dElJuBN+gs0iK4Lm5gyvTQDEL6Y
kpLA9AhLS9p1ykQOZMPLATz9zZYwxfsvbOo96XnGjN4oxnK7zsJyOjNCzZASxzII
gghjfcYLqE3dAoizyJMRqH2rNR3EtQ==
=cdVE
-----END PGP SIGNATURE-----

--Sig_/zpveZ/ZE0wm6.npdQCRGTqj--
