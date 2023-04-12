Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E36DF427
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDLLsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjDLLsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:48:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496A7D8B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681300094; x=1712836094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ILjdmyuPTkYufkBcTi9/UCiMAmeCostpkElpj9B9nh8=;
  b=uapBjbBPZHnJLXJnjQ5rN8EaGoQBTqxH2wWJtgjhJ/kyELqs0dhmJvgv
   yv68kLr3DckxUGZzU90Sqs6KSAC+rYb/mnNIsGsM4ZdK5YJ2fijLJ6Dwh
   itJDlzG73bJjF0QEoLRkd0B4JOlh0ybxELmPCGJM26U8KPbFU9TdcE0QO
   qEWsphiCdCXjwuAP4spwA2AN25O9hupz7UplD5bJQF/OrKEsEFnsIsFZM
   DDNTlcFe3V7ymtV+11p6gCO5pFdldjLYkUz5J748UZmIQWNcmsmTOtRJB
   ZhfkElHEWgYKJdD/uDI9ciUV/HnbYeYqLzJoXmOG1LrX2VXxVJCSlYe7f
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="asc'?scan'208";a="210041997"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 04:48:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 04:48:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Apr 2023 04:48:11 -0700
Date:   Wed, 12 Apr 2023 12:47:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 3/3] cacheinfo: Add use_arch[|_cache]_info
 field/function
Message-ID: <20230412-femur-aspect-b54b10ad9fd1@wendy>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cj6q1gBv517zjI8o"
Content-Disposition: inline
In-Reply-To: <20230412071809.12670-4-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Cj6q1gBv517zjI8o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 09:18:06AM +0200, Pierre Gondois wrote:

> +static inline bool
> +use_arch_cache_info(void)

Tiny nit, why the newline when `static inline bool
use_arch_cache_info(void)` is only 50ish characters?

Cheers,
Conor.

--Cj6q1gBv517zjI8o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDaaawAKCRB4tDGHoIJi
0jNuAP45OidWrbm6wqZLKKiE+eYftJ727CLB9sYgqwBswXbJCgD/b9AHSb/U++JU
5S7bSe5Az8ud6zcuGs4ZQ+wZxleIGQo=
=FEpD
-----END PGP SIGNATURE-----

--Cj6q1gBv517zjI8o--
