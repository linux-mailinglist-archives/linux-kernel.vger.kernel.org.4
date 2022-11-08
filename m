Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45327621F45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKHWaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKHW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:29:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9371DA67;
        Tue,  8 Nov 2022 14:29:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6N765YW9z4xTt;
        Wed,  9 Nov 2022 09:29:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667946546;
        bh=R0Nrt+aLwmFltyK+1DTSPxxtz3w2ijtHQ8/Gvop5afg=;
        h=Date:From:To:Cc:Subject:From;
        b=q6HpBRw40X/4sQVBMna8Rp+vEjVev2pdlpAY64yIvPOidLkl6iQFqopL21WWdKpQd
         vQJXhERZmIWBiAzuZC7qB/4MCtOpiwogwaFe4gxAD3yGCu2as05GNbwd0J6wol5TfS
         iIbPFR9iwEJaLVlB+ckYmBRlr2U507mxA2Qj6Pt6llOpmSNSfH5NeZdXxcSe2jVhYE
         j76JmOAE8UAZXZU2Ey2XphMWpW9dOb0qlKgNKAeMNWnSqmAljrCwNucRxYduCzAc5i
         kqSwaUXC3z3zos8OPP9z19Yiaj/u3M3QVZTm+xxPmAEZ9uQgw8/lBe3ZxO0R2QdSRF
         k/wxzoF3ufgKg==
Date:   Wed, 9 Nov 2022 09:29:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scmi tree
Message-ID: <20221109092901.0c748a3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ub9jelDoD3yMmBeJ8gs4rpW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ub9jelDoD3yMmBeJ8gs4rpW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scmi tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "debugfs_create_str" [drivers/firmware/arm_scmi/scmi-module=
.ko] undefined!

Caused by commit

  4ccdc880f1bb ("firmware: arm_scmi: Add core Raw transmission support")

I have used the scmi tree from next-20221108 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ub9jelDoD3yMmBeJ8gs4rpW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNq2C0ACgkQAVBC80lX
0Gz3mwgAhc5hfzMLp3v2E+QVeqT2l+8qUYP1ojBUhHPP693x3bZtG4xVWAbwCeeI
lDHosRPPn/47sB/pJpa7bT8V98+yS7GZgSQsWXh3j2lYC0F11lupsNedL8sZL/iL
sLNaHI4XRt7/U8/uy3tCCejTY1T94yojdNtuVjj54B72trB8UluUPJk2jSE0zyEd
+2NfQpk2PF6sv/FqAT060vU8np6Sx7tLCICRiVK/Uo1Xf5K900qQLi4rYS4G29V+
Ugn/1efBFddtv51g4mafNDnabtAjaGXurJ8Gj7S5Rp8fDfrqlTZt6YDzgxQZ0ekM
rrkIYk6onRioG0jamfZlVPMWEOqlWA==
=KXfI
-----END PGP SIGNATURE-----

--Sig_/Ub9jelDoD3yMmBeJ8gs4rpW--
