Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8600465EFB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjAEPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjAEPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:09:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450345C1E8;
        Thu,  5 Jan 2023 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672931340; x=1704467340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VQr1KAn7DJn6wCEBbldmytZDYWPEdYKoAnRcIsQVKOc=;
  b=KoSfbdZenXqAg/9XdQzMmPQtCUEaGavL5257o4OiyBwabCCR+LDywAIN
   s2JYwjnrqMyvIDjnNlHuHP9W8xZezdkovob3nVQQNOpYjknXq/7YTOQOl
   hcT4KNCoIBchdy46Pqvn84NKfQ4IeZNcFVyHCmGLvcACg8E3aRdybEbeI
   6baDjPuXNFnTw0ryNXiUZ/k3QsJNpIB1UVZZvBMCtj42/6gbQxpZRZ+O7
   DvaWTlhlKbEuYg8a4zoBqznB5DmW/oN9z5AHkV3ENK1ed8D3K/bscoJm4
   vaU9pczIWMCMBj997yLPEMjPJccuQkZ0nuE34cnPvPjMR20aLJwyk7YWk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408477493"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408477493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 07:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="686128134"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="686128134"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2023 07:08:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pDRr7-004oHa-0D;
        Thu, 05 Jan 2023 17:08:33 +0200
Date:   Thu, 5 Jan 2023 17:08:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, matthias.bgg@gmail.com,
        chiaen_wu@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v15 RESEND 2/2] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Message-ID: <Y7bn8NPyBoBI2HFy@smile.fi.intel.com>
References: <cover.1672728620.git.chiaen_wu@richtek.com>
 <c1c6d3e51c93c15620ded0e2a53dcbe5de066ec9.1672728620.git.chiaen_wu@richtek.com>
 <Y7QoNpbFRsK3bW6V@smile.fi.intel.com>
 <CABtFH5KjksZ6GSOMafU8aS5mJzGkd8SDGEzH5irFUEFceQTWtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtFH5KjksZ6GSOMafU8aS5mJzGkd8SDGEzH5irFUEFceQTWtQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 06:25:01PM +0800, ChiaEn Wu wrote:
> On Tue, Jan 3, 2023 at 9:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > >  obj-$(CONFIG_LEDS_RT8515)    += leds-rt8515.o
> > >  obj-$(CONFIG_LEDS_SGM3140)   += leds-sgm3140.o
> > > +obj-$(CONFIG_LEDS_MT6370_FLASH)      += leds-mt6370-flash.o
> >
> > Can it be kept ordered?
> 
> hmm... I found "mt6360" actually did not keep the order either...
> Do you want me to put it after "max77693" or after "mt6360"??

Make it most ordered. From above context I can't say which one is the best.


-- 
With Best Regards,
Andy Shevchenko


