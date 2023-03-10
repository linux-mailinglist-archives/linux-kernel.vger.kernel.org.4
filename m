Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898DD6B54C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCJWqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCJWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:46:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573B5274
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678488376; x=1710024376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G7UL3U+qmAaf4xKpgEvzpeIeSPSrSibmFMiBDa1iJmY=;
  b=VbJBa0TrXa+yUArUCyeQKr5j3nl1DVHdVU0Dry3cMT8O/IW0/OTOGDF5
   NIiEZ8rBlfUOfa3nI8NEw3FI310mf9lXITObs7sHfQwl/BPGyuOqfHDzJ
   yFylj0EBJq/G4Bwr9+hT3vm1Wa4+jMQmptNlzHSpd4OV8qrzJrTg4b5qA
   BDPvdWWTns/QtPcU8O/QrV9Dins6GslJ7s+tUazbdm21dXKNZhZsN7I1b
   PJwlr6lo5kxiJwqPndn8nIZYnF4d1qFmy/bzZQ79niassxUe9TV4fsFMV
   AD9yY0Wpj65ageLTbssotuE8YnvrxX8vJdjsRLkPr6XNWk1foPmcHDlxf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="401705834"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="401705834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 14:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="852086352"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="852086352"
Received: from dprende1-mobl.ger.corp.intel.com (HELO [10.255.33.142]) ([10.255.33.142])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 14:46:14 -0800
Message-ID: <a5962d12-ccd2-79ea-27bc-674e0b3065f4@linux.intel.com>
Date:   Fri, 10 Mar 2023 16:46:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload on
 adl_rt1019_rt5682
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, dharageswari.r@intel.com,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        alsa-devel@alsa-project.org, Mac Chiang <mac.chiang@intel.com>
References: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
 <0456bd4e-cfee-b863-e02d-98084b5da0f6@linux.intel.com>
 <CALprXBamM-M-YdyfX9dQHp_AQAovcqzL5H4rMPsZPXS426+VgA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CALprXBamM-M-YdyfX9dQHp_AQAovcqzL5H4rMPsZPXS426+VgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 14:01, Ajye Huang wrote:
> On Sat, Mar 11, 2023 at 2:48 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> This sounds good, but if the intent is to have BT offload enabled across
>> all ADL skews there are still misses, e.g.
>>
>> .name = "adl_mx98357_rt5682",
>>
>> Can we please try to add this BT offload in a more consistent manner, or
>> add a comment when this is officially not planned/supported?
> 
> Hi Pierre,
> 
> The "sof-adl-rt1019-rt5682.tplg" for this "adl_rt1019_rt5682" sound
> card also need to enable bt_offload, this one I will submit to SOF
> later this weekend.
> ex, topology: sof-adl-rt1019-rt5682: add bluetooth offload uses SSP2
> link -- https://github.com/ajye-huang/sof/commit/09dcbc3cc1617df652944299c63082f1936dea6e
> 
> To be more clear, I think we can add a comment in the commit message
> for mention " The related "sof-adl-rt1019-rt5682.tplg" enabled the
> bt_offload feature", is it ok?

It's best if you provide a series that enables BT offload across the
board for ADL, if that's the intended goal.
