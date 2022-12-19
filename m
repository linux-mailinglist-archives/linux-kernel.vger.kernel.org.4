Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1A650D55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiLSOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiLSOdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:33:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFEBB38;
        Mon, 19 Dec 2022 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460393; x=1702996393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YWFxPztdOfRlO83nnW2s60uirJQwacvkE6+joy8ji8=;
  b=VztIelMuajzXNC5PAmcpism6/o2UCHRJmne9it0EnjmtPRZ7/0wlHxbE
   j2CLzmxVODiQFV+3QA4Sq5ulM5B9tsRxdXd8O492Sr+t7kMnQeq8C13Dz
   zztT/YIl/a0iVaUTLPJ7CjDi8VO3ul0tJe39glabFwGUDtOMd1jb6AvBx
   g15QkxMbJtn0/LIARvwEAtZJDMYz5Q7FEcYeBrIyCa7z+wCp3PZVHVACD
   K7drlg+/TlGv7iBQaIeYwYyIzI2iHpvH/L1r96/xbbO9teroe0HSAISDz
   5W2loFtcagwvOPvW2N+QVjgZOk6B4Rh0y/cPcyU5i27HTFJZwhAZY4WAM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307033924"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="307033924"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="683029004"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="683029004"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2022 06:33:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A45FB11D; Mon, 19 Dec 2022 16:33:41 +0200 (EET)
Date:   Mon, 19 Dec 2022 16:33:41 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Convert to
 generic_handle_domain_irq()
Message-ID: <Y6B2RUCQ1ImSUOsq@black.fi.intel.com>
References: <20221219122722.3639-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219122722.3639-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:27:22PM +0200, Andy Shevchenko wrote:
> Replace construct that matches generic_handle_irq(irq_find_mapping())
> to a single call to generic_handle_domain_irq().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
