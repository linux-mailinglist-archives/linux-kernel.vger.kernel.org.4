Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B86429A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLENmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiLENlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:41:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63A1CFF2;
        Mon,  5 Dec 2022 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670247709; x=1701783709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3GEBq+TnHHBMj8dKCAPrgcd5mxHNa6hFVgpFoTSTC/c=;
  b=SpPVP0hdQppycTBJfqc525okQOHISoGrU10DQt4MPeGe/+zoIy96WjZe
   xPWzywOdATF5flG4RQgso6tLMUNlfu82sr0fIm/lJCIVCgR0IEQ27hYNn
   qLTsU/lzg2KK0KHd0eFHe1moYIAypi3CNFYJ930LsN73P5OU9MoY1ywSg
   H1Ka1HeVNs1ExhFwrTd9aCa13WKW/nIQlMwnjFPY1vDiyP4p9DhrgMevW
   2E5HplGa1ZTCDPfvi4t629DKNvDxiWZA9rxbl/pkfR5rwSTajfY9Vy/rn
   m/L2CMNGaUm6Eo2lD9+QxbzE1Ic6kVgIf/p2Aa3qL1kpmSTwm/fCzT2tP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="299776121"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="299776121"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:41:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="714401437"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="714401437"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.104])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:41:43 -0800
Message-ID: <c200557f-c30a-62f9-287a-af804e818cf1@intel.com>
Date:   Mon, 5 Dec 2022 15:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
References: <20221205085351.27566-1-tmaimon77@gmail.com>
 <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 15:25, Andy Shevchenko wrote:
> On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>> On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> 
> ...
> 
>>>> +#include <linux/clk.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/mmc/host.h>
>>>> +#include <linux/mmc/mmc.h>
>>>> +#include <linux/module.h>
>>>
>>> I guess platform_device.h is missing here.
>> Build and work without platform_device.h, do I need it for module use?
> 
> The rule of thumb is to include headers we are the direct user of. I
> believe you have a data type and API that are defined in that header.
> 
> ...
> 
>>>> +static int npcm_sdhci_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct sdhci_pltfm_host *pltfm_host;
>>>> +       struct sdhci_host *host;
>>>> +       u32 caps;
>>>> +       int ret;
>>>> +
>>>> +       host = sdhci_pltfm_init(pdev, &npcm_sdhci_pdata, 0);
>>>> +       if (IS_ERR(host))
>>>> +               return PTR_ERR(host);
>>>> +
>>>> +       pltfm_host = sdhci_priv(host);
>>>
>>>> +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
>>>
>>> You can't mix devm with non-devm in this way.
>> Can you explain what you mean You can't mix devm with non-devm in this
>> way, where is the mix?
>> In version 1 used devm_clk_get, is it problematic?
> 
> devm_ is problematic in your case.
> TL;DR: you need to use clk_get_optional() and clk_put().

devm_ calls exactly those, so what is the issue?

> 
> Your ->remove() callback doesn't free resources in the reversed order
> which may or, by luck, may not be the case of all possible crashes,
> UAFs, races, etc during removal stage. All the same for error path in
> ->probe().
> 
>>>> +       if (IS_ERR(pltfm_host->clk))
>>>> +               return PTR_ERR(pltfm_host->clk);
>>>> +
>>>> +       ret = clk_prepare_enable(pltfm_host->clk);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>>> +       if (caps & SDHCI_CAN_DO_8BIT)
>>>> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>> +
>>>> +       ret = mmc_of_parse(host->mmc);
>>>> +       if (ret)
>>>> +               goto err_sdhci_add;
>>>> +
>>>> +       ret = sdhci_add_host(host);
>>>> +       if (ret)
>>>> +               goto err_sdhci_add;
>>>
>>> Why can't you use sdhci_pltfm_register()?
>> two things are missing in sdhci_pltfm_register
>> 1. clock.
> 
> Taking into account the implementation of the corresponding
> _unregister() I would add the clock handling to the _register() one.
> Perhaps via a new member of the platform data that supplies the name
> and index of the clock and hence all clk_get_optional() / clk_put will
> be moved there.
> 
>> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
> 
> All the same, why can't platform data be utilised for this?
> 
>>>> +       return 0;
>>>> +
>>>> +err_sdhci_add:
>>>> +       clk_disable_unprepare(pltfm_host->clk);
>>>> +       sdhci_pltfm_free(pdev);
>>>> +       return ret;
>>>> +}
> 

