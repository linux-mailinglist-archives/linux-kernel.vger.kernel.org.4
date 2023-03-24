Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71A6C8134
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCXP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjCXP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:28:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D01D93C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679671732; x=1711207732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QnXO9tD65xE00C1x+fbsAJ7iDcx8NXcgRbEs/4X1O58=;
  b=hrMEYdCR8kA3UnwYyynoviMfgkEAOjOC6yNjO6N0Bftqi54YVIxEL1Nq
   EXMz6czBBbIL8oM7JAp3NQX1xK6GCMsFqZPcaWPZF7W14aa9z1z5DkTIM
   iViWlzsoUu3+xcTDQHUm2uz21W9KAOe+E6NrrhMgjPmjxhw+fAXIilA8G
   m/MEaEo6T2qvMN+fWxV3/HKfkC1AWIUMxdoasbxSPMT1Mz/HnhU0JUsDx
   Kq7lbP8KZJ2Ue2PlL9fx+eZDrKeGHZQNbrWFvMZ0muKVU6lkqwqU3CYM5
   Z9t695NLnkZKuI5pSGDzSFVVyyUNOK/Kg5ib7uD6JRyXayxhPkAlLq2yi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="319453365"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="319453365"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="928687439"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="928687439"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.66])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:28:51 -0700
Date:   Fri, 24 Mar 2023 08:28:50 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Staging: greybus: Use inline functions
Message-ID: <ZB3BshO6Yen25LvB@aschofie-mobl2>
References: <cover.1679642024.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679642024.git.sumitraartsy@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:20:30AM -0700, Sumitra Sharma wrote:
> Convert macros to a static inline function, to make the relevant 
> types apparent in the definition and to benefit from the type 
> checking performed by the compiler at call sites.
> 
> CHanges in v2: Change patch subjects, noted by Alison Schofield 


Please review: https://kernelnewbies.org/Outreachyfirstpatch
Section on 'Following the driver commit style'.

To follow the commit style of the greybus driver, update these
commit messages to be under 80 chars, and use "staging", not
"Staging"

Like this:
drivers/staging/greybus$ git log --oneline | head -3
1498054921e2 staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
a7d2a41b7453 staging: greybus: Inline gb_audio_manager_module()
f7d3ece211be staging: greybus: Inline macro gpio_chip_to_gb_gpio_controller()

BTW - I wasn't instantly sure about using 'Inline' as a verb in this
case, so I did this (git log --oneline | grep inline) and found it's
a common use. 

We're building a habit here for when you submit across subsystems
in the future. 

Alison

> 
> Sumitra Sharma (3):
>   Staging: greybus: Use inline function for macro
>     gpio_chip_to_gb_gpio_controller
>   Staging: greybus: Use inline function for gb_audio_manager_module
>   Staging: greybus: Use inline function for pwm_chip_to_gb_pwm_chip
> 
>  drivers/staging/greybus/audio_manager_module.c | 7 +++++--
>  drivers/staging/greybus/gpio.c                 | 7 +++++--
>  drivers/staging/greybus/pwm.c                  | 6 ++++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
