Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B52A738390
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjFUMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjFUMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:15:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E91713;
        Wed, 21 Jun 2023 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687349755; x=1718885755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o33O9E/sTQij2wF7nfbm1fbzPvGMPtF4b4Czb9FyI8w=;
  b=RGqfVLH+/3qoc7MoF87/Aerln8WiQxRTy1lKKci48pEAd3cgM+CCi4ht
   zb9CP6URTyE0Wef1d2/s2eoyyJEY9vmB63DuIcvq/CzcWAGhHvpt3uY8l
   UGu1pS8VNx3c63mjA1OeGrMCGPqSB4yw3tk4SdPX6ym+6Wbj4OnjMilR2
   YI0Md/5iB98V+xb3ApvmMd5XzU/OvSQQ8hMWxi6soe5ZQP6QRJPtp3lqC
   /xWRa8Z8lrcJq6Lgv6QdnvpA2JiVQzXPG3dWX0U0WZEvJa2GsIMUiViSS
   /K/88NikOMQ5hM3cjvnaN7LU3KSje7KDxbXpF9yU5iOzzEDv/xER+X84i
   A==;
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="asc'?scan'208";a="219694599"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 05:15:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 05:15:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 21 Jun 2023 05:15:51 -0700
Date:   Wed, 21 Jun 2023 13:15:24 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <20230621-attempt-unstirred-567b0352176a@wendy>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n3xCvkrHFE9ObyCr"
Content-Disposition: inline
In-Reply-To: <20230621072234.9900-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--n3xCvkrHFE9ObyCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Alex,

On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.

Thanks a lot for writing this & implementing the feedback :)
I had one or two minor comments about rather long sentences, but there's
little point I think in respinning for that, so I have ignored them.
Other than that, didn't spot anything new on this second reading.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--n3xCvkrHFE9ObyCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJLp3AAKCRB4tDGHoIJi
0mK+AQCazV/48ocacOBemauABiD3W3ckxoRGUXlGgRGjJmhQPgD/Q0WBQAi95q/m
lAjRrZfXGyJ2XQqkfntxou17Ja1gXwU=
=KT1X
-----END PGP SIGNATURE-----

--n3xCvkrHFE9ObyCr--
