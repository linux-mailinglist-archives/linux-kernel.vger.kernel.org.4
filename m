Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE969EB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBUXxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBUXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:53:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1540F9ED4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677023582; x=1708559582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QoqD8P6ikBakoLwMBIWameGKAp9SzS0lMN/1Sy3cuio=;
  b=LYKsuTqWRghHd9g1xNZXyL7kqdux5RDK8e3s0zkv9IBNb++3/deASIb1
   ruUS0Qro7SV6JanQn2BpRi/0oF8migIM7o9K3Dy4xG3yYfBBflk1lmGXG
   7xHK034yDjF8zFTRfad+zxpWJZxgE/GXiIMQoNMHbGLq3uTLL+Z3s/BCp
   ZAS/4iZW2rUj2vFKV1WAOoi9nhgvmuGSG9Zg3LfEqGRbsVKusfHjOSd4w
   e7cLyVkdB1yYXzuvCpFtHc0WulCEutEn4qjwovGBsSc6BrmUbN2HGXHPr
   8hHztbgi7rHTs5xm+ub7doEE3d3tSJ7U3WRuN9yWxI/Ml87SCOPnbUxpK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="332789092"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="332789092"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 15:53:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="735660217"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="735660217"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 15:52:59 -0800
Message-ID: <84a9fb4c-daf3-84ac-3946-f554a8d5d309@linux.intel.com>
Date:   Tue, 21 Feb 2023 18:48:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V3 3/8] soundwire: amd: register SoundWire manager dai ops
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-4-Vijendar.Mukunda@amd.com>
 <b6f06e29-22cb-a996-5dfb-91544059051f@linux.intel.com>
 <70f873a4-5b41-aede-55b5-8a731c892198@amd.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <70f873a4-5b41-aede-55b5-8a731c892198@amd.com>
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



On 2/21/23 16:05, Mukunda,Vijendar wrote:
> On 21/02/23 21:29, Pierre-Louis Bossart wrote:
>>
>>
>>> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
>>> +	.hw_params = amd_sdw_hw_params,
>> don't you need a .prepare to deal with suspend-resume?
> DSP based solution is not implemented yet.
> As per our understanding In .prepare () callback, there is
> no extra logic needs to be implemented. Because of it,
> we have dropped .prepare() callback.

You don't need any logic IF the IP keeps its context while suspended.
That wasn't the case for us, we had to re-program the registers when
resuming.
