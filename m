Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF173DD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjFZLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFZLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:15:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F419BF;
        Mon, 26 Jun 2023 04:14:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="427235526"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="427235526"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 04:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="890248760"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="890248760"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2023 04:14:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qDkB3-006kDE-1X;
        Mon, 26 Jun 2023 14:14:37 +0300
Date:   Mon, 26 Jun 2023 14:14:37 +0300
From:   "andy@kernel.org" <andy@kernel.org>
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2 1/2] gpiolib:
 cdev: Fix &lr->wait.lock deadlock issue
Message-ID: <ZJlzHc8eiHnPe+Ot@smile.fi.intel.com>
References: <TYCP286MB1188A94580A60F47CAF892C88A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJlwjhQT2wfO3Ukn@smile.fi.intel.com>
 <TYCP286MB11884755575685089C1BBDC38A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB11884755575685089C1BBDC38A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:06:05AM +0000, YE Chengfeng wrote:
> Thanks for the reminder. Would fix the problems and send new patches soon.

Please, avoid top postings!

Also you must follow this https://docs.kernel.org/process/researcher-guidelines.html.

-- 
With Best Regards,
Andy Shevchenko


