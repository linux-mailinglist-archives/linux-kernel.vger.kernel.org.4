Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8AB6624E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbjAIL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbjAIL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:58:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478E1A051;
        Mon,  9 Jan 2023 03:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673265512; x=1704801512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CVmhaM3jEhg8fncm+fzD91Uf6V70xL+ZewS2UOQLFbM=;
  b=OnzMdzrfBIVSsyo3f02NjYE9rfhXwfyGAvJH/NJF4LSGNhWEpVMTZ0cE
   lg3eVK4gEwqXCcXegEkOu6vFwPNmCDIUsfn4jGfQpiLBoI9a1LK4I5Khs
   iKWnnHOJMerS7FMk9J/k+fiUy1JqMc21RumNr3aLhQq65ndpAWUPpG+vw
   K6CtWGukLpfmEYr8PQa37cokXIfYmprZqNBE/n+70x1do87aP9xbm84fW
   bYuHJqczz07d4CuGgRKxsaPpd1uov/PMFvMe/aosbTWGLhtvxEnK84QwW
   KoOV1JYlyagLrWbEyg7q/sMo9h+mygE2pargC/3yiRQg0NXZmX3dVcmQL
   A==;
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="asc'?scan'208";a="131447965"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2023 04:58:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 04:58:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 9 Jan 2023 04:58:27 -0700
Date:   Mon, 9 Jan 2023 11:58:05 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <atishp@rivosinc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <apatel@ventanamicro.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <opensbi@lists.infradead.org>,
        <samuel@sholland.org>
Subject: Re: [PATCH v4] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <Y7wBTQM7BY8P4Oc4@wendy>
References: <20230108215047.3165032-1-conor@kernel.org>
 <20230109092715.bwomqoeosif43lr2@orel>
 <Y7vpxW1AeEOhcxUf@wendy>
 <20230109104029.3cwbngqiydlpl7z2@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8XoNT0OmVvQCfAv6"
Content-Disposition: inline
In-Reply-To: <20230109104029.3cwbngqiydlpl7z2@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8XoNT0OmVvQCfAv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2023 at 11:40:29AM +0100, Andrew Jones wrote:

> Maybe just replace 'platform specific hooks' with 'in a platform specific
> way'? I'm mostly just hung up on "hooks" (pun definitely intended), as
> this document lives in the Linux repo and there aren't any hooks.

Yes Captain,
Peter.

;)

--8XoNT0OmVvQCfAv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7wBTQAKCRB4tDGHoIJi
0i22AQCCB18ZFTC5gZ6XV+3/PdQCzJYQyvuE7kzMeGmJc/c2QQD/c7OWy8G4QbAx
AkwR/Nzg4U0fhRCkp3VKOyyD4bOI3Q0=
=vhFw
-----END PGP SIGNATURE-----

--8XoNT0OmVvQCfAv6--
