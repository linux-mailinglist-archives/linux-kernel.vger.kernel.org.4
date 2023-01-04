Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B446365D78F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjADPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbjADPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:51:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA043C38A;
        Wed,  4 Jan 2023 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672847500; x=1704383500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yd+8UlKLLBzhcftUBY+oHqG8KLyn72UMHSYUk/7mHkc=;
  b=a9BNt9QyBl9lSO4Tmpbk0fobHYODjHXI7IrUYn1dtm790w3PBomX2NHu
   CSRTif0aBfFNbEp9zy786vCYWBoTxzCgbfeoB3Ur+mJtQWnGyYl7PoQiT
   fpLRMte6u5qfWxhxB6o2ZCiqKtF10uTqH49gyyoUq57YHvJ+KOfZekxP9
   HKbWUmHIOS7KZiZqhPfHG8y2oWFeFPyaYnKHfH5YXxI+dPjvlrC5MbhSf
   WoGjR9J3y5c/DMOE48Z1JOUvEUdLjTD+2GJbGn3dtvH0mjL79Z6XHZgTp
   C/fFpX5cTjNWTLo8WBS1umQLM/X59QQ+DAwRjQhM17CT4zX/PhwOtrYzn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301652952"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301652952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655221145"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="655221145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2023 07:51:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD63B-004MoS-31;
        Wed, 04 Jan 2023 17:51:33 +0200
Date:   Wed, 4 Jan 2023 17:51:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y7WghcaWPpCHh6Wz@smile.fi.intel.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y6WX1Y9GZmvxqlCc@google.com>
 <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
 <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
 <Y7WMHl1Mv1alXadG@google.com>
 <20230104153924.0b92c52c@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104153924.0b92c52c@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 03:39:24PM +0100, Henning Schild wrote:
> Am Wed, 4 Jan 2023 14:24:30 +0000
> schrieb Lee Jones <lee@kernel.org>:

...

> As we speak i already have the third box to eventually support, which
> will likely be similar but this time around with PINCTRL_ELKHARTLAKE

A bit of offtopic here.

Are you able to get / fix / ... the firmware to work with the upstreamed
version of pin control driver for Intel Elkhart Lake?

(I'm asking this in terms of the https://bugzilla.kernel.org/show_bug.cgi?id=213365)

-- 
With Best Regards,
Andy Shevchenko


