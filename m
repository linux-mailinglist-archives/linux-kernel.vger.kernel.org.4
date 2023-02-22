Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3769F6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBVOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBVOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:32:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14623CC23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677076367; x=1708612367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NsHIPmf/VqUyvtbsMl5F/BlQCTsBJP/bsobvIa8fEnU=;
  b=F2G+rjxWYIS/tgcmoAl+9RuLkEpcRo02PSfUEZspbiUo0ZubdDFKHa1f
   lzddXK/CKwOhXBnqO0FS8qduq/hqXJ8HAgsDWsbp3xxAWi3LcVtHVJjlZ
   4IuTkZTm+/quXRVY+UAegMYaA0qpTczJsg0bx5noEF2xr6BgbaH28HADG
   kqP/5LruWwkHY4FIe48NmTkw1JUX7L4TXual88XytsLlKuun0jygc43Dl
   FU4U7rrXb3uLNzBKGjWUy3iwqztq1LxFm3E7qZ43O7UhelmSWg7ODWeLc
   ou7ZhA7dLwqfmCgb1pMHoe6vUKOsWlG9Da/RAyNPNouStPVx2kcqIo9wL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313310945"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="313310945"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 06:32:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="1001012479"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="1001012479"
Received: from sgrider-mobl1.amr.corp.intel.com (HELO [10.212.96.73]) ([10.212.96.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 06:31:53 -0800
Message-ID: <5d92a38b-6a5c-8960-1e20-5793a0bb5da4@linux.intel.com>
Date:   Wed, 22 Feb 2023 09:31:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 10/10] ASoC: Intel: soc-acpi: Add CS35L56 Soundwire to TGL
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-11-rf@opensource.cirrus.com>
 <20097f1d-a7ef-9932-685c-afb22006076c@linux.intel.com>
 <941c3c3f-673f-a4b8-092d-d495de9da9dd@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <941c3c3f-673f-a4b8-092d-d495de9da9dd@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/23 06:48, Richard Fitzgerald wrote:
> On 21/02/2023 16:52, Pierre-Louis Bossart wrote:
>>
>>> +static const struct snd_soc_acpi_link_adr
>>> up_extreme_cs35l56_sdw0_one[] = {
>>> +    {
>>> +        .mask = BIT(0),
>>> +        .num_adr = 1,
>>> +        .adr_d = cs35l56_sdw0_adr,
>>> +    },
>>> +    {}
>>> +};
>>> +
>>> +static const struct snd_soc_acpi_link_adr
>>> up_extreme_cs35l56_sdw0_four[] = {
>>> +    {
>>> +        .mask = BIT(0),
>>> +        .num_adr = 4,
>>> +        .adr_d = cs35l56_sdw0_adr,
>>> +    },
>>> +    {}
>>> +};
>>
>> If the machine driver has support for the 2-amplifier configuration,
>> shouldn't it be present here as well?
>>
> 
> Not necessarily.
> It's not a setup we're currently using on this initial TGL
> configuration.
> 
> The machine driver we'd expect to work on multiple hardware. The
> counting algorithm has to go through "2" anyway, and the code to
> handle that is so trivial we may as well include it.

it's fine. usually we are more conservative and have a 1:1 match between
the soc-acpi tables and machine driver, but it doesn't hurt to add the
2-amp case in the machine driver.
