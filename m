Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBC6DEAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDLEg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDLEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:36:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83582E66;
        Tue, 11 Apr 2023 21:36:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px90L3sk5z4xFd;
        Wed, 12 Apr 2023 14:36:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681274210;
        bh=u4zLyPSYAyQl1gxPF0FmJzJ4o1NZ3iG53BFE4dd06+0=;
        h=Date:From:To:Cc:Subject:From;
        b=mMXa+QZnh0Z3N4jE5FqaJDwmc2Jat8QLrb58uPO4UkDEMK4lw22pshBd2+pMnThEZ
         /bbTFGomEIGetkLvPSH5zcQms52qemx9tD/zeDoC9C48PqabWMWDywEMXwZ6XLxXR5
         9rD7nu0oEM69K9nULHieRXEwUVtTyZBPY4NyG1dHS20hYgr14ftr/U48rJD63DkF1J
         VrguTeDc+HiEiAPntY2U1eY/Bi462LSXweFWFjHi6G3Fr+++eV3oDeftxMQuB4UFPt
         t4hyQh5+TU8yCfCCC/PpdnMnf/EVl3Ac97oou3xTIWRN6ZJIUn0uI+6xPXOHPIrhwS
         bzYMTVOj1aJ2A==
Date:   Wed, 12 Apr 2023 14:36:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alvin Lee <Alvin.Lee2@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230412143648.0e13fb50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KMN0PynQyzz0Q0f8LWekEBU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KMN0PynQyzz0Q0f8LWekEBU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:882: warning: Function parameter or mem=
ber 'disable_boot_optimizations' not described in 'dc_debug_options'

Introduced by commit

  d170e938f01f ("drm/amd/display: On clock init, maintain DISPCLK freq")

--=20
Cheers,
Stephen Rothwell

--Sig_/KMN0PynQyzz0Q0f8LWekEBU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ2NWAACgkQAVBC80lX
0GxTuAgAn/OVcKJIEf7NdoQ1bDSA5ZWVT5mThLuGc2LqpSycqrW3hFbNd5173ifE
in0JgViVKVSRf5rf1gb/sJ0r3J7Z3q8ZZADlWsQCDlrZYdpwwDxCayOCNv36hJOI
ms/PcFfhW5y78+OtFbMr7qK/tY1/HXGJf1rtBx3Q/Jg9R/VTtOk2FH48aiRZAAd5
stqSSFOcstTPb4W7Idg3fXQucjAnIACDAsGilzTbLMjBrIaWNnJygAnYmTMse8A4
uN6sPFKO9T/QT+HE023auhalVaPhosVGprNtrrAiDLTT/bNqZflVCvmO9SMrBA4n
Mig+eRmpWTseab5uUZzcjfnWIXTsUg==
=AqvO
-----END PGP SIGNATURE-----

--Sig_/KMN0PynQyzz0Q0f8LWekEBU--
