Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B9166CEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjAPSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAPSSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:18:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857EE3456A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673892363; x=1705428363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N8T9dC4MhCj1V1rc1Oi3oPDU4pzVY12HeNUEeFyLyCE=;
  b=i9ldywsam17ORCiZMbalmwucEb3KqIrdKmn6lK9+38Cp4/hIl6+eRhOJ
   GKA4XSHc9AWq2MN/UaA9xe3WYYvIStMpUL2NbRqIDb0OxuArAIUfw2TRq
   3RAtuBp/tE16e+wmDF4B3/60Qmgo1ISMK7VIoiEtQkt2so2QPuUR1CnmN
   qty+1i4pLk7N931apBpcI3dzY5wgqj7B0Fwbite1xQ2noMPOB3jERVxGe
   ifVboEtAEcsuSXbeQe03a5xO/rpC6ykyjHE4XzqG2okiokGIbxC2hje6W
   eAMZtXK4VEdSu5kE5UTYUo+pyVxRNy8ktvYV4QIhIYfZ1ncOVKNq+hlQr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351767493"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="351767493"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 10:06:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="766987458"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="766987458"
Received: from mahdiahm-mobl1.amr.corp.intel.com (HELO [10.213.173.94]) ([10.213.173.94])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 10:06:01 -0800
Message-ID: <62272f17-bb97-aa10-d5d9-0914595e5431@linux.intel.com>
Date:   Mon, 16 Jan 2023 09:02:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org, Mastan.Katragadda@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
 <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
 <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
 <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
 <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
 <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/23 02:35, Mukunda,Vijendar wrote:
> On 14/01/23 01:27, Mark Brown wrote:
>> On Fri, Jan 13, 2023 at 11:33:09AM -0600, Pierre-Louis Bossart wrote:
>>
>>> I do recall some issues with the codec jacks, where if the card
>>> registration happens too late the codec might have suspended. But we
>>> added pm_runtime_resume_and_get in the set_jack_detect callbacks, so
>>> that was solved.
>> Right, I would expect that whatever needs the device to be powered on
>> would be explicitly ensuring that this is done rather than tweaking
>> timeouts - the timeouts should be more of a performance thing to avoid
>> bouncing power too much, not a correctness thing.
> Machine driver probe is executed in parallel with Manager driver
> probe sequence. Because of it, before completion of all peripherals
> enumeration across the multiple links, if card registration is
> completed, codec register writes will fail as Codec device numbers
> are not assigned.
> 
> If we understood correctly, as per your suggestion, We shouldn't use any
> time bounds in machine driver probe sequence and before registering the
> sound card, need to traverses through all peripheral initialization completion
> status for all the managers.

What's not clear in your reply is this:

What codec registers are accessed as a result of the machine driver
probe and card registration, and in what part of the card registration?

Are we talking about SoundWire 'standard' registers for device/port
management, about vendor specific ones that are exposed to userspace, or
vendor-specific ones entirely configured by the driver/regmap.

You've got to give us more data or understanding of the sequence to
help. Saying there's a race condition doesn't really help if there's
nothing that explains what codec registers are accessed and when.
