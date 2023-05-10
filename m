Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956D6FD7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjEJHOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEJHOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:14:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10742D70
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683702860; x=1715238860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qXFR+BIP/U3TTlzjbDBkfTuKjPFJ9PK38Gpxgz5qpRs=;
  b=X8nZ+EGDseRNYJjh6TUIfQMi8s2qnZuD0fAzcTCAfVXlkRaSgGTcuiHk
   gQgcBiC8wjsviGjDLyCN5c5ksQJ4M8D4NCbixzs1RxA+kfh9uv1uK8p+g
   x2t9iut5SPkH2NgfAEuq/4Oj2goVRSuXW8SXrTzkOLbf1o1ONhelBdmgK
   /iF4RXHKOKzFxVoaNtVyLcm289aC+cR+UVSXAl9egRgaq0HzqcgHl51AE
   6m7QtjqTBXcbvYFTKtey8jJkC5qogaaNNDRMqcUUvXsgSuLw0fX3EM2YQ
   +mhgVQDI1rcwQPDT0c35x8WbgCv6/zzauT6p75HDCmUiPhvvn/IL7ekq1
   g==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="151272995"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 00:14:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 00:14:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 00:14:18 -0700
Date:   Wed, 10 May 2023 08:13:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     zhangfei <zhang_fei_0403@163.com>
CC:     <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <zhangfei@nj.iscas.ac.cn>
Subject: Re: [PATCH 1/2] RISC-V: lib: Improve memset assembler formatting
Message-ID: <20230510-cricket-dwindling-a35d40f1da10@wendy>
References: <20230509-b0dc346928ddc8d2b5690f67@orel>
 <20230510035243.8586-1-zhang_fei_0403@163.com>
 <20230510035243.8586-2-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cBXCyWD8ANQTX0/G"
Content-Disposition: inline
In-Reply-To: <20230510035243.8586-2-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cBXCyWD8ANQTX0/G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Zhangfei,

On Wed, May 10, 2023 at 11:52:41AM +0800, zhangfei wrote:
> From: Andrew Jones <ajones@ventanamicro.com>
>=20
> Aligning the first operand of each instructions with a tab is a
> typical style which improves readability. Apply it to memset.S.
> While there, we also make a small grammar change to a comment.
>=20
> No functional change intended.
>=20
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Three things for you here..
Firstly, since you sent Andrew's work, you need to add your own
Signed-off-by to the patch.
Secondly & thirdly, please version your patchsets & do not later
versions as an reply to the v1. In my mail client I see:

May 10 zhangfei        (  58)           =E2=94=8C=E2=94=80>[PATCH 2/2] risc=
v: Optimize memset
May 10 Andrew Jones    (  36)           =E2=94=82 =E2=94=8C=E2=94=80>
May 10 zhangfei        (  32)           =E2=94=9C=E2=94=80>Re: [PATCH] risc=
v: Optimize memset
May 10 zhangfei        ( 205)           =E2=94=9C=E2=94=80>[PATCH 1/2] RISC=
-V: lib: Improve memset assembler formatting
May 10 zhangfei        (  56)         =E2=94=8C=E2=94=80>[PATCH 0/2] riscv:=
 Optimize memset for data sizes less than 16 bytes
May 09 Andrew Jones    (  87)       =E2=94=8C=E2=94=80>Re: [PATCH] riscv: O=
ptimize memset
May 09 zhangfei        (  67)     =E2=94=8C=E2=94=80>Re: Re: [PATCH] riscv:=
 Optimize memset
May 09 Andrew Jones    ( 211)     =E2=94=9C=E2=94=80>Re: [PATCH 1/2] RISC-V=
: lib: Improve memset assembler formatting
May 09 zhangfei        (  57)     =E2=94=9C=E2=94=80>[PATCH 2/2] riscv: Opt=
imize memset
May 09 zhangfei        ( 204)   =E2=94=8C=E2=94=80>[PATCH 1/2] RISC-V: lib:=
 Improve memset assembler formatting
May 05 Andrew Jones    (  91) =E2=94=8C=E2=94=80>
May 05 =E5=BC=A0=E9=A3=9E            (  38) [PATCH] riscv: Optimize memset

How am I supposed to know what is what there?

Thanks,
Conor.

--cBXCyWD8ANQTX0/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFtENgAKCRB4tDGHoIJi
0hBMAP0d6q46/8kriiKrrTjdhs3AC87O5BVmNujgDAfo+Bj98AD/X80Lu5zP9oPj
C2xPcZjZNPJ2xwdBfBqAW1oPf4QJmAU=
=l3yW
-----END PGP SIGNATURE-----

--cBXCyWD8ANQTX0/G--
