Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6170400A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbjEOVqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjEOVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:45:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE855127;
        Mon, 15 May 2023 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684187158; x=1715723158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Prwu9Uk+PDd3I1x2mRYVxlayRK7xUMoPvr/NmZgu5XA=;
  b=herFdI0zKldh2C+7W4dWxSAOIIy8ePUFZzayByxlfdDa6UidJU7vXYIN
   yp2WC1Uet8mEeknOOlpjPbri3hGC3/nIYGl1IfKwhBE7rsRWYfoZ55yaY
   2JaCv9/jnIJyFtbc8qzCYHdZQBfA0hCwxceKiRPRO1+D7s1mpA79pOUNC
   wpskb8SXuVqqIl9mzhiuXq3ITSGJFIdptR9gOcAXbqZl+lPZ0wgQgP0f+
   GQq4+by4zN9hQ3KVBnZXXMEP3ujRBp8H1ki83z+/t8lNfzrYxFKDZ3J7+
   BYyF/qS63Pt9BRjKcSKOfECHKbWxnwCvdKO1Qor6g4xyoylv5bxOqfl/g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="351352123"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="351352123"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="678581705"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="678581705"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2023 14:45:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pyg0u-00075J-2m;
        Tue, 16 May 2023 00:45:52 +0300
Date:   Tue, 16 May 2023 00:45:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: tmp006: Add OF device matching
 support
Message-ID: <ZGKoEAgJguAINlaW@smile.fi.intel.com>
References: <cover.1684089997.git.anupnewsmail@gmail.com>
 <d0114a66fa3e9fb07a98dde3cc0bd87c526a3753.1684089997.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0114a66fa3e9fb07a98dde3cc0bd87c526a3753.1684089997.git.anupnewsmail@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:33:06AM +0530, Anup Sharma wrote:
> Adds an of_device_id table entry to the driver, enabling
> device matching through device tree. With this update, the driver
> can now match devices using both the i2c_device_id entry and the
> newly added of_device_id table.

...

>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/bitops.h>

> +#include <linux/mod_devicetable.h>

Can you try to keep this ordered as much as possible? (For example, by locating
a new inclusion near to module.h)

...

> +static const struct of_device_id tmp006_of_match[] = {
> +	{ .compatible = "ti,tmp006", },

Inner comma is not needed.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


