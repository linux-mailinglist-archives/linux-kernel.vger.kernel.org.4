Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B665E66A2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjAMT2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjAMT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:27:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BE8793A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673638072; x=1705174072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XsVxTpswxKpJq81rhcwlfxUKgUo1hWPn8GrChGU2LnQ=;
  b=Jjv6x7Gvpr+K7FQNZfD8Q9hmqjKy0X+JXzUpguGiWY+5Q5Gwp4a755dh
   zDpfhnZ/pUhUVwtJCeYPKjD5SDeGv3J2EG3EXgIMmGGqo1z0P7EX7oPbp
   obSKnOHw5d7uX9XQPNGh3BGx2Xq7ip9NMqGLL6FpZlghohw1nNqdtH4YX
   mAz8mNQbKnkysS98LOaGqtmXo5M1zEppSjTfpTvR+GRXHUvkN9SIQxnWF
   hPK0tPMEffUzAM4ZWXsbO/ONFQQ9KYQ17PDFYHbAqMxX4Nee+NbBuoYHb
   PF1JEBt66Nh/IP/VB0J+jjwdh8ww55CFtya7ISgi5p4h2+2R31s8TVq9K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322777251"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322777251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608257467"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608257467"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:51 -0800
Message-ID: <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:33:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
 <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
 <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>>> increase the runtime suspend delay to 3 seconds.
>>>>>> You have a parent PCI device and a set of child devices for each
>>>>>> manager. The parent PCI device cannot suspend before all its children
>>>>>> are also suspended, so shouldn't the delay be modified at the
>>>>>> manager level?
>>>>>>
>>>>>> Not getting what this delay is and how this would deal with a lengthy
>>>>>> enumeration/initialization process.
>>>>> Yes agreed. Until Child devices are suspended, parent device will
>>>>> be in D0 state. We will rephrase the commit message.
>>>>>
>>>>> Machine driver node will be created by ACP PCI driver.
>>>>> We have added delay in machine driver to make sure
>>>>> two manager instances completes codec enumeration and
>>>>> peripheral initialization before registering the sound card.
>>>>> Without adding delay in machine driver will result early card
>>>>> registration before codec initialization is completed. Manager
>>>>> will enter in to bad state due to codec read/write failures.
>>>>> We are intended to keep the ACP in D0 state, till sound card
>>>>> is created and jack controls are initialized. To handle, at manager
>>>>> level increased runtime suspend delay.
>>>> This doesn't look too good. You should not assume any timing
>>>> dependencies in the machine driver probe. I made that mistake in earlier
>>>> versions and we had to revisit all this to make sure drivers could be
>>>> bound/unbound at any time.
>>> Rather than a timing dependency, could you perhaps prohibit runtime PM
>>> and have a codec make a callback to indicate it's fully initialized and
>>> then allow runtime PM again?
>> We already have enumeration and initialization 'struct completion' that
>> are used by codec drivers to know if the hardware is usable. We also
>> have pm_runtime_get_sync() is the bus layer to make sure the codec is
>> resumed before being accessed.
> Instead of walking through codec list and checking completion status
> for every codec over the link, can we have some solution where once
> all codecs gets enumerated and initialized, a variable in bus instance
> will be updated to know all peripherals initialized. So that we can
> check this variable in machine driver.

No, because the bus cannot know for sure what codecs to expect on the
platform.

This comes from the design, we first create a bunch of devices based on
ACPI information, which causes the drivers to probe. Then when the bus
starts, codecs that are physically present on the bus will attach and be
initialized in the update_status callback.

It's perfectly acceptable for devices to be exposed in ACPI and not be
present on a board. The bus wouldn't know what is needed.

I am still not clear on what the "early card registration" issue might be.

Can you clarify which codec registers are accessed in that case, are
those supposed to be managed with regmap? one possibility is that we
need to make sure the codec drivers are in regmap cache_only probe at
the probe time, that may prevent this sort of uncontrolled register
access. I had a PR on this that I haven't touched in a while, see [1]

I do recall some issues with the codec jacks, where if the card
registration happens too late the codec might have suspended. But we
added pm_runtime_resume_and_get in the set_jack_detect callbacks, so
that was solved.

[1] https://github.com/thesofproject/linux/pull/3941
