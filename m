Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F372653F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjFGP5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbjFGP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:56:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176EA1FCF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686153413; x=1717689413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7nNTbx876l3a0dmbd1lJ09G1ovmqUK2cjUQUfZr1dsM=;
  b=U3HwomazOB+OwqDwHqE72XJA0lfMxYv9WTW0uzIkiVou/QCYwhKFVQjf
   ZQe42Jyl066Ir3btG/zc5FwnCBSyWwZj8SYto/iDgnZSCwET/TBnjjxwj
   mU1q0J4+YhfFpygztEIZ/KYqSHUZsj6TK+a9ZGUSZFIEqU+QbicF/VcIO
   dDXMBz3hQZwBdV9nl9KHVSgbNNKYyuI3f82gmVqCPFz9C+1SMa+1cfLL9
   37ACNFp4xwMsBzaSi6VFBIW0c4Oq/DW1dx37wWYCh6BSS7/uwwpx7RXg+
   frQtdTu/z2mDXY2IXo40xwZb3JoyGJy0O8ana8pE3PS3XJ3O0hxylO/HA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360360055"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="360360055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739335739"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="739335739"
Received: from sorrin-mobl3.amr.corp.intel.com (HELO [10.209.124.63]) ([10.209.124.63])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:56:49 -0700
Message-ID: <a00d401f-961a-bd1d-b344-5c234e87135b@linux.intel.com>
Date:   Wed, 7 Jun 2023 09:45:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/26] ASoC/soundwire: add support for ACE2.x
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org, bard.liao@intel.com
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
 <ZHHdSjXwyHvBezkG@matsya>
 <8f4a024d-a218-c4ed-925c-b74663b7e280@linux.intel.com>
 <ZICA/YIYQ/DGhhdk@matsya>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZICA/YIYQ/DGhhdk@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/23 08:07, Vinod Koul wrote:
> 
> Hi Pierre,
> 
> On 02-06-23, 15:46, Pierre-Louis Bossart wrote:
>> On 5/27/23 05:36, Vinod Koul wrote:
>>> On 15-05-23, 15:10, Bard Liao wrote:
>>>> This series uses the abstraction added in past kernel cycles to provide
>>>> support for the ACE2.x integration. The existing SHIM and Cadence
>>>> registers are now split in 3 (SHIM, IP, SHIM vendor-specific), with some
>>>> parts also moved to the HDaudio Extended Multi link structures. Nothing
>>>> fundamentally different except for the register map.
>>>>
>>>> This series only provides the basic mechanisms to expose SoundWire-based
>>>> DAIs. The PCI parts and DSP management will be contributed later, and the
>>>> DAI ops are now empty as well.
>>>>
>>>> The change is mainly on SoundWire. It would be better to go through
>>>> SoundWire tree.
>>>
>>> Applied, thanks
>>
>> Hi Vinod, is there a way you could provide an immutable tag for Mark
>> Brown, the patch1 in this set is required for my next set of ASoC
>> LunarLake patches?
> 
> Unfortunately, I have picked the whole series into next. If I was aware
> I would have pushed them to a topic.
> 
> Mark can pull sdw/next but that would bring other things as well which
> may not be preferred. I guess next best would be wait few weeks (rc1)

Yeah, it's a miss on my side, I forgot about this one-line enum
dependency for DMIC/SSP.

SoundWire has more dependencies so we expected to send the relevant
patches in the next cycle. DMIC/SSP is quite simple and could have been
part of 6.5.

Oh well.

>> "ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake" adds
>> the SOF_INTEL_ACE_2_0 definition to select different ops for LunarLake.
>>
>> Thank you
>> -Pierre
> 
