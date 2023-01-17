Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FC66DDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjAQMgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjAQMga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:36:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED8252A0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958989; x=1705494989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uhUyp8s8X+TLtfLu32/M/aKyQIv+uFrr5EaeTyAlnig=;
  b=bDanFBfjvjpWMGoAhtidZWQvAFOk98tcbyleprzLwIyKJkmhF8USNy4g
   nIEp5MLE6epZ+BAmQ8yDE7H5x4oBSstOUGgF0hl8Wv3DNLBBPnuSDsHM0
   P8hQYrV4wYkO687j0djX+BylKcokHP4ie9LX5fZaQhSpzU03bvEpWJehs
   SNvotj3g26L72YxVwChlOT13X2xi7NmUtE15JTjDg6Fr1KtFX+nbAaTxH
   PCTZj0p3VmYbi4LvopUjM5Ms6UnSAb8j5rOUcmgNa93NzYPw2hm9KVPmg
   dQD+zHVf7Ju/xUu6nHP6PeO5x7B/GNj07fbBqdjXlJ9IMBn8T2hrbLAyx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305058720"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="305058720"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:36:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722641870"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="722641870"
Received: from tdnguye2-mobl.amr.corp.intel.com (HELO [10.212.127.230]) ([10.212.127.230])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:36:20 -0800
Message-ID: <f3aaf5b7-d822-d5d6-eb7c-71ef1e9c9e73@linux.intel.com>
Date:   Tue, 17 Jan 2023 06:36:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org, Mastan.Katragadda@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
References: <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
 <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
 <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
 <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
 <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
 <62272f17-bb97-aa10-d5d9-0914595e5431@linux.intel.com>
 <b61474ce-01a9-7602-e3c0-df8fdc5191c6@amd.com>
 <625915d5-0c2a-ce63-e71b-ff4f4f2c6d07@linux.intel.com>
 <Y8aRlJRsCjIzYuqa@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y8aRlJRsCjIzYuqa@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/23 06:16, Mark Brown wrote:
> On Tue, Jan 17, 2023 at 05:51:03AM -0600, Pierre-Louis Bossart wrote:
>> On 1/17/23 05:33, Mukunda,Vijendar wrote:
> 
>> [    2.758904] rt1316-sdca sdw:0:025d:1316:01:0: ASoC: error at
>> snd_soc_component_update_bits on sdw:0:025d:1316:01:0 for register:
>> [0x00003004] -110
> 
>> The last one is clearly listed in the regmap list.
> 
>> You probably want to reverse-engineer what causes these accesses.
>> I see this suspicious kcontrol definition that might be related:
> 
>> 	SOC_SINGLE("Left I Tag Select", 0x3004, 4, 7, 0),
> 
> Looks like a case for putting the CODEC in cache only mode...

Right, and I think we'd need to do this during the probe instead of the
hardware initialization (which could happen at a later time).

I started a PR to try and improve regmap handling, see
https://github.com/thesofproject/linux/pull/3941

I was trying to solve the case where codecs become unattached, but
apparently the problem is hardware-related. One of the suggested
improvements was to move the cache_only part earlier to prevent such
accesses. Unfortunately the work isn't complete so that PR is just a
draft at the moment.
