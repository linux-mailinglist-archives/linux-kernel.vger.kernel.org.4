Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4123D5BE612
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiITMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiITMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:41:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700A6D541
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663677659; x=1695213659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V2BYHTC7y1t+CL2r/JyeDBXMO9m2ezRDcckIY4/M8Dc=;
  b=GjQfaK9PprfFf98J/bXNjbIL29KGSEtyWhfOIPAqyjvU6W5nkvTOWsLs
   m+aLO5mjzx8p+dhPhDCbkSOobZJUiGkJb2RAH5YRA/CAtRLl03rQY7TU7
   adOof5nZQiM70XdGJEd0euo5GWPhJOK8bOI9eFSnmYVow8X7g2mejsJia
   Bxrr/pCu4dR+uh/1sfjBLOcksXr17Y3h1hHbQRd9aEOhj+87S0tRdadU+
   vzRF8cQqbgWuo0T5NxVEm89n6XjKrdj3KZVvnu1IAUhvIzwrd6/BB447J
   DVSNNwLmR4p7+L7fV9h/ujJu/ITZ9duwOxdwvjrFIO8Kaoiq6+qSjz8Kn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280061447"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="280061447"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="744520200"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2022 05:40:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oacYZ-004zXp-1d;
        Tue, 20 Sep 2022 15:40:55 +0300
Date:   Tue, 20 Sep 2022 15:40:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 1/1] HSI: nokia-modem: Replace of_gpio_count() by
 gpiod_count()
Message-ID: <Yym01zusrm4qX7sv@smile.fi.intel.com>
References: <20220914153755.37866-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914153755.37866-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:37:55PM +0300, Andy Shevchenko wrote:
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko


