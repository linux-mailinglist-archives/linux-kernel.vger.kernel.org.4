Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AC696DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBNTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:22:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4597A9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676402571; x=1707938571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mN730GcofAZx7UQtH9cNk0SirtgsgD2Oln+LpGur4LI=;
  b=gPdJl5At4EXmxRwywbAq8OLub5sYjVykXqUfEI5+DmVfMbFqYYFvpc7X
   SQCHlTBAKKn5xDv6HfLnUkrm0zmEXoTZqT3q9cjeTPmxdjUuEAJSWJu0z
   +9RSo5+Q0W79gGEqPhLkz3qGunGJHY+aifYhbYEKtwnok8yJs/7Spl36I
   KbsgTi4rrGvjbGNaG22De5nzOfGnaSfP37gcPMq41SsoF6zP+ldZlLz3a
   b5cZ+amtHheAFPDa1wvmUNtxO6ULQyEV1NtmlxJauYypl1z5tUw0sQrwX
   lWyUzxFg+SPL7mCzP077Z/PIyVBwtjxQWkYX65GIMlRap2SUzgDZNIJFs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314893702"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="314893702"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778485232"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778485232"
Received: from parthgup-mobl2.amr.corp.intel.com (HELO [10.209.175.23]) ([10.209.175.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:49 -0800
Message-ID: <e79dae39-faec-b2a4-82e6-e11325904f3e@linux.intel.com>
Date:   Tue, 14 Feb 2023 07:21:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-3-Vijendar.Mukunda@amd.com>
 <a3a75ead-5430-ae32-a6ae-78314bc637f1@linux.intel.com>
 <7b5198f5-1894-5ab5-f84b-410cf102268d@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7b5198f5-1894-5ab5-f84b-410cf102268d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static void amd_sdw_probe_work(struct work_struct *work)
>>> +{
>>> +	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>>> +							   probe_work);
>>> +	struct sdw_master_prop *prop;
>>> +	int ret;
>>> +
>>> +	prop = &amd_manager->bus.prop;
>>> +	if (!prop->hw_disabled) {
>>> +		amd_enable_sdw_pads(amd_manager);
>>> +		ret = amd_init_sdw_manager(amd_manager);
>>> +		if (ret)
>>> +			return;
>>> +		amd_enable_sdw_interrupts(amd_manager);
>>> +		ret = amd_enable_sdw_manager(amd_manager);
>>> +		if (ret)
>>> +			return;
>>> +		amd_sdw_set_frameshape(amd_manager);
>>> +	}
>>> +}
>> There should be an explanation as to why you need a workqueue to
>> complete the probe.
> We want to separate the manager probe sequence and start up sequence.
> we will add the comment.

Do you need to split in two? For Intel, on some platforms we had a clear
power dependency, we had to wait until parts of the DSP were powered
before accessing SHIM registers, so we called the startup() when those
dependencies were resolved.

I am not sure you can count on the probe_work to enforce any kind of
delay, worst case the work function could be scheduled immediately.
