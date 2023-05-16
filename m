Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30D704D12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjEPLyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:54:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03E6A6A;
        Tue, 16 May 2023 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684238019; x=1715774019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7D3YaE5lYG3fnEdXFRAaVlDXMPi64yw97ieL1am27CI=;
  b=LR/SpJ79H5BaVHb2CUkiotCuvV2Q8OglM9UiZGUuIKosGfu1NSPya3AH
   2ZOpCoabNNGyAuYLQfyHEv4dqrVZCOulZpXSegSr7KE/6I9QUPYYbYHFn
   eWeosypqvPTiHG9GVM5jcn/auda655mmzaw6zVzij5FhVy8N2lVQZzdrk
   o8x2zo2YUv+2gp6Q+H6B4QvAyWNLHiJx3rxYJd/i0Lc2uMguj4isWxPYD
   V4Wn8E4KIJB3F8vdwqEajJh7Hq8du+9f5CUXFEIjPrz/Oe/SQZhyO45wC
   EPTfkpvw+KUm2J6k7aC1z2nt5b4IKHnerENoEYc66hNe7BuK2F8t2/Twq
   w==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="211506438"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 04:53:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 04:53:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 04:53:33 -0700
Date:   Tue, 16 May 2023 12:53:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefank@nvidia.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: Add support for DRAM MRQ GSCs
Message-ID: <20230516-cadet-enslave-208d91e66b32@wendy>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-5-pdeschrijver@nvidia.com>
 <20230511-carnivore-legend-17206803d713@spud>
 <ZGNJEoiFmtPiLC4p@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QkN7dRCmSJ1GEE8S"
Content-Disposition: inline
In-Reply-To: <ZGNJEoiFmtPiLC4p@orome>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QkN7dRCmSJ1GEE8S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2023 at 11:12:50AM +0200, Thierry Reding wrote:
> I think Peter had to add these explicitly because the defaults are 2 and
> 1, respectively, and DTC was warning about this. I suppose the "reg"
> property could be adjusted to use the defaults, but on the other hand I
> find that it's good if the examples match reality and we need size-cells
> to be 2 on Tegra.

Huh, caught out by an abnormal example!
If it avoids an error & matches the use-case it seems like a good idea to
leave it as-is. Here's an unqualified
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
instead of the previous qualified one.

Thanks,
Conor.

--QkN7dRCmSJ1GEE8S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGNuqAAKCRB4tDGHoIJi
0ioQAP48UgZ1Wi699mzewpc4KOv1IsY/lRC+3goYNkTl3WgqfwEAnCJExTi8wZll
rQgPKPiu0PhFv9OfeFZv4MGDWou76QA=
=xTp2
-----END PGP SIGNATURE-----

--QkN7dRCmSJ1GEE8S--
