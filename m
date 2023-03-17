Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96A6BDE40
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCQBoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCQBoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:44:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705312F14;
        Thu, 16 Mar 2023 18:44:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd6P60X9sz4xD5;
        Fri, 17 Mar 2023 12:44:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679017450;
        bh=xpvO4chyHf8oseweq3a/LXH7PfAfZ7T6uwwtsC3XsG0=;
        h=Date:From:To:Cc:Subject:From;
        b=T7uAB2p1/MukvfNKVj7CWj1egvJ+2f+qZozz/IkGnAVJPzSSLSn6EzdUxxlrA85da
         rS1EPnbkp0t6s37lXCuCfSMbBeRkSIFDwetxjQDwQyGVJSSNuFAvR26NdtCsPLA8N7
         hXwMonWTgLL6IXVGi4DusmJSS54OPzmgUpaE9ZTO7FXaphhpF8VU0/TUxH3ctoutMo
         3OGGK4B8JxZfcHynMbF7gwCXW60angRs9ozvBTVSfvLqCHz8ASK33elfRASk43B/Be
         PZ5XhDQ7s1CRT/oB+foj6bmnpkps4JlBz5jSt6tVZ7DNe0iTgHlcosPXbyu6l5s0Yx
         5m9QUtGcDcmsQ==
Date:   Fri, 17 Mar 2023 12:44:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20230317124408.4f868a50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HcEJ/N4S3+.ySL/GHURX8KH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HcEJ/N4S3+.ySL/GHURX8KH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  include/linux/slab.h

between commit:

  af8daebdbc08 ("mm, treewide: redefine MAX_ORDER sanely")

from the mm tree and commit:

  4503dfcf39b1 ("mm/slab: remove CONFIG_SLOB code from slab common code")

from the slab tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HcEJ/N4S3+.ySL/GHURX8KH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQTxegACgkQAVBC80lX
0GwO6wf8CTHY/i0NQvTt7YxFbzeFnJuOQDP+Ksf8qAxt5ZpYEyG9IVsmJ3SrLtQ7
IyeAFzPabP///Tt++qV59ESUVEi7wjgRIEfndA1HNdHzRdeYLBdnl1TKHUtqMzwc
Juono0AeuhoLlpskT11JbrlVUANDzW0s7oEIrrQZP948+zml/GMaE1yj8iSdzvJe
jPU8staI590aoXeiGSQnriGqAXMdzP+OqmzGy5nkfhzJg/smAk4kXS2ksUVS1A3J
EE+/TnXxH7kM0KbnE5582QiOd0jSA6asLC3Y1ZCkDsEgB6Xcrd+HxWRfO7mlvgy6
9p/Yulns61M3WEzS7FhCAvzrv9HPbA==
=Zi5Z
-----END PGP SIGNATURE-----

--Sig_/HcEJ/N4S3+.ySL/GHURX8KH--
