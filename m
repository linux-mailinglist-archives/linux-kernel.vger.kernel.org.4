Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149B962A318
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKOUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKOUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:38:53 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB7E84;
        Tue, 15 Nov 2022 12:38:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBdLf07pPz4xTg;
        Wed, 16 Nov 2022 07:38:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668544730;
        bh=k809YecVyJ/i0stvUv8T83qyvCDeubm4DV7Sxyj+e9U=;
        h=Date:From:To:Cc:Subject:From;
        b=DY/PLTvW4q2tQ1xhsZOvAFmc4IFoBDLH4ITdXOZC5I9dfxNhedV7oa9WaQ9074bcG
         5BOd25Ee15fCV26+P/6TJ787+NrxcvdRlRQaVraCLWaavMX7N2mHXIhWj7N9K5jdJ2
         jzFxsS+qBqXdHXjNHsXqRzrHKvuopO4U0uYGTimWHFKSt6PRvXWLAICo6kLFASVHst
         Ks2d1h39uMVpCh4QhT44eq8PmaaPUeDvUURjqhiho1g0YBx3VD7JifSGrdOaGRl0m/
         GiDq0T5Sm2t+MNkN87SF0YZ941I1hHK2soD76BOhCof4iqALf7IUydSxdUBRxO/FKw
         t70wb0gFSB41w==
Date:   Wed, 16 Nov 2022 07:38:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20221116073848.46178032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j3X.ylo3M=FFjstQb4+_/wZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j3X.ylo3M=FFjstQb4+_/wZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  0f6e8d8c94a8 ("venus: pm_helpers: Fix error check in vcodec_domains_get()=
")
  ee357294a85b ("MAINTAINERS: Add Vikash as VENUS video driver co-maintaine=
r")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/j3X.ylo3M=FFjstQb4+_/wZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNz+NgACgkQAVBC80lX
0Gwt6Qf+L7gAxvVRhyXfbu66Qa49EdLJggpQD6mswrsw3N6KwcEGwcq5VCIwKnlH
yBzL5oloWEGJAml1UMkiETntGmWfJTGhGHTmDAh9RG4EnETWfhbrT+gQ+HBwxh1V
tlwDbdKKQOFb8OXEus8F9D9TkBq0LLkLYGII5gnEGIlEuCkWlIyPF1siMr4UzPQW
A4/YNFjaVM4XUjwtD0ydykpmE+NkldtPdlWyGlIBOIFJwmgcVxjYirm6RK4yrTef
jcUJA6HUpywcHXpfI9wni+WnkkV8BHSBrf85ZBYQiRAMH1qMyR5NrLnqCwGnCmNt
tuVldgFAegbDlGRFnHfIi0o6GntHhw==
=Nq6M
-----END PGP SIGNATURE-----

--Sig_/j3X.ylo3M=FFjstQb4+_/wZ--
