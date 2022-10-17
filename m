Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7760157F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJQRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJQRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:35:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFC757BD7;
        Mon, 17 Oct 2022 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666028122; x=1697564122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRXn6DtoMsdNcDLaHy1tDtZ6Q8cgyt8khp6TmWhX7QY=;
  b=Vzb/PuqnxmpL2tqYzo/aH0p4LOuWydZCS86Cm/tF2UsEuiSoi+2IAGd1
   EQIctYI+QTFf08iSjprD5qHMNilElRcWf5D+LfbN5lu5GEOZH+iyAzMeQ
   MiFeo9hDRSM4U14jyatXHtjfk0AyoEQguf0oIxeifjnbECs5qXeNT8Roh
   df3avd33b114yqjBIzOCkwreAT09Coq2P/iWU2acQ1/nByAlh1Gun0RSH
   JRvqVxRQrmHKScjdJGVkceK/YJPvjsHD82CY6vVvEdBRdnwDiNaM6g9sG
   9zGimyo8S9qdcrug8BPiHXsIxadOfQC+Su28+xt3HVNoFkqhHYOelQhId
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289162918"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="289162918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691448303"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="691448303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 10:35:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okU1F-008wba-0m;
        Mon, 17 Oct 2022 20:35:17 +0300
Date:   Mon, 17 Oct 2022 20:35:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02ObkYoUQlY9oG/@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:18:38PM +0100, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 08:12:40PM +0300, Andy Shevchenko wrote:
> 
> > Since the PCI enumerated devices provide a property with SSP type,
> > there is no more necessity to bear the copy of the ID table here.
> > Remove it for good.
> 
> They do?  How?  Are you sure that this is true for all existing devices?

Currently the board code assures that the property is always there for all
existing devices.

-- 
With Best Regards,
Andy Shevchenko


