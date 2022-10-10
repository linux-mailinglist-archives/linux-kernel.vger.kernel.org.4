Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6545F9752
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJJELS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJJELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:11:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC774E627;
        Sun,  9 Oct 2022 21:11:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mm57d6ZvKz4x1D;
        Mon, 10 Oct 2022 15:11:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665375070;
        bh=7he/dZ/InMjVaKiYvJ41gnPNRto+T/lOsjnj9yh1UTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rZLqLtYfTPgIX6ykGbKlxgfXgEPOavmvmvpYBONC4al5PtPkITxaej1NpXSM7VebL
         JXu8boaYArv2/MD0voB1UZzNL2mWd+/qslmwyytg6W33IW0O/onVluSIfmhzWKRIrl
         UZUU7/CKnSEwdT9Oy0/hES56BW9BoedArM4NY74nQFwtDAlPoswIt9Xl/z9ZgwR4SW
         LfpoQL72uvVPPLz2wK6tF3Bxb59ibuQar/RB29AcTILg+aq/08si6vCQ9rdRgNxx1p
         ztb8JF3Dw03KoMs4e/yCmX+XldvUWf4ZjrdHgebv9LuMpnJi+koUMEeVm/96pmi8mH
         AXj2YGyLgR+FQ==
Date:   Mon, 10 Oct 2022 15:11:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning
Message-ID: <20221010151105.0504dfa2@canb.auug.org.au>
In-Reply-To: <20221010144134.1a806e7d@canb.auug.org.au>
References: <20221010144134.1a806e7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CqNLEnvO1zXILcUMQaU+_l1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CqNLEnvO1zXILcUMQaU+_l1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 10 Oct 2022 14:41:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> My linux-next builds have started producing these warnings:
>=20
> ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissio=
ns
> ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissio=
ns
> ld: warning: vmlinux has a LOAD segment with RWX permissions
>=20
> I assume that these turned up now because I upgraded my binutils to 2.39
> but I have no idea what the root cause is.

Probably a false alarm due to me upgrading binutils while the builds
were in progress :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/CqNLEnvO1zXILcUMQaU+_l1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNDm1oACgkQAVBC80lX
0GzcVAf+K92W9qy8jkZhJnuFwTC1NY9zFYUTdzU7CVkDxRbxEI4jock6OG1IDBJb
OBKQxsf7iy1oJadDe+E+nnroMEKB3VmiOJPgKw1qPpWXBUAwZKA4kx+FIon8IpMb
3tr7CrREqxvMBiGGXDGvmJGKBdFs7kwABps6WTsz8c+1eth7veQim+vMXbsvAXHz
W+IANhDzVY8rMvVkwqj9rGGjIVuin4WGHA28ZfdkvcDeBDckwpLNUJm6wdaMS2b7
AfxV3d3YX8r12a0sef9ziVvcru2GVi2BTq98jSTA1o4gRjjtdTqHW8nAc4R4N0kR
H6NYtMdxynCCdLRQHZwKXdDMcHWbeA==
=pumt
-----END PGP SIGNATURE-----

--Sig_/CqNLEnvO1zXILcUMQaU+_l1--
