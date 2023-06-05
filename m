Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C6722662
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjFEMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjFEMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:52:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAFA1;
        Mon,  5 Jun 2023 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685969557; x=1717505557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gr9FU0HsXW4j6iFAuKnKLc7ghOPdKZNL52m0iUuheIY=;
  b=A30ZL6KRktmNztWZoetcMdIlgvonLlo//yU15CLlWFP0ipTiZBzzcSMD
   oe0h6S3YxRiz330dZgLAUjZcNhFNTZpoPTAUCN0dxjnLYhDGsNzvByaK2
   8nQst8rTZNdkbGuzCIr4MlY89tjaFU6taUMK78+vbPSWhhUlOzD/87nzG
   891CE/UdIb0Xw8Zsx1YWRwbFWtaM0EzfQC2B1Wgw3W5gdMWyp5B+i5sG6
   C4wDiaycVEbpMOt6vJMcxSqdOQRJvJsk57Hlr9DxUAD1sgTpy//LaxL62
   tHVXABCA4qK2wP+rRHBjPXD3mUxZkljb7nnFJD3DMGo0F58DM/0zZSVeW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="358806227"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="358806227"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 05:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="773729801"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="773729801"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 05:52:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q69hH-001NFH-0K;
        Mon, 05 Jun 2023 15:52:31 +0300
Date:   Mon, 5 Jun 2023 15:52:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused gpio_cansleep()
Message-ID: <ZH3ajj/tGc3VYvHT@smile.fi.intel.com>
References: <20230602150106.47783-1-andriy.shevchenko@linux.intel.com>
 <2fad9d11-ecc6-aa3d-8c0b-14b1f196ce74@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fad9d11-ecc6-aa3d-8c0b-14b1f196ce74@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:27:44AM +0800, Yanteng Si wrote:
> Hi andy,
> 
> On 2023/6/2 23:01, Andy Shevchenko wrote:

Thank you, I have incorporated the proposed amendments and it will be available
in v2 of this patch.

-- 
With Best Regards,
Andy Shevchenko


