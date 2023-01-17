Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CEC66DCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjAQLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjAQLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:51:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78895234C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673956266; x=1705492266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IZXhlBrkzXWw0dVHctvOYOPG4b31ftJugED5dJsqzgs=;
  b=UA+YGRmRBffDlR/ey55IgvArxzmoIVLbakkWzzVmza1dWseRTTx7dA2E
   1TTcaSK/u94iZX6fnOv1nP/ENwT/Z1NtX6oy090I1W0oSarRXPvFLIOKT
   /yqq8HHdKQtRXqnuuXxFhlTeM3Pn+1rpms6bWgr68Cn4uVviEKbt+bHpU
   lmmtvQ0fVLl5C86e9HC5yzCbEyw0FXUH6DI3EE81U6ip2aynWBLqK3lix
   Y998pYvEMjExYGNPzMJHr7LZ4V3HyDGPwKC1udnNdnTJZ3gtD+pdHJwqU
   6ygOTjESbylcJUVdHbSAW4dDPsy1t+EK+MAB5RawIGnV3a+jVn8XWdoZg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325950857"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="325950857"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:51:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659366332"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="659366332"
Received: from tdnguye2-mobl.amr.corp.intel.com (HELO [10.212.127.230]) ([10.212.127.230])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:51:04 -0800
Message-ID: <625915d5-0c2a-ce63-e71b-ff4f4f2c6d07@linux.intel.com>
Date:   Tue, 17 Jan 2023 05:51:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org, Mastan.Katragadda@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Takashi Iwai <tiwai@suse.com>,
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
 <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
 <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
 <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
 <62272f17-bb97-aa10-d5d9-0914595e5431@linux.intel.com>
 <b61474ce-01a9-7602-e3c0-df8fdc5191c6@amd.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <b61474ce-01a9-7602-e3c0-df8fdc5191c6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/23 05:33, Mukunda,Vijendar wrote:
> On 16/01/23 20:32, Pierre-Louis Bossart wrote:
>>
>> On 1/16/23 02:35, Mukunda,Vijendar wrote:
>>> On 14/01/23 01:27, Mark Brown wrote:
>>>> On Fri, Jan 13, 2023 at 11:33:09AM -0600, Pierre-Louis Bossart wrote:
>>>>
>>>>> I do recall some issues with the codec jacks, where if the card
>>>>> registration happens too late the codec might have suspended. But we
>>>>> added pm_runtime_resume_and_get in the set_jack_detect callbacks, so
>>>>> that was solved.
>>>> Right, I would expect that whatever needs the device to be powered on
>>>> would be explicitly ensuring that this is done rather than tweaking
>>>> timeouts - the timeouts should be more of a performance thing to avoid
>>>> bouncing power too much, not a correctness thing.
>>> Machine driver probe is executed in parallel with Manager driver
>>> probe sequence. Because of it, before completion of all peripherals
>>> enumeration across the multiple links, if card registration is
>>> completed, codec register writes will fail as Codec device numbers
>>> are not assigned.
>>>
>>> If we understood correctly, as per your suggestion, We shouldn't use any
>>> time bounds in machine driver probe sequence and before registering the
>>> sound card, need to traverses through all peripheral initialization completion
>>> status for all the managers.
>> What's not clear in your reply is this:
>>
>> What codec registers are accessed as a result of the machine driver
>> probe and card registration, and in what part of the card registration?
>>
>> Are we talking about SoundWire 'standard' registers for device/port
>> management, about vendor specific ones that are exposed to userspace, or
>> vendor-specific ones entirely configured by the driver/regmap.
>>
>> You've got to give us more data or understanding of the sequence to
>> help. Saying there's a race condition doesn't really help if there's
>> nothing that explains what codec registers are accessed and when.
> We have come across a race condition, where sound card registration
> is successful before codec enumerations across all the links gets completed
> and our manager instance going into bad state.
> 
> Please refer below link for error logs.
> https://pastebin.com/ZYEN928S

You have two RT1316 register areas that are accessed while the codec is
not even enumerated:

[    2.755828] rt1316-sdca sdw:0:025d:1316:01:0: ASoC: error at
snd_soc_component_update_bits on sdw:0:025d:1316:01:0 for register:
[0x41080100] -22

[    2.758904] rt1316-sdca sdw:0:025d:1316:01:0: ASoC: error at
snd_soc_component_update_bits on sdw:0:025d:1316:01:0 for register:
[0x00003004] -110

The last one is clearly listed in the regmap list.

You probably want to reverse-engineer what causes these accesses.
I see this suspicious kcontrol definition that might be related:

	SOC_SINGLE("Left I Tag Select", 0x3004, 4, 7, 0),
