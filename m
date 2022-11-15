Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E7629E02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKOPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKOPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:47:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A332CCAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668527272; x=1700063272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QhtIFitBUVQQqjdVNUzXUsVTOtyY5X/TcbGpxY+iIVY=;
  b=HkcY+aKXjWLW8K3O1SktT4A7Ri96gyKUkUe8ZOyRtawPDj9rmoWHuq66
   Um1+eBUqxOFYBtXViRDPvzcRYrBNi/waDAAVJa0tV78O2fypwycixhmBG
   S6QyUqRzTWWx69n3KMayfiQD2cHtEHwIPI47ceOeUhu7y0yoqL7HbUEOp
   THhOtrV+oI4cdihRjAc8Vm0BQbzegLu66z/O/JMAs8YG93pPHT1JiT8zl
   LQ6Sc+3oBwhRZFVF1iIOF7rHqv8UFCFimSn1yGcCIAMDBhtddkpvTPtFH
   KUIYF/sgo/gq9Mbe3qwe/DmpeinVWvgbjGiw8MgP/Y6koCBIUaZo+1eLJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292679226"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292679226"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:47:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968028185"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="968028185"
Received: from bathomp1-mobl1.amr.corp.intel.com (HELO [10.209.177.76]) ([10.209.177.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:47:51 -0800
Message-ID: <f8206ecf-7215-1f85-02ef-7d4f57a7898f@linux.intel.com>
Date:   Tue, 15 Nov 2022 09:12:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] soundwire: Provide build stubs for common functions
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-3-ckeepax@opensource.cirrus.com>
 <90b01c76-fc65-a57f-9247-fae78241342c@linux.intel.com>
 <20221115110345.GM10437@ediswmail.ad.cirrus.com>
 <730128a9-46ce-02b2-f88d-c9982fff2e69@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <730128a9-46ce-02b2-f88d-c9982fff2e69@opensource.cirrus.com>
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



On 11/15/22 05:41, Richard Fitzgerald wrote:
> On 15/11/2022 11:03, Charles Keepax wrote:
>> On Mon, Nov 14, 2022 at 10:13:07AM -0600, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 11/14/22 04:29, Charles Keepax wrote:
>>>> Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
>>>> that are quite likely to be used from common code on devices supporting
>>>> multiple control buses.
>>>
>>> So far this case has been covered by splitting SoundWire related code
>>> away from, say I2C, and with a clear 'depends on SOUNDWIRE'. This is the
>>> case for rt5682, max98373, etc.
>>>
>>> Is this not good enough?
>>>
>>> I am not against this patch, just wondering if allowing code for
>>> different interfaces to be part of the same file will lead to confusions
>>> with e.g. register offsets or functionality exposed with different
>>> registers.
>>>
>>
>> I guess this is a bit of a grey area this one. Both work, I guess
>> the reason I was leaning this way is that in order to avoid a
>> circular dependency if I put all the soundwire DAI handling into
>> the soundwire code then I have to duplicate the snd_soc_dai_driver
>> structure into both the sdw and i2c specific code (worth noting
>> the I2S DAIs are still usable when the part is sdw to the host). But
>> there are also downsides to this approach in that it will likely have
>> some small impact on driver size when soundwire is not built in.
>>
> 
> I think we should just add the stubs. Other subsystems use stubs to help
> with code that references stuff that might not be available.
> 
> Splitting all the soundwire-specifics out into a separate module works
> for simple chips that are either I2S or soundwire. but can get messy for
> a complex codec. I used the separate file method for CS42L42, but for a
> driver I'm working on I abandoned that and put both DAIs in the core
> code. I didn't notice the missing stubs because my defconfig that was
> intended to omit soundwire apparently has something that is selecting
> it anyway.

It would be good if you could look into this, I don't see any 'select
SOUNDWIRE'.

I agree the premise of the split was that the device is used in one mode
of the other, I am not sure however what the a 'complex codec' would
change. It's likely that we will see a second level within a SoundWire
device to deal with independent 'functions', but I don't quite see how
this would matter.

That said, I don't write codec drivers so I am not going to lay on the
tracks over 2 stubs. We can revisit the sdw.h split as well later.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
