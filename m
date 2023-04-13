Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB66E0AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDMKDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:03:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1835FE5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681380190; x=1712916190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4MzuhZHBbPmQVbijtFmXO+9tVxRJdViVCL5UWZqqFdA=;
  b=kh6UdKuUDoS5BCnJ0a7dV1NoSKJEx9OK3slGPAALJQeL3kg7s5Dnn2NQ
   dtRJNLh6mMuAXmUD81O7ZZmLTWP5RCRulOlzlkS3eHP5TIcpjVexiYtlo
   mvT3Io5vjsHzQFRJ6/3VqmRv26F9sqk/50TEJxCqtvHeZj9L+evrjdFnC
   3exPA/H80KNSjEi0DNIVqwcBDblKwaqb2qsUd3qokffB6EONJ0pkVl1oU
   6qj0H6OUzZXzzTsS7pO/EZK4F5SXQOa/VBtiWIOnI/KvDSb9foeYtPtJY
   my0D1B9Z+BbrqIa5catngBdDNGpQEnyDMYzEebH0Nk05qkBZRq951yKPj
   g==;
X-IronPort-AV: E=Sophos;i="5.98,341,1673938800"; 
   d="asc'?scan'208";a="209373248"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 03:03:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 03:03:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 03:03:00 -0700
Date:   Thu, 13 Apr 2023 11:02:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>, Conor Dooley <conor@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 3/4] arch_topology: Remove early cacheinfo error
 message
Message-ID: <20230413-prudishly-unruly-090f5297fd54@wendy>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ual3BbTya047iMjD"
Content-Disposition: inline
In-Reply-To: <20230413091436.230134-4-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Ual3BbTya047iMjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:14:33AM +0200, Pierre Gondois wrote:
> fetch_cache_info() tries to get the number of cache leaves/levels
> for each CPU in order to pre-allocate memory for cacheinfo struct.
> Allocating this memory later triggers a:
>   'BUG: sleeping function called from invalid context'
> in PREEMPT_RT kernels.
>=20
> If there is no cache related information available in DT or ACPI,
> fetch_cache_info() fails and an error message is printed:
>   'Early cacheinfo failed, ret =3D ...'
>=20
> Not having cache information should be a valid configuration.
> Remove the error message if fetch_cache_info() fails.
>=20
> Suggested-by: Conor Dooley <conor@kernel.org>

Not that it really matters for suggested-by, and there's no way really
for you to know, but the corporate overlords prefer:
s/conor@kernel.org/conor.dooley@microchip.com/

> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@sp=
ud/
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/base/arch_topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b1c1dd38ab01..1f071eaede5b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -843,10 +843,8 @@ void __init init_cpu_topology(void)
> =20
>  	for_each_possible_cpu(cpu) {
>  		ret =3D fetch_cache_info(cpu);
> -		if (ret) {
> -			pr_err("Early cacheinfo failed, ret =3D %d\n", ret);

Hmm do you really want to remove the print altogether? This can fail
with -EINVAL and -ENOMEM too, so should we just check for
| if (ret && ret !=3D -ENOENT)
instead, since in the other cases it really did fail?

Cheers,
Conor.

--Ual3BbTya047iMjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDfTRAAKCRB4tDGHoIJi
0tYkAP9yLlzQHvQg1adZ0A+5pW0ajLaHO2FY8QNfvn4cQFWuWAEAvznI8IVt+o8u
oUW6Cwfdejb70Uknvd2u4ISyC6AcuQc=
=5ghb
-----END PGP SIGNATURE-----

--Ual3BbTya047iMjD--
