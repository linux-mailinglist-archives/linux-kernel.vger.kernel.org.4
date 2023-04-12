Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13696DF80D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDLOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:11:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08110EB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681308674; x=1712844674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rFb8LUdOar1rVBoFs0RRiVet8qUiYYkcQuG9p1x2yPY=;
  b=CmRV5+xIjtP2GtHhlzG7sd9D50wDcZNmpRsCtVeVSUHlfcWm1mWdjnGk
   JIi7itdLUKMtbNxdOu0PUT7hxV8ncaehUOrEqy9SRvfHqVe02B8TgVH7F
   9epJ8x1FwFieWJ1it9QBcjwAbv0ZUQydIJ11uvxgCpi4pNo7l+cuCSafU
   TGljIZ1kpypy1Iy+2UKXQQfWBCZx9ZwPc09/eI4okqSGde/muv9GrrLZ9
   RduTbP0kqn7OqRvY4Ej2uCUaWpY4ho99yzvG9RKw8BMIhK78dF/b+8cQz
   cr78juoNJB6MZfICkvcGqgR0HVEJb8fm6pN4cSh1lpBhLfAut5+wcAaD7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="409045919"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="409045919"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682480424"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682480424"
Received: from mdhabibh-mobl.amr.corp.intel.com (HELO [10.209.99.121]) ([10.209.99.121])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:11:10 -0700
Message-ID: <27493df8-e1c7-1a8b-e77e-dc3bd495567b@linux.intel.com>
Date:   Wed, 12 Apr 2023 09:11:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 00/20] ASoC/soundwire: add support for ACE2.x
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, bard.liao@intel.com, tiwai@suse.de
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
 <ZDaC6D8yBiJ4GrXm@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZDaC6D8yBiJ4GrXm@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/23 05:07, Vinod Koul wrote:
> On 23-03-23, 13:44, Bard Liao wrote:
>> This series uses the abstraction added in past kernel cycles to provide
>> support for the ACE2.x integration. The existing SHIM and Cadence
> 
> ACE2..?

Not sure I get the comment, this refers to the IP version.

ACE 2.0 IP used in LunarLake, x refers to future TDB versions.

BTW this depends on the series "[PATCH v2 00/18] ASoC: SOF: Intel:
hda-mlink: HDaudio multi-link extension update" applied yesterday by
Mark. It'd be really nice if we can have this in 6.4-rc1 to continue
adding the rest of the Lunar Lake patches.

We tried to limit the number of changes impacting both ASoC and
SoundWire subsystems but there's mechanically 2 merges needed (ASoC ->
SoundWire for the hda-mlink dependency and SoundWire->ASoC for the
interface changes below).

> 
>> registers are now split in 3 (SHIM, IP, SHIM vendor-specific), with some
>> parts also moved to the HDaudio Extended Multi link structures. Nothing
>> fundamentally different except for the register map.
>>
>> This series only provides the basic mechanisms to expose SoundWire-based
>> DAIs. The PCI parts and DSP management will be contributed later, and the
>> DAI ops are now empty as well.
>>
>> The change is mainly on SoundWire. It would be better to go through
>> SoundWire tree.
>>
>> Pierre-Louis Bossart (20):
>>   ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake
>>   soundwire: intel: add ACE2.x SHIM definitions
>>   soundwire: intel_ace2x: add empty new ops for LunarLake
>>   soundwire/ASOC: Intel: update offsets for LunarLake
>>   soundwire: intel/cadence: set ip_offset at run-time
>>   ASoC/soundwire: intel: pass hdac_bus pointer for link management
>>   soundwire: intel: add eml_lock in the interface for new platforms
>>   ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock and pass pointer
>>   soundwire: intel_init: use eml_lock parameter
>>   soundwire: intel_ace2x: add debugfs support
>>   soundwire: intel_ace2x: add link power-up/down helpers
>>   soundwire: intel_ace2x: set SYNCPRD before powering-up
>>   soundwire: intel_ace2x: configure link PHY
>>   soundwire: intel_ace2x: add DAI registration
>>   soundwire: intel_ace2x: add sync_arm/sync_go helpers
>>   soundwire: intel_ace2x: use common helpers for bus start/stop
>>   soundwire: intel_ace2x: enable wake support
>>   soundwire: intel_ace2x: add check_cmdsync_unlocked helper
>>   soundwire: bus: add new manager callback to deal with peripheral
>>     enumeration
>>   soundwire: intel_ace2x: add new_peripheral_assigned callback
>>
>>  drivers/soundwire/Makefile              |   3 +-
>>  drivers/soundwire/bus.c                 |   3 +
>>  drivers/soundwire/cadence_master.h      |   2 +
>>  drivers/soundwire/intel.h               |  16 +
>>  drivers/soundwire/intel_ace2x.c         | 390 ++++++++++++++++++++++++
>>  drivers/soundwire/intel_ace2x_debugfs.c | 147 +++++++++
>>  drivers/soundwire/intel_auxdevice.c     |  17 ++
>>  drivers/soundwire/intel_init.c          |  21 +-
>>  include/linux/soundwire/sdw.h           |   3 +-
>>  include/linux/soundwire/sdw_intel.h     |  88 ++++++
>>  sound/soc/sof/intel/hda.c               |  31 +-
>>  sound/soc/sof/intel/shim.h              |   1 +
>>  12 files changed, 711 insertions(+), 11 deletions(-)
>>  create mode 100644 drivers/soundwire/intel_ace2x.c
>>  create mode 100644 drivers/soundwire/intel_ace2x_debugfs.c
>>
>> -- 
>> 2.25.1
> 
