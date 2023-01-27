Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF567E1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjA0KlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjA0Kkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A1977D;
        Fri, 27 Jan 2023 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674816027; x=1706352027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pCLUqHrcYs/NeE2BNqrGmzOjvERZA/RdL1uGV47JSSE=;
  b=jrj3YbUzar2RtFakPdhDVW0Gdx5b47B592VZIXlav4+m9msIftrX6rZw
   srAWc4x+8/5hHTIHbo3L+KbprxFNRbdWS5QTAKTwXs/XAJfSFkB4xTZGd
   nBuxLx0DAGsmb4RRwE0TK1dJX1GLiDT0/fL9ZeUzEupU7iXKDbgizoeL0
   yESk905vzEVhiUmgLgSfjXNQJpViDa96lXmpHQKJ3da6sIhL1KiFKMQM5
   UswTGNfcN0mHv8L23ZwJ78LvFytXIOjQfu8eb9mritEfJmCKtCqqttmyk
   bClnymepehjH03znP3P1f+SaTcmqaUe8KhGpyXAG8Jm+WJEsJvtqAyt71
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306711290"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="306711290"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="613137946"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="613137946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2023 02:40:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLM9Y-00Fv1Z-1p;
        Fri, 27 Jan 2023 12:40:16 +0200
Date:   Fri, 27 Jan 2023 12:40:16 +0200
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
Subject: Re: [PATCH v16 1/2] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
Message-ID: <Y9OqEC4A/PT2H83s@smile.fi.intel.com>
References: <cover.1673886245.git.chiaen_wu@richtek.com>
 <1c4cf50600bb0334bd03027f49d7511b394c6ced.1673886245.git.chiaen_wu@richtek.com>
 <Y9OlmCZ+7NpKztee@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9OlmCZ+7NpKztee@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:21:12AM +0000, Lee Jones wrote:
> On Tue, 17 Jan 2023, ChiaEn Wu wrote:

> I see that you guys have been super helpful reviewing this in the past.
>
> Have your queries now been addressed?

As per previous answer, not anything visible right now.

-- 
With Best Regards,
Andy Shevchenko


