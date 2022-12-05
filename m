Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E49642A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiLEOdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:33:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF417186D5;
        Mon,  5 Dec 2022 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670250807; x=1701786807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2OBOfD2t0N8EJ/uY+cDMKQSnWSQHCvSrSmWj83dLn6E=;
  b=KB0axOQPLP1EdGDBtxymLXy40/rrqXkEFJ/T1hmo1/kG7zeqePKeYKdz
   tEvztcPRvTpoLnPmP0F1HIiTGwr71SN9aLvxL8ikKIY2Xh5+bcNAfkFOt
   gz160HdVDBx0WIxNp29aTipAn3yAX5wd11pQZ3fk7ARPcvz4Qip8WJ31H
   0jaGMbP6sFysg+Wb6VdeZxfRjRuMV6/1Dfg1hQfwsAM3Tcck9tgQsdE4c
   Au40D+dsEG31I2NwVb8lSlFEylygy7zDBz5Dpv/iqe3zVRBQteL59duX2
   OPcNZ2+ibuOZRFJ6JE76iFobz42JKYozMJNQdEkO1Tue9V8FA9J/G3a6s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="296719660"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="296719660"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 06:33:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="974700771"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="974700771"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.104])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 06:33:22 -0800
Message-ID: <c4e2a00c-d09e-95e2-eaf2-1de6b820ac6e@intel.com>
Date:   Mon, 5 Dec 2022 16:33:18 +0200
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
 <c200557f-c30a-62f9-287a-af804e818cf1@intel.com>
 <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
 <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 16:17, Andy Shevchenko wrote:
> On Mon, Dec 5, 2022 at 4:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 5/12/22 15:25, Andy Shevchenko wrote:
>>>> On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>>>>> On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>>> On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>>
>> ...
>>
>>>>>>> +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
>>>>>>
>>>>>> You can't mix devm with non-devm in this way.
>>>>> Can you explain what you mean You can't mix devm with non-devm in this
>>>>> way, where is the mix?
>>>>> In version 1 used devm_clk_get, is it problematic?
>>>>
>>>> devm_ is problematic in your case.
>>>> TL;DR: you need to use clk_get_optional() and clk_put().
>>>
>>> devm_ calls exactly those, so what is the issue?
>>
>> The issue is the error path or removal stage where it may or may be
>> not problematic. To be on the safe side, the best approach is to make
>> sure that allocated resources are being deallocated in the reversed
>> order. That said, the
>>
>> 1. call non-devm_func()
>> 2. call devm_func()
>>
>> is wrong strictly speaking.
> 
> To elaborate more, the
> 
> 1. call all devm_func()
> 2. call only non-devm_func()
> 
> is the correct order.

1. WRT pltfm_host->clk, that is what is happening
2. WRT other resources that is simply not always possible because not every resource is wrapped by devm_
e.g. mmc_alloc_host() / mmc_free_host()

> 
> Hence in this case the driver can be worked around easily (by
> shuffling the order in ->probe() to call devm_ first), but as I said
> looking into implementation of the _unregister() I'm pretty sure that
> clock management should be in sdhci-pltfm, rather than in all callers
> who won't need the full customization.
> 
> Hope this helps to understand my point.
> 
>>>> Your ->remove() callback doesn't free resources in the reversed order
>>>> which may or, by luck, may not be the case of all possible crashes,
>>>> UAFs, races, etc during removal stage. All the same for error path in
>>>> ->probe().
>>
>> I also pointed out above what would be the outcome of neglecting this rule.
>>
>>>>>>> +       if (IS_ERR(pltfm_host->clk))
>>>>>>> +               return PTR_ERR(pltfm_host->clk);
>>>>>>> +
>>>>>>> +       ret = clk_prepare_enable(pltfm_host->clk);
>>>>>>> +       if (ret)
>>>>>>> +               return ret;
>>>>>>> +
>>>>>>> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>>>>>> +       if (caps & SDHCI_CAN_DO_8BIT)
>>>>>>> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>>>>> +
>>>>>>> +       ret = mmc_of_parse(host->mmc);
>>>>>>> +       if (ret)
>>>>>>> +               goto err_sdhci_add;
>>>>>>> +
>>>>>>> +       ret = sdhci_add_host(host);
>>>>>>> +       if (ret)
>>>>>>> +               goto err_sdhci_add;
>>>>>>
>>>>>> Why can't you use sdhci_pltfm_register()?
>>>>> two things are missing in sdhci_pltfm_register
>>>>> 1. clock.
>>>>
>>>> Taking into account the implementation of the corresponding
>>>> _unregister() I would add the clock handling to the _register() one.
>>>> Perhaps via a new member of the platform data that supplies the name
>>>> and index of the clock and hence all clk_get_optional() / clk_put will
>>>> be moved there.
>>>>
>>>>> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
>>>>
>>>> All the same, why can't platform data be utilised for this?
>>>>
>>>>>>> +       return 0;
>>>>>>> +
>>>>>>> +err_sdhci_add:
>>>>>>> +       clk_disable_unprepare(pltfm_host->clk);
>>>>>>> +       sdhci_pltfm_free(pdev);
>>>>>>> +       return ret;
>>>>>>> +}
>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> 
> 

