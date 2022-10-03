Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38355F36F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJCUUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJCUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:20:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645F1928F;
        Mon,  3 Oct 2022 13:20:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhBz30stQz4x1D;
        Tue,  4 Oct 2022 07:20:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664828415;
        bh=Z0DYROTuh3CkW4unvgaleVW78G+I7N7qprjEMxq26qU=;
        h=Date:From:To:Cc:Subject:From;
        b=bQN/G34DTg2JW/NyEIwnPakPktcncd145+K1PHlxJEV6d3rNktjKQIyjzSaF2kYAt
         zlFrU4yabs6Iv8FnlmYlWutW/Q9dbri0vYqyvCvqkDj1s49LUCFz0SiP8p9smJjrPN
         skYhC8JiBmD202jV+5FXTMuqeC3Q73qmMmCc9D4CsR+R5UyHTAbGsQbUUafqwcg/js
         LvQHiWhHUGczkSeCX7z9Yc9Wffz3jxegv6d5Ro5mwjXiaZPc365C3jHu5tls3VVYut
         w8DabtE58xMTo09MpVxMYk2DN0rkpZPDP/+DC37m6sDKA444Ee/vzRY4LZ5J5rht4a
         VzDr190sFEnDQ==
Date:   Tue, 4 Oct 2022 07:20:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20221004072013.3d2f395b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i98ZEcfR6nNDKu8lbhc3Q.C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i98ZEcfR6nNDKu8lbhc3Q.C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5b4e447a70d1 ("f2fs: fix to account FS_CP_DATA_IO correctly")

Fixes tag

  Fixes: commit 040d2bb318d1 ("f2fs: fix to avoid deadloop if data_flush is=
 on")

has these problem(s):

  - leading word 'commit' unexpected
Fixes tag

  Fixes: commit 186857c5a14a ("f2fs: fix potential recursive call when enab=
ling data_flush")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/i98ZEcfR6nNDKu8lbhc3Q.C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7Q/0ACgkQAVBC80lX
0Gw8Igf1G7CGVGVl4BzEeU5RicTQeqqjvEJ8Gmjh7x321aXoqlBuRCNYio2wEDc+
9c3bUinrw/LzK/rhOrh5N6rFBsiJq7D+mAqmZOkis2/kyMrbTDm063bRbApvMuHW
DoL9RZmCB3IzdIH+SVx8vHvAFAi+8mCNWZHkOszQEd7RUOYr+2V1cSwyGpJWsPTt
cCmTCv7qjGDBCpBFGtkQztx+a7WqlPorYgeHbv3XacCFTiOMKWNlcP3dtZ+tOvdG
IFNDEaGiiTlaQzh/zVPwirmQ+yDV8eAkuqiN8o4aNfk5LJ8MWQPu3bhBTlluwBVf
W74cVR3tkMcDd0KZ7UjWUY9bflec
=aSGA
-----END PGP SIGNATURE-----

--Sig_/i98ZEcfR6nNDKu8lbhc3Q.C--
