Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E872B12B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFKJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:31:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEADE7B;
        Sun, 11 Jun 2023 02:31:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qf8hD3ZrLz4x4G;
        Sun, 11 Jun 2023 19:31:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686475868;
        bh=Xc4/KmoIGQMXgxjfsRQf8lIozPiWzVqVF5s9/Amf1+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SSrCj5U+vUTvHPmhiyBl/27zuG+O3m8oNpL8s2fL14Qigmo2R0y3A+Fv8uq1BmWFU
         DPEzZqhNf6QhIUVEjKnk3r9AaQP65TGaKCI+tdXL6C842w9VRLj8AW5MohW/d46m9/
         A1TrLh/uuBpy6IX3F6mZhR/mKShVXn4k6g2iybMr0ilhuh1w45AkEnMGtJis5vWtQC
         wj7++IAXCKIQQLaAvtB/fRzVLksf0PB63jaZ2huisKyh8EKnYUIECbe6yAGIk0olw8
         3L+JI2jvPXBYsXpsRgWyI/H+n7Y68wKlh6+rf29jzUgj5Jd0+BY3p4+UQ+Kj97mz6F
         UfxGz0FVMi7+Q==
Date:   Sun, 11 Jun 2023 19:30:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 9
Message-ID: <20230611193039.6c8e8a71@canb.auug.org.au>
In-Reply-To: <20230609140618.532c4bcc@canb.auug.org.au>
References: <20230609140618.532c4bcc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u+EWinwL3mvVZK3wd.jgLtK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u+EWinwL3mvVZK3wd.jgLtK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,


I forgot to say that there will be no release on Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/u+EWinwL3mvVZK3wd.jgLtK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSFlD8ACgkQAVBC80lX
0Gwz9Af/c7GacFv8Y+VkfgItURyKZgyzkW9HYvqyqlApUsFPoNKzJE5nguyiYWcs
U93B2cKMxPCuD28AeW3tA3CzD2WsKmwk38SFje1/Jxj2wEemK/CuTPrMZPKDxLT1
3LpOwwSXXTZ9/BDpmZGM5MhVPLyxGuybfCg6lnL2hcFo5QcHQ9UrZB5fZtIUM9vD
lvhRh5eXGnLWeJ8Q91fvASBu8U34dzKt9Rvd0AR07CemlZ1ES78rKuyAO6DB1C8J
ekhm/+5CWVDdwCDs5HxUv6h1nwgQuj9FbZDiIBJD5GaK3crEgFMQoUkhpOIduaV2
HffXAxLEtlw3QNhCBeUlRQ50UkQN6A==
=rR8a
-----END PGP SIGNATURE-----

--Sig_/u+EWinwL3mvVZK3wd.jgLtK--
