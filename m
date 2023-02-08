Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA368E734
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBHEi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHEi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:38:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51D15C91;
        Tue,  7 Feb 2023 20:38:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBS1h6fYjz4x1R;
        Wed,  8 Feb 2023 15:38:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675831129;
        bh=N2QReVKOeP5CtM2s2zRPf14uo45WHc24/O70tPf/jQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=Wtq8uG8K91BBipjy+WYlLAxYkhJbISlrmgUoL+lSxlHAUq/YZGs22Gy68KzU8kA+0
         fiaXhi2HNqtsv/qBxJG3zxeQuH9JeDougbJ+9dd2MUktGZTCyqApKpyavZ2tDJu2TI
         7eq4qrlKl2uJH467wyt/uqz1suIb1ZwTxuNhwiA9v+8o0ne7wZ6zvDtGUS+KzaWCEL
         qqIx2CcjmnJZUBzf3fPFG2m7V4Xn+COIqt/oG/KNGRtJwYWch3lXCQtS7nJ4xYC4us
         wGLSufPMn68flc8652rQBpvI0whCMrrUOT1eQ4/hnAU6d86J6w7s/jLtd68lhDUmgq
         bIiqGRpTGA1AQ==
Date:   Wed, 8 Feb 2023 15:38:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kvm-x86 tree
Message-ID: <20230208153847.5c89b497@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2ud7VTRlJeDGEYnr_Gd.EB=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2ud7VTRlJeDGEYnr_Gd.EB=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a `different
commit (but the same patch):

  4dfd8e37fa0f ("KVM: selftests: Make reclaim_period_ms input always be pos=
itive")

This is commit

  c2c46b10d526 ("KVM: selftests: Make reclaim_period_ms input always be pos=
itive")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2ud7VTRlJeDGEYnr_Gd.EB=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPjJ1cACgkQAVBC80lX
0GyRjgf/Vv0b+xp2hR2wsFO05yUDwqlmk+jCHWw3XEcvFPVuxlKnhs/8w4yfgQ2W
GFRIjt4JlYfGwjyuRtLtEoL0FQEQjGiHtjrA2NHHi36113mYJH8+Lp83vA62zdhd
Hon/kd15ksBFznKNJDFk1+hv/0w2AXnRif/Ow4Rr03Hee0C3yTXlygiHx8Tz9tc8
QBrZkswLDo+/l2BYWW88KRe/nLsgnfVVXkxTHF3Pyq5/G/BDV0JKCJqnL86BOvQf
b4krY4e/3INzJeecTGUBVob9wfJWfjZzH9EGVEPYfPKBPF9Qnv7gdPl0dHylgvv7
Qco39N65Jf9/AEoWw6+DRoMdduWIrA==
=NAVE
-----END PGP SIGNATURE-----

--Sig_/2ud7VTRlJeDGEYnr_Gd.EB=--
