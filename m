Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCF6A4FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjB0Xi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB0Xi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:38:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C5A24A;
        Mon, 27 Feb 2023 15:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677541106; x=1709077106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ixxBTf5Ocgi76s8GFyE+uxGzNzt2DbcOET9UuIiMt50=;
  b=CUybXDbFszRu9qrrCDkUZfj3eHtzKKOly9P0bpcqv68YIDMblYl3ib5l
   5HFWX/qZptP89kvvDekkvMkgAKFB03kJmK4EjBwrZ/iULef6B247xZt8k
   UI9DKv7S9Iq/VzOOwI6NJ85PA5ZqEPWdOEkF3VugAayZ5UO75w2T/o/XT
   DIDKzLNjdQ+tZSyBLNsOc4oeOKI/2e8BoL9zt/u8hc7qyRLH0XDTxA5zN
   q+uEdY7kXB+3PZ4Y5fLGObkRQL6fenQ35VeQiE07g4Irm86ceYKoGJsZ1
   ek3aYRRwfL0NqSRWdeqhgrZ/oelziaM5WpxNIihXV4i1Bcdtcye3iEA76
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313672717"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313672717"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 15:38:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="1002997697"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="1002997697"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 15:38:10 -0800
Message-ID: <5d78bbc6-340e-dea8-40c6-d065c7e7a878@linux.intel.com>
Date:   Mon, 27 Feb 2023 18:38:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
To:     "Lee, RyanS" <RyanS.Lee@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
 <Y/zsqjOWFKrpDtl8@sirena.org.uk>
 <d95d15f3-34c3-32df-1a50-0ebce35bf81f@linux.intel.com>
 <Y/z6EB+0beX2Ji2h@sirena.org.uk>
 <SJ0PR03MB66814E588528C771D7BEAB3D8AAF9@SJ0PR03MB6681.namprd03.prod.outlook.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <SJ0PR03MB66814E588528C771D7BEAB3D8AAF9@SJ0PR03MB6681.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Put differently, SoundWire codec drivers should only deal with
>>> non-standard vendor-specific registers.
>>
>> OK, it'd be good to be clear about what the issue is when reviewing things.
>> The registers *are* in the device's register map but the driver shouldn't be
>> referencing them at all and should instead be going via the SoundWire core
>> for anything in there.
> 
> Thanks for the comment.
> The only reason I added standard SoundWire registers to the amp driver is
> to check the values for the debugging purpose because these registers values are
> important to understand the device status, but it is not visible from the regmap
> debugfs if those registers are not included on the regmap table of the driver.
> The driver never controls the standard SoundWire registers by itself.
> Do you recommend removing the standard SoundWire registers from the driver
> or keeping it non-volatile?
> (The reg_default values in the table are all amp reset values and those registers
> are treated as volatile. I shall clear 'unique ID' field because it is determined by
> the hardware pin connection.)

We already have debugfs support for those registers, see
sdw_slave_reg_show() in drivers/soundwire/debugfs.c

It's not the same file as regmap debugfs but the information is already
there, see e.g. an example on the SOF CI devices:

cd /sys/kernel/debug/soundwire/master-0-1/sdw:1:025d:0700:00
more registers

Register  Value

DP0
  0	 0
  1	 0
  2	 0
  3	 0
  4	 0
  5	 1
Bank0
 20	 0
 22	 0
 23	 0
 24	 0
 25	 0
 26	 0
 27	XX
 28	XX
Bank1
 30	 0
 32	 0
 33	 0
 34	 0
 35	 0
 36	 0
 37	XX
 38	XX

SCP
 40	 0
 41	 7
 42	 0
 43	 0
 44	20
 45	 9
 46	 4
 47	XX
 48	XX
 49	XX
 4a	XX
 4b	XX
 50	10
 51	 2
 52	5d
 53	 7
 54	 0
 55	 0

DP1
100	 0
101	 0
102	 0

