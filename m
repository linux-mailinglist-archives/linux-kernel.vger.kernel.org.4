Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8875044D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGLKUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGLKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:20:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53CAD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689157232; x=1720693232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tY/BfVTFYGugQI0lJy+CeErN+l4YRI6ixdTewpDFRCY=;
  b=VgBpMT9sZxkl7XMKNGB1TFg8J4HgptpKPAWKP+rH+uWani+XkbcDzPHd
   x5jQD8tQdJFsNh7wWeaQNQNcMnWvnq0pVGW8K5pcMMvOe65oS6S/gx29j
   F+U0EkzricYWOSuECph2XE+tnehcN6hxK3cNblXXLBbN5x0BCT/8LBW+S
   +rE2p0b4Gctvrl3R3+UbDHy8OhdEbK92hXFXQAQo2XZJ2s8hsiE3bRzRg
   HAd/UmTzH9BHRKDyIs3mXAOMyMnWrSWg73hHdbTS45posLizxqTQ4rB7h
   MUM/F7idzWbMgv0Y7pgYDXgqyL6sTSA/eD/iyDeBoQhkdsJswl/i2r5HC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354759615"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="354759615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 03:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866070621"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866070621"
Received: from hoermank-mobl.ger.corp.intel.com (HELO [10.252.42.188]) ([10.252.42.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 03:20:26 -0700
Message-ID: <ab085fff-ade7-02b1-22e0-acba8e6c1846@linux.intel.com>
Date:   Wed, 12 Jul 2023 12:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
Content-Language: en-US
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230712100855.272467-1-brent.lu@intel.com>
 <2e9a5d5b-f637-1f9a-b500-03f9c151dc26@linux.intel.com>
 <CY5PR11MB6257F77DBF1D123FAD0DF4689736A@CY5PR11MB6257.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CY5PR11MB6257F77DBF1D123FAD0DF4689736A@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 08:15, Lu, Brent wrote:
>>> +	{
>>> +		.id = "10EC5650",
>>> +		.drv_name = "jsl_rt5650",
>>> +		.machine_quirk = snd_soc_acpi_codec_list,
>>> +		.quirk_data = &rt5650_spk,
>>> +		.sof_tplg_filename = "sof-jsl-rt5650-dual.tplg",
>>
>> what does 'dual' mean in this context? it's not something we've used before
>> so a comment would be needed IMHO.
>>
>> two DAIs, two codecs?
> 
> Dual I2S. Should we remove it? Just sof-jsl-rt5650.tplg?

that would be my preference, we have lots of configurations with 2 I2S
and never mention it in the topology file name. 'dual' sounds more
confusing than helping here.

The rest of the patch is fine.
