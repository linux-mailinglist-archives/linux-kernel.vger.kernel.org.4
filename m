Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407B6A4322
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjB0NnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjB0NnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:43:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BFB19F39;
        Mon, 27 Feb 2023 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677505398; x=1709041398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B8kKgrBjxWQyCV0wZXde3NVGF5SDI0kmpRoxcky0ObQ=;
  b=STO1rlWWvlglTb0fpPF8CIZC75XILfQ6S5hwgU3CklD2PCIr9vnFliD/
   1qLFvtVOu4FPQt+uqXeAf29LkFzPlAD4f8xv4bO836de9R6Nzv0NBEos9
   uqB+J9Dl2AMCs7JljUezv+mmr1h3xZAEeSIj75IdQQbAG+FhIyvyxmBaq
   Jv9CgdwHa996WMxlw0IU/vhBj5A4pvA4Bto+CUDduToUFbCe8LftcSzkz
   FVZmN0yNlKijiTFRqXKi+mWG2I5EFkjniqe5ir6LsegPGth+baHlowXoI
   8AJMlHg9bKy4/OE7zp/THCu8USUcwmeJQt7A+y9C63+rmsR1nipVrxlla
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,332,1669100400"; 
   d="asc'?scan'208";a="198931385"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 06:43:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 06:43:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 27 Feb 2023 06:43:13 -0700
Date:   Mon, 27 Feb 2023 13:42:46 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <nathan@kernel.org>, <llvm@lists.linux.dev>,
        <ndesaulniers@google.com>
Subject: Re: [PATCH v7 1/1] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <Y/yzVv717htZLuRY@wendy>
References: <20230224100218.1824569-1-alexghiti@rivosinc.com>
 <20230224100218.1824569-2-alexghiti@rivosinc.com>
 <Y/yilORflGv3vXjX@wendy>
 <CAMj1kXGCkqpHY7rHZv0EFKhPNk6jpbh1OfG_Jm3vSW8c5Y+9_A@mail.gmail.com>
 <6bd8012a-7311-7956-b0ae-966b8534a64a@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i8ZwX1OEi/syzAPO"
Content-Disposition: inline
In-Reply-To: <6bd8012a-7311-7956-b0ae-966b8534a64a@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--i8ZwX1OEi/syzAPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 02:27:11PM +0100, Alexandre Ghiti wrote:
> On 2/27/23 13:56, Ard Biesheuvel wrote:

> > Note that we switched
> > to --orphan-handling=error on other arches, as the linker sometimes

> It seems orphan-handling is set to "error" only when WERROR is set (see
> CONFIG_LD_ORPHAN_WARN_LEVEL).

My CI explicitly disables CONFIG_WERROR for allmodconfig builds so that
it can run with W=1, it is indeed set to "error" for regular
allmodconfig runs.

Thanks Alex/Ard,
Conor.


--i8ZwX1OEi/syzAPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/yzVgAKCRB4tDGHoIJi
0v7sAP97bImU6hzDN3fw3MI74GR1HLzo1JA7yvIRvToGW+BFVQD9E0SqjMsSvsa0
8IM3znP8VY/yIXWltmbmNqpvKDHp5QI=
=46Kj
-----END PGP SIGNATURE-----

--i8ZwX1OEi/syzAPO--
