Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344F968FE34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjBIEFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBIEFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:05:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4EB5FC6;
        Wed,  8 Feb 2023 20:05:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PC3DB3Dcjz4xyF;
        Thu,  9 Feb 2023 15:04:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675915498;
        bh=ayzQkMkmOGgHXPi/Wh+u/BeKFeaWDqZAB35qVuc+7b4=;
        h=Date:From:To:Cc:Subject:From;
        b=CB38AmIEY9WOEVa6Wu9Lea89pzhSHyXbC0MZPbWNyMrxwvgjgsaQNwDHQVccwRFrD
         PvqL3nRBjk2DK+xamgq0i60Dgmjc6Kof8NybRpwIRe5MXAbV3wxKPUN+XZCJChTBu+
         EQ62cqomiqS0mhoUJJ57PxOOEHhcD8BfT9cmR5JKedSLXwAOlRNIAZph8TTWnR/dwc
         RD1Q54xQoobbryp1eTYCLMXf9qhQ8ckDUcEjEeyuKB8sqDXIuBQJ79u/rKg4XPRQ4Y
         /FlIs2B628D7urPCYPTqDG7C9zvNXXxovD+OGCAA+yZXnCsyDMLuQGUPPdUx6e8NDH
         nwReCV8AnxF6Q==
Date:   Thu, 9 Feb 2023 15:04:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230209150457.401837e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8YRA0OrZrSFynjOGbp6T_GA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8YRA0OrZrSFynjOGbp6T_GA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e710abbb1740 ("clk: qcom: gcc-sa8775p: remove unused variables")

Fixes tag

  Fixes: ed432b1ed00a ("clk: qcom: add the GCC driver for sa8775p")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")

--=20
Cheers,
Stephen Rothwell

--Sig_/8YRA0OrZrSFynjOGbp6T_GA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkcOkACgkQAVBC80lX
0Gyf+gf/VNZsz1BG2q+AoohSnfu+ghSinStOniXIFao/bkWhf4QsZDy5fS4ElhAo
1iwQ9j1RkpH/RhUyVN++bZiHFYfPWl94VuJpNY+fs7ffqodLYSSm6AHX8XG+rgjK
94+Ab0Oi4QsGokCBIZaa7UILHdYjiSj9zddhzFfaJtGy0+/f9+fujl/JSitaeK94
1gdhAXn1UWsz5f13tvETB7QKI5eUFwjqPxAO63MXUMMScp1vWLniDbuPDinww7PT
5gN0fppaAyX8RojLrt9bN7GWMQ1kV5uclenuL43/NClGh/Gb5AAlHdQNnTnoLqyh
ubpRjWZStVnuZZJJYfGtZ5AEFIVIew==
=8F/x
-----END PGP SIGNATURE-----

--Sig_/8YRA0OrZrSFynjOGbp6T_GA--
