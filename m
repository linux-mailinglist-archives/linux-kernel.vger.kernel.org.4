Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC13622E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiKIPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiKIPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:01:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154611C1F;
        Wed,  9 Nov 2022 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006107; x=1699542107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAPuJL+NtPPeSlFA4UzE5lNAwnRWjReTdEhV5NW8Va0=;
  b=YPDKnf/5L1iDK+5IsJeA4lJDPTuCXvjNf6SuH92S+JhR1fHnrWCNWgBy
   quli8p9+aE3ks4HrjmLNJSP4wmQGl1iO/I9xXldXbSfQiktMKR5ef9N+b
   oVnMzaOdAFNT4vUQpOFHR7p35n1x1JR2HNmJnk3es30aLndPH9ggOJ7JN
   PrJ8GIIOustamY5FxxBkcVxWYETcgx5vFX0/XZpRz+1jKgSAszUOBBZIY
   pSDv8dnwtR4f9Lz4kdIJq/NMUg+qF0DWBDxCPVEW3UZm1jV43NQQArrz1
   nplrvCt93iM8bM6PisjnAaBV8Y/oPB+3sd/MpYZ1iuZBzm8+ts4WNoGfL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337732284"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="337732284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="881954391"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="881954391"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 07:01:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1osmaB-009nO9-1i;
        Wed, 09 Nov 2022 17:01:39 +0200
Date:   Wed, 9 Nov 2022 17:01:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Message-ID: <Y2vA09rQSbCRX+rL@smile.fi.intel.com>
References: <20221109061122.786-1-zhuyinbo@loongson.cn>
 <fc52c692-4cbd-e5f9-2e62-d05b5330052a@loongson.cn>
 <CACRpkdbu-gqNBK0=L8pOr2TwYGOv2MUvFxzYiBNfJ5KyJT+A8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbu-gqNBK0=L8pOr2TwYGOv2MUvFxzYiBNfJ5KyJT+A8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:30:03AM +0100, Linus Walleij wrote:
> On Wed, Nov 9, 2022 at 7:42 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
> > I had added some changes in these series patch in v8, please help add my
> > change and merge it into your tree and sync it to linux-next.
> 
> Yeah no problem, I took out the v7 version and applied this one instead.

It needs more work.

-- 
With Best Regards,
Andy Shevchenko


