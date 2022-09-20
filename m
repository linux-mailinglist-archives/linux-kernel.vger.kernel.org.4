Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A769B5BE5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiITMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiITMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:35:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921DE75483;
        Tue, 20 Sep 2022 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663677333; x=1695213333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CQ0JS/VqnHFEwfrs/FBkCjfMdg77UcNq/QWSA/6J0aI=;
  b=Zd6Px3MsAj9rypgNd1vOJb+2LDtWCmrzf8XAuBn1aZdpNQlTCmFMQXpu
   OUR8kIJHO+2PbLjCiTb4a53dtD8QT+um+mvzGrGdyLObaRZWmppMhNQEu
   hRu6yBxjVw4YsnWN1ILV1l2949pJBuLB9F0sKz+PQCG2PIhrlq9WKCOPa
   EH10sTwDVOXgoqC7BrhqHOE2DZtkXrzgqeUAsITS5NazZewHW0hAcAmwB
   xyUf45RhVUPOtx5u/XTwBPTxCwhzzO00cMRydYX95WI7Ui0loVklDIyBE
   ILxBH3HMjJ0vD9Ix35VpFO3QHbl1n9Pyqz64M17GVpMy5PJI3IzpLctW+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298405309"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="298405309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="652077555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 05:35:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oacTF-004zS1-1F;
        Tue, 20 Sep 2022 15:35:25 +0300
Date:   Tue, 20 Sep 2022 15:35:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        timvp@google.com, hdegoede@redhat.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <YymzjfyjCYQqgP5O@smile.fi.intel.com>
References: <20220919155916.1044219-1-rrangel@chromium.org>
 <20220919095504.v4.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919095504.v4.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:59:08AM -0600, Raul E Rangel wrote:
> ACPI IRQ/Interrupt resources contain a bit that describes if the
> interrupt should wake the system. This change exposes that bit via
> a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> before arming an IRQ to wake the system.

(A nit-pick, but because of other patch comment)

...

> -			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> -					 ext_irq->triggering, ext_irq->polarity,
> -					 ext_irq->shareable, false);
> +			acpi_dev_get_irqresource(res,
> +						 ext_irq->interrupts[index],
> +						 ext_irq->triggering,
> +						 ext_irq->polarity,
> +						 ext_irq->shareable,
> +						 ext_irq->wake_capable,
> +						 false);

I understand this is done by a script, but it's unrelated indentation changes,
please just change what is related, like:

-					 ext_irq->shareable, false);
+					 ext_irq->shareable, ext_irq->wake_capable,
+					 false);

-- 
With Best Regards,
Andy Shevchenko


