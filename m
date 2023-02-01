Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0A685CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjBACDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBACDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:03:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B41ABE7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675217012; x=1706753012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQEHpWFfNSyitaLvBhEXmkncdRfOLcou64NXF+6nmxw=;
  b=US78NhYmQ/aWlBhyG7mQFnA+xX6OLDELtnJzQJmWZUOUlQCFVyP12V8g
   OK1MzRgKsSA0C2H+hjNwmrG9lIez1K/Cyt1EEp3MXiNOVz7LlriiOTWWW
   IRVxlNVaS25to2VNVsYHlGVIvBZZtX1+csUew5irNMa+By3hFgwK5QBC/
   yEqAGtJEy8IILpr1Hocbwc0h7G73DsgO72oJpe/WDrUszwbMjQ09Q+VlV
   npSCW9KCK76bNKruWLW4C0zKTByK9oxLSlQXjMR/5CcyqGeR6QTYIW5qa
   jXLEUrNJWItX5+OViz5oPmFrHQCasKyJ+bAOy5zV61OBHC3+PMfJQjsbB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315985990"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="315985990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:03:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910134328"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="910134328"
Received: from ncollins-mobl.amr.corp.intel.com (HELO [10.212.85.244]) ([10.212.85.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:03:17 -0800
Message-ID: <815ab487-a1a3-1978-94fc-b60e931c2848@linux.intel.com>
Date:   Tue, 31 Jan 2023 20:03:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Katragadda, Mastan" <Mastan.Katragadda@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2ea354bc-4263-1db6-4423-4de1b0d4e535@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Yes Controller has ACPI scope. Under controller based on
> "mipi-sdw-manager-list" property manager instances will be created.
> Manager and Link terms are interchangeable.
> 
> Below is the sample DSDT file if we go with two ACPI companion
> devices.
> 
> Scope (\_SB.ACP)
>     {
> 
>         Device (SWC0)
>         {
>             Name (_ADR, 0x05)  // _ADR: Address
>         Name(_DSD, Package() {
>                                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                         Package () {
>                                         Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>                                         Package (2) {"mipi-sdw-manager-list", 1}, // v 1.0
>                                         },
>                                         ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), // Hierarchical Extension
>                                         Package () {
>                                         Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
>                                         }
>                                         }) // End _DSD
>         Name(SWM0, Package() {
>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                 Package () {
>                                 Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>                                 // ... place holder for SWM0 additional properties
>                                 }
>                                 }) // End SWM0.SWM
> 
>     Device (SLV0) { // SoundWire Slave 0
>                         Name(_ADR, 0x000032025D131601)
>                   } // END SLV0   
> 
>         } // END SWC0
> 
>      Device (SWC1)
>         {
>             Name (_ADR, 0x09)  // _ADR: Address
>         Name(_DSD, Package() {
>                                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                         Package () {
>                                         Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>                                         Package (2) {"mipi-sdw-manager-list", 1},
>                                         },
>                                         ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>                                         Package () {
>                                         Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
>                                       
>                                         }
>                                         }) // End _DSD
>         Name(SWM0, Package() {
>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                 Package () {
>                                 Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>                                 // ... place holder for SWM0 additional properties
>                                 }
>                                 }) // End SWM0.SWM
> 
>     Device (SLV0) { // SoundWire Slave 0
>                         Name(_ADR, 0x000032025D131601)
>                   } // END SLV0
> 
>         } // END SWC1
>     }
> }

that looks good to me.

> In above case, two manager instances will be created.
> When manager under SWC1 scope tries to add peripheral
> device, In sdw_slave_add() API its failing because peripheral
> device descriptor uses link id followed by 48bit encoded address.
> In above scenarios, both the manager's link id is zero only.

what fails exactly? The device_register() ?

If yes, what the issue. the device name?

I wonder if we need to use something like

"name shall be sdw:bus_id:link:mfg:part:class"

so as to uniquify the device name, if that was the problem.
