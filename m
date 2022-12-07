Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC68645B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLGNtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiLGNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:49:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A8959876;
        Wed,  7 Dec 2022 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670420967; x=1701956967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=244oBt7BYcfp9OKLgDcoevrJ5DGlb+K1/OKrzuTdtw8=;
  b=dmNw4xSB8lAyuaDHob2osPr+3zEPleJt8cKRVNCLO/rfDT+VHrY24Yh8
   5uh5r2bmgUBPetPXkI8SOIOwsDXIE48GuFbZEDywxzJum9GN9+wQxlBnL
   Unoe65vx2G9ow7ozmOPmceQwOqcLkLb5IEvV5lnz5S8pumqu85w5QcQBJ
   zY+N5RpfqaGo/SUmppFqO+lmvZXv/ZtfTzEMFV/qwJxEtc3vnQEytPc5J
   JE3SWAnRLYdvRXcq0OBxiBxTsboEygJeKnK/HIgtGu4sP9Zuk1EP4NZpO
   Na5hyJzkMcHdwY0eCVAAqTk25AP/2xe9YX9gtor2FhrP8rMKU7qAEIrG2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381185384"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="381185384"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 05:49:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="710069060"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="710069060"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.130])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 05:49:21 -0800
Message-ID: <cae6475a-a1e9-ae57-6e64-59931f467050@intel.com>
Date:   Wed, 7 Dec 2022 15:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205085351.27566-1-tmaimon77@gmail.com>
 <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
 <c200557f-c30a-62f9-287a-af804e818cf1@intel.com>
 <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
 <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com>
 <c4e2a00c-d09e-95e2-eaf2-1de6b820ac6e@intel.com>
 <CAP6Zq1h9XvH501e_nH9TkUCKPNOuH7dhOM8FrsUM=PYX4gt0qw@mail.gmail.com>
 <CAHp75Vd5DzkCW0Gpouv+0Or=Yhjp_KdFGP-jXkpHD=UZrG2ajA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAHp75Vd5DzkCW0Gpouv+0Or=Yhjp_KdFGP-jXkpHD=UZrG2ajA@mail.gmail.com>
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

On 7/12/22 15:25, Andy Shevchenko wrote:
> On Wed, Dec 7, 2022 at 3:01 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>> On Mon, 5 Dec 2022 at 16:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 5/12/22 16:17, Andy Shevchenko wrote:
>>>> On Mon, Dec 5, 2022 at 4:14 PM Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>>>>> On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>> On 5/12/22 15:25, Andy Shevchenko wrote:
>>>>>>> On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> 
> ...
> 
>>>>>>> devm_ is problematic in your case.
>>>>>>> TL;DR: you need to use clk_get_optional() and clk_put().
>>>>>>
>>>>>> devm_ calls exactly those, so what is the issue?
>>>>>
>>>>> The issue is the error path or removal stage where it may or may be
>>>>> not problematic. To be on the safe side, the best approach is to make
>>>>> sure that allocated resources are being deallocated in the reversed
>>>>> order. That said, the
>>>>>
>>>>> 1. call non-devm_func()
>>>>> 2. call devm_func()
>>>>>
>>>>> is wrong strictly speaking.
>>>>
>>>> To elaborate more, the
>>>>
>>>> 1. call all devm_func()
>>>> 2. call only non-devm_func()
>>>>
>>>> is the correct order.
>>>
>>> 1. WRT pltfm_host->clk, that is what is happening
>>> 2. WRT other resources that is simply not always possible because not every resource is wrapped by devm_
>>> e.g. mmc_alloc_host() / mmc_free_host()
>> I little confused about what to decide, should I use only
>> non-devm_func because mmc_alloc_host() / mmc_free_host() is not
>> warrped with devm_?
> 
> It is up to you how to proceed. I pointed out the problem with your
> code which may or may not be fatal.
> 
> If you want to solve it, there are several approaches:
> 1) get rid of devm_ completely;
> 2) properly shuffle the ordering in ->probe(), so all devm_ calls are
> followed by non-devm_;
> 3) wrap non-devm_ cals to become managed (see
> devm_add_action_or_reset() approach);
> 4) fix SDHCI / MMC layer by providing necessary devm_ calls and/or fix
> sdhci_pltfm_register() to handle the clock.

I can take care of sdhci_pltfm when I next have some time.
Otherwise it looks OK to me, so I am acking it.

> 
> Personally, the list order is from the least, what I prefer, to the
> most (i.o.w. I would like to see rather 4) than 1) to be implemented).
> 
>>>> Hence in this case the driver can be worked around easily (by
>>>> shuffling the order in ->probe() to call devm_ first), but as I said
>>>> looking into implementation of the _unregister() I'm pretty sure that
>>>> clock management should be in sdhci-pltfm, rather than in all callers
>>>> who won't need the full customization.
>>>>
>>>> Hope this helps to understand my point.
>>>>
>>>>>>> Your ->remove() callback doesn't free resources in the reversed order
>>>>>>> which may or, by luck, may not be the case of all possible crashes,
>>>>>>> UAFs, races, etc during removal stage. All the same for error path in
>>>>>>> ->probe().
>>>>>
>>>>> I also pointed out above what would be the outcome of neglecting this rule.
> 
> ...
> 
>>>>>>>>> Why can't you use sdhci_pltfm_register()?
>>>>>>>> two things are missing in sdhci_pltfm_register
>>>>>>>> 1. clock.
>>>>>>>
>>>>>>> Taking into account the implementation of the corresponding
>>>>>>> _unregister() I would add the clock handling to the _register() one.
>>>>>>> Perhaps via a new member of the platform data that supplies the name
>>>>>>> and index of the clock and hence all clk_get_optional() / clk_put will
>>>>>>> be moved there.
>> Do you mean to add it to sdhci_pltfm_register function? if yes I
>> believe it will take some time to modify sdhci_pltfm_register
>> I prefer not to use sdhci_pltfm_register.
> 
> In the Linux kernel we are trying hard to avoid code duplication. Why
> do you need it to be open coded? (Yes, I heard you, but somebody
> should fix the issues with that funcion at some point, right?)
> 
>>>>>>>> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
>>>>>>>
>>>>>>> All the same, why can't platform data be utilised for this?
> 

