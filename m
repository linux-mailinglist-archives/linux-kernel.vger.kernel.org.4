Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3961F71D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiKGPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiKGPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:05:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DCE643F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667833548; x=1699369548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cm8ffb5GHq5ear3HHr7w7HEJfMOXAl8tcZ1AMebuD6s=;
  b=Ul8Fx8u/+w+BOoDD+Ocx6cSFIQEGbjC2Bql0DxER5TIndZCnCZMF7z8i
   a4E0SDOea+wAlYOBoe/MsYuRC7KQ/fPaCVr6+Sr+nKDbJFZXYD5dYrYj9
   uoX7ap37qECOvXl70Vz3xvlDP6d9cy/Bzb9b+kHCVLNuOk7oGoc6/TLmP
   iYiUhLDX7NqDVoX4ARBWbvdYuwwV30usVN2CU+FsFGYwGvdXyQwAWbeQT
   m+swCuxcIClgDuzNcz/mHUsrkvrFhmLhCT+W0YYEbkFtDfbHeqLmlZL5l
   D+UyrlDUdjQf92IDL3Tg/5F8zGVS1wOcIm2KJTWlppzsNnV+p7TpZ7ZLZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293779919"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293779919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 07:04:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="635940451"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="635940451"
Received: from seanabue-mobl.amr.corp.intel.com (HELO [10.212.82.80]) ([10.212.82.80])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 07:04:31 -0800
Message-ID: <2ac3f9c9-5fa0-1b2f-de57-0774eb0acc5e@linux.intel.com>
Date:   Mon, 7 Nov 2022 09:04:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Content-Language: en-US
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        Vijendar.Mukunda@amd.com, vsujithkumar.reddy@amd.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
 <Y2EttkwUvMReQcqg@sirena.org.uk>
 <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
 <Y2JVWmJsprt0xnKH@sirena.org.uk>
 <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
 <dff6e7af-6a07-587e-79d0-706fe7ec6504@linux.intel.com>
 <02a0dfa6-fb6a-25cf-4111-fb609b9b6b68@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <02a0dfa6-fb6a-25cf-4111-fb609b9b6b68@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/22 09:02, Venkata Prasad Potturu wrote:
> 
> On 11/7/22 19:44, Pierre-Louis Bossart wrote:
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On 11/7/22 04:34, Venkata Prasad Potturu wrote:
>>> On 11/2/22 17:02, Mark Brown wrote:
>>>>> On 11/1/22 20:01, Mark Brown wrote:
>>>>>> On Tue, Nov 01, 2022 at 03:15:08PM +0530, Venkata Prasad Potturu
>>>>>> wrote:
>>>>>> Right, that's what the code does but why is this something that
>>>>>> should
>>>>>> be controlled in this fashion?
>>>>> This machine driver is common for TDM mode and I2S mode, user can
>>>>> select TDM
>>>>> mode or I2S mode.
>>>> Why would the user choose one value or the other, and why would this
>>>> choice be something that only changes at module load time?  If this is
>>>> user controllable I'd really expect it to be runtime controllable.
>>>> You're not explaining why this is a module parameter.
>>> Different vendors/OEM's use the same hardware as one need I2S mode and
>>> other need TDM mode, using common driver  to support  I2S and TDM mode
>>> with this parameter.
>>>
>>>
>>> static int tdm_mode = 0;
>>> module_param_named(tdm_mode, tdm_mode, int, 0444);
>>>
>>> And this can be runtime controllable by setting permissions as 0644, we
>>> will change and send next version patch.
>> kernel parameters are difficult to manage for distributions using a
>> single-build. Either all platforms use the kernel parameter or none of
>> them do. That would not allow a per-platform choice of parameters.
>> Using DMI quirks or ACPI identifiers would be a lot less problematic, no?
> 
> All platforms use the kernel parameter to select the I2S/TDM mode.
> Runtime parameters are not required here, by default it is in I2S mode and
> when the platform needs to enable TDM mode then pass tdm_mode module
> parameter as 1.

How would a distribution decide to set this kernel parameter, what
criteria would be used to determine that the TDM mode is required?
You've got to think of who uses that parameter.
This may work for a Chrome solution given that there are per-product
overlays but won't work in the general case IMHO.

