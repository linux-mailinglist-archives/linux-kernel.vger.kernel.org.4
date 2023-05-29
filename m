Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E57147B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjE2KGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjE2KGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:06:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E399
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685354812; x=1716890812;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=U1TsKlIKqlAkAk+ynvXHbRTCq4Ng5rsCi5jfPO/4B8s=;
  b=BrDS0exE3OPeTF/kGK0koBij3mDRaLs22qWkIw4qL7SFZKlIBbp4cAac
   tE2QOUO6fy5hDYrTBWbkuisvixqMw4IqmyR7aSbNs4iKfeVd/DVZ5KmTI
   wt/3aE5GD6xayFJcKme2etOaSlOxnUUtT9CXeIep09WNk3/P2MuIG+acJ
   aG2mdNamHDKYzHR3phImYpBRmX7r4ILOO9KQqcLV6V3+F5R2mBz1MhXD9
   UHnhrETN2Z94PkqK3fdCrh67Bu17TUzIZtYmMzt7t89h+6ZxpBu4DWcM1
   AcmxeGsr/22seK19ibjskzlAwPzsOAIyljeToiAlNCnxXjwJnBvlKENpU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="353515767"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="353515767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 03:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="739096825"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="739096825"
Received: from iswiersz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.191])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 03:06:48 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915_drm.h: fix a typo
In-Reply-To: <970d2cff-f181-d933-8ce3-b1dbe7f90fd8@189.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230529074912.2070902-1-suijingfeng@loongson.cn>
 <874jnvimtf.fsf@intel.com> <970d2cff-f181-d933-8ce3-b1dbe7f90fd8@189.cn>
Date:   Mon, 29 May 2023 13:06:45 +0300
Message-ID: <87wn0rh2oa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, Sui Jingfeng <15330273260@189.cn> wrote:
> Hi,
>
>
> On 2023/5/29 16:06, Jani Nikula wrote:
>> On Mon, 29 May 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>>>   'rbiter' -> 'arbite'
>> Should be arbiter.
>
> Yeah, should be arbiter.
>
> arbiter is a noun. Here, this arbiter may referrer to the 
> drivers/pci/vgaarb.c.
>
> Can you help correct then apply it ? thanks.

Please send a fixed version and I'll apply it. I'm not fixing trivial
patches for you.

BR,
Jani.


>
>>
>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> ---
>>>   include/drm/i915_drm.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
>>> index 7adce327c1c2..3dcb1db519ae 100644
>>> --- a/include/drm/i915_drm.h
>>> +++ b/include/drm/i915_drm.h
>>> @@ -42,7 +42,7 @@ extern struct resource intel_graphics_stolen_res;
>>>    * The Bridge device's PCI config space has information about the
>>>    * fb aperture size and the amount of pre-reserved memory.
>>>    * This is all handled in the intel-gtt.ko module. i915.ko only
>>> - * cares about the vga bit for the vga rbiter.
>>> + * cares about the vga bit for the vga arbite.
>>>    */
>>>   #define INTEL_GMCH_CTRL		0x52
>>>   #define INTEL_GMCH_VGA_DISABLE  (1 << 1)

-- 
Jani Nikula, Intel Open Source Graphics Center
