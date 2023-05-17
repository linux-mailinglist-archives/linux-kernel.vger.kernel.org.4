Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639B706366
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEQI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEQI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:57:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81E101;
        Wed, 17 May 2023 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684313870; x=1715849870;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=i4ZR3iaeusalPkEACBO162RSA5D79eHRBor1gqPbdOM=;
  b=L+jCO1c2RPlpCGzbJx2/Iimm3MtKyDqVofyknKuuX3cZKW9fB1AyHbwX
   Ach+4xjywFq2jfBnHpaoc1EChayjFD4z17opezydB497vNOTlwFXrIcOE
   8g0X5VSX8vr0U5/MMuzUhLvp2o8rKGZBV0/1j6ir69RtejItX27t3tLcj
   og3GkRlmJsV26yWbHcWLhWAXSUydxCaqRhTIsH1YrH+6/a8lAjrGUX5Ce
   Ms2kh9JulQ6Ak0pHbRFX6EpMVFExOxekxenfUNpCaccMO6W2heJVY7VBi
   6NuP8R17FhtBWtEyj81lnrlWuj8CQiw9qUJrY8ACK7ElV2mHmxlMW+oqN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="349206070"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="349206070"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 01:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771388557"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="771388557"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.50.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 01:57:46 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: i810: include i810_main.h in i810_dvt.c
In-Reply-To: <c28483ac-fbf3-494c-a634-d6edfb998d8f@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230516202814.561262-1-arnd@kernel.org>
 <87lehngxbr.fsf@intel.com>
 <c28483ac-fbf3-494c-a634-d6edfb998d8f@app.fastmail.com>
Date:   Wed, 17 May 2023 11:57:43 +0300
Message-ID: <87ilcrgws8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Wed, May 17, 2023, at 10:46, Jani Nikula wrote:
>> On Tue, 16 May 2023, Arnd Bergmann <arnd@kernel.org> wrote:
>
>>>
>>> drivers/video/fbdev/i810/i810_dvt.c:280:5: error: conflicting types for 'i810_get_watermark'; have 'u32(struct fb_var_screeninfo *,
>>
>> Changes here look fine,
>>
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> Thanks!
>
>> but I think you should try CONFIG_FB_I810_GTF=y to get the same
>> mismatched prototype error for i810_get_watermark() in i810_gtf.c, and
>> add the const there while at it. R-b stands for that addition as well.
>
> I'm fairly sure I looked at that and did not see a problem as
> i810_main.h is already included in that file, it was added
> in 2006 with commit a0aa7d063927 ("[PATCH] drivers/video/: possible
> cleanups").

True that, my bad. (Which kind of puts the R-b above in doubt, but hey,
at least I looked at it. ;)

BR,
Jani.

>
>      Arnd

-- 
Jani Nikula, Intel Open Source Graphics Center
