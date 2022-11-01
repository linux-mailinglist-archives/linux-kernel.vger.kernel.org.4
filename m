Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD4615442
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKAV2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiKAV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:28:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDAD1DF2F;
        Tue,  1 Nov 2022 14:28:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N236c07kkz4xFr;
        Wed,  2 Nov 2022 08:28:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667338120;
        bh=begiQeirg8nUPiZn4wI0A7c46RT1wVmZbLG90APn0Yg=;
        h=Date:From:To:Cc:Subject:From;
        b=cGW4why/+Ah15TLjY/7yV7X1577SEcvOeTtdmPTCgORrMMLjr3OROj+5YS3Bhp0Hi
         4cB5Qgu2LGV4Y7/J94zGbJBOgvMgim52WgaJ0m8mPjcXJDEL+S8hm2RG1qYnJTeKOq
         8r05f//g39h8QelcaPwu8Yrkel/WLIgmHB3wmMN7gt0o2Xiz2p6lr6w+WN5WnXTsW2
         1NPTLAiUA39oMRbDQTcmTMfi7RfNfw+6c1SzHZ1A/FJyRRikbH1zc/s3PQ/2GLrhEE
         Js9zJUGV165pNcNTo/7XnK7aiNvSG2oZwq0qbuws8Hd+nz/mUUTPbGCmdSvko+CCRZ
         5ioodo/1OVUvg==
Date:   Wed, 2 Nov 2022 08:28:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the apparmor tree
Message-ID: <20221102082826.0541eec6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0nVuu_HNwXIh2WZWD2glVLR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0nVuu_HNwXIh2WZWD2glVLR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0fc0401eb24c ("apparmor: Add __init annotation to aa_{setup/teardown}_dfa=
_engine()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/0nVuu_HNwXIh2WZWD2glVLR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNhj3sACgkQAVBC80lX
0GxhCgf/QtjtIv3sC7uqNfE7p08DPtzs3JHsj/cPe0dYaYU81ziOOofA6DT5J/Ah
PHMkwDGK6TlolaQJFzhLWvvMGwePZl5k0QSpIwZY8LkGZBlN/QCCL1CDoSzoVuBA
CzWltahgh2KWah51PQmemRX5/43H4KmtLG+P8QaSkMIT1wM6gyRaWCDoWXyx5U+c
HTHCbQycpoZ2yDGQpiGYftiEUnWZsxoR+T2KF69H6H67Oh9ZkCsI78XBIItWcqol
kLOv6WNC0H/ZtCeiFQ+0+Zb4sJcDiZDPer0wdSWZcFtrqy2yg/GBD3CgGZLkIuBP
a3VQVjQW3ACBRDn4OTiMBwaQg2Oi+g==
=iXA8
-----END PGP SIGNATURE-----

--Sig_/0nVuu_HNwXIh2WZWD2glVLR--
