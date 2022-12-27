Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC56656E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiL0ULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 15:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0ULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:11:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F6EE67;
        Tue, 27 Dec 2022 12:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672171863; x=1703707863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZe9g/BRs1pwpm2oRodWlUNpn0uToVJhlchWGIMzD3g=;
  b=EwC9wwpDavylPyP5o0Ldlob39zjFrwrG5bmg5Ez3lLwDClO1YHamq4eZ
   XCnpkNqRW204vR/YCrBqlmY8HzbxHJrK/DD4bx4w0HqkPo5YyuKTZ9HqW
   N3lJgkZQxMYjd2nph72A/NFNaf8fRQC7t8/an2qtPaggvqNZp5kDa+4it
   y4qY7L5YtAHbXmsaH0re1FFbCKvChKtfHPGktQEv6LXo2MfVPfciU/xr6
   t2lEV5+AJcs1K0L1LXciNbhBc+XutjjubtNa5lPB/v9GP6n1SZ8Z14Frc
   Rpgn1rTa++MBhxC3yOVZ7MyRUl83XCRO/gSDkZNOhElfhCpOAUaI6/mGB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407017066"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407017066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="630774323"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="630774323"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Dec 2022 12:10:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAGHo-000Djo-1C;
        Tue, 27 Dec 2022 22:10:56 +0200
Date:   Tue, 27 Dec 2022 22:10:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add MAX77541/MAX77540 PMIC Support
Message-ID: <Y6tRUOwwrk5ZlD84@smile.fi.intel.com>
References: <20221226225158.106055-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226225158.106055-1-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 01:51:50AM +0300, Okan Sahin wrote:
> MFD, regulator and ADC driver and related bindings for MAX77540/MAX77541.
> The patches are requeired to be applied in sequence.

I have got only a single message, i.e. cover letter. What am I supposed
to do here?

-- 
With Best Regards,
Andy Shevchenko


