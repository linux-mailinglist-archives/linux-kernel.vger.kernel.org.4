Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653AE5B6593
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIMC1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:27:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CED52E47;
        Mon, 12 Sep 2022 19:27:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MRS6c5Y6qz4x1F;
        Tue, 13 Sep 2022 12:27:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663036057;
        bh=O0UBRh/JKj2cfgD0Xh2XLss1jScWUyYlrf3LDv/g6yY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gA/vdPzXjdVgWzPYMKDuz0w2cBonVX9b6zoT1YPI/5RDJ5WjP7SGTVgB7nURqb+Rw
         5eo/UEermpOxiGMF8JPkPZ2UgMc0X/AcANc7p1KfzIErp3ZTM9+IUZBhh68bQpxaNk
         42fB/ATM2DePxFo7wdPbkrGQ0hcFneyfeMchTwOw3DhPLOXkld1txKNUSKrAF7FnmS
         JqXzjEeYAF/7MmwK83An7k/WfeTGQzhKboCE1c2bJuGh3GRiVz6VQQf0X7HRdkvBUg
         8rkUTWEzcR+J/S90DiOO/+5kLnVThdXOv/vpMeS+gpo++IC7Y+Oe2h77R7tIvTIex1
         l3rrQ3imwJbsA==
Date:   Tue, 13 Sep 2022 12:27:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the nfsd tree with the cel-fixes
 tree
Message-ID: <20220913122734.431114ef@canb.auug.org.au>
In-Reply-To: <2D1DCBBA-FC98-49D7-82CE-9CDA31BB72B6@oracle.com>
References: <20220913102507.3295ce32@canb.auug.org.au>
        <2D1DCBBA-FC98-49D7-82CE-9CDA31BB72B6@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NpK.SyNga.aF8h.P.IqyCm9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NpK.SyNga.aF8h.P.IqyCm9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Tue, 13 Sep 2022 01:47:01 +0000 Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>
> nfsd's for-next is currently based on v6.0-rc5, which does not have
> 00801cd92d91 ("NFSD: fix regression with setting ACLs.") yet. Next
> week I will rebase nfsd's for-next on v6.0-rc6, which should resolve
> this conflict. I will test the conflict resolution with the usual suite
> of NFSD check-in tests before pushing that update to for-next.

Why not just merge the cel-fixes tree into the nfsd tree (with this
fixup in the merge) and not pick up all the rest of -rc6.  Also will
save a rebase ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/NpK.SyNga.aF8h.P.IqyCm9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMf6pcACgkQAVBC80lX
0GxDvAf7BRN9hIkgL469ZK9f5afI+x/v95Ei8gsjbo8GwDHcI2ZTaAJ61A0swVVt
mlXe0s3ztHSnrWewuTxjFDr8nvgiq7iOOCaIbqawtqXdqcvpnjqmBbUEOiKglzOm
9KLQaN91p5kHbZfieg9gsWXJ0nV5OrBltdyVw8xGEx8hGRl1godG7ue+eJE07ZAM
XgHLnZrLEcFMyCcgW/gCUgIIaxiFAMBt15daIJFt+I1fuP82okmvJ04Vx3FCjjeY
s3PDnhXd+QzffOuJif959/GqgEeC/77qTxbDkGFd4Ri74JI3l2QTjGy7UBGNpEcj
pjG3uhf8iAjaRIIoISxorbygC3ZsDQ==
=bW7v
-----END PGP SIGNATURE-----

--Sig_/NpK.SyNga.aF8h.P.IqyCm9--
