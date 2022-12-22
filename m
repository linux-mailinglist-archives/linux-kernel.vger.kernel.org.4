Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE792653A17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLVA1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVA1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:27:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E332034C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671668837; x=1703204837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jHQcEHSK0InmHnPsXM0Gx80tyPuqDCQXyyxjt9KKKBE=;
  b=eFxG1caUXXOZ19rXqHGaJGkZFG5HOHTZ/avXSdQ4gAcGk7rXU6gzEbqJ
   FgfyeoLJjqKoyX3D6foDLkJlxaojndLjeK4l6mYsvYUEyvaJMLlI6AffN
   P6Au238XqMaQ8eYpc7wdxIreM1Zma6kD5llmJmhNBTKLqlBs73BYDPy25
   4Q3Yn9pSeY+kmR2DNSKsEMODgrPNEL8oMX98C/AOAAJrVYPwnld7wrkjQ
   2F3Z6U3nVctM5GcIcUl/dIJjTwOSYFEOvwDOyVM/S3g3viCcghhEk4cts
   ux+ivd93flQ2Agl14xj8clo3Y30BxYld4tana2KiV45Uh2cgPTGm0xsRT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="299679563"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="299679563"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 16:27:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="740360369"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="740360369"
Received: from gaoyuanf-mobl.amr.corp.intel.com (HELO [10.212.85.133]) ([10.212.85.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 16:27:15 -0800
Message-ID: <07538266-ea40-389e-9e68-054822121e0b@linux.intel.com>
Date:   Wed, 21 Dec 2022 18:27:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318
 amplifier.
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Libin Yang <libin.yang@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com>
 <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
 <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com>
 <CALprXBZkhWitJBeenKHxzyQvkf=Q2FDAHKD511oCWC8-SJBK+A@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CALprXBZkhWitJBeenKHxzyQvkf=Q2FDAHKD511oCWC8-SJBK+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/22 17:30, Ajye Huang wrote:
> Hi Pierre
> 
> On Sat, Dec 17, 2022 at 1:37 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> 
>>
>> Ok, thanks for the explanations.
>>
>> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Yesterday, I saw Arnd Bergmann sent this patch "ASoC: Intel:
> sof-nau8825: fix module alias overflow " for reducing the string to
> prevent over length,https://patchwork.kernel.org/project/alsa-devel/patch/20221221132515.2363276-1-arnd@kernel.org/.
> 
> so, I need to check with you, should my string need to change the
> format style with his, even the my string does not over length , from
> .drv_name = "adl_nau8318_nau8825" to .drv_name = "adl_nau8318_8825",
> align with his format style?

That would be more consistent indeed, no objections from me.
