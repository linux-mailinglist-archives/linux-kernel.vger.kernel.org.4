Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1147700636
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbjELLC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbjELLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:02:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25212EAD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683889330; x=1715425330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/vGDmWyb7O/CVbDWwj1/T/1ZQcEflXOl6DRVuJnaLjM=;
  b=hdJ/a6EXm8QOokTKMSUJsyEJj7xckk8u7Lw5Uit036QTFCFkmcsmnLX8
   uOwpP2PqacLsRt/n+qHz0ItEnHaUZlWDdVN55SwzYAtggRO4wLLdzrl5D
   G9T61GlmdbVv4MINHk0s1uw+1aItvSLq9kr/3S2M3xh5jN/1JpUgjW3bJ
   HoApyejxrMmNFHhn815XSx2gA7wiwypO5RxS8bJS8hFB2V3ReHQ11Rw13
   EejyP+5n1vhtF/DJAXUSTnlTt+H4DhRKxslAwbLO1/hEDoWVLTuYwGcvb
   r4eG+Ag8bIsCisGap/E5+gHZ0+n/jadG9th1NxBwfdaaBF3z4t1nrpwuu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378897537"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378897537"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="733010189"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="733010189"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2023 04:02:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pxQXG-0004aB-2A;
        Fri, 12 May 2023 14:02:06 +0300
Date:   Fri, 12 May 2023 14:02:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: Re: [RFC PATCH 05/13] list.h: Fix parentheses around macro pointer
 parameter use
Message-ID: <ZF4crs8iKBGH3lJe@smile.fi.intel.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-6-mathieu.desnoyers@efficios.com>
 <ZFjoJqbDn/BL1GQT@smile.fi.intel.com>
 <6971bfd0-b200-6cb8-7cd8-9973b72ef9ba@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6971bfd0-b200-6cb8-7cd8-9973b72ef9ba@efficios.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:46:40AM -0400, Mathieu Desnoyers wrote:
> On 2023-05-08 08:16, Andy Shevchenko wrote:

...

> The only use I found that would break is as follows:
> 
> LIST_HEAD(testlist);
> 
> int f2(void)
> {
>         return 1;
> }
> 
> #define eval(...)       __VA_ARGS__
> 
> void f(void)
> {
>    struct list_head *pos;
> 
>    list_for_each(pos, eval(f2(), &testlist)) {
>            //...
>    }
> }
> 
> Because "eval()" will evaluate "f(), &testlist" with comma and all, without
> enclosing parentheses.
> 
> So the question is: do we want to support this kind-of-odd macro evaluation,
> considering that it requires adding parentheses around pretty much all macro
> parameters when used as expressions between commas?

Similar question can be asked for your initial motivation to support indirect
pointers. I found the double pointer as weird as this macro case. But it can be
only me. Hence I left this to the more experienced developers to express their
opinions.

-- 
With Best Regards,
Andy Shevchenko


