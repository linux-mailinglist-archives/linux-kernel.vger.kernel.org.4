Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163ED654FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiLWL0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiLWLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:25:40 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89B23EAC6;
        Fri, 23 Dec 2022 03:25:20 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MuUvS-1orYg51CuA-00rW0P; Fri, 23 Dec 2022 12:24:03 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 833A03C087;
        Fri, 23 Dec 2022 12:23:59 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id DC4E13615; Fri, 23 Dec 2022 12:23:58 +0100 (CET)
Date:   Fri, 23 Dec 2022 12:23:58 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vipin Sharma <vipinsh@google.com>, x86@kernel.org
Subject: Re: [PATCH 4/5] kbuild: allow to combine multiple V= levels
Message-ID: <Y6WPzqCep/ANFzyZ@bergen.fjasle.eu>
References: <20221222162535.1578462-1-masahiroy@kernel.org>
 <20221222162535.1578462-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t7E0gvr3nj9T3Qdj"
Content-Disposition: inline
In-Reply-To: <20221222162535.1578462-4-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:mqtybKQT2OFmeIS+awKVXfL8lxsrLfqhTStIlmYvZTzBDru0gAT
 mCu8ScoZJkKpnhQRd5k9ZnEQNxDd643CqcVrDYeC2HEEfn/gXxeeoYT7f46J/n+alk1TgnC
 7yEWtynNYzn4+EZjSQjod2Y+BBJVOjb16svBjJKZxiREdOBv8+E28ASx+KyBQ9Q1vBA49X3
 92hWpmifvN/HNp2P/Rc3A==
UI-OutboundReport: notjunk:1;M01:P0:Z8CeUknG2L8=;h2YeLjmhzfTiOt8KS9NrmzS9F75
 0aetJI+RlRi8sV2tUWw2zKCUXkBj12tSpFRKgQ+A+R3t2rigKgPYLM0VxFZMkun+aznKAsK1B
 hmXEW87dBREm8K1plHGClsMUR0r/nDckzA30nloAourmlZiwvHdjrO2wL59V3Ceo9Btg4VUrf
 JyeEim30XVGrllY//qpIk1/lQOexkeo7hp1X7FiFbjCivcQ4kVm2t8bQRIe5WdhlSoZ9r+Uq2
 oxJeSIzXrtrwmfpo5clFERPJFi4DLRaAOu2QFEQY8Slvlq+rbvjTI2M2m4WCknY5sHKKSMU4d
 TxOQF8HQPR7iYng40+4wH8VdG3V63zPPtkEFklqm6BL2kbniykbpY7cSSMxec/1VaPmCpfnXy
 /9pbAKYVAIs/ftHmEcQ67SAucGCbAwHr2cDqbu250x6iopRNOhohM/LKv9luS+v2vJeREI4P0
 tW99NHD6bPv6Lgcrhjcr5MlhmzR8FuizfQlXrq4CjxYYKMToOhu/FSrlmpAbjnV92rc5fHMNz
 FA1Uy4pLXz7nRoL19P4YUTEriuN1MsYyCgOQM6/Go5TcyI69IgFHGp4bgNuz06VuNqGZcsNrF
 bpepCUlqjQiypSYRAWFCK8XVfc7IVjhuU48pLS1LR4/EM6ONCBxDLuboX9NCe4FTHQGGPtSXz
 +wrGoJjminBR2l+FgOsD6rAGBECT9RzEt6zDspmMfg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7E0gvr3nj9T3Qdj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 23 Dec 2022 01:25:34 GMT, Masahiro Yamada wrote:
> Commit a6de553da01c ("kbuild: Allow to combine multiple W=3D levels")
> supported W=3D123 to enable all the extra warning groups.
>=20
> I think a similar idea is applicable to the V=3D option.
>=20
>   V=3D1 echos the whole command
>   V=3D2 prints the reason for rebuilding
>=20
> These are orthogonal, and can be enabled at the same time.
>=20
> This commit supports V=3D12 to enable both of them.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile                | 18 +++++++++---------
>  arch/x86/tools/Makefile |  2 +-
>  scripts/Kbuild.include  |  4 ++--
>  scripts/tags.sh         |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
>=20

Tested-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--t7E0gvr3nj9T3Qdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOlj84ACgkQB1IKcBYm
EmkydBAA07bg6V2RFOpUUuRG+RiBQYQrYvqnPXGoXJ4IQa7DUig2k+LLJcrfe7PX
4eqe0bqzPdNolIIi8e8uFyOznmBfV7a+F48pSkJjRpIcsgr7xTOvANcHJ/SZTFkw
PDGM1mqchyDgr2htokASVloh/ncQAeyx0Hf2TJdy/GMXM6bK3i6SPMRxdJWknLkA
85eg+Gnt9brEvMAaqI5sOeWvAy/onoZE10zth5zQ2QnMSMjx5riFHC6K+DOBjka0
VsPuV06OCpVj6uwnMh738F8rPwPv4pT5d2HWjOYx4CMTrksCna+fWiG2Q76ChchY
a93Ru1y1HXdYU/u8QlxOBN4ADm7HI+XF3EVsngkgFLVRx5hJ08a0mrC59YS9iZpo
MewijXE/2ttDwzQ2eETEO7BDOaXtjgTN1D8CTJU7tce3aRnEqgJ60vQSNrjgtKiM
pmFXvglZSa47+m6WFL8oZP372DswfhIK0n+GwpzRtVIE5OHJxnqP778H8MCLmBkp
8CJV1pXl0pEt8nTUhD73L/Ai9ia/PlSkYMXfJV8ySmR+n4Xf7D5D2j5JRuO/mugs
KoIPFYJpWLM1sQJtBAmlyj/ZMSFQ4pTo4iNcTIgNCa6Us4kZ3W8ltt43P+vpOlle
n9oAHgwnR9IXbg/cxV0sPu6WfZc84nq0AW/zshUJo0EQrsuNB5A=
=sRBt
-----END PGP SIGNATURE-----

--t7E0gvr3nj9T3Qdj--
