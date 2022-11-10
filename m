Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58FE623C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiKJHXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiKJHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:23:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32345F92;
        Wed,  9 Nov 2022 23:23:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7CxM4X8Pz4xGR;
        Thu, 10 Nov 2022 18:23:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668065015;
        bh=eCgZuOrZeK3uav+U6LxiRcLS2WwQlJr1zG7pU+NFb8s=;
        h=Date:From:To:Cc:Subject:From;
        b=ocnQ4Z9/9AqI+YFp2ZH/ojygbUHgVs4UMtctC40pD+gwCIRpYfxw0LMgx+F3X9QW4
         gcaueR7pakFoLv5y1R5IkgPagDTJAbevNdU7djJlbv8f2o2O0IaEN4mgQbmQMD4jKb
         HcVURZFehtGVfUGCkqinMEQRwxNpkFh4gjztMowHg63s3/zu0s8+P7GkoB2jIKI8HS
         z8BpgtPBiDJrimwG/mMyR5WdsT0jYjOFxRXmHFDz3/DCyVL/OpAcw9WYCz+JLDX1kL
         7IXD1nsBY3w0/5FVBfg5Tdc+8T01sjaB40NkMmzdI9qPo+66Jou/6wY4uKFzE3MBFZ
         7hs0Q5Ypt9a3w==
Date:   Thu, 10 Nov 2022 18:23:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dillon Varone <Dillon.Varone@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221110182333.5b590d8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ms1LLnaW_=qH1evLk_pii9L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ms1LLnaW_=qH1evLk_pii9L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:869: warning: Function parameter or mem=
ber 'min_prefetch_in_strobe_ns' not described in 'dc_debug_options'

Introduced by commit

  01c0c124b9ec ("drm/amd/display: Enforce minimum prefetch time for low mem=
clk on DCN32")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ms1LLnaW_=qH1evLk_pii9L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNspvUACgkQAVBC80lX
0GwlbAf8CrFOIfG3AJVql+81Oa2N5iYuzR+fvUi5DqATWI9OBThAP0/aWpXLdnQp
LY9uHE34PIlq9To6ruMCGyW6wWZmF2RkTWHvcMLU6ZVUZdXDvEsHoTTDMDfcbH+U
CRrQD7Aqibp+euy/Dn/1yVPHisbJdxGtV3mARgUCPETr/+CnYMFBqFzUz9k9eVEa
ce73i4JuzjjUucgkTozg7ZXqOFs3UejAgHD+8RoVVY/kSv0bJo4HLJSQ7SI5Y2bD
rFnKAxcedfjd5XfpjpzVrjhG73EAZDV2oYMTc0FbIIobg5++hlkRdaWF65L7PadJ
3Ui5FshtUJmuXwjX/Cv9uEU87z1WQQ==
=nJjf
-----END PGP SIGNATURE-----

--Sig_/Ms1LLnaW_=qH1evLk_pii9L--
