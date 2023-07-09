Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17174C8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGIWZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 18:25:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E01115;
        Sun,  9 Jul 2023 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688941535;
        bh=6BHmcWQo769ecWETCS780eJR7MBDhmvUlu4G3tngDgk=;
        h=Date:From:To:Cc:Subject:From;
        b=AJs8FBRtIjh5jpWXX2akVMtfqXCx9Y9uyV/ICBMpOdjaeRPfhNAMJPCqVuZiEL1g9
         PhUayszk+xwt6ujoD1qaU0CXsbcbEiTZok7NVulWlTGumsLTvvbKGrJ+7y8A8gKJb/
         fmvi/L/WuQUPB4lFYR3PLo42ulkR50h1RNnHnrjWAuXyG3GCHTzvL0UmsEP/bA7Pn+
         BZpubV925IyhsFUnIAH/ULfxLM+BrCY4WapZne98HFH7A3GxhHGY3ZK+C20PZAyWJc
         aAq62XofabHowdAAqSVfsMeUeAo13m9DBkCIgUg7xuayrxKeYuomC6HfncxvlJp6iD
         zqIm2u/EL4xow==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QzhXv1xwNz4wxm;
        Mon, 10 Jul 2023 08:25:35 +1000 (AEST)
Date:   Mon, 10 Jul 2023 08:25:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20230710082534.762599c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4W5oRzT1ylEF4nNQ2flMvIx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4W5oRzT1ylEF4nNQ2flMvIx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  aeddb7d13ad3 ("drm/amd/display: Block optimize on consecutive FAMS enable=
s")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/4W5oRzT1ylEF4nNQ2flMvIx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrM94ACgkQAVBC80lX
0GyuKgf/S4S94PDQ7cvPjlJEjVig4+iD/hqaZoGrG3TjSAamShuAqjwP6gvd6yeT
+KKArp6DlHjHyMdXVOA5kiTiVQTsj2ys2Gcd6CpfzycyzI79PnAwkY7NN0H6lGao
am0ZzWp1AKbz8yHbRJysGTRG5Zft7Ozpyu+kWNLN6MKrgeYPp2Keol/1g+EwU2mG
C1itDOrWNX2SaRPD4P/j0848JP4Dr+vUxTncoSbBQWri3u5STK9RHq2Gw8qHQw8p
G9iLHCjgqr8Wnd7Y1lZYjXkFgiQlDUwY+GERwnEvdHpzUycvV95rxBQ+Py7HaI6h
Ac7i+6emSkamRJcfENkYJTojJxutjA==
=N7MU
-----END PGP SIGNATURE-----

--Sig_/4W5oRzT1ylEF4nNQ2flMvIx--
