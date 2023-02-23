Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78236A0FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBWSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBWSwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:52:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848890
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677178361; x=1708714361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T5c5dYd/7o6Mp7o1b1NX72cb1jT5ZAgXikuuyX1CoQk=;
  b=APcbSEzQTcov0Jkj2E3xZdS54oNSKfYOlQUsfidTc47OtQC7GNu1om/s
   Et7lrVryzHvwxBwdNTNZS3wEopIo3BCXLmSGtJMLuvq9okvhrXYkj9Hnf
   kUOT6rRu9j0FfrcZdR/b+d9g5zF+3Bk4cEaJN8/hTCPVk5WeOVxizgx2y
   wsut3pk0MXIbwbMfPd/nMtgcNqQ5LWcjN3WWUO9wBom+NbR4dNm9UneVk
   3/CmcJnlHyrb1KgBff4BoGDW4DGOBjwtyRm3NAnNZV0hFxhaKShypu2sr
   HpNc6LlUICCPE6/RfxSEMJHvNydx668XV2WawH+uqda8WBkn5yI15jQ29
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="312930513"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="312930513"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 10:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="665896092"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="665896092"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2023 10:52:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pVGhp-00B7dk-0N;
        Thu, 23 Feb 2023 20:52:37 +0200
Date:   Thu, 23 Feb 2023 20:52:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y/e19Oqf1XwDo/aw@smile.fi.intel.com>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
 <Y/ZGMDI9wcOwMUWI@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ZGMDI9wcOwMUWI@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:43:28AM -0500, William Breathitt Gray wrote:
> On Mon, Feb 20, 2023 at 05:33:34PM +0200, Andy Shevchenko wrote:
> > It seems that a couple of members got lost theirorder, put them back.
> 
> Looks like a typographical error here: "theirorder".

Ah, thanks!

...

> >  	unsigned int use_ack:1;
> >  	unsigned int ack_invert:1;
> >  	unsigned int clear_ack:1;
> > +	unsigned int status_invert:1;
> >  	unsigned int wake_invert:1;
> > -	unsigned int runtime_pm:1;
> >  	unsigned int type_in_mask:1;
> >  	unsigned int clear_on_unmask:1;
> > +	unsigned int runtime_pm:1;
> >  	unsigned int not_fixed_stride:1;
> > -	unsigned int status_invert:1;
> 
> These don't look alphabetical, so what is the order for these?

Nope, the order is to follow:
a) kernel doc
b) semantics of each of the groups

Do you think the order can be improved? Can you point out how?

-- 
With Best Regards,
Andy Shevchenko


