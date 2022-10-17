Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508B601B16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJQVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJQVMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:12:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23907E03C;
        Mon, 17 Oct 2022 14:12:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrqSZ1wVpz4xFy;
        Tue, 18 Oct 2022 08:12:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666041134;
        bh=AVpql/+TQkHUSe1EuN8BufK4d+yArS35nCjCfOeXM7A=;
        h=Date:From:To:Cc:Subject:From;
        b=EmBYUqe/Fc2f/2DBdfciN8I7G+ZVYVl/FNtRHcjYOU7nFE+UG8mHRGWMqxWj+e6zo
         0kk2ggdun/aEET9HY2V79eo9JTlS03mFh7NHdJvnm/mCg2vCNXMXKs45D31iwMU2s7
         1eMXj2vTduDDqapIQELQVSAhA6MIEJliR1us92jVg7uFoJ6YnnJYaad8CGNfUlW6Pu
         vN0jpT2H2IN4sV2iPAP6pbz6NPxbBIUBiox9jyQSxGW01lEpB5QISpK9VV70adGZEO
         6+voVYWUNBS2i1ahYbt1l0asIfSpr4vFNvuzcbaVgKUT2yxrFD+Ebsc1G8F2neOhrI
         03nh+ZA1aKfFg==
Date:   Tue, 18 Oct 2022 08:12:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the jfs tree
Message-ID: <20221018081212.088bf5f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lbvs613XTYmT9W/eQBwqOHj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lbvs613XTYmT9W/eQBwqOHj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  342fe8606db0 ("jfs: remove unused declarations for jfs")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/lbvs613XTYmT9W/eQBwqOHj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNNxSwACgkQAVBC80lX
0GzhqQf9Gmz02VXr34Ty1YB19mAXvXZZhmOpaSdbSlR2e9JjCf6DVal+Et1DLjAk
N/CemYUV8CRSNaqGFcyf4cs7J01jmiC6qRnUPmwtuowWEYh2LLuTK2nSd+NHZfi6
DPwxga+FZjLWogA866sYCE6QoyLCk3FNef74R9IAY8DBl9AiGKP5DNYWS0P9Y55B
takmnNPIM0ujAUcEDYz8psRE9RM0rWnyYCUloupRy6ehNQPAZYmAsbaxACxGMq/R
8lrXvkjsGRAFR3RR0lBXsB4RuMI+TDcccZHoT8cbSWHzkFChFZnYpmCYQlprbtaC
RPSRX7nv2xnvAbAlZg8wl+iYwES+kA==
=bi3N
-----END PGP SIGNATURE-----

--Sig_/lbvs613XTYmT9W/eQBwqOHj--
