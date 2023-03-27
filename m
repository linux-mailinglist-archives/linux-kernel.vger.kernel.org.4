Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654FC6CA6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC0OC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjC0OCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:02:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED493C00
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679925766; x=1711461766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZJNfR83lx4nJswcwFr/ia7Rk0WaWuVxn+mINr7UlXo=;
  b=1mG/pKKFjHcFuWeLv+KvUjtuz0F/cDb9ZGufpVq9WRKSPRzZ62Mbs491
   n1eP0MjZtw6nqHD8GWkDnwpcH3CmJ2qLTpyaLRRzzeGdd32D1Sim95eUh
   bRAenSMR2Gqkd79fNghqY/hnW3bD8R4i1OcuVKTYHuZOu9Kfo41/faBJs
   nxeW3BD72j9mFlRjOLIpZu85YDMB4FL5On9w3X2VUMNQh0YlVndK3ja3M
   xXyQqKsoO75LwvISTbL65cDAhkz8chcnT0on0bHbuQUr1ojtfDkWVomHf
   3R+i1os0OTFUIc3yWiRXnrCPmSyF6M9AAziVYrXfGpPJAZD4Bd9K72fBM
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,294,1673938800"; 
   d="asc'?scan'208";a="207440248"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 07:02:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:02:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 07:02:42 -0700
Date:   Mon, 27 Mar 2023 15:13:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] cacheinfo: Check cache properties are present in DT
Message-ID: <8296483f-4056-4e64-890f-3f676edb3c3d@spud>
References: <20230327115953.788244-1-pierre.gondois@arm.com>
 <20230327115953.788244-3-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hgtnu3DfB5qE0km9"
Content-Disposition: inline
In-Reply-To: <20230327115953.788244-3-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Hgtnu3DfB5qE0km9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 01:59:50PM +0200, Pierre Gondois wrote:
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
>=20
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

> +static bool of_check_cache_nodes(struct device_node *np)
> +{
> +	struct device_node *next;
> +
> +	if (of_property_read_bool(np, "cache-size")   ||
> +	    of_property_read_bool(np, "i-cache-size") ||
> +	    of_property_read_bool(np, "d-cache-size") ||
> +	    of_property_read_bool(np, "cache-unified"))
> +		return true;
> +

Rob's been purging use of the of_property_read family of functions
recently [1], should this use of_property_present() instead?

Cheers,
Conor.

1 - https://lore.kernel.org/all/?q=3DUse+of_property_present%28%29+for+test=
ing+DT+property+presence+f%3Arob

--Hgtnu3DfB5qE0km9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCGkpwAKCRB4tDGHoIJi
0pRoAP0WVrUP5UjiaYB8ZCpfCqjV3qY2LjPQSE3Y6IDjDSpf2gD/bopWKFK6af36
f9d0cWw9AtjwFaxEB/HUyCa5Eio65wE=
=4KTq
-----END PGP SIGNATURE-----

--Hgtnu3DfB5qE0km9--
