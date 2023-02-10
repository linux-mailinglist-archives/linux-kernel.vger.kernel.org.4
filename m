Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1F691CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjBJKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBJKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:32:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179E6D608;
        Fri, 10 Feb 2023 02:32:09 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="318403729"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="318403729"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 02:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="668011981"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="668011981"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 02:32:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1pQQhJ-0050Uk-1b;
        Fri, 10 Feb 2023 12:32:05 +0200
Date:   Fri, 10 Feb 2023 12:32:05 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Message-ID: <Y+YdJdkToTAcvCDt@smile.fi.intel.com>
References: <20230208185714.27313-1-asmaa@nvidia.com>
 <CAHp75Vf7FcAvSwLPWj4OfnJ61iXy7TAFFzTAq_8b9VXeyCfBFg@mail.gmail.com>
 <CH2PR12MB3895C873B4381A88636A0EABD7D99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfVJ8B1d+gSi6WJw9guJBUkaJwH1yU7N7FpJ-DtL_L6Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfVJ8B1d+gSi6WJw9guJBUkaJwH1yU7N7FpJ-DtL_L6Rg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:15:15PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 10, 2023 at 12:48 AM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
> 
> First of all, do not top-post!
> 
> > Thank you for your response. I was just going to contact you regarding this. I successfully sent these patches to you, Linus and Bartosz while they failed to get delivered to the "*.kernel.org" emails below:
> > linux-gpio@vger.kernel.org;
> > linux-kernel@vger.kernel.org;
> > linux-acpi@vger.kernel.org
> >
> > Have these emails changed?
> 
> No, but you need to work with your company's IT to understand what's
> going on. Your mails are only available privately and not in the
> archives on lore.kernel.org. This is an issue and I'm not going to
> comment on something that was not in public.

To illustrate what I'm talking about:

https://lore.kernel.org/linux-gpio/CACRpkdZ_sPCa+Q6MWUKj1ytCe5AxTp--bMmbRTUfsNO0kZTMpQ@mail.gmail.com/T/#t


> > These patches don't have much in common with gpio-mlxbf or gpio-mlxbf2 because the hardware registers and logic have changed across generations. The only similar code between gpio-mlxbf2.c and gpio-mlxbf3.c is the irq handling.
> 
> I see, don't forget to put it in the cover letter for the next version
> (you will send it when you will be sure that emails are going to the
> kernel.org archives).

-- 
With Best Regards,
Andy Shevchenko


