Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8406693BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBMBYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBMBYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:24:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EBB975F;
        Sun, 12 Feb 2023 17:24:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFRSy5Bv1z4x1S;
        Mon, 13 Feb 2023 12:24:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676251459;
        bh=hkd22KfgPVUj7WypptryT5xdEKzZSTfd73qCwjO6prA=;
        h=Date:From:To:Cc:Subject:From;
        b=nw3KPNtfLH6R5e4HxblM7EMXTH0IMEpS6+uJO/ByW6HeuCP+fud77R0UlwxF/JcOt
         P4Ifp1RRqvh3T5TwLeEsNX4082nC6EjPo0jFTD7WdnyO4QnLadoqQtiRWR5D5aPxvg
         U7Uxd2oQAtaKgcW2rmUUefPFFv1G4lVD4cy4z2kg9ksm9jPtt4LEsjBoIEjfFJs18I
         bFjIWE7yUyic2cPPfVZTABR7ofvRp0IIgXdVVW+bCy6FSO9YJXuhgRfjGG53Abacpy
         rXIiFnW5PASn+L4dtThaYezjI1gkJvvMYL07GvBeU3g8c4igFNTmCEHUGd35yoqPT+
         9Go9gWOZl30Dg==
Date:   Mon, 13 Feb 2023 12:24:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Donglin Peng <dolinux.peng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yoann Congal <yoann.congal@smile.fr>
Subject: linux-next: manual merge of the ftrace tree with the jc_docs tree
Message-ID: <20230213122416.5bf20111@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u8FujN0_yy3ru2WdC.A/MO3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u8FujN0_yy3ru2WdC.A/MO3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  Documentation/trace/kprobetrace.rst

between commit:

  5d18c23c763d ("Documentation: kprobetrace: Split paragraphs")

from the jc_docs tree and commit:

  ce9c752ee1e7 ("tracing/probe: add a char type to show the character value=
 of traced arguments")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/trace/kprobetrace.rst
index 0d103074d3d2,ef223b8ad6d5..000000000000
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@@ -81,7 -80,7 +81,9 @@@ E.g. 'x16[4]' means an array of x16 (2-
  Note that the array can be applied to memory type fetchargs, you can not
  apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
  wrong, but '+8($stack):x8[8]' is OK.)
 +
+ Char type can be used to show the character value of traced arguments.
++
  String type is a special type, which fetches a "null-terminated" string f=
rom
  kernel space. This means it will fail and store NULL if the string contai=
ner
  has been paged out. "ustring" type is an alternative of string for user-s=
pace.

--Sig_/u8FujN0_yy3ru2WdC.A/MO3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpkUAACgkQAVBC80lX
0GxK9Qf/bqaOAhI1YipDDNlHZ+r0308k4miuXF6h0FUnQ9wXnmbCBh+lRfcgoZat
uDRWnMpPxywqRai8xCc+9dqFRE2iTKf/6gHeG8NufsC//PffjaaGXQVuKR6mDmXm
eHhBBCVrHmcq2XnpmXYb8fGHJvuKGtOhprHNHBNApx0EJXWmLERT/QgRxPLowdoq
ICmDW7tptL7xBKj/pth5KEWouaBclcOH3gpVO1RqX+SWEPQAj2YgGPEGvYt9xcen
x71/Q7yvHGq3vghkK1VJfZ1qnbYEURl7ZoI38cbY39gA7TwjcMUZLs2J91z0wd2g
AIc73/VdqvSVmaPnD3cZ8N6xM0rQYg==
=MFX7
-----END PGP SIGNATURE-----

--Sig_/u8FujN0_yy3ru2WdC.A/MO3--
