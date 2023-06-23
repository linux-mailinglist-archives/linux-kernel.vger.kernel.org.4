Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87673AF74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFWEfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFWEf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:35:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E082126;
        Thu, 22 Jun 2023 21:35:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnPYM3440z4x0G;
        Fri, 23 Jun 2023 14:35:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687494920;
        bh=ZskOC+cCF8/1ColPMPP+LaROpkzweQ/aPkgpe9itvU0=;
        h=Date:From:To:Cc:Subject:From;
        b=Sm77AadHjqVYzBHQVDlPJO35LZRalzclBH2RJHH8eieibmqBFnskdfVYS6MYz/2Ib
         Lgw+HldZecGczvvPjaIOW5MmOGbe5nl6yXLPnuw8AYKzslbE/RYLju52KxSB+4L6e4
         4C2KnxMYB1gANuBtdta5zOIcd1B3fwr1u0zsC9mGl6CHEpVcwzHzc82oR4GfuAXuwB
         ZDTMIEzUhHjjiGP8+oBp9BxcPW+fBM0oFZ5ziJPL/ZbPqsfZgvabtDV0cO3CPnnHa5
         0k+Mys7hpkLr9aG6xliW/67t2DAfWhZ2XD7xVAp9AG7lVSv1iQe7rGjftjgU1ppW6n
         HCnzrZy4QHBjw==
Date:   Fri, 23 Jun 2023 14:35:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Donglin Peng <pengdonglin@sangfor.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the ftrace tree
Message-ID: <20230623143517.19ffc6c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RcO5jDrgAuSQehikJZ6A93s";
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

--Sig_/RcO5jDrgAuSQehikJZ6A93s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/trace/ftrace.rst:2797: WARNING: Literal block expected; none =
found.
Documentation/trace/ftrace.rst:2816: WARNING: Literal block expected; none =
found.

Introduced by commit

  21c094d3f8a6 ("tracing: Add documentation for funcgraph-retval and funcgr=
aph-retval-hex")

--=20
Cheers,
Stephen Rothwell

--Sig_/RcO5jDrgAuSQehikJZ6A93s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSVIQUACgkQAVBC80lX
0GybuAf8CDtX6KSAi5pgpOAC6gFAwF9rA47O7xsAGAu3XI71H5mToCQKROiRHVCB
JR0ImZRxv38qSF3/cPrZ4MSAqjXPOCvtZPMG+sFttgn25pl/yjueFI5u2ck4pW8a
RAzJoVsCPoHUB2LHtZpvKoG9kr4ulTbxOblTdMutQen3wBTsClc4qkWfTRcI6AVq
rD6Gq52eVT6l7w5yQ17L2Nj63RhsfeSSD0uLDFe+tU6TtNG9GNidfTdJk9Dus8Si
yjMf9git/iMOIZmnebCxa0SQdqKj22qTS64sq7FfWuiLITMUlCcnoAkhvzorBqRt
MO4LFwnOhPEO5tEl4aGeRoLL59AOYQ==
=KSE3
-----END PGP SIGNATURE-----

--Sig_/RcO5jDrgAuSQehikJZ6A93s--
