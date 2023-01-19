Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5446A673EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjASQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjASQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:27:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8798B30F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674145643; x=1705681643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EzV80YrxebRUHuKIKvpev2GAI8oUOLaQkTdDBDXUvOI=;
  b=af0D0HV5uiSCZN/Kj2h6m761SybVObje1uwn3YeSDPwHgWIM2QuNVO9l
   uc5T2OrskvZocDPumy5XhJ2Li1G5Owbm8rmgib/5YJ/VrWQfTb5ydw9OQ
   y47LSuMeTqqMJZw0lN2ue9R2zGRYCtX6J/p1ur8fHjuoZWyDebTu7jT55
   Ltj/ZtOQ7HI+a4E7G0robHKUmqzWDpbjiWi9F8lpOp6x8tsOJ/zNbTK1G
   tovp172KOexybcpK6T6ybFK2ZRUFtdcCHAcV3Sn/Tx6kwiwY2dHZNROYi
   ZrqxPVxXvwCcKdw13ZRfccdQOZpXUj5dDXJgB+JtHjnkUqkT5G/sVWESf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326614552"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326614552"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:27:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905577374"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="905577374"
Received: from sahamad-mobl1.amr.corp.intel.com (HELO [10.213.187.97]) ([10.213.187.97])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:27:22 -0800
Message-ID: <c45d34ba-1aee-16aa-1ccf-79c43c8c4ed4@linux.intel.com>
Date:   Thu, 19 Jan 2023 10:27:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
 <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
 <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> You lost me here. Are you saying the soundwire bus clock is only known
>> in the prepare stage?
>>
> 
> hw_params() doesn't know the Soundwire bus clock so it can't do the
> check. We need to wait until we have both the sample rate and the
> chosen SWIRE_CLK.

Yes, makes sense. I forgot that all the stream management and bandwidth
allocation takes place in the prepare stage at the dailink level, and
the dai prepare happens after that. Thanks for the clarification.
