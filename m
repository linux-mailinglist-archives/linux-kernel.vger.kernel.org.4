Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561C56FAA75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjEHLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjEHLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:02:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367F2E814;
        Mon,  8 May 2023 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683543686; x=1715079686;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LjfkfoKDufvFptmjnU8Tpr/miNBczjPxAPKLfzlZzdI=;
  b=gmF/MTiwnEnSvrJ8lxfKxTtC/KvhQ4Fhyx3ktWO4cuebN8aT1n6BF07X
   fyjDZBTZkwEdeJo1r/pXXDWx+G+RMW8xnZqycss6C39T3CNb7aSwMUfxb
   RmzHO2IIMq0nkJGThASqlAuFMN/VZ+sy/deVquGLxgzehRleU1Eh/hgaY
   UbBa31qz0FifMHONYdvJf7pN3x4Chw96VBoXNwFOCYgE+ZQZbX/ysMQUQ
   HL1BWBKBtSHMeP8D4AYFNeywWXa8lrvd4b8qWZ63Xbw/He8CrgcYW2kdk
   +/6CIBjQUlgsvQA/zT2ZssauS6Qbw7QfjFgQZlOZM1C4uAyVJbbzCvtoN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329237302"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329237302"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 04:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="698489829"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="698489829"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 04:00:58 -0700
Date:   Mon, 8 May 2023 14:00:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v10 09/10] reset: Add Nuvoton ma35d1 reset driver
 support
In-Reply-To: <20230508025936.36776-10-ychuang570808@gmail.com>
Message-ID: <1ec43550-9aee-3a36-6ca5-ed56e98628f@linux.intel.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com> <20230508025936.36776-10-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1035541048-1683543664=:1790"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1035541048-1683543664=:1790
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 8 May 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This driver supports individual IP reset for ma35d1. The reset
> control registers is a subset of system control registers.

registers are 

> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---

> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
> new file mode 100644
> index 000000000000..19ed323981df
> --- /dev/null
> +++ b/drivers/reset/reset-ma35d1.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/reset-controller.h>
> +#include <linux/spinlock.h>
> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +struct ma35d1_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct notifier_block restart_handler;
> +	void __iomem *base;
> +	spinlock_t lock;

Please add a comment about what this protects. After adding that, feel 
free to add also:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1035541048-1683543664=:1790--
