Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09D62C58E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiKPQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKPQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:55:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209DB18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668617736; x=1700153736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gVWP195KB/4o1HYHRuQ55q8hg8l803VpcH9uitiDMkQ=;
  b=RMGrcybavstbcguHfmgTbSlW0hi5pT2+yEmm7KUKABoEgYfMPzGd+hi8
   M8ju2RnaiwSpYUWEk8kOgt3OvkSgIyg/snE3kKwEASU7sM3awi0nI7g7H
   +iLUSZtsuNfcuQoGMGipCQ5hDcdIJrtj0T6p4S/mdc3SyRL8kaqJgR/Av
   SZXZAsU9NYPhpc+8sOq5aHBxLhZ4aMpJxn4QXBvuPabeOuIi2JTXHtjjq
   kNZGU0jhp4nOpxbmKZYJ+PdkUyVOGjEPuANusXoo+rQDQgAJOwhbrjma2
   mE+sGUA+LDx4Ppw7QCNlRg1CNEQxjDUraPqDo/kTx3s2/4Yj9QiLEX3ca
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="311304774"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="311304774"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:55:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="814149438"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="814149438"
Received: from msureshb-mobl3.amr.corp.intel.com (HELO [10.212.45.114]) ([10.212.45.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:55:33 -0800
Message-ID: <d7b32cb5-7fec-0c2a-d2c7-6934a1eb932b@linux.intel.com>
Date:   Wed, 16 Nov 2022 10:55:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [Sound-open-firmware] [PATCH 3/4] ASoC: SOF: Adding amd HS
 functionality to the sof core
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        venkataprasad.potturu@amd.com,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Basavaraj.Hiregoudar@amd.com, Chen-Yu Tsai <wenst@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vijendar.Mukunda@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
 <20220913144319.1055302-4-Vsujithkumar.Reddy@amd.com>
 <36a45c7a-820a-7675-d740-c0e83ae2c417@collabora.com>
 <a8bc9284-c0c2-79aa-fee6-40101fc34f96@linux.intel.com>
 <02c2643f-bd32-c3db-51a1-d7773b60c655@collabora.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <02c2643f-bd32-c3db-51a1-d7773b60c655@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/22 10:33, AngeloGioacchino Del Regno wrote:
> Il 16/11/22 16:04, Pierre-Louis Bossart ha scritto:
>>
>>>> diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
>>>> index 21d98f31a9ca..83fd81c82e4c 100644
>>>> --- a/include/sound/sof/dai.h
>>>> +++ b/include/sound/sof/dai.h
>>>> @@ -84,6 +84,7 @@ enum sof_ipc_dai_type {
>>>>        SOF_DAI_AMD_BT,            /**< AMD ACP BT*/
>>>>        SOF_DAI_AMD_SP,            /**< AMD ACP SP */
>>>>        SOF_DAI_AMD_DMIC,        /**< AMD ACP DMIC */
>>>> +    SOF_DAI_AMD_HS,            /**< Amd HS */
>>>>        SOF_DAI_MEDIATEK_AFE,        /**< Mediatek AFE */
>>>
>>> Adding SOF_DAI_AMD_HS before SOF_DAI_MEDIATEK_AFE desynced this
>>> enumeration
>>> so the DAI type is now 11 and not 10 anymore, leading to a failure in
>>> firmware
>>> at IPC3 helper function `dai_get()`, as when `dai_find_type()` is
>>> called, the
>>> DAI type that the firmware expects doesn't match with the one that gets
>>> sent
>>> in the request message from the kernel.
>>>
>>> As a local test, I tried moving SOF_DAI_AMD_HS after
>>> SOF_DAI_MEDIATEK_AFE and
>>> this has restored full functionality on my MT8195 platform (Tomato
>>> Chromebook).
>>>
>>> If SOF is supposed to guarantee backwards compatibility (and I believe
>>> it is),
>>> this commit breaks that.
>>>
>>> I would be tempted to send a commit that moves SOF_DAI_AMD_HS to the
>>> end, but
>>> that would break the already compiled firmware for AMD platforms, so I
>>> am not
>>> sure how to proceed.
>>
>> D'oh. Yes this breaks backwards-compatibility and this is a clear
>> mistake. I think your suggestion to add the AMD_HS at the end is the
>> only practical solution indeed - this would need to be done for both
>> kernel and SOF version of dai.h.
>>
> 
> Okay, I will send a commit tomorrow :-)

I sent those two GitHub pull requests already:

https://github.com/thesofproject/linux/pull/4017
https://github.com/thesofproject/sof/pull/6616

