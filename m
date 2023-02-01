Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CED685E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBADwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjBADwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:52:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C09402F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675223537; x=1706759537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rmCcr90OIBPdiIGNAQ9gadT4jTI03VlYZhtAK3NArTU=;
  b=Bqmr9D/89WOCxBVlovZdH9QvFRioryb5TUJYbdx6kZGy5LIIDM3EC5+O
   lxBsE2oMW+qrHqeGHJYPpdBXGYe0I9CsEbbzrYlr5LaNojnrp4SyECeOl
   d5tXzc1GyCjbs+w/HjLH0BFDg+dVDsUz8RJugInFZXBEwASSJQ8RzOBy5
   RZsqB4+0WCoNg/RGphx6aJEj0F/ONcWCaDhqREQvjp1SjkKo4NFw97/68
   adX2//GJVhMlUiEUi+GP105KgKMko3r6OmSANU13E92tC3q4ebU2YEqj3
   N5W6wO8ziqJgmZcFsxGOQTtL/qxNBZ5wCFXR9YihQyOAFBIWY3sAz3x0s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="414238359"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414238359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 19:52:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788686482"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="788686482"
Received: from ncollins-mobl.amr.corp.intel.com (HELO [10.212.85.244]) ([10.212.85.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 19:52:15 -0800
Message-ID: <7b8fe2b6-84cb-e8c8-22aa-2d940a5c68b7@linux.intel.com>
Date:   Tue, 31 Jan 2023 21:52:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Katragadda, Mastan" <Mastan.Katragadda@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
 <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
 <fa4cdd91-b430-eb1b-a151-d144f62e827d@linux.intel.com>
 <MN0PR12MB6101DBF0419C2C565F7F6840E2D09@MN0PR12MB6101.namprd12.prod.outlook.com>
 <c5161bc3-62cb-d0a1-2ba2-d670285b6958@linux.intel.com>
 <2ea354bc-4263-1db6-4423-4de1b0d4e535@amd.com>
 <815ab487-a1a3-1978-94fc-b60e931c2848@linux.intel.com>
 <ac734e4e-2f61-b9b8-0751-4e3293084696@amd.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ac734e4e-2f61-b9b8-0751-4e3293084696@amd.com>
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




>>> In above case, two manager instances will be created.
>>> When manager under SWC1 scope tries to add peripheral
>>> device, In sdw_slave_add() API its failing because peripheral
>>> device descriptor uses link id followed by 48bit encoded address.
>>> In above scenarios, both the manager's link id is zero only.
>> what fails exactly? The device_register() ?
>>
>> If yes, what the issue. the device name?
> device_register() is failing because of duplication of
> device name.
>> I wonder if we need to use something like
>>
>> "name shall be sdw:bus_id:link:mfg:part:class"
>>
>> so as to uniquify the device name, if that was the problem.
> Yes correct.

can you check https://github.com/thesofproject/linux/pull/4165 and see
if this works for you? I tested it on Intel platforms.
