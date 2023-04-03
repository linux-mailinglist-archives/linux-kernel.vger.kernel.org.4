Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6384D6D3CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjDCFQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDCFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:15:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB20AF11;
        Sun,  2 Apr 2023 22:15:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqfHc5kTkz4x91;
        Mon,  3 Apr 2023 15:15:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680498957;
        bh=UyIoMfxCfU6+yE1bUDqSjuh4no72bD9uFpCgENpQkpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ibQIFpPctPMHH/WGciopeG0oO57qp8kQ+KZkrSHk4qddCGUjfU81q5+KfLeQT7Elm
         ZOHelLj2MXxDQlM8zi0nU2LdpuPdiYUEmoQUCpT5B6ZcBOGElpOX1iahl9iOpohTio
         kFsb0S15UsBbB16GAy9dr4aHmNN5Jz+6br+3R1eWiWE2n794vXDZFe1zgrlP/k/4Cb
         2cpDA8Y0n2lU+c6SpXiXyWVWjR19OpnsvJ+STSYNCGzmkWHUknlCL1fGtktQgdvgi5
         If7kuE8i1nyvAsIq1y7tEp9cksKu0aRBn2cV5xa/GFETEch5t3UOl7lu767671oZLO
         F8fZ3AWpf2Z1g==
Date:   Mon, 3 Apr 2023 15:15:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20230403151555.401ab99b@canb.auug.org.au>
In-Reply-To: <ZCQu9+J8/AhAXgNI@kernel.org>
References: <20230317095025.49aa34f9@canb.auug.org.au>
        <20230322083956.5c051777@canb.auug.org.au>
        <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
        <20230323095437.1ecccec1@canb.auug.org.au>
        <ZBxTyLqkIaoVhIXU@kernel.org>
        <20230328123332.0a3e2b6d@canb.auug.org.au>
        <ZCNES6N7AkskjD0o@kernel.org>
        <20230329100612.074b18d0@canb.auug.org.au>
        <ZCQu9+J8/AhAXgNI@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DPLfQGLSNX.q0_WB1+ICEyF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DPLfQGLSNX.q0_WB1+ICEyF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Wed, 29 Mar 2023 09:28:39 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
> > [On my arm64 machine:
> >=20
> > $ ls -l /sys/kernel/btf/vmlinux
> > -r--r--r-- 1 root root 5209570 Mar 29 09:52 /sys/kernel/btf/vmlinux
> >=20
> > and on my amd64 machine:
> >=20
> > $ ls -l /sys/kernel/btf/vmlinux
> > -r--r--r-- 1 root root 8536946 Mar 29 10:04 /sys/kernel/btf/vmlinux
> > ] =20
>=20
> Everything should be working fine on those machines, right?

Sorry, I don;t build on those machines.

--=20
Cheers,
Stephen Rothwell

--Sig_/DPLfQGLSNX.q0_WB1+ICEyF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqYQwACgkQAVBC80lX
0GzAFAgAgbSZ9uRbgIbqImZXotdIqrPxiAT6kFOKcbVrs1GVwcQvaZVRT8fR74Kj
5nF3KfQLaiTQralpQGhGPZh99Bv0nredIhNtnyUwguC5j38NsAAjLWPJh1GcDvdE
+49ikpVbnEIKculppjN9mOG4qYGlmfHYIr1EV+w7lDImUfP6pPkwCqoSCy+Gm/r4
LUpAGYG65ONAW385dO+L75wyUL9dQwqcx5NY/CNLRVWL/5tbmi2fn7aAkhGDy2Iw
vbcPTUNlIdoV36BgPVlboPuL+os0I/fvAQAf4kSdDP8ogJQZxqUaqSWeTpG+RHuA
gAgfoIuoOK2fxWNST+fJGLkxJBcDLw==
=Ogf9
-----END PGP SIGNATURE-----

--Sig_/DPLfQGLSNX.q0_WB1+ICEyF--
