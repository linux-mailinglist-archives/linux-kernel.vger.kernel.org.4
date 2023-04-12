Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650BC6DF4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDLMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:11:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD2B4;
        Wed, 12 Apr 2023 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681301495; x=1712837495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ewT/IrLeXzhwmk8e73q3/ULj13sZtuYMfUJ09TlK3Rs=;
  b=mP7D6/EWOW7Nj1eRrJ251nO0kIpSGJlAVBjYkd9cAOC3vkz/5jRWa6Mq
   KuTL0W1P/EI2qvVt1OzdWGALYqSSDIZIIPbbkW17rVE5pgnEy7T/SzDDl
   o8sqAENnxzlPKJ/kcLfdAEIdkKr6JsCmO3aiKk88lNq80w9LYYnKCmNIx
   DGXvLhgGvlAzilsfSHp9XnHN0vThviQdLhjsrd19/XvxZ/BaKVMhC3nri
   H2BNdlSw/mWO7O9ip+rwAJrv7GqnV118y/Vj9+8ElHw5i7Uyf5uTCfNtT
   N5E1UjpAKUYKbykgKg0ylPY4th5C4Hr8+jDQdvWVPkdlvRgbxaoyWPQjy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346550590"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="346550590"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 05:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688934157"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="688934157"
Received: from amurkovx-mobl.ger.corp.intel.com (HELO [10.213.229.123]) ([10.213.229.123])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 05:11:28 -0700
Message-ID: <98bb3388-d671-dcf3-0247-649a702b5e11@linux.intel.com>
Date:   Wed, 12 Apr 2023 13:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/7] drm: fdinfo memory stats
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>, Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
References: <20230411225725.2032862-1-robdclark@gmail.com>
 <bbbbbf34-2ea5-5344-30db-f976c5198d75@amd.com>
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <bbbbbf34-2ea5-5344-30db-f976c5198d75@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/04/2023 10:34, Christian König wrote:
> Am 12.04.23 um 00:56 schrieb Rob Clark:
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Similar motivation to other similar recent attempt[1].  But with an
>> attempt to have some shared code for this.  As well as documentation.
>>
>> It is probably a bit UMA-centric, I guess devices with VRAM might want
>> some placement stats as well.  But this seems like a reasonable start.
>>
>> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
>> And already nvtop support: https://github.com/Syllo/nvtop/pull/204
>>
>> [1] https://patchwork.freedesktop.org/series/112397/
> 
> I think the extra client id looks a bit superfluous since the ino of the 
> file should already be unique and IIRC we have been already using that one.

Do you mean file_inode(struct drm_file->filp)->i_ino ? That one would be 
the same number for all clients which open the same device node so 
wouldn't work.

I also don't think the atomic_add_return for client id works either, 
since it can alias on overflow.

In i915 I use an xarray and __xa_alloc_cyclic.

Regards,

Tvrtko
