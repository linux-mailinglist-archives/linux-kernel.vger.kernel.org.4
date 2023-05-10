Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A486FD379
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjEJBSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:18:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98EA2D7E;
        Tue,  9 May 2023 18:18:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGHGf5bMsz4x2j;
        Wed, 10 May 2023 11:18:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683681517;
        bh=BCg6r/1gzUYJOlMTS5Jy76o5qoEAj9zul1+ItPRF3sA=;
        h=Date:From:To:Cc:Subject:From;
        b=UOfs7p7zDdw0aFX5vmrPnkywFL0MTI5fbUIW02qopTq7pV/HexyuFp+wDLlQHYHob
         cmEvieX/QLOujlJQjFsVUZkDa9GExfE2ET0jEGR1kRGFGSbeW7vQ3bpbDgzEwRra25
         qQfEbPUNGJtJfk+9XWO1Sk70Nu87l3HCWIzNXUar+BU7TJIE7nWckAiUyS7sc1aaps
         L1otA9/4IMVE7kizqSaiuJL8MzDtKkBpmgIP7k3jmUHibuWWAkMJUHTB022v3xw0Pz
         pGZA7SJX4CJSnlPPSCcdzBUnCGQtUaeo7IccXZBfW7UM3njBwVdWiJYU07RMwRbKSi
         kB9pvQsOi3vvQ==
Date:   Wed, 10 May 2023 11:18:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: linux-next: build failure after merge of the mmc tree
Message-ID: <20230510111833.17810885@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ljt3I_geK1.Sa7vGXcdfEZK";
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

--Sig_/Ljt3I_geK1.Sa7vGXcdfEZK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mmc tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

error: the following would cause module name conflict:
  drivers/soc/qcom/ice.ko
  drivers/net/ethernet/intel/ice/ice.ko

Exposed by commit

  31dd43d5032a ("mmc: sdhci-msm: Switch to the new ICE API")

I have used the mmc tree from next-20230509 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ljt3I_geK1.Sa7vGXcdfEZK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRa8OkACgkQAVBC80lX
0Gy8tQgAkG/EwMLzl8mKJ4ZYj0TFIbCyHVlrlrqyHP6A/01xRSv+aeyQ2U3wcq+O
nkBA9PYfLVhu/1RYNdUxMtWTocAT1GKmwcFC+ToHfnD/qAz5FaR/w8Z3jt39kBst
vnJyU2ADA7O0yhUq5me4VkdTRYUOcSNTYPDbYGjkwYgiiZ4qgniJl9FLA/7wb6nr
G2LKFkTjvz1OkiszSSnOCwu0Bi821K4v5XntMN53A9KMHT+2kgJEo3ybDIEJmotm
p0FbGtNkppgP/PZd6/qJIonOLiU9mm9zJTnMt9aGoA8jls1QBNgOVtH37VnUefWA
/qRtpZ4sjhjs7Z40ucaMXTlkyFSn8A==
=2IfQ
-----END PGP SIGNATURE-----

--Sig_/Ljt3I_geK1.Sa7vGXcdfEZK--
