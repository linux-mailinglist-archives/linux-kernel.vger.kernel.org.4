Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2314F6487C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLIRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:31:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A115709
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670607087; x=1702143087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6gaByd85Ir5jpC5TjpFdxoKpv9W8N2P7lwLZnGk0xEw=;
  b=aK4aLT8f04EgmqTPTsh1o2xVK8uuJ7rVcR4uBe8P+ful5SbfV6yyc2cS
   X3k2Jk0af1hrCzODoWfcgTXzM8rbuiZ795uKt3oY4rzzCC/GtsYDB1CS9
   46jh5e8FBIx23iQP5lMvi1dfDL1GQbB0tba22bqIRXKb+BwYUtBhmaWUC
   536AAnj/JYmMQhh2NAT9aRAE4rtjrBp/fkiMqmGKzoqt7Hj1qqVJbY8CR
   LOfRUZhyUbjNA5scZkfqArXUJCdVvaPX4185iAxm8Roga6Gy+lMVSG3zw
   sX33TyyFyGTgycRMsdraZmJhMja+Ue94vF2BqOS1iLEbg373QNCx6MFx8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="316213601"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="316213601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:31:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="625180439"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="625180439"
Received: from bdmeredi-mobl2.amr.corp.intel.com (HELO [10.212.15.195]) ([10.212.15.195])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:31:25 -0800
Message-ID: <22043956-e18c-9ed6-5091-188ae40f3cd9@linux.intel.com>
Date:   Fri, 9 Dec 2022 11:31:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1] ASoC: Intel: sof_nau8825: add support for nau8825 with
 amp nau8318
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Libin Yang <libin.yang@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>
References: <20221209150503.11875-1-ajye_huang@compal.corp-partner.google.com>
 <eca17001-93ff-d379-1ab2-2927f1831e78@linux.intel.com>
 <CALprXBayJtWRe9J+q7EahgpXrRy_B-tMAf0KXbDtWa+=4RKyHA@mail.gmail.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CALprXBayJtWRe9J+q7EahgpXrRy_B-tMAf0KXbDtWa+=4RKyHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> This looks inconsistent with the commit message. There are separate
>> Kconfigs for different codecs.
>>
>> SND_SOC_NAU8315
>> SND_SOC_NAU8825
>>
>> Which is it?
>>
> 
> Sorry about confusing you, I think it is better to change the title as
> ASoC: Intel: sof_nau8825: add combination of nau8825 headset codec
> with nau8318 Amp.

Suggested edit:

ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.

> 
> And add some information about Nuvoton chips in the comment message.
> ***
> The nau8315 and nau8318 are both Nuvoton Amp chips. They use the same
> Amp driver nau8315.c. The acpi_device_id for nau8315 is "NVTN2010",
> for nau8318 is "NVTN2012".

That should be added in the commit message please.

>> NAK for this v1. Please clarify which codec you are using and make sure
>> all references are consistent.
>>
>>
> 
> I apologize for the unclear comment message, please give me any
> suggestions if needed, and I will send v2 for review.
> thanks.

Ok, makes sense now. Please do include the explanations on 8315/8318
variants, I couldn't figure out what chips were used.

I would also not use the same topology name as a different platform with
another amplifier. I appreciate you trying to reuse when possible, but
it's just better to create a new topology file. That way if you want any
update down the road you can do so, it's more maintainable and risk-free.
