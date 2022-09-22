Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E575E6668
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIVPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:04:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5E6310;
        Thu, 22 Sep 2022 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663859073; x=1695395073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0SOmpnIhXbxL0WPVHjaLmgvvMBk2HDBU41MSJusvK8=;
  b=KnGtnFD1+IbgcmDROHu/N7J34OQM+JnNjXxmOXOA8FAxvfS73DouC3xP
   lX22L7ib6TpD7ZvjYPjGxNVuUTBB+T7acB6foAd3PkKGrPv4u7F6pag1K
   XGDE+6aQ6clG9bv5oiOQJrXWO4W/6zMxNd6XAoobYj6kZgZMTVPBV9MNF
   RF/Yd7fXX6lguIbV11aChBtLBhAsXuCMcgVk/dlCJwE3PMaOaz/dShAOi
   4GJEJEKPaFt4mtoCV9mRjrQ79Dg6dsHpgWZxw+re/g+KFhkKhsqtuRPa5
   geEoXtdcUDJ5SNAD7U0DgOyPQmPMeWpADTHD32yJtZ55Bac6IaxPJ979u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297917608"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297917608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 08:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="650551318"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 08:03:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obNji-0063HF-0m;
        Thu, 22 Sep 2022 18:03:34 +0300
Date:   Thu, 22 Sep 2022 18:03:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_omap: Convert to use
 uart_xmit_advance()
Message-ID: <Yyx5RYkN6BMG8T6M@smile.fi.intel.com>
References: <20220909091258.68886-1-andriy.shevchenko@linux.intel.com>
 <Yyxs4NSxYs/KrQyt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyxs4NSxYs/KrQyt@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:10:40PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 09, 2022 at 12:12:58PM +0300, Andy Shevchenko wrote:

...

> Breaks the build :(

As per other thread, will be sent after v6.1-rc1 is out.

-- 
With Best Regards,
Andy Shevchenko


