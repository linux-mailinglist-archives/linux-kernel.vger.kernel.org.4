Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1774652B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGCVyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGCVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:54:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CFE4E;
        Mon,  3 Jul 2023 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688421270;
        bh=ZJNKlw1eFwjgPNbX5o3mK1GIBEQjlX0bLI1/yWHkyAI=;
        h=Date:From:To:Cc:Subject:From;
        b=Nup8gaZyykqqhtpFb9088FuhVHa0v33w4qU0li61K2RihIcC9WCkzyvBYYuUDaQAb
         zWbh6iqUQyqPJguwc6fcz8ovggfRrjT8YFzI5wIWxjfZAjIx9YtysCp3vlXRtf3xwv
         1GUmEkW7cYQsV6x32YQ2AMwK5tUGtaw3pEoZHf6FmNwCYXcae8Bon575xTO2bGjT7c
         BH4AgjCMSvViE/iWkUKJRZePt0ByBp9VN+Lr7uwsfKB4JbB46VkXjW3t26aDoXml/2
         K8LuT2xI4dgCfIT3WfEKl6hsY7YMigqAF3wuQgMp1qQmnynK7yrP5NzXoC+7sTk08K
         deHhUKV+hbD7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw07n5bH5z4wbP;
        Tue,  4 Jul 2023 07:54:29 +1000 (AEST)
Date:   Tue, 4 Jul 2023 07:54:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Olaf Hering <olaf@aepfle.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20230704075407.1b9483c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QYH0v.xMd64173J/NaXnSdo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QYH0v.xMd64173J/NaXnSdo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  54179768c2e6 ("Fix documentation of panic_on_warn")

Fixes tag

  Fixes: 9e3961a097 ("kernel: add panic_on_warn")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

Also, please keep all the commit message tag lines together at the end
of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/QYH0v.xMd64173J/NaXnSdo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjQ38ACgkQAVBC80lX
0GwvGgf/eiXii7eaCxsp9f6xMbnOjIAZyNJ41c3al1znA89dUXg8ZnR897B+99UH
HAqHbW7aPm+X9h1s1SQ+LX6RSv+3/bg4SdbYT8RBy/QZSon9RJqDgPJLlxvTCmtM
jIUKq+xFdNJnzXMk/ZgfqRTp2d6YO3wkyb2EIYsJcGP6BnDvW6GY7hl0Xx2SCI0s
cN94h95YNM0z+1LSLMu2uF0OTESQC44863+pil1+Xox8rlER4FgqNH9ZrbwU9mE0
RPfiuIH/V2u/biR8dkIcu3rkLodHJH08b5OOb13rvkRJuT68sEpkS8neUXmF6Co2
T1pyVlDIqFMHFV0T2W5Kcmm7U2AdyA==
=H4st
-----END PGP SIGNATURE-----

--Sig_/QYH0v.xMd64173J/NaXnSdo--
