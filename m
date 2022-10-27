Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C1D610481
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiJ0VfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiJ0VfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:35:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC7491E6;
        Thu, 27 Oct 2022 14:35:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MyzVR0cvcz4wgr;
        Fri, 28 Oct 2022 08:35:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666906511;
        bh=u03Hw1XPYGWHgxIwZ8cO/9jmHawAccFgsbYH1ri92/o=;
        h=Date:From:To:Cc:Subject:From;
        b=ANFUHs2npmsdn05Xdcp7aPidsR+5ZlpiIrX0G4TrvSbHit6ih+OQFrMrVW73hX5nc
         7UiZHjXsNR6XgjcHmQNjbv13nzkAODga47Ygl41Phlr7vEDi9m+T0oTsjAq7g0jvJZ
         qChgxWJ0nPWKUuqQZzT8j6UmcKkXxxuIXISLETBN+IQc4jC1pf7yVBXp6S0By40gTV
         3cFuJO/dd2aUlLMIM7OD4F5orbdwXAhVFk1lcOxm+72Rn1AnLWhGqZDAJ53AFBwDjA
         43JRZoh4k5Tg93IQuKMBS9CCVzWjvhSv14ectEQsBmK32BGkS+O4MTKyC/LHAy/hpk
         eWWLjuA91cgoQ==
Date:   Fri, 28 Oct 2022 06:33:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rdma tree
Message-ID: <20221028063328.29b404bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ff.8dY9gkE_/=ih+30fsx4v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ff.8dY9gkE_/=ih+30fsx4v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  cca19da0d998 ("RDMA/rxe: Remove unnecessary mr testing")
  90f0afc4039b ("RDMA/rxe: Handle remote errors in the midst of a Read repl=
y sequence")
  aba632f6e406 ("RDMA/rxe: Make responder handle RDMA Read failures")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ff.8dY9gkE_/=ih+30fsx4v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNa3QgACgkQAVBC80lX
0GzVOwf/f7WMVhfYtiuKZYgEzg/dJ4SUABRRxxQhjpdD6AwzyU3JYXA3BExeNEd8
xKD7LlBo0hC/L6VHrSlbYQv1ucriZUZk6IChnyzA0V8BReUQeQmDtNSUIvdCTLiy
z1iUbSO6r/QfrpOT3148UjVD6IOLfE6zooXmjWmGkIjVLoW1mzztGucMILYfAESD
NKBtQg/4AKU/8BcwyibE7p5JPKI3mUBJSQJKSsr8IT6AtkRYtpWRsFktAqh1NY6O
Zy/3stikZOI2CE/qzhkqKzOPAXyAfj5suamFps/cYgsIJz7U3BgcoR0nT8YH0Igg
J2lT0x7RFK/7LeFDyzfUi2yXJH2dOQ==
=JE3O
-----END PGP SIGNATURE-----

--Sig_/Ff.8dY9gkE_/=ih+30fsx4v--
