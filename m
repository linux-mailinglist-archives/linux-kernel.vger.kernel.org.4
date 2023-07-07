Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7474B53F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGGQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE641FEF;
        Fri,  7 Jul 2023 09:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267CC619FD;
        Fri,  7 Jul 2023 16:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FA4C433C7;
        Fri,  7 Jul 2023 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688748476;
        bh=xaxR5LdYxVE2tosF86edgKHIbkGlYTFvwouFf3J52bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjGydPHQwmS3FbZizdz7ALKDj0ou4KNPyuDA7t9taCfC06/v+pYVNTpjOVTKVBIxZ
         jtQLQC5tMD/nScEqxfENye7DNV/2tIDXPCWEs/5Us/sBSYgqtr2NTex2Sq6ds4sTsF
         EcWlVkF7uwvxxTRoGulb/oLbBA6nahAT8HVRzOAGv+/Clk6YKg0Q2mFWyBWOmrFM4P
         CnXyBOJnjJOFWbcNONGdiPh047OZJaajpqYGse4JDYms4pZTsSFsA45eHfDih0KKqo
         9sI4yCPq8BxxaUhuuOiUmuWw6vKyyUn+mBL3lBL+eu3UxwpWCsolVZ9DaOAW1OcWep
         XNN3RYdTkCXmQ==
Date:   Fri, 7 Jul 2023 22:17:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH 02/18] soc: actions: Move power-domain driver to the
 genpd dir
Message-ID: <20230707164735.GQ6001@thinkpad>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230707140434.723349-3-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:04:18PM +0200, Ulf Hansson wrote:
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: <linux-actions@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

I hope Arnd will take this patch directly.

- Mani

> ---
>  drivers/genpd/Makefile                   | 1 +
>  drivers/genpd/actions/Makefile           | 2 ++
>  drivers/{soc => genpd}/actions/owl-sps.c | 0
>  drivers/soc/actions/Makefile             | 1 -
>  4 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/genpd/actions/Makefile
>  rename drivers/{soc => genpd}/actions/owl-sps.c (100%)
> 
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index a4e40e534e6a..a2d5b2095915 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -1 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y					+= actions/
> diff --git a/drivers/genpd/actions/Makefile b/drivers/genpd/actions/Makefile
> new file mode 100644
> index 000000000000..e78c420a2454
> --- /dev/null
> +++ b/drivers/genpd/actions/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +obj-$(CONFIG_OWL_PM_DOMAINS)		+= owl-sps.o
> diff --git a/drivers/soc/actions/owl-sps.c b/drivers/genpd/actions/owl-sps.c
> similarity index 100%
> rename from drivers/soc/actions/owl-sps.c
> rename to drivers/genpd/actions/owl-sps.c
> diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
> index 4db9e7b050e5..4ac88fec2050 100644
> --- a/drivers/soc/actions/Makefile
> +++ b/drivers/soc/actions/Makefile
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  
>  obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
> -obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
