Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A368C000
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBFOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBFOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:25:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9318B;
        Mon,  6 Feb 2023 06:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675693548; x=1707229548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rATt2PX8P75QhOIAjUfrO77yb+4mDlyqMVW4eOWEDpg=;
  b=jkP4qJyyOpvE0YAdCeKID2veEpSEasY9Q3iBL0gMxQUYpssnCWIpKhru
   10Fv/OmV6RacLVAWPh6JPFClz1wULSehIdmAeI7lV7TrArpKrux3IOFfX
   K9CFsfhei2oOza0olV28ZQIg64glVxd7xSRCRGj/pMJ7GQCxP9e7uq+I5
   FnuvoxGPJAQyuH71jGeNcY/ncaKQWfXcR4xc6kC+Ucc48YsojGP4o2IXG
   OcpZvED9Wp0PA6FaWZtx7ALOHM2yvHllOH7S0maE4QB0VUH6d9/nltXpO
   PrQIdSgXNtBTNLsTPK4ZH3UAhSfGfGi98EqLY5QgJON0dHcuL1VneRoy4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312870294"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312870294"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 06:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775183443"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775183443"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2023 06:25:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A31AC241; Mon,  6 Feb 2023 16:26:24 +0200 (EET)
Date:   Mon, 6 Feb 2023 16:26:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jim Minter <jimminter@microsoft.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be
 in Direct IRQ mode
Message-ID: <Y+EOEHgDK3cRUmr6@black.fi.intel.com>
References: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 04:15:59PM +0200, Andy Shevchenko wrote:
> If the firmware mangled the register contents too much,
> check the saved value for the Direct IRQ mode. If it
> matches, we will restore the pin state.
> 
> Reported-by: Jim Minter <jimminter@microsoft.com>
> Fixes: 6989ea4881c8 ("pinctrl: intel: Save and restore pins in "direct IRQ" mode")
> Tested-by: Jim Minter <jimminter@microsoft.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
