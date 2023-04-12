Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853EB6DED0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDLHz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:55:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF55C3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681286154; x=1712822154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L4GRltKsC62Qcydnf2jlGg6qLDDSoBJwtyiadtuogUc=;
  b=z2pDQDv/s+4oidr72Ok4FseUekdLwUoKfBjf3Gw+UObv4M5GC0ygJy+C
   ZolvU8yDTosK3mCQ/ngUxnTZWD8Z+uNCgILt3LRHxuI96RtPhue0tTQlb
   sQCEAiVdPI59eJ8R1K4Ipnpzy/zCIfuAB0SHPM9RzhHKaQisVDpDd2Pjt
   y/M5e4/oAH7cCppXOfrMd1y7FAJdmJr5Iu2UocSVY2QiOFLUiw/77aIZf
   ba8dlKqerdRBILDoBgwbZ61MbZZ9puA+2E6ch61OVCkCeLDbzcqslQC3e
   flObQNTebHAtbi5xpy6yGGjHX3PeaD42w8B2FAC/BpHRbQWbo5ja0uuri
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,338,1673938800"; 
   d="asc'?scan'208";a="220513235"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 00:55:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 00:55:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Apr 2023 00:55:49 -0700
Date:   Wed, 12 Apr 2023 08:55:34 +0100
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
Subject: Re: [PATCH v2 2/3] cacheinfo: Check cache properties are present in
 DT
Message-ID: <20230412-cone-mousiness-23326e149592@wendy>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-3-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tpBqFoyWWsu1/B9s"
Content-Disposition: inline
In-Reply-To: <20230412071809.12670-3-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tpBqFoyWWsu1/B9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Pierre!

On Wed, Apr 12, 2023 at 09:18:05AM +0200, Pierre Gondois wrote:
> If a Device Tree (DT) is used, the presence of cache properties is
> assumed. Not finding any is not considered. For arm64 platforms,
> cache information can be fetched from the clidr_el1 register.
> Checking whether cache information is available in the DT
> allows to switch to using clidr_el1.
>=20
> init_of_cache_level()
> \-of_count_cache_leaves()
> will assume there a 2 cache leaves (L1 data/instruction caches), which
> can be different from clidr_el1 information.
>=20
> cache_setup_of_node() tries to read cache properties in the DT.
> If there are none, this is considered a success. Knowing no
> information was available would allow to switch to using clidr_el1.

Hmm, w/ this series I am still seeing a:
[    0.306736] Early cacheinfo failed, ret =3D -22

Not finding any cacheinfo is totally valid, right?

A basic RISC-V QEMU setup is sufficient to reproduce, for instance:
| $(qemu) \
| 	-m 2G -smp 5 \
| 	-M virt -nographic \
| 	-kernel $(vmlinux_bin)

Cheers,
Conor.

> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count =
cache leaves")
> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@sp=
ud/
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/base/cacheinfo.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index e7ad6aba5f97..6749dc6ebf50 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -78,6 +78,9 @@ bool last_level_cache_is_shared(unsigned int cpu_x, uns=
igned int cpu_y)
>  }
> =20
>  #ifdef CONFIG_OF
> +
> +static bool of_check_cache_nodes(struct device_node *np);
> +
>  /* OF properties to query for a given cache type */
>  struct cache_type_info {
>  	const char *size_prop;
> @@ -205,6 +208,11 @@ static int cache_setup_of_node(unsigned int cpu)
>  		return -ENOENT;
>  	}
> =20
> +	if (!of_check_cache_nodes(np)) {
> +		of_node_put(np);
> +		return -ENOENT;
> +	}
> +
>  	prev =3D np;
> =20
>  	while (index < cache_leaves(cpu)) {
> @@ -229,6 +237,25 @@ static int cache_setup_of_node(unsigned int cpu)
>  	return 0;
>  }
> =20
> +static bool of_check_cache_nodes(struct device_node *np)
> +{
> +	struct device_node *next;
> +
> +	if (of_property_present(np, "cache-size")   ||
> +	    of_property_present(np, "i-cache-size") ||
> +	    of_property_present(np, "d-cache-size") ||
> +	    of_property_present(np, "cache-unified"))
> +		return true;
> +
> +	next =3D of_find_next_cache_node(np);
> +	if (next) {
> +		of_node_put(next);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int of_count_cache_leaves(struct device_node *np)
>  {
>  	unsigned int leaves =3D 0;
> @@ -260,6 +287,9 @@ int init_of_cache_level(unsigned int cpu)
>  	struct device_node *prev =3D NULL;
>  	unsigned int levels =3D 0, leaves, level;
> =20
> +	if (!of_check_cache_nodes(np))
> +		goto err_out;
> +
>  	leaves =3D of_count_cache_leaves(np);
>  	if (leaves > 0)
>  		levels =3D 1;
> --=20
> 2.25.1
>=20

--tpBqFoyWWsu1/B9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDZj6wAKCRB4tDGHoIJi
0gzZAQCtwuxJautzYqFuN7VC/ZYl6n7d0LPrNnGsMKUqwAi5aQEAyhOatu3EX+Mn
zZYrA/9ULoFq3teGuZ56XdEU0BrIJAg=
=GpdU
-----END PGP SIGNATURE-----

--tpBqFoyWWsu1/B9s--
