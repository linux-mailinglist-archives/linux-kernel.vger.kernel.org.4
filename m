Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F04960A1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJXLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJXLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:32:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6961D4D;
        Mon, 24 Oct 2022 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666611153; x=1698147153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J//vhD4MqQrSeKUj+KUsipHKrzYYM8OFew0w8HAgIXg=;
  b=ZbMMeY+SAqNctRFuAQVVyUldSf4gpstGVpSqqXsWskSQ77H/zy0OCCRi
   kn96m9LP0e25JDpl+6BApxDdgEfj1l3Jyg1aQpYgYEMMtERf9p9W5H6aM
   j99HxeBUyKcpe/6FRzdtRhY8mXw8k6W0Ek2SnZTOY6jO/RHhQVCPsQ5Kx
   /mrNWgRSt/2wNnchBJbR212sRJByQDgugAn6hzLQovqk1myIlGRfSZzdQ
   65Vh+KadXVkpF/I1esvsxXL8QhmFGs00wrEH6nRzlcmOxe0u2mnnCS95O
   kgWBE617Yv3RN4FGb8EQh+hc+IlFoxQ3Z1hpfFmBJItVYWzzweiMFk0DA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="287790568"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287790568"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 04:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="756541972"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="756541972"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 04:32:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omvgf-001Pmz-1z;
        Mon, 24 Oct 2022 14:32:09 +0300
Date:   Mon, 24 Oct 2022 14:32:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v15 0/2] Add MediaTek MT6370 PMIC support
Message-ID: <Y1Z3uWt0dnWjqzTB@smile.fi.intel.com>
References: <cover.1666636223.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666636223.git.chiaen_wu@richtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 06:59:34PM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> This patch series add MediaTek MT6370 PMIC support and add a index macro
> to <linear_range.h>.

Is it? Please, align the cover letter and actual code series.


-- 
With Best Regards,
Andy Shevchenko


