Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6973723EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFFKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjFFKBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:01:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F83C10E6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686045671; x=1717581671;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QwkajiXVbZ8XHqKTye5piHy7gOYD1DKHgpn0jdqJN1I=;
  b=CghZTsemtRuGA54i7isRZtG/TqRufPiLgV/mxhtGDzrK/2PbxsDJJTLB
   HTWKGlHLJv3qV3mfFxOaOQHEMUBbKUmvMqAdyOCSrEOMTgj16Px/5q+FS
   zs4LHVtHCifhWjrEXzToClhLRkhkaVynHvqbckLoLqBzn1rAy2zaR7oZ4
   GPyXZ73ec2DdI4VoZb3b2aLanK9s41E6jb55ZMhzvan23jNO1NDCnNd89
   v2aiKPQAwARyC3rAfeaCx3m0lpABoTk2O+qdZYP/wfln0NXLFplrt+zOv
   1UyqJhdVttKlKF6nElyA7NlAhzKhh/LkuvLBbc6lwXHljS/V/oSR2hvg7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="346218096"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="346218096"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 03:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="798771410"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="798771410"
Received: from vkkalava-mobl1.amr.corp.intel.com ([10.249.42.194])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 03:00:00 -0700
Date:   Tue, 6 Jun 2023 12:59:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacky Huang <ychuang3@nuvoton.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reset: RESET_NUVOTON_MA35D1 should depend on ARCH_MA35
In-Reply-To: <011578db5fc4426d7df5d8ce2cf5ac09b7080531.1686045287.git.geert+renesas@glider.be>
Message-ID: <6f9587b0-85df-6f80-8dc5-b27fbf11645@linux.intel.com>
References: <011578db5fc4426d7df5d8ce2cf5ac09b7080531.1686045287.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1201266873-1686045602=:2339"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1201266873-1686045602=:2339
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 6 Jun 2023, Geert Uytterhoeven wrote:

> The Nuvoton MA35D1 reset controller is only present on Nuvoton MA35
> SoCs.  Hence add a dependency on ARCH_MA35, to prevent asking the user
> about this driver when configuring a kernel without MA35 SoC support.
> Also, do not enable the driver by default when merely compile-testing.
> 
> While at it, fix a misspelling of "Nuvoton".
> 
> Fixes: e4bb55d6ccf0f774 ("reset: Add Nuvoton ma35d1 reset driver support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/reset/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 0cdf9d64c2185c89..ccd59ddd76100a51 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -144,8 +144,9 @@ config RESET_NPCM
>  	  BMC SoCs.
>  
>  config RESET_NUVOTON_MA35D1
> -	bool "Nuvton MA35D1 Reset Driver"
> -	default ARCH_MA35 || COMPILE_TEST
> +	bool "Nuvoton MA35D1 Reset Driver"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	default ARCH_MA35
>  	help
>  	  This enables the reset controller driver for Nuvoton MA35D1 SoC.

All adjustments make sense.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1201266873-1686045602=:2339--
