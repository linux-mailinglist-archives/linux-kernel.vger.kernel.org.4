Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F45F370E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJCU1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJCU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:27:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AEC2F642;
        Mon,  3 Oct 2022 13:27:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhC7f18Sqz4x1D;
        Tue,  4 Oct 2022 07:27:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664828862;
        bh=iHxonACJpfGxptPy/AuMYiZVLCodid0kRjg2Mnt+QOo=;
        h=Date:From:To:Cc:Subject:From;
        b=Mrz/vv3z8ME75SUdPxBdTetw9OMckB9qBHAwQpQIWRE9TSBk35vJn/yFlGameYE4f
         hIesYxLWqP0wgi7XBu9nQ19cM0h1lImw7EcYd9sLMuQ+3PFzs+NTvEHiM4knWOdlSP
         QOAc9WR4qM1DpeUUJhIEoGv/B8y95i7Bf4uaVIdppayzp3ViH1arGmt1PN2qPetPnM
         a8GYXQWM9oD+YVvKhPN9wZrKCUZVugO3nFvwxuo0jz+Vbs6DNKeBsx/ffahl6PMeBk
         5+YfGbqD7/YCUfssCi8kylU246vIRRZSArxRTuC00M1dypIE5nOAlfrS2Pw22aH/vx
         ZzIJ9xg0LIKCg==
Date:   Tue, 4 Oct 2022 07:27:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the apparmor tree
Message-ID: <20221004072740.5fb5f841@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q7F_Nzp+1URqUA.Vw8u.lTL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q7F_Nzp+1URqUA.Vw8u.lTL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4c212501f8c9 ("apparmor: fix a memleak in multi_transaction_new()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/q7F_Nzp+1URqUA.Vw8u.lTL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7RbwACgkQAVBC80lX
0GxQ0ggApZwG6PSuTkUTyio0jnbI8ldvOlWTrp/R1A7/SygkPNnfpuynKNeAQsPo
wuv6GzbAzMs4QaSo3V+xHlB3VPNLIrkS7OFeS38YyABzcVCWEScRaCea3gjb2Bpx
53zg0jvdAVJ6C2AAnWT1UQo3/Kcs0cL45c2DBrZ02Nt794FeVBtweEx3pPdPhd9P
lquDuBzQIxZRaTkDFAQXKyvsEITiQLcDp7UCY6fQLqvoz1WlsKCX5I0isddSvgyY
3PiY7WMYE3Y8en6ngQSFiqxfPcprBgtk2E+9exhWDcmOBbAtZDhqoaVpCsrPe2f3
TwFZYlGXrhawGHr1D12ZupFY/ui1aA==
=7wrE
-----END PGP SIGNATURE-----

--Sig_/q7F_Nzp+1URqUA.Vw8u.lTL--
