Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB7742319
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjF2JUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjF2JUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:20:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E230107;
        Thu, 29 Jun 2023 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688030442; x=1719566442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7gZ4/CukNppLRuBzD2qOl8DYO973DAjz6Z0U7eO0W4c=;
  b=G4r/Fe1wRrH31bB+E5waaFFclxRj5wS6MImiX56qJz1AWDRnXi/Jam/p
   0BHUsxrsghtwwXdX4oY34aMWFyrgohDS/cDOfL5QkrfgYwuAC0Vw3CO7Y
   fn2N7/GZyNWTUl85H9HBX2AKKxwlXM0ppr56RoHY7QyX1wE4rghXu8GuS
   EQMdLk1ewbbpFf4+uwKslIvkrxIXbSdOT4NyN8Qp2OlCi6QJZcL14JSmS
   3xUy6R5Xbf1e48DJWeuJywVhikwLcpybyFBUBSOYsOcCNC8qQR1dGBRQD
   sevLV39kaw83Qn8fnfsuTn+KJPrGvXeiz2m6G77jKwdY880mMSwf48/PQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="425735227"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="425735227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 02:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963924757"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="963924757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2023 02:20:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEnpN-000oND-29;
        Thu, 29 Jun 2023 12:20:37 +0300
Date:   Thu, 29 Jun 2023 12:20:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ruihongluo <colorsu1922@gmail.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        ruihongluo <luoruihong@xiaomi.com>
Subject: Re: [PATCH v1 1/1] serial: 8250: Preserve original value of DLF
 register
Message-ID: <ZJ1M5QvyWzgWNlpE@smile.fi.intel.com>
References: <20230628152135.56286-1-luoruihong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628152135.56286-1-luoruihong@xiaomi.com>
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

On Wed, Jun 28, 2023 at 11:21:37PM +0800, ruihongluo wrote:
> This commit is aimed at preserving the original value of the

"This commit is aimed at preserving the original..." -->
"Preserve the original..."

> DLF(Divisor Latch Fraction Register). When the DLF register is
> modified without preservation, it can disrupt the baudrate settings
> established by firmware or bootloader , leading to data corruption
> and the generation of unreadable or distorted characters.

You have From different to SoB. You need to fix this.
It can be done by setting corresponding values in the ~/.gitconfig
of your machine where you are making patches on.

Quick fix is to run

	git commit --amend --author="ruihongluo <luoruihong@xiaomi.com>"

and resend as a v2.

Code wise looks good to me, thank you for fixing this.
Perhaps it needs a Fixes tag, as

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")

added before your SoB line. (Again, use `git commit --amend` to address
this.)

> Signed-off-by: ruihongluo <luoruihong@xiaomi.com>
> ---

Also don't forget to add a changelog here for v2 to describe your changes.

-- 
With Best Regards,
Andy Shevchenko


