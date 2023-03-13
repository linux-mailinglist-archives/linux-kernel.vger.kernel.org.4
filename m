Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860DF6B7FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCMRti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCMRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:49:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950387605C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678729761; x=1710265761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ac0J0wDsrRrQOCKOPmVPqi3IPMCeAJCrifPoOm+f26E=;
  b=aoQMypmgXNtlCk1CIgHTt1oIWGosxGT3eyNBCzjqNSynAWcywHlkinqK
   jDG9hirKvENx6h5Bo7czzZLh3wPM7KyjIKGw3yRalTUHClnQwHAtN5RT+
   SH5mK9Ix4tyN2RfSxJfNgF1axTCkgzVCYSdEcAM2AsyE6kpJ/z/4nQCjE
   WlSFMPdlFRZQrqIjfgxTvJBt7yulHCLoGPaXthogGxHJz9JCSZmTMJVeH
   XdLW5lKYYFTiYjMiZambKNq9ytl4Kh3ILbUgxSYdNvtxw+EGQByILukuZ
   u8Ak+5B6aVlNusm7Oz5pGXCtVmvKb//Ima0CFWW0r892xu7nswgWgKiDS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321069304"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="321069304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="852860019"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="852860019"
Received: from jlewis8x-mobl.amr.corp.intel.com (HELO [10.255.34.75]) ([10.255.34.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:49:07 -0700
Message-ID: <e6a96b2d-19d2-97fe-387f-cddc4abbb590@linux.intel.com>
Date:   Mon, 13 Mar 2023 09:36:07 -0500
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
 <a5962d12-ccd2-79ea-27bc-674e0b3065f4@linux.intel.com>
 <CALprXBYVFWDFkT5tnrj6Ef=+ibFLoBAnCnBHtZwSThDauN=uzw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CALprXBYVFWDFkT5tnrj6Ef=+ibFLoBAnCnBHtZwSThDauN=uzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 17:55, Ajye Huang wrote:
> On Sat, Mar 11, 2023 at 6:46 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
> 
>> It's best if you provide a series that enables BT offload across the
>> board for ADL, if that's the intended goal.
> Hi Pierre,
> 
>   {        .name = "adl_mx98357_rt5682",
>         .driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
>                     SOF_RT5682_SSP_CODEC(0) |
>                     SOF_SPEAKER_AMP_PRESENT |
>                     SOF_RT5682_SSP_AMP(2) |
>                     SOF_RT5682_NUM_HDMIDEV(4)),
>     },
> The "adl_mx98357_rt5682" is the sound card of the google "Brya" Board project.
> Because the SSP2 is used for the max98357 amplifier, so SSP2
> bt_offload can't be enabled at the drv_name  "adl_mx98357_rt5682".
> (The hardway layout I2S port2 connected to max98357 amplifier)
> 
> The other adl projects that enabled the bt_offload feature were
> designed with ssp1 for amp, ssp2 for bt_offload based on pins
> definition.
>     {
>         .name = "adl_rt1019_rt5682",
>         .driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
>                     SOF_RT5682_SSP_CODEC(0) |
>                     SOF_SPEAKER_AMP_PRESENT |
>                     SOF_RT1019_SPEAKER_AMP_PRESENT |
>                     SOF_RT5682_SSP_AMP(1) |
>                     SOF_RT5682_NUM_HDMIDEV(4) |
>                     SOF_BT_OFFLOAD_SSP(2) |
>                     SOF_SSP_BT_OFFLOAD_PRESENT),
>     },

ok, so for this patch:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I accept the argument that when SSP2 is used for the amplifier then it
can't be used for BT offload, but I still find "mtl_mx98360_rt5682"
missing BT offload.  This would need a follow-up patch or a comment if
this miss was intentional (not formally supported).

