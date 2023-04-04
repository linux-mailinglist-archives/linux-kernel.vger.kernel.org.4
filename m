Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5DC6D5C45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjDDJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDDJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:45:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653126A3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680601541; x=1712137541;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=evwuNJoFJzh7/WRai7GmJeBqO2kip9yckbdJm/jV9u0=;
  b=SEAa3ukZGycDY2UQSkHN9uRPgpIPv/AjL8+LdHO8t8ym1UrtypSoucbE
   CK7bnnCMFwi1IubJLf0EL7WbicT6FqTK36E3FuM/BXRVR4AmMXX1WE3Cc
   IiL8WwQcBFFjLQNmdUjr+dq9mEiU5gDLgCDKDYSHYwPhXuu8bUORk71oZ
   dvK9yIG19Q+9tIXN9kRfQfpa5pmQQ7GTVIpt3i75Egr1IhHkbCXp3perB
   w1vXYDsqRqK+blXBUhy0V8GgFdJdi3FdE5zyOYR0PqHsO42RvXwU/CIBi
   +Q+KZAAUfFTWd2TBZ1J8VK6n0XgASmamYboiwy7umSainCZZcnaI2OgaJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330720189"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330720189"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775576241"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="775576241"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.43.58])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:44:35 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/19] drm/i915/i915_scatterlist: Fix kerneldoc
 formatting issue - missing '@'
In-Reply-To: <20230403162059.GC8371@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230331092607.700644-1-lee@kernel.org>
 <20230331092607.700644-2-lee@kernel.org> <87jzyt0yil.fsf@intel.com>
 <20230403162059.GC8371@google.com>
Date:   Tue, 04 Apr 2023 12:44:32 +0300
Message-ID: <878rf80ynz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023, Lee Jones <lee@kernel.org> wrote:
> On Mon, 03 Apr 2023, Jani Nikula wrote:
>
>> On Fri, 31 Mar 2023, Lee Jones <lee@kernel.org> wrote:
>> > Fixes the following W=1 kernel build warning(s):
>> >
>> >  drivers/gpu/drm/i915/i915_scatterlist.c:62: warning: Function parameter or member 'size' not described in 'i915_refct_sgt_init'
>> >
>> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> > Cc: David Airlie <airlied@gmail.com>
>> > Cc: Daniel Vetter <daniel@ffwll.ch>
>> > Cc: intel-gfx@lists.freedesktop.org
>> > Cc: dri-devel@lists.freedesktop.org
>> > Signed-off-by: Lee Jones <lee@kernel.org>
>>
>> Thanks for the patches!
>>
>> Applied all but one of the drm/i915 patches to drm-intel-next or
>> drm-intel-gt-next depending on the area. There were a couple of issues
>> that I fixed while applying. There was a conflict with patch 5/19
>> against drm-intel-gt-next so I left that one out.
>
> Thanks Jani.  I'll rebase and see what's left.

We also took notice and aim to track this more aggressively [1].

BR,
Jani.


[1] https://gitlab.freedesktop.org/drm/intel/-/issues/8335


-- 
Jani Nikula, Intel Open Source Graphics Center
