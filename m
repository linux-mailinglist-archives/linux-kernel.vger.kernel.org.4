Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397B364A9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiLLVw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiLLVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:52:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21AB17415;
        Mon, 12 Dec 2022 13:52:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWFhd3hKhz4xN1;
        Tue, 13 Dec 2022 08:52:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670881921;
        bh=LXZXBtU5X9M+WZnuPVj6Y5+7/YDtFyXToIerNV57mzg=;
        h=Date:From:To:Cc:Subject:From;
        b=FyS5RfdqmlD45aZYDkdm3Gu4PsXRZaLhE4jgTTOW0+Aj3QrkfdAdsLpj2w91fFQed
         jFRKwvOugxki7PWysjoeaUJDyLqWsQjBEkJd9FHvqdJ3DpYVqlqbk80v98Nx1iFRXw
         cvnEjOwO7vaTeGaZazv9il0kQxTZ57ZIhT/DrJ3R03uLV3FwBtjkg4/Nf2sXiqZuqv
         cX5GKqGgX51Tdc5s3hmwGFO7Nu92hZu9/ZJf41XDcYpiAHyBxUOeLFD8xuzjFxx/dA
         qG/NGL/l0pYUZghv2csiZNqMx4jcTMNI6igOcwFwhdRRG+7i1kQAnF2LhIaacNpYlK
         t0nERUXn2VPRw==
Date:   Tue, 13 Dec 2022 08:52:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-ID: <20221213085200.772ddd94@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5+en1poW0DoPDv5hpwYNdwH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5+en1poW0DoPDv5hpwYNdwH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  fff1787adaee ("trace/kprobe: remove duplicated calls of ring_buffer_event=
_data")
  8c2b99790196 ("tracing: docs: Update histogram doc for .percent/.graph an=
d 'nohitcount'")
  ccf47f5cc4ce ("tracing: Add nohitcount option for suppressing display of =
raw hitcount")
  a2c54256dec7 ("tracing: Add .graph suffix option to histogram value")
  abaa5258ce5e ("tracing: Add .percent suffix option to histogram values")
  5f2e094ed259 ("tracing: Allow multiple hitcount values in histograms")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/5+en1poW0DoPDv5hpwYNdwH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXooAACgkQAVBC80lX
0GwDFAgAgd0gp/bOR1u6CswJB8cYtIef59ZKz7sKRmDziIh6GYmhn9XM/Ev4hPTn
ClEPni5mlKr7ghBpeMmHCJYG0lyhwUTJeLWwJyDBvtoXqTcZq6tcFvvQ395GUReM
1skSKgOq9rRvQ7nwAkPxyyBTgh2V/vNKCvGfbM22jpFPRBnBWBtgesbCvJkkgANM
rSQ1odEQmNjcS3W13DeoAZe6/HBNC2fmul2yZbrwGoUHEuKiMgN+GPk5GhA0VSMT
XADIprSt8HF5diq8MwRDEAzRKP98eByytXjE40esg87zvCDY+BRPusQ5vgyU3ird
jbFsNYHckdn1rP53iGf9tyr9jbHkmg==
=cb8W
-----END PGP SIGNATURE-----

--Sig_/5+en1poW0DoPDv5hpwYNdwH--
