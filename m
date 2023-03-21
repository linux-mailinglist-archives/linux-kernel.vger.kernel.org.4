Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C16C2CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCUIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCUIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:44:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85DEC48;
        Tue, 21 Mar 2023 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679388208; x=1710924208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cJdbBf+bpw+4ZJXIgzlJlPNlSnPstSFYZ4kxxJGkF7s=;
  b=WdEViKIWktEpZURMkBzkhwlGoTKkARKsPiBHpl3wXHNO8GLLYdC+tvdT
   hqspPNKk6DF3uHe5t5vyRvRD0h0E7acdWU41IGNSWLZaKNeeCpC0en/E1
   ydmwjNDPRM6b8Rv/k31MtVkr/NiUR1RRpJq4WpYgj6FmBcCYSP0MFVyEU
   MFdPnkxr6IWxDykJksMDsWch9EsjGwA4OJprpB1Nq1/IIZWVgSKnSx1ec
   g31bJh+visYL/rCusUoMuIeIhS07Rsb2hKOir7cDAyDsfne3rhLoFVodx
   DkupUBKmxUWl2FUqPjK6UiQNIx7SkkIPWwFjNH3qTOk1bchRg/qUnHv7d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340428308"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="340428308"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674741495"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="674741495"
Received: from scoyle-mobl.ger.corp.intel.com (HELO [10.213.210.173]) ([10.213.210.173])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:43:09 -0700
Message-ID: <f72efa19-8f29-afcd-af07-d2ac89c9785d@linux.intel.com>
Date:   Tue, 21 Mar 2023 08:43:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH][next] drm/i915/uapi: Replace fake flex-array with
 flexible-array member
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZBSu2QsUJy31kjSE@work>
 <64189999.170a0220.fa1d9.c3f5@mx.google.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <64189999.170a0220.fa1d9.c3f5@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/03/2023 17:36, Kees Cook wrote:
> On Fri, Mar 17, 2023 at 12:18:01PM -0600, Gustavo A. R. Silva wrote:
>> Zero-length arrays as fake flexible arrays are deprecated and we are
>> moving towards adopting C99 flexible-array members instead.
>>
>> Address the following warning found with GCC-13 and
>> -fstrict-flex-arrays=3 enabled:
>> drivers/gpu/drm/i915/gem/i915_gem_context.c: In function ‘set_proto_ctx_engines.isra’:
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:769:41: warning: array subscript n is outside array bounds of ‘struct i915_engine_class_instance[0]’ [-Warray-bounds=]
>>    769 |                 if (copy_from_user(&ci, &user->engines[n], sizeof(ci))) {
>>        |                                         ^~~~~~~~~~~~~~~~~
>> ./include/uapi/drm/i915_drm.h:2494:43: note: while referencing ‘engines’
>>   2494 |         struct i915_engine_class_instance engines[0];
>>
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>> routines on memcpy() and help us make progress towards globally
>> enabling -fstrict-flex-arrays=3 [1].
>>
>> Link: https://github.com/KSPP/linux/issues/21
>> Link: https://github.com/KSPP/linux/issues/271
>> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Flexible array member is even consistent with the rest of our uapi, 
pushed to drm-intel-gt-next, thanks!

Regards,

Tvrtko
