Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F4714824
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjE2KpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjE2KpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:45:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B2C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685357101; x=1716893101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YeK4bOaPPVED6M0jo6gE82z2OrZM4hi2gJuygqvi62w=;
  b=YAKy4wEfwTn3f+pZNB5VgiOB0bmhidbVEK93/V7dCXmCQrtqq+V9ybbS
   qO02x/FjJeTVJkVyMfRg+ctbh6OrTQnDsgpow6hQHlqab7iklffz8cJpp
   YzOM7oKl977rDT3O5dT14VlqPJVZaD0hXyM7TkWObEXeCTC2HN0GLS0/E
   PcXJkCfXdZYe29MFvpTgjXGJLFbJEijbr4oteU1Go+J/6v/GTaf+qSqOX
   tjRAUeMok7E22L2zHvSgDvFjJBXm6r+8SQHuFoIIIG4/F5S0YrWEH6My8
   bdJuw3o//2qjcfQnfKEAdeDlGX6T82rGYKPQNkMgwH5E9eq6K9k4F1quV
   w==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="227430189"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 03:45:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 03:45:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 03:44:59 -0700
Date:   Mon, 29 May 2023 11:44:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/6] riscv: mm: mark CBO relate initialization funcs as
 __init
Message-ID: <20230529-borough-climatic-59605cdd65fe@wendy>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BKsJkpcc/h7MB+TE"
Content-Disposition: inline
In-Reply-To: <20230526165958.908-3-jszhang@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BKsJkpcc/h7MB+TE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 12:59:54AM +0800, Jisheng Zhang wrote:
> The two functions cbo_get_block_size() and riscv_init_cbo_blocksizes()
> are only called during booting, mark them as __init.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BKsJkpcc/h7MB+TE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSCFQAKCRB4tDGHoIJi
0qcOAP9bmBs7+ststKrxj2fgL/PLc0wiDSRdWDPIllmdfLdQnQD/XP74ftRp7Jcm
0/AtBFBnSLBAQKE3KzLK1VcCxjrDbwk=
=Cas7
-----END PGP SIGNATURE-----

--BKsJkpcc/h7MB+TE--
