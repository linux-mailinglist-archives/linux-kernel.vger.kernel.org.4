Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD667E1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjA0Kjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjA0Kjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:39:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB41233D1;
        Fri, 27 Jan 2023 02:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674815971; x=1706351971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AsZgpenLAU9xjhKqfjBX9R9XKFqTNtiIBho92RvLtSk=;
  b=G/Hj9qAK7AypmtX8ohoOeSPINYMxFAc9os82thhUyea1Q1L/dOV7YYUk
   zWV2v8WCGdqrKp7HLmG2x/BPwlxFi6xLvm25oa6itMWg5MFLpO54Ki0Ia
   qj80hq8lRYmpmYCQbVFmQQxwFf1oFg0Ir9HouIqrCaPpO8INp4Q9IG8n7
   aHbfSyPgQJIiYNRwLBfGGYmej0GmkWaXRU9QpLQbD1OFvu8GAyy9SoW3X
   gX320GxUfNSis1nDvNhdG/XuBA2nGwXiq7ksNrtTcKrYTmIOtG5m/tkwv
   WW/O0uMC6giMXX5b4+8MqkAggaae3t/YSDW37SkVf9ilHyOvqzItyNPPy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="315014115"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="315014115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="805757993"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="805757993"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2023 02:39:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLM8j-00Fv0N-0c;
        Fri, 27 Jan 2023 12:39:25 +0200
Date:   Fri, 27 Jan 2023 12:39:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     ChiaEn Wu <chiaen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>, pavel@ucw.cz,
        matthias.bgg@gmail.com, peterwu.pub@gmail.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>
Subject: Re: [PATCH v16 2/2] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Message-ID: <Y9Op3A746oHhgAxc@smile.fi.intel.com>
References: <cover.1673886245.git.chiaen_wu@richtek.com>
 <7a6ac0051789831a7a53c2f3b66010fc0f1e5395.1673886245.git.chiaen_wu@richtek.com>
 <Y9OlXOJ31SUDNtPN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9OlXOJ31SUDNtPN@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:20:12AM +0000, Lee Jones wrote:
> On Tue, 17 Jan 2023, ChiaEn Wu wrote:

> I see that you guys have been super helpful reviewing this in the past.
> 
> Have your queries now been addressed?

I do not see any obvious issues that makes me suffer, if anything left
it can be addressed in the followups.

-- 
With Best Regards,
Andy Shevchenko


