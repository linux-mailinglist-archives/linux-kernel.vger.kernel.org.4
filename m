Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9143F6BA4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCOBsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCOBsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:48:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94DA211E4;
        Tue, 14 Mar 2023 18:48:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pbtb44XjJz4x5Z;
        Wed, 15 Mar 2023 12:48:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678844912;
        bh=ja9Sm8hHcWv45CeBMHVbMbvNxQBLUKYxEQvTPcNJq4A=;
        h=Date:From:To:Cc:Subject:From;
        b=nQBkAtfrWqyeLzLogGjzZlyWUbQC9iLJi8GlaSLR/MuKNbKnFgF//LqimdhORK7JF
         prr2QofeelcLo9h/hV8PmZhALgWkPH1/zehT67jlYjZnwul7eFyLW4zOJ9mCA5kWRP
         koIzrWLCmP70jla/fXVcm3pEdAMj6Dva+aMJSK6mWPoFclsUQV4+nPeGNDJillbxxv
         Lv+BKGNt5MTqRZS8OmXRWoDYFmgTo9s8PuvQS4ZyUUvjCEBcF/uDZzYerGONbub58A
         Fyjl98fI2IGm3ATxiP1uoucyVxEtDcanQLmvZ9BhCu+nTh0dXsbxBxokIdne9x/hAi
         86asQY6h+tzTw==
Date:   Wed, 15 Mar 2023 12:48:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20230315124830.1c2bd002@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.TYFl+Rk6=kL+.ucXFn9ceZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.TYFl+Rk6=kL+.ucXFn9ceZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/pipe_fs_i.h:214: warning: Function parameter or member 'nonbl=
ock' not described in 'pipe_buf_confirm'

Introduced by commit

  342a048d7390 ("fs: add 'nonblock' parameter to pipe_buf_confirm() and fop=
s method")

--=20
Cheers,
Stephen Rothwell

--Sig_/.TYFl+Rk6=kL+.ucXFn9ceZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQRI+4ACgkQAVBC80lX
0GzDNAf/V0Ki+F/H3ADRwIUCchjEx9I0vcxRJQNVYz63pawuh4mQ65iAjzgsQ6Bj
/qYZfRwJ4p92u5+nvH1kNGSIPVua3Y3Z6tBSOoCGdG9uaYBzbVZ+ZjalsZf4Fv5p
HLXYqWBIwfzx4EcaO1fsCDVLhDJ3NpCYUosCsac50t6inMT5cqHL69IbIkUT+Nu5
esojg0Ku8MpljWKSMa9apUgkS4so7g3RF9exdJrC1JZekF6Ayf6jPoB0Xtg9ACAz
QkNYTap1RxTaphGA2ZUTY/yiq4KlY++KbAxCSenWkW+B/beepdnZyStvWjnaq0xG
maQdjTPv8qnkuotb4XX17tqrx57+Og==
=nhum
-----END PGP SIGNATURE-----

--Sig_/.TYFl+Rk6=kL+.ucXFn9ceZ--
