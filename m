Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3FA689DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjBCPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:14:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE31AE847
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437164; x=1706973164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A3OPBOpZFYUYwUMhLao7aBJ7DMGEYe/S93D8TYK9mmI=;
  b=ctrS8cxfaQy/Qh2d6o/EpxaEaMBFAHU/XFH0+viWrnhu3/Q+zAkjCmZW
   uMBk0v3ttj2cj5zdwgQmQ68uxh9zWovbab0nadRCTn0gIl4DaWMoyuYsH
   tgnR7dvRArUdDBp4DSdkNqF3Ea3yMdDnHaJS448P4JnPGDCY9XCZMR7gj
   l3tn/ytegDMAtmmx92Fr6QqL8ZLt1teC6/+NSJn71tCXKaiW1duLJbEt1
   SxppclU8l3LSUf8vNNyinoBSLsNRaYULxD+TC7pz4t9qf/ofrGeFb7iPa
   FMNpX7HVnniYQcGJ7rcxZnIpdkcRtL1lOqmx89r16FFDdHtu3fI9oNqWH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330898232"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330898232"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="729289957"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="729289957"
Received: from albuitra-desk.amr.corp.intel.com (HELO [10.209.172.145]) ([10.209.172.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:23 -0800
Message-ID: <1473e1e9-b368-d8f3-c1f5-1b64e6e2ed90@linux.intel.com>
Date:   Wed, 1 Feb 2023 17:08:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Katragadda, Mastan" <Mastan.Katragadda@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
 <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
 <fa4cdd91-b430-eb1b-a151-d144f62e827d@linux.intel.com>
 <MN0PR12MB6101DBF0419C2C565F7F6840E2D09@MN0PR12MB6101.namprd12.prod.outlook.com>
 <c5161bc3-62cb-d0a1-2ba2-d670285b6958@linux.intel.com>
 <2ea354bc-4263-1db6-4423-4de1b0d4e535@amd.com>
 <815ab487-a1a3-1978-94fc-b60e931c2848@linux.intel.com>
 <ac734e4e-2f61-b9b8-0751-4e3293084696@amd.com>
 <7b8fe2b6-84cb-e8c8-22aa-2d940a5c68b7@linux.intel.com>
 <9e6200ee-9b21-66d1-6bb1-832ec7399111@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9e6200ee-9b21-66d1-6bb1-832ec7399111@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/23 00:01, Mukunda,Vijendar wrote:
> On 01/02/23 09:22, Pierre-Louis Bossart wrote:
>>
>>
>>>>> In above case, two manager instances will be created.
>>>>> When manager under SWC1 scope tries to add peripheral
>>>>> device, In sdw_slave_add() API its failing because peripheral
>>>>> device descriptor uses link id followed by 48bit encoded address.
>>>>> In above scenarios, both the manager's link id is zero only.
>>>> what fails exactly? The device_register() ?
>>>>
>>>> If yes, what the issue. the device name?
>>> device_register() is failing because of duplication of
>>> device name.
>>>> I wonder if we need to use something like
>>>>
>>>> "name shall be sdw:bus_id:link:mfg:part:class"
>>>>
>>>> so as to uniquify the device name, if that was the problem.
>>> Yes correct.
>> can you check https://github.com/thesofproject/linux/pull/4165 and see
>> if this works for you? I tested it on Intel platforms.
> It's working fine on our platform. As mentioned earlier in this thread,
> we can't go with two ACPI companion device approach due to
> limitations on windows stack for current platform.

Thanks for testing.

So if you can't go with 2 ACPI companion devices, what does the
'Windows' DSDT look like and how would you identify that there are two
controllers on the platform?
