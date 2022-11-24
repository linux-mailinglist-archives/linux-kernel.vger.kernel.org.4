Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868F5637527
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKXJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:28:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A224113FD5;
        Thu, 24 Nov 2022 01:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669282109; x=1700818109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LUokDyXQ5ExiyeCZJMF66xAlop2/Sr5qt8SvDLkcOLk=;
  b=2E+qU7gbfypE92ibb4KvDO5BIKrZZlkpVs9Ko0j1snPTOhRaViw5nQM9
   11KSICkY3Qi+Gu9JjXI70UWTLBdKhrDEuZ7ADhy6DI5qxhoC3msV5bnMn
   713SzMJoatAI1sph/nHMbf0DO4d5kbwAqa8l1g56SKp3u8z6Vy61mMVyw
   fXNyE4RXfXPVj525oD7Tob5Z4F3GPLzAfgSj5xXvDaLqis1wijyasbVc+
   2GjVoB8+NQGvSGF8s4Tb/abJBgv+V+WmObbnKNbbc2BrFtUZa7ZLlNzlX
   4lJZcSSaTaTI2TC1ZNMA0o6UzrbJAW0fPIX3i6rcwf4fi6jmxSMd/x8n0
   g==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="124924007"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 02:28:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 02:28:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 02:28:25 -0700
Date:   Thu, 24 Nov 2022 09:28:07 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Message-ID: <Y385J2m5YByyAz0g@wendy>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
 <CAJM55Z9jfpOW49Z5cdR18T0w4Ae6CQAYF-AsCD8eOcPczwgoZA@mail.gmail.com>
 <6303c341-a691-fd52-2861-74e9d3ea09c9@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6303c341-a691-fd52-2861-74e9d3ea09c9@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Walker,
Just jumping in here...

On Thu, Nov 24, 2022 at 05:08:57PM +0800, Walker Chen wrote:
> On 2022/11/19 2:31, Emil Renner Berthing wrote:
> > On Fri, 18 Nov 2022 at 14:35, Walker Chen <walker.chen@starfivetech.com> wrote:

> >> diff --git a/include/soc/starfive/pm_domains.h b/include/soc/starfive/pm_domains.h
> >> new file mode 100644
> >> index 000000000000..a20e28e9baf3
> >> --- /dev/null
> >> +++ b/include/soc/starfive/pm_domains.h
> >> @@ -0,0 +1,15 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> >> + * Author: Walker Chen <walker.chen@starfivetech.com>
> >> + */
> >> +
> >> +#ifndef __SOC_STARFIVE_PMDOMAINS_H__
> >> +#define __SOC_STARFIVE_PMDOMAINS_H__
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +void starfive_pmu_hw_event_turn_on(u32 mask);
> >> +void starfive_pmu_hw_event_turn_off(u32 mask);
> >> +
> >> +#endif /* __SOC_STARFIVE_PMDOMAINS_H__ */
> > 
> > The header and functions within are named very generic, but
> > implemented by the jh71xx-specific driver.
> > 
> > Also who should use this header? These functions are never called by
> > anything in this series.
> 
> These two functions will be used by the GPU module. Only the power-off
> of the GPU is not controlled by the software through PMU module. So
> here the functions are needed to export.

...the general policy is to avoid adding things without users. I think
they should be kept as static functions for now & when your GPU driver
is being upstreamed you can expose these functions. That way your usage
of them can be reviewed with the appropriate context.

Thanks,
Conor.

