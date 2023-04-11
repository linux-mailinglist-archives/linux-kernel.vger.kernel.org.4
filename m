Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78516DCFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDKCqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjDKCqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:46:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4067273C;
        Mon, 10 Apr 2023 19:46:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwVZz6hLJz4x84;
        Tue, 11 Apr 2023 12:46:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681181164;
        bh=6w26UeAKdqfmldQqm2l4LwaTlZAHRLoOxve3bBHXDpc=;
        h=Date:From:To:Cc:Subject:From;
        b=mSyn5WWkou3kd0Mp7UeiakL+DeU7Jj6dJvl06NZru8VksDHnCwQsSqZJz1ipjaAvx
         lw+7bEbyGsVRDakTzSEKVhDrTV7X5KgxK/3euw4VosgsYHEALxjuWNYZuRC9xMk5gm
         5VtHG8AQUft1C496QiIcrxHJAnkMhVxzJoLInDZYPtF2H+MKiiS4c6bQ/sv5+c6XHi
         YDxbvV2uDY8OwKRoXvuyw6EaYWQc4kfOf3Ng6Xzh7jK54+46A1sZMcEZQwfYM3QnYG
         IcmmI3V4/kkHJYgHvTrjtr0XhKdJ9UlgMbQrHfLJfJd4giVzJa7mKrSfDNeOObOZIK
         kHjL0yQfLgKiw==
Date:   Tue, 11 Apr 2023 12:46:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Florent Revest <revest@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20230411124602.5938513c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NJoAkyKm1Eeyr/M3=2h815V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NJoAkyKm1Eeyr/M3=2h815V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  kernel/trace/ftrace.c

between commit:

  2a2d8c51defb ("ftrace: Fix issue that 'direct->addr' not restored in modi=
fy_ftrace_direct()")

from Linus' tree and commit:

  8788ca164eb4 ("ftrace: Remove the legacy _ftrace_direct API")

from the ftrace tree.

I fixed it up (the latter removed the lines changed by the latter, so I
did that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/NJoAkyKm1Eeyr/M3=2h815V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0yeoACgkQAVBC80lX
0GyRFAf+JYZm3u4NWMRfDV2QPFhRGZRDsyLG4tPFWcRsfPH+gcqhKFgW03lqnnm8
016XTTCR61YggjbeFWTEWUkiE6r6Hp9JvgsIrwZ0LnR+twW7hsaVnd0C/v9lOlwk
mE7vcYn9/h7mzKfSAYkzhyv49edtSn+kUynqIjMdEVSGCP3OrE4c7zx/jQlYH3CE
/zXZMtpW/2zHRSF72YFzpblnmwYq866cK2yuOyxdGFxocBxOR8qcdN0AnvV9BWu3
3W7AF90HSGR3COz9NBEIrXgnWrSW/hjV0or3xlqoGb4H90zF77cRcPFXWSPeAomb
NEHriRdQF1+gcZwjgxbu32ZwsxCZxw==
=v2uf
-----END PGP SIGNATURE-----

--Sig_/NJoAkyKm1Eeyr/M3=2h815V--
