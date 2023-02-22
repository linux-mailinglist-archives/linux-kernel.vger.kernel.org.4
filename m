Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360E969F4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBVMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBVMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:41:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625FA38E97;
        Wed, 22 Feb 2023 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677069715; x=1708605715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cv362uPUr3jCMhErDyLuuhUYC3pM4pKuPc2EB1jEUxY=;
  b=PGKsOX4VorEbUx/aU+v/gFOqc3RHf6Z8FQ+/XIha/P/rihGcm7liokrJ
   5jtaAvdPhUAvu9WGI4sTEcm8jiIRtDjyVvfeldDwZzi0cfaghwXvl/yuk
   Iu5xgMebkbniJSFFBgaZ0C6n2BqT0Unr1NRwpqIPAdrZcQ+Yt/50mU1+q
   gcompj6U4hUC8IHQHiFEgp672UPFMUzJ5n9910PBh0WYN7eRLEboRsuEQ
   Zv4YRKedj8wVs5UD4dXMv1QJDIDV3ZCL5anltUu7Q+GaQPYU3sufw3B5X
   f3ThQ04fWMnuv15qfMSGIyL7IAMy+8np6ghEK6lkM41Rr9Kk73ERWUYy1
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669100400"; 
   d="asc'?scan'208";a="202069183"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2023 05:41:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 05:41:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 22 Feb 2023 05:41:52 -0700
Date:   Wed, 22 Feb 2023 12:41:25 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nick Alcock <nick.alcock@oracle.com>
CC:     <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 12/27] kbuild, clk: remove MODULE_LICENSE in non-modules
Message-ID: <Y/YNdSkRnafr9Vg3@wendy>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-13-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A6MmvpIR+3s5tp96"
Content-Disposition: inline
In-Reply-To: <20230222121453.91915-13-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--A6MmvpIR+3s5tp96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 12:14:38PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org

>  drivers/clk/microchip/clk-mpfs-ccc.c | 1 -

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
And since there's no reason to have this split via the at91 tree:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Clearly there's a hole in my maintainers entry for this driver, I'll go
fix that.

--A6MmvpIR+3s5tp96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/YNdQAKCRB4tDGHoIJi
0uToAQDS4jBN3ip9omamYeZl5YP5ggkJm0CAeeoGkzKlh6wuogEAgAfej0BJ1oqM
0zAVz7zCgpejdxMqS4X0dgrCRtMWLAM=
=PLRl
-----END PGP SIGNATURE-----

--A6MmvpIR+3s5tp96--
