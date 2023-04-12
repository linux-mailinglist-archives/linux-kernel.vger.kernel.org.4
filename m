Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99A6DFADB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDLQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:09:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5A1993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681315761; x=1712851761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u6EFeKZbn8HI0fUEkD9VQ43Ja+SJCIDHmkLxpj+imoo=;
  b=FCvrDkVPyGwyMWEwRhh1UIR1l5dmMgne2Lsbrs2cc0h8nO3WAOEIwR29
   GJ2kyXic4QziHFyKas0HWcAH4smGera58Q+HfHAzja9dpu+gnYNoUC5kj
   bDuBmKPRVHD78oqVF9w1M9ajXOA94Zo2n2NGLgCBh2a9Ak2hgOocJcgmS
   oJzuml4Fqsy7T3U+AST9NUPYqeK1owtWrxNn8ne7T0ewa8VJeLcBfXkET
   rPqeOn478mxzsj9lKSvXqjccChgdZvcpXZr+ULa1ooUQ0d9eftObfGvcY
   W977hKVrzMC3vb0B9Jx8xAI7Q+AWSdHWuxcCnAWSiD+rsC5BwChOwH+f4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332641653"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332641653"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 09:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639279410"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639279410"
Received: from mdhabibh-mobl.amr.corp.intel.com (HELO [10.209.99.121]) ([10.209.99.121])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 09:06:43 -0700
Message-ID: <ddd0eb0a-d1f8-4d41-9820-663010e95437@linux.intel.com>
Date:   Wed, 12 Apr 2023 11:06:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 00/20] ASoC/soundwire: add support for ACE2.x
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, bard.liao@intel.com, tiwai@suse.de
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
 <ZDaC6D8yBiJ4GrXm@matsya>
 <27493df8-e1c7-1a8b-e77e-dc3bd495567b@linux.intel.com>
 <ZDbMt5BRrAV5UUEw@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZDbMt5BRrAV5UUEw@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/23 10:22, Vinod Koul wrote:
> On 12-04-23, 09:11, Pierre-Louis Bossart wrote:
>>
>>
>> On 4/12/23 05:07, Vinod Koul wrote:
>>> On 23-03-23, 13:44, Bard Liao wrote:
>>>> This series uses the abstraction added in past kernel cycles to provide
>>>> support for the ACE2.x integration. The existing SHIM and Cadence
>>>
>>> ACE2..?
>>
>> Not sure I get the comment, this refers to the IP version.
> 
> What does ACE mean, it should be expanded so that people know what it
> might refer to..?

I think at one point it stood for "Audio Converged Engine", which
doesn't really clarify anything, does it? It's easier for most people to
just refer to cAVS or ACE as a type of IP followed by a version number,
and use the mapping between the IP version and end-user device in the
PCI descriptors.

>> ACE 2.0 IP used in LunarLake, x refers to future TDB versions.
>>
>> BTW this depends on the series "[PATCH v2 00/18] ASoC: SOF: Intel:
>> hda-mlink: HDaudio multi-link extension update" applied yesterday by
>> Mark. It'd be really nice if we can have this in 6.4-rc1 to continue
>> adding the rest of the Lunar Lake patches.
> 
> That should be mentioned in cover, 

Yes the cover and some patches miss details, it's hard when you have
such a long series to be clear and avoid repetition at the same time...

> I can ack this if okay and Mark might apply..? or u folks have
something else in mind?

that would be ideal, but unfortunately this series will not apply as is
on Mark's for-next branch. I just checked, there are multiple conflicts
with the intel_bus_common stuff which is missing in Mark's tree.

Mark also provided his Acked-by tag already for patches 1/4/6/8, so I
was under the impression that these patches would be merged  through the
soundwire tree.

I think what's missing is a tag from Mark to make sure the hda-mlink
dependencies are in the soundwire tree?

>>
>> We tried to limit the number of changes impacting both ASoC and
>> SoundWire subsystems but there's mechanically 2 merges needed (ASoC ->
>> SoundWire for the hda-mlink dependency and SoundWire->ASoC for the
>> interface changes below).
>>
>>>
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
>>>>
>>>> Pierre-Louis Bossart (20):
>>>>   ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake
>>>>   soundwire: intel: add ACE2.x SHIM definitions
>>>>   soundwire: intel_ace2x: add empty new ops for LunarLake
>>>>   soundwire/ASOC: Intel: update offsets for LunarLake
>>>>   soundwire: intel/cadence: set ip_offset at run-time
>>>>   ASoC/soundwire: intel: pass hdac_bus pointer for link management
>>>>   soundwire: intel: add eml_lock in the interface for new platforms
>>>>   ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock and pass pointer
>>>>   soundwire: intel_init: use eml_lock parameter
>>>>   soundwire: intel_ace2x: add debugfs support
>>>>   soundwire: intel_ace2x: add link power-up/down helpers
>>>>   soundwire: intel_ace2x: set SYNCPRD before powering-up
>>>>   soundwire: intel_ace2x: configure link PHY
>>>>   soundwire: intel_ace2x: add DAI registration
>>>>   soundwire: intel_ace2x: add sync_arm/sync_go helpers
>>>>   soundwire: intel_ace2x: use common helpers for bus start/stop
>>>>   soundwire: intel_ace2x: enable wake support
>>>>   soundwire: intel_ace2x: add check_cmdsync_unlocked helper
>>>>   soundwire: bus: add new manager callback to deal with peripheral
>>>>     enumeration
>>>>   soundwire: intel_ace2x: add new_peripheral_assigned callback
>>>>
>>>>  drivers/soundwire/Makefile              |   3 +-
>>>>  drivers/soundwire/bus.c                 |   3 +
>>>>  drivers/soundwire/cadence_master.h      |   2 +
>>>>  drivers/soundwire/intel.h               |  16 +
>>>>  drivers/soundwire/intel_ace2x.c         | 390 ++++++++++++++++++++++++
>>>>  drivers/soundwire/intel_ace2x_debugfs.c | 147 +++++++++
>>>>  drivers/soundwire/intel_auxdevice.c     |  17 ++
>>>>  drivers/soundwire/intel_init.c          |  21 +-
>>>>  include/linux/soundwire/sdw.h           |   3 +-
>>>>  include/linux/soundwire/sdw_intel.h     |  88 ++++++
>>>>  sound/soc/sof/intel/hda.c               |  31 +-
>>>>  sound/soc/sof/intel/shim.h              |   1 +
>>>>  12 files changed, 711 insertions(+), 11 deletions(-)
>>>>  create mode 100644 drivers/soundwire/intel_ace2x.c
>>>>  create mode 100644 drivers/soundwire/intel_ace2x_debugfs.c
>>>>
>>>> -- 
>>>> 2.25.1
>>>
> 
