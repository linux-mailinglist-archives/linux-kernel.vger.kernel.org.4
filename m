Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A004623CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiKJH3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiKJH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:29:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0C13E85;
        Wed,  9 Nov 2022 23:29:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7D4N1M5bz4xGT;
        Thu, 10 Nov 2022 18:29:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668065380;
        bh=0I3H4V4YKqZP6S+Fe9HrjGaB0ZUQArhZIm8VwpuUsvg=;
        h=Date:From:To:Cc:Subject:From;
        b=EHNHgKNdgh39aQ3nhk8SQC0v5KnNP5COFUz5ZfXDb6XH06mnuCSGHmu/ibCZJ+ExP
         6XwHrUVGAhbi0WddWHvT7wPkSmxNy74oySBOHklno4Znv/o4kyRmV8GjOSpnwowsTg
         8lQIWmdg1PkHpIlotgJ0606hKs0bzc8ofpj1zQpAJDno0h/Ec2uMpnCh/Aiy8pd+z0
         WrA1OF8jEfDXmPXFDl56YvHcuQVQ7Irqls7hWvTXV2VRvsBS4t4OqxiHpAvlfPcHcy
         XLg1ohmV6qW8oVWN3CdLXmKR7i40Ex0yE6fpxNcW6x7RsCbfVEg9FTf6CoQmLoomb6
         d3wcZvQfbJGBg==
Date:   Thu, 10 Nov 2022 18:29:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the iommufd tree
Message-ID: <20221110182938.40ce2651@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MVUTXbsDi83fKOnHfhreezG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MVUTXbsDi83fKOnHfhreezG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iommufd tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/iommu/iommufd/device.c:1: warning: no structured comments found
drivers/iommu/iommufd/main.c:1: warning: no structured comments found

Introduced by commit

  f3873afb9d7e ("iommufd: Document overview of iommufd")

--=20
Cheers,
Stephen Rothwell

--Sig_/MVUTXbsDi83fKOnHfhreezG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsqGIACgkQAVBC80lX
0GyRHQf/bz3pH/eniw+1wfKSy23gJgsvsILfTJw/PzN6VjqkCY/q6U7mkaYhdIXc
BEIwizfW1cW27j2OlH1Nrd5JeviONnQ8QENeZzcLGoV5Spq3i6CA7GKNuvPLHNJb
Mx+/G18ETV4bCaVSJC+BVw/yN1M4/Mx2MjRG+8HPDQC64moIfn9NimvbgzTa3wOV
MH/1ns65677p6X0kPwNwbZqFBbxrjr1L+6Bjm+eXS057QDC1jpo3HbDiwWpNx7KG
MnMZpB1+tEfoEkCJm8HUrW4dpI+W6XhxZSrc7wP8KUZ22w4I+mWoyIn8A9X6px3Q
mDGveqphy1mfM9pqrz17aienlOrr/g==
=gEEF
-----END PGP SIGNATURE-----

--Sig_/MVUTXbsDi83fKOnHfhreezG--
