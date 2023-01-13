Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC693669ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjAMOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjAMOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:41:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409182E4;
        Fri, 13 Jan 2023 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673620351; x=1705156351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZFrYQY8wwSNe7504/1JOB6HAcc8OS7/l0P/HAsC9ZE=;
  b=gzVS3AJtGy6cYC9ZdMPzvBy/iv7SEGrSg1Bj6HnEAXJLCruG3VM1Lxce
   DzB9axTwPIN3gKlddlrM4OeaiGfXp6tJ9fIfxX2cNiweom+LNy7WzpH81
   E5pYXtBHNizi2q2guLL2oRzYA5ObUNM1Bqvp6M+TAhQfU9Q2NUg1qkZqC
   +Ti1zyudE37zugZ2cV1c/pV+HqNpPJEWK14pzzxL2LBpXrq268SjIsDdA
   KfjIjV0MREMrGpV+33gfWXRxe4cv2ibV4Frj4wwmuvL+/qLTpIG/6oE1g
   Yjb9uE6ZImbFj9J09mUzNBIBrhzYK0W5nl3OyvgPGtBDjWumL/kIf+ML2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410238487"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="410238487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="651539035"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="651539035"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2023 06:32:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGL6Q-008eS1-2M;
        Fri, 13 Jan 2023 16:32:18 +0200
Date:   Fri, 13 Jan 2023 16:32:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v1 1/1] pinctrl: digicolor: Remove duplicate assignment
 of of_gpio_n_cells
Message-ID: <Y8FrckOgd5ton0Rl@smile.fi.intel.com>
References: <20230112184347.79642-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112184347.79642-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:43:47PM +0200, Andy Shevchenko wrote:
> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.

Ignore this one, it has been (re-)sent as a part of the series which needs
an update, so look forward to the v2 of that one.

-- 
With Best Regards,
Andy Shevchenko


