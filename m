Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF91C66A2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjAMT2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAMT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:27:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8F087932
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673638069; x=1705174069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=70dcSDAcJhXyk0eJE46WLgGwnEuEo5G70db30p8p7DA=;
  b=OWjJeHARwbmunOffVMHlbS+ItyClWU3KptCUHAihslB+E1kCRsfZtKpt
   wWz6WVSftlM/fjblIbSji0goC4ypwx5ImtVQcJDPeTSQLJGu1rYS1dXnB
   QT53ZhnguQTdetL2B++k7uch1H9xq6mqWclA30BgeD65ykDoetwthDPh/
   DyadNZwSz8DEArSDjbf7sTm0bhsawhdwDd29DDKYhnNdTcwE094iYnubU
   +KL41wTsLTTNOVgJwlyrOmyleMiRfsJlGoCV02SWa34nPafXYaQ3y+wgV
   VCSKnX0+B6NerDViJe9Z7gOsDc9ACaPQ2bpUge7UOcrFSNsdWXBY6w1Eo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322777210"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322777210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608257455"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608257455"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:46 -0800
Message-ID: <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:11:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
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


>>> +		if (is_dmic_dev && is_sdw_dev) {
>>> +			switch (acp_data->sdw_master_count) {
>>> +			case 1:
>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>>> +				break;
>>> +			case 2:
>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>>> +				break;
>> so the cover letter is indeed wrong and confuses two controllers for two
>> managers.
> ACP IP has two independent manager instances driven by separate controller
> each which are connected in different power domains.
> 
> we should create two separate ACPI companion devices for separate
> manager instance.  Currently we have limitations with BIOS.
> we are going with single ACPI companion device.
> We will update the changes later.

Humm, this is tricky. The BIOS interface isn't something that can be
changed at will on the kernel side, you'd have to maintain two solutions
with a means to detect which one to use.

Or is this is a temporary issue on development devices, then that part
should probably not be upstreamed.
