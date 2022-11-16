Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC062BF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiKPNhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiKPNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:36:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710564EA;
        Wed, 16 Nov 2022 05:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668605813; x=1700141813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JELkfQUrNNjTFHvCmopSzT6F8rwD4FHhQPiEyR2Qkz0=;
  b=fiRd22VUhcPlY+LYsrYNBJDYtHtrC5Nh2hArsGJuSV6n2wAiWN3vN4u3
   CXArsMogFjGFBqprITbvHdiyteCJVMq8wSkETrIXt5X8Dabb9hrQKV4P7
   OpEy81KoHLOImPO6K4lMC2dqBvNNvL393oDC+D27FfYzv0JfwOHD1viEW
   i98ixEhWce1v22tBNoL3oClxvjoeseoD3+wBVhZj0Et4gmQlRkR9zhEkC
   fsHYjMpVWkCbbjthWbGkZVjyQsXYr7ZTq8OcwDVnI34iFlzoeTa5dSI8/
   KY82FdnVW/bRuZdRXh3h1wpx5LeQPGIQxymkNqiHLePfOh2UQc0adRCeu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312549354"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312549354"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 05:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968424218"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968424218"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2022 05:36:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovIak-00D90f-0E;
        Wed, 16 Nov 2022 15:36:38 +0200
Date:   Wed, 16 Nov 2022 15:36:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>,
        "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
        "sodaville@linutronix.de" <sodaville@linutronix.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v2 2/2] x86/of: Convert & update Intel's APIC related
 binding schemas
Message-ID: <Y3TnZYjD9fZ74wOK@smile.fi.intel.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <5ba7963fbd82a859ffd99c6d8edb4d717fce0e6c.1668589253.git.rtanwar@maxlinear.com>
 <Y3S+cgOm1vHq/kv9@smile.fi.intel.com>
 <db4c2ec5-d4ac-c2b8-0b6f-89ae926ac1ee@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db4c2ec5-d4ac-c2b8-0b6f-89ae926ac1ee@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:52:59AM +0000, Rahul Tanwar wrote:
> On 16/11/2022 6:42 pm, Andy Shevchenko wrote:
> > On Wed, Nov 16, 2022 at 06:28:21PM +0800, Rahul Tanwar wrote:
> >> Intel's APIC family of interrupt controllers support local APIC
> >> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> >> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> >>
> >> Also, update more info and newly introduced optional property for
> >> lapic to choose legacy PIC or virtual wire compatibility interrupt
> >> delivery mode.
> > 
> > Conversion should be split from a new property addition.
> > 
> 
> Do you mean, i first update older text file with new property addition
> and then later convert it into YAML i.e. for now i just update existing 
> text file with new addition and later convert them to YAML schema ? Thanks.

Patch 1: Convert to YAML (no content changes except its format)
Patch 2: Introducing a new property
Patch 3: Updating code in x86

First two must be send to the DT people and have their Acks/Rb after all.

-- 
With Best Regards,
Andy Shevchenko


