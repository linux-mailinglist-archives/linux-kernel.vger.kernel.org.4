Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD1651A95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiLTGSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiLTGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:18:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0BD2C8;
        Mon, 19 Dec 2022 22:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671517095; x=1703053095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WsZmWKqOwZ07+RR1l0e8u+N6CmhZA2Av9/5pF57cJns=;
  b=VhbTY4IrhOUMJg/RNFYzO00k3/CvowVHwz7KUlXLOSBMPMB5CIJueDIt
   kUDQuU4OxbyVbDHVWEkFIxTy9TFv4yP0PdTLk11oq3gIC1MxJxgvPtSSc
   i04GAvpZ5ltNK0Tp+9/KcVjoaSaGz4PGHsNBaMTaWY9d5ddM8MAP0MsyP
   SXJTBw/mmuTQGvsWgSrnvhjsWvX9jti+0I3ITacwEjqUzlyhZacmcIpI0
   BHWBLHiUs5kWohh86gHKnfwhSquFo4JXkTp6IyI3rnzHIRkhCfKvHewSZ
   XOuNG4UT73xWfVjdEyfYP0F3tNwOmA9I4cjtGzkxqMtn5qq41Ur70u5Aw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="319592329"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="319592329"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 22:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="683299120"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="683299120"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2022 22:18:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 197AEF7; Tue, 20 Dec 2022 08:18:42 +0200 (EET)
Date:   Tue, 20 Dec 2022 08:18:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] pinctrl: intel: Add default case to
 intel_config_set_pull()
Message-ID: <Y6FTwscP2xOw5ADE@black.fi.intel.com>
References: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
 <Y6B4HrOXNPXGBDWZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6B4HrOXNPXGBDWZ@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:41:34PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 02:32:05PM +0200, Andy Shevchenko wrote:
> > For the sake of symmetry with intel_config_get_pull(), add
> > a default case to the outer switch.
> 
> The stats for the entire series:
> 
>  drivers/pinctrl/intel/pinctrl-intel.c | 45 +++++++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 18 deletions(-)

Thanks!

For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
