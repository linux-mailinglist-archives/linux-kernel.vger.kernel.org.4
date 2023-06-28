Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB02B7413EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjF1Oi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:38:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:51261 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbjF1Oix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963133; x=1719499133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbL6+8IOydZgwh2S4eqQZSEu5o5novv5z8EuQf1SO+U=;
  b=lkBm+CyGpLQDq53PJIKoapOZaIT6HhHzbM/KUdE9fPGLUmrEFT2cQztJ
   xc9rR0hVVhZF7lBtHnDEH3B0istq/d7XmkVxrR6wILTNV45i7iKUymHur
   6FmY1cO8OGxDwQor1LUd6XKaIGsftSV8ifWd+5+m66A8v8KbPBWgEPuvj
   8VLNXRjv8a8Lfvs+x4480jAgldkJqdITwcMD9/6IWwSb5vri+N7b8wsnF
   TAkFglEewpryxh4DW+MXzaUo34tfARFmRU8CFbDaVXKAuVP4JvbxgTctu
   j9DhQnCrVsswge452I6syOp79/+GlmdDwGincGXxAZPe7ZXOh+SamYszA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365323111"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="365323111"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="711062902"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="711062902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2023 07:38:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEWJb-000clN-2U;
        Wed, 28 Jun 2023 17:38:39 +0300
Date:   Wed, 28 Jun 2023 17:38:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     You Kangren <youkangren@vivo.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] crypto: qat - use min() in fw loader
Message-ID: <ZJxF77bNAQ79OpWs@smile.fi.intel.com>
References: <20230627071726.20578-1-youkangren@vivo.com>
 <ZJwPlLC7/sJP8U7u@smile.fi.intel.com>
 <ZJwxmUGPsIlTv+TG@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJwxmUGPsIlTv+TG@gcabiddu-mobl1.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 02:11:53PM +0100, Giovanni Cabiddu wrote:
> On Wed, Jun 28, 2023 at 01:46:44PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 27, 2023 at 03:17:24PM +0800, You Kangren wrote:

...

> > min_t() can be dangerous some times.
> > 
> > To make it robust I would suggest to use min() and mark UWORD_CPYBUF_SIZE
> > with U suffix to make the type the same.
> Thanks. I reworked it, added a missing include and ordered the includes
> in the file.

I think it should be two patches then, but it's up to you and subsystem
maintainer.

-- 
With Best Regards,
Andy Shevchenko


