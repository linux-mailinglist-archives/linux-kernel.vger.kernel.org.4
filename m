Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E516F4ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEBUBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEBUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:01:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64D10FF;
        Tue,  2 May 2023 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683057679; x=1714593679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XNLfq1FKE5HOh8rOGIhhAA4qWJQTxU3C5Z2Bm9Da1bg=;
  b=hUAXw2vnebwa8AAVwofdj18whP0L71vW+jselfduEgd0Wp9LswCCww8Z
   1vawo4jLsNmnyv7y1YwPk43s8jnvknwHD2G7Ogpu356LCppyEsFX4V2m1
   5cGKwEH461TqgVQhiXJUpTzmlC0SjlfC/1f6A6MSeG9EcMmkWH19Zigge
   9skox8iNRdfm2KGjeNv+Aib37cwYCgaD/wDAUdnvsQXQAK/48rcQIKacQ
   6U53/dxZ6LpQNGT8HXHjzQgjSglDOPvfPNEdl3b41P2TbkxLG9cNQS0oA
   HBsz+DKNqXBIJkKy02R4ZMNyUxpQ7oidSKQs96v08bt1caBQbiz5wJ73e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="351472440"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="351472440"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 13:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="761246188"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="761246188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2023 13:01:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ptwBU-008DEp-1k;
        Tue, 02 May 2023 23:01:12 +0300
Date:   Tue, 2 May 2023 23:01:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Konrad =?iso-8859-1?Q?Gr=E4fe?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Message-ID: <ZFFsCHzbS6B0+Jbp@smile.fi.intel.com>
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
 <954a3b8d5be0487e8ead23bef450fabe@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <954a3b8d5be0487e8ead23bef450fabe@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 07:46:14AM +0000, David Laight wrote:
> From: Rasmus Villemoes
> > Sent: 28 April 2023 07:57
> > On 27/04/2023 13.51, Konrad Gräfe wrote:
> > > The CDC-ECM specification requires an USB gadget to send the host MAC
> > > address as uppercase hex string. This change adds the appropriate
> > > modifier.
> > 
> > Thinking more about it, I'm not sure this is appropriate, not for a
> > single user like this. vsprintf() should not and cannot satisfy all
> > possible string formatting requirements for the whole kernel. The %pX
> > extensions are convenient for use with printk() and friends where one
> > needs what in other languages would be "string interpolation" (because
> > then the caller doesn't need to deal with temporary stack buffers and
> > pass them as %s arguments), but for single items like this, snprintf()
> > is not necessarily the right tool for the job.
> > 
> > In this case, the caller can just as well call string_upper() on the
> > result, or not use sprintf() at all and do a tiny loop with
> > hex_byte_pack_upper().
> 
> Or snprintf with "%02X:%02X:%02X:%02X:%02X:%02X".

Of course this is a step back. Why? Have you read actually what we have in %p
extensions already?

Also, what about stack?

Entire %pm/M exists due to reversed order. Otherwise it's an alias to %6phD or
alike.

-- 
With Best Regards,
Andy Shevchenko


