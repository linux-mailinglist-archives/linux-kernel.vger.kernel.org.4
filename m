Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE66E0AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDMKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:04:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB36A4D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681380283; x=1712916283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p+lOEqmR1XV9AQ9ZNhPLcQlJffKLDBsvUImzEO478Ic=;
  b=q6XlEgkSIpijAkNPfR6nWCQWN0XXfgX4NXVcG70IhSo9417SQHOT4RfH
   hr4sUbiR1F3WROBXGzfgX2KbnUIs/jsGLyFtJS/pCV9v/jD3iXp9CwMTd
   7BzKHTpPox70LIQnmmbwG7jVeuIAzwUhsukilmS8f0aYwkJPG8B/lkiq2
   7AALpkjtEFRqY8QaINSiqMb8Tm5igPve3TDL79wIa7uUotG3Yun0VUuxj
   SUWPmd+SXfC9AY8zRSUJg8klKsveQBzuJAJRTIPOYp8F/VuQvek9awiSA
   SBvYxCFQuvFfsmkHAsVJCcEBeiXoPcA+IB19VH08D31j1fZlQlWouJmza
   A==;
X-IronPort-AV: E=Sophos;i="5.98,341,1673938800"; 
   d="asc'?scan'208";a="146867761"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 03:04:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 03:04:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 03:04:40 -0700
Date:   Thu, 13 Apr 2023 11:04:25 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 1/4] cacheinfo: Check sib_leaf in
 cache_leaves_are_shared()
Message-ID: <20230413-willing-ignition-176ca292846d@wendy>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ZbF3Rs7VX4XZKEm"
Content-Disposition: inline
In-Reply-To: <20230413091436.230134-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0ZbF3Rs7VX4XZKEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:14:31AM +0200, Pierre Gondois wrote:
> If there is no ACPI/DT information, it is assumed that L1 caches
> are private and L2 (and higher) caches are shared. A cache is
> 'shared' between two CPUs if it is accessible from these two
> CPUs.
>=20
> Each CPU owns a representation (i.e. has a dedicated cacheinfo struct)
> of the caches it has access to. cache_leaves_are_shared() tries to
> identify whether two representations are designating the same actual
> cache.
>=20
> In cache_leaves_are_shared(), if 'this_leaf' is a L2 cache (or higher)
> and 'sib_leaf' is a L1 cache, the caches are detected as shared as
> only this_leaf's cache level is checked.
> This is leads to setting sib_leaf as being shared with another CPU,
> which is incorrect as this is a L1 cache.
>=20
> Check 'sib_leaf->level'. Also update the comment as the function is
> called when populating 'shared_cpu_map'.
>=20
> Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers to check if the ca=
ches are shared if available")

Cool, thanks for the updated commit message. Easier to twig the
rationale this way.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--0ZbF3Rs7VX4XZKEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDfTqAAKCRB4tDGHoIJi
0vLLAQDjWmPPYi9cknyfhFnWKQ7O9P4+UusLM7bcX66okm13bgEA7/2zwTqVnmsg
VEuTZ5FGbDTdiSwIFwUHulG8WeJYFwo=
=HbXi
-----END PGP SIGNATURE-----

--0ZbF3Rs7VX4XZKEm--
