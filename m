Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE9472A059
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjFIQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFIQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:41:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A73AAC;
        Fri,  9 Jun 2023 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686328900; x=1717864900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGHw0GIh6cheMahMfWCeEaMngP4Hko4mlOPZZvZpodw=;
  b=cFXWIWpiVy9OniKhXmBne4qwHq8sAmUOcbYLCUQFiQKp9TAIokUSPHox
   NJNtF4eRBQHHzjmdOUKq9AKVt9o5WiO+F39zFaE+iTxCVs2L/W+85KH4D
   y/ch4hwdrgzuvWGaC+0zcmu8SQxXXlcg50WQqc5666CxU4fV1xvIuE4hV
   dICiIgdCchwG0o5dIgx3Mvl9ADZwOXVbpmNvTAGXZF291N8mBPPBweZzm
   sqYlSxe6yJ4B2rZSTBCX1ZpqLoixk49EPzrW8wPYTUf0/kJEo5ptkma85
   X/J45OWDkQbuq6bWshX0nQbtoGxbAl7XmUNQiWafQsGEduCyKE46cvBk+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342315858"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="342315858"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 09:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="823126183"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="823126183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2023 09:41:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7fB4-002Rxv-0d;
        Fri, 09 Jun 2023 19:41:30 +0300
Date:   Fri, 9 Jun 2023 19:41:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v2 1/4] pinctrl: intel: refine set_mux hook
Message-ID: <ZINWOWLjyZk2Gj3j@smile.fi.intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
 <20230609082539.24311-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609082539.24311-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 01:55:36PM +0530, Raag Jadav wrote:
> Utilize a temporary variable for common shift operation
> inside ->set_mux() hook and improve readability.

Seems the bloat-o-meter statistics is missing here.

-- 
With Best Regards,
Andy Shevchenko


