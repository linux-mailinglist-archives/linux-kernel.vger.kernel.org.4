Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062375EF2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiI2JuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiI2Jtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:49:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C01183D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664444903; x=1695980903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=URHxb8lU81RnkvovOLqWHu3JtwNm+uTnov0gAOxG9/M=;
  b=nUb6kUNkCYUcAu2RxCvetqnjecxreNT+PHVz+D2vdLaJvbYcsM9gMjqT
   dlxs7iht2m1yq1YJzV7cXG7ylm4dOK0yjzEZyJdSTh5u6abNFGt3ETxyJ
   70F1WBbQuB65X4izE8/JrLOuCsbkcEQaXZ1sDSU5IR4sCPagUkyyqvWJE
   ndMHolB2qkLKgH33lAclr83SBCCooZZ/ghPGXm7kQVDd/7xWbyDu+vuWx
   GlA1HaNlxhWHbu7Zj5o9Pg7Nwol9kWbAJXcLrRttGZJYQJlOdoRUvkvA5
   f2t5A7b1lt9LM20qrhDkX/bBkMZ6vT+sghNmijNaCo7IM2JbCSzOqeODG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302760932"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="302760932"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:48:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="690754011"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="690754011"
Received: from crijnder-mobl.ger.corp.intel.com (HELO [10.251.211.131]) ([10.251.211.131])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:48:18 -0700
Message-ID: <3bddff5a-78ed-a3fa-841c-2f2f6a8f8bbb@linux.intel.com>
Date:   Thu, 29 Sep 2022 10:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: remove
 SOF_RT1015_SPEAKER_AMP_100FS flag
Content-Language: en-US
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
References: <20220913074906.926774-1-brent.lu@intel.com>
 <2577e4db-8593-cf37-135b-aa51b6268cd7@linux.intel.com>
 <CY5PR11MB6257A5CC3976FAEA2C713A4997559@CY5PR11MB6257.namprd11.prod.outlook.com>
 <d94a9abd-95ca-09ba-ab24-e4c38b832678@linux.intel.com>
 <CY5PR11MB6257AF53395DDF069A43D28E97579@CY5PR11MB6257.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CY5PR11MB6257AF53395DDF069A43D28E97579@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 08:25, Lu, Brent wrote:
>>>
>>> I think TDM slot number is possible but not TX/RX mask. What we have
>>> in topology is union of tx/rx mask of all channels. We don't know the
>>> mask of specific channel in DAI_CONFIG.
>>>
>>> DAI_CONFIG(SSP, 0, BOARD_HP_BE_ID, SSP0-Codec,
>>>         SSP_CONFIG(I2S, SSP_CLOCK(mclk, 19200000, codec_mclk_in),
>>>                 SSP_CLOCK(bclk, 2400000, codec_slave),
>>>                 SSP_CLOCK(fsync, 48000, codec_slave),
>>>                 SSP_TDM(2, 25, 3, 3),
>>
>> the 3 3 is precisely the channel mask!
>>
> 
> Yes, but what we need in the hw_params() is the mask for individual channel,
> like 0x1 for left and 0x2 for right.

Ah yes, you're talking about the mask configuration on the codec side,
sorry I was confused with your reference to DAI_CONFIG. That would be
platform-level information, not DSP topology information indeed.

Sounds good then, thanks for the explanations.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

