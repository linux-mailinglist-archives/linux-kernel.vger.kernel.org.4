Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7172D4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjFLW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFLW4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:56:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FABE4;
        Mon, 12 Jun 2023 15:56:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qg6W56VCvz4x48;
        Tue, 13 Jun 2023 08:56:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686610594;
        bh=pz3LeOfPo8iuI93nAGpEz5/ad9c/k/eHA7NkntToHek=;
        h=Date:From:To:Cc:Subject:From;
        b=AceZqM86jfIQuQmxXSNlsRSSGRKgipYHA3A+4S8bXWOmk5kB1l0Yri30bFhQO1BQx
         6IFOJeHmNbRAOqaq/nOMkixOtV37os7GZrR5wSzvzYl8OgHgMg/+w9WOWkexL0S6xV
         W+Lpzxeo0qi+Ex7DD6G9sWgeD4Gvy3R0M05s1zXat2mj1WDgdYjKiQKWSd1apoeE/o
         w26llqQz0JB1XYkX7nsyAlDdfAPG6suKcOwnM4PvlQYzuBMWiW781200j+QnryV1eZ
         ejVq/ITen+fRJLoBy0CX2h+E0nyRb08FPWItWpUv8p+kUoKn3Qdbzd+oqMmF6rSxSE
         KJffSZEz+dYiA==
Date:   Tue, 13 Jun 2023 08:56:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the overlayfs tree
Message-ID: <20230613085631.0eb14aa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SYEkPLrltUA69JmO=hR5T2T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SYEkPLrltUA69JmO=hR5T2T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  1dad6bc25487 ("ovl: get_acl: Fix null pointer dereference at realinode in=
 rcu-walk mode")
  8be29d51d3fe ("ovl: ovl_permission: Fix null pointer dereference at reali=
node in rcu-walk mode")
  a38e13c79db7 ("ovl: Let helper ovl_i_path_real() return the realinode")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SYEkPLrltUA69JmO=hR5T2T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSHoqAACgkQAVBC80lX
0GxX4wgAi4+ymaiHyNWutSxVmRfUszUjkX3hYCm4Uk4C9QnZ1McHrPVdG6xYpUwd
Jssn1jIis/P8pe4LZ8Z334zeQU0ShN929sKdFY+m7E3Gg+30jGHCKM0LQpejUOPF
Q0DV02fKEDmu7fdW305as91+8FTUCGQbOiAQA81D567YpeBZ8C8n5C7uLD84bmI4
FPTyDrNE5wLYnxvlD4nfg5PneDeXkeWNvEKb5/4wmQhfkoKGtkmD21sHqVWY1hSD
yDefyogK1a/Rc8i6orDjmXOEDr/W4BI0YKX4G/haxhrUDULJtkT/1sYwefvdEOsq
JxZ//sKOQN/9a+liOOzf3Z4pMY4HNA==
=eHTN
-----END PGP SIGNATURE-----

--Sig_/SYEkPLrltUA69JmO=hR5T2T--
