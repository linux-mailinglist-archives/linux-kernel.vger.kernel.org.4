Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B770761D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEQXDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjEQXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:03:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068246E88;
        Wed, 17 May 2023 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684364600; x=1715900600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+0dwq6i5SrTU+4itFIZkMLXuGYnuIgVovKsqf7sCNE=;
  b=bz3wfmJ8p2miQm5XNO0u2C5npXIqIHJYXvdiENkRR9G21n3fHt16Bxj9
   1K4u2ZpupFYtYD3gkvTOUKdzaO2qwFkSXFf9aSv6IIiHUd84iZ9/fqMhY
   pVe8BhZFsuKjUSGiTM+HIdhqxrvjmOJVActQCnCxeV9BXgsixxZ8gnYvD
   5tpW6Xyn0cSZKTqZO6EOuiuuaX0VZLqhiS+BijATBgSISdIKqdn9S6ACc
   i7tF25CvzgHNgL6Pa0HdU5jhrRejpOvkCLXz1eaVGOCvvwA+OaF1UOVLX
   pB7v/2Ud9IKcLJK2J0/EQvb6Fd+chyIKPgQu+TB0GUMaqU7bKwd7kA8Oe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="417561586"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="417561586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 16:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="771617280"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="771617280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2023 16:03:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pzQAl-000AU7-2p;
        Thu, 18 May 2023 02:03:07 +0300
Date:   Thu, 18 May 2023 02:03:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v11 3/3] spi: dw: Round of n_bytes to power of 2
Message-ID: <ZGVdK9jQ+zxRvOze@smile.fi.intel.com>
References: <20230512104746.1797865-1-joychakr@google.com>
 <20230512104746.1797865-4-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512104746.1797865-4-joychakr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:47:45AM +0000, Joy Chakraborty wrote:
> n_bytes variable in the driver represents the number of bytes per word
> that needs to be sent/copied to fifo. Bits/word can be between 8 and 32

FIFO

> bits from the client but in memory they are a power of 2, same is mentioned
> in spi.h header:

> "

Just a blank line is enough here.

>  * @bits_per_word: Data transfers involve one or more words; word sizes
>  *      like eight or 12 bits are common.  In-memory wordsizes are
>  *      powers of two bytes (e.g. 20 bit samples use 32 bits).
>  *      This may be changed by the device's driver, or left at the
>  *      default (0) indicating protocol words are eight bit bytes.
>  *      The spi_transfer.bits_per_word can override this for each transfer.
> "

And here.

> Hence, round of n_bytes to a power of 2 to avoid values like 3 which
> would generate unalligned/odd accesses to memory/fifo.

FIFO

> Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

> * tested on Baikal-T1 based system with DW SPI-looped back interface
> transferring a chunk of data with DFS:8,12,16.

This shouldn't be here. It's not a tag.

-- 
With Best Regards,
Andy Shevchenko


