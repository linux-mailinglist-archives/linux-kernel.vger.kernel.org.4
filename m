Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945B741403
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjF1OpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:45:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:48671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231833AbjF1OpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963506; x=1719499506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5vCRBYpY7jo1Ni88rEwRhjkpOvVkhHCe9+LLsHYVXK4=;
  b=jr48XKIGlUN88VQqm+1L0HwleBepg3HBpU/+RiclWD58VgyyPi1CFprB
   uPC6B6TFBW2h13i+Bdz0muJ79rkhd4vY3+H1GSBKI77tlmQvPMl3VfYKn
   5Kmw5OQ/T1hOVftyCR7QglG8PE2vuoDc9HvhedQI1TvXRBv10/byIqgJy
   9mJr0HfdJh7TTAB/noxq6ZT4fOCkXAmFADvLNOFqbo4UPvqRyL1KlPd7t
   OSZzgdwMzbEB5vOoINBNPOrIr+2ZGQyeoW2CkP4HMsmtE/GuEpTk8iYsg
   tTFtly0faebqBYLDLGn87Gz+ep711BrlUQfci9R5frDFTCcxFvuKlNfx1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="351651669"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351651669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752276046"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="752276046"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 07:45:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEWPj-000cqM-2r;
        Wed, 28 Jun 2023 17:44:59 +0300
Date:   Wed, 28 Jun 2023 17:44:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [RFC PATCH 4/8] ALSA: hda/i915: Update PCI IDs
Message-ID: <ZJxHa36/xN3kClw0@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-5-amadeuszx.slawinski@linux.intel.com>
 <ZJxG7YRroqi6kiyz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJxG7YRroqi6kiyz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:42:54PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 28, 2023 at 10:51:31PM +0200, Amadeusz Sławiński wrote:

...

> > -#define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
> > -				((pci)->device == 0x0c0c) || \
> > -				((pci)->device == 0x0d0c) || \
> > -				((pci)->device == 0x160c))
> > +#define IS_HSW_CONTROLLER(pci) (((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_0) || \
> > +				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_2) || \
> > +				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_3) || \
> > +				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_BDW))
> 
> The very same macro under different name appeared in the previous patch.
> Am I correct? Perhaps go further and first move it somewhere to be available
> for both?

Ah, this one is a subset of that one, nevertheless the proposal stays.

-- 
With Best Regards,
Andy Shevchenko


