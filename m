Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADB612D12
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ3Vj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ3Vj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:39:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEEA18A;
        Sun, 30 Oct 2022 14:39:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0qRq2m29z4xDn;
        Mon, 31 Oct 2022 08:39:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667165960;
        bh=+aBU7ZA5geVQM/30TggdquQpOF2bN+5m18KZO57UuKo=;
        h=Date:From:To:Cc:Subject:From;
        b=L+TJzMPrpiVDV2nkvFfHBCg8PmTVA2TguQdGsoIsypn1X+8kKd8ZTwRDX1hp6ul4D
         d7p9wLDuzqA2noup/WxybFOpwfnx8B4LopsopWVycxgqJAXGaEVrhoO/Xj8whC8ojP
         uUOe+I2152Qry+OPS1ydl6dAq5j0yD8O/bmFFKkL3+/7/XgVbU3E9o6Abg91jB0/e/
         FP9WNL6/y1UtcAf82/utHa2LJo/gt5DNbgUi3DrJN42gRp70FjSCJQlktX0l3dXulX
         9xIh1xK/ZTIWuyu+ks2P/cnMb6BBgRRJewGj7VSQ0B7qmD1SnTx0WLqx4xQAs8SlYo
         ZZsAQiBKiOoEg==
Date:   Mon, 31 Oct 2022 08:39:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the sound-asoc-fixes tree
Message-ID: <20221031083917.6944b95b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZvSHMJYsqsrF96+CJ4WMsg.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZvSHMJYsqsrF96+CJ4WMsg.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc-fixes tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

WARNING: modpost: sound/soc/snd-soc-core.o: section mismatch in reference: =
init_module (section: .init.text) -> snd_soc_util_exit (section: .exit.text)

Introduced by commit

  6ec27c53886c ("ASoC: core: Fix use-after-free in snd_soc_exit()")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZvSHMJYsqsrF96+CJ4WMsg.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNe7wUACgkQAVBC80lX
0GxkAgf+Nz6VdbssPm24S37sI2Y1OREiPehGhjgLLlX/iModbHz9oUVRJ/beUQdU
yoQRJZe4wra5CNrN4yppAv3Tloeanm4Hr+KG0PMMxTMB4a4X70l7qWJtoaR6q9+X
O/yNoo1JcUaKwJg0R70sc0ANRM53ZvEOv4y43ShTtj+f5NcR5kamQFNgWS3RCTqP
WTSiklFRDbAibJM8/2kkmjDy+9vKQORjCA+TAj+T/eoaUGb0JqjENB1KTXreTsLP
a0aL2JsNTdmMfRG0/8Agtwd37gK3fmL9BfDjpdz5549h94WAqIR6wzPs1X4hBYv2
+Skkt2QJBAmA6RFJDEvLrAO4/duFtw==
=TEMv
-----END PGP SIGNATURE-----

--Sig_/ZvSHMJYsqsrF96+CJ4WMsg.--
