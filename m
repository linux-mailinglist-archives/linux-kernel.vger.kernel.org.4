Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0C745A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGCKs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:48:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96B4B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688381305; x=1719917305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GElUSEjJgkbqcofvqhL882P3ZXsEhg9Ndi1e2fZzULo=;
  b=s+q6FkrL90IvIvsTXSQZZ0LUr8PAQ8F6F2+cG1jmdrcd0JZGm+uXTOaz
   BGrO3u8Rk0g33j4M4p7spSD3gsFTUwANx8mDTgZ4CS7ff7rZK2iwcqdRT
   ubt0941yOhi1WkzJ+F3ADdTc6j/BsR0uty6g/8Pdsx9iC0SCnQHvT+9OS
   GrbL92VlBoBQj1kr01IKus6rrQ7W/LUxRmphtzUpDurjUVxuaeQCYuiPA
   SVbctdckNnfyzYnrCxXGwSd+lV7kwRntxr3+mMV1VRL862hPq/Gtsdxle
   N1UyAq6lGtOW/dPTjDKgDPZkZsm0NQBAeaAFyRGSIole/R54B0LKJFIqa
   w==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="asc'?scan'208";a="221038374"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 03:48:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 03:48:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 03:48:23 -0700
Date:   Mon, 3 Jul 2023 11:47:53 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Amma Lee <lixiaoyun@binary-semi.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <xiezx@binary-semi.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: optimize ELF relocation function in riscv
Message-ID: <20230703-pretender-sculptor-c76e6d7428f5@wendy>
References: <1688355132-62933-1-git-send-email-lixiaoyun@binary-semi.com>
 <20230703-8fe42edab5ff83cea01db4f9@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BlJnNwQEuty8t1OC"
Content-Disposition: inline
In-Reply-To: <20230703-8fe42edab5ff83cea01db4f9@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BlJnNwQEuty8t1OC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 12:35:15PM +0200, Andrew Jones wrote:
> On Mon, Jul 03, 2023 at 11:32:12AM +0800, Amma Lee wrote:
> > The patch can optimize the running times of insmod command by modify ELF
> > relocation function.
> > In the 5.10 and latest kernel, when install the riscv ELF drivers which
> > contains multiple symbol table items to be relocated, kernel takes a lot
> > of time to execute the relocation. For example, we install a 3+MB driver
> > need 180+s.
> > We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
> > type items relocation function in the arch\riscv\kernel\module.c and
> > find that there are two-loops in the function. If we modify the begin
> > number in the second for-loops iteration, we could save significant time
> > for installation. We install the same 3+MB driver could just need 2s.
> >=20
> > Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
> > ---
> >  arch/riscv/kernel/module.c | 67 ++++++++++++++++++++++++++++++++++++++=
+++++---
> >  1 file changed, 64 insertions(+), 3 deletions(-)
> >
>=20
> I guess this is a v3 of [1]? But there's no change log here to know
> what's different.
>=20
> [1] 1683881513-18730-1-git-send-email-lixiaoyun@binary-semi.com

It's also still got the checkpatch issues (and possibly others) that
were pointed out previously.

Cheers,
Conor.

Also, when applying the patch:
warning: arch/riscv/kernel/module.c has type 100644, expected 100755

--BlJnNwQEuty8t1OC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKKnWQAKCRB4tDGHoIJi
0rzGAP4yGsFWAkWYAe/FI+YHgNsq3eWaO1BQaNBLdLesfizvMAD+Pq0/kv1xh2cr
KSbR74+nIN1TFVixuSIxcxQnJu9FGAU=
=pumt
-----END PGP SIGNATURE-----

--BlJnNwQEuty8t1OC--
