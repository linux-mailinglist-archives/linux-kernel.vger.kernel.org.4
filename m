Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871947236A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjFFFLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjFFFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:11:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C9123;
        Mon,  5 Jun 2023 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686028272; x=1717564272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/y9Ibxhn7QI1vqH8tx8k3cKEEBl0vnbxxYlUaZcgDRU=;
  b=FHJswNyFomWiGE3BaoOsZeUwTYi9fe0iQlETjseD0OC3CdRhW5NwQK9K
   Bl3LjR6KRp8b1Q/W4+IouOvXir/5CJIn69hYU8pW6rS8F2VkneiSwEMJp
   u3KNO15f/Kplu4pygjWzxaTYQJ5AmnM7jUvknxawq3kvgqyHuZ1DufIXk
   czQZ3oifhMkFCr1NH44eAa33rGguvezsm96bEOzisZaN1NQpU9KS18QbF
   QvAxDl6QkexkWpGtOOujMkv3XM/OMuDms8DdDA1dgIy/r8yZMtQjgcG19
   KD8Ksf74cCRtGvU76znBSwoUqjdZo2nUI04HyXk/Zt+tQn0UWsSkeAoQE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336923252"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="336923252"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="833075953"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="833075953"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2023 22:11:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8937734F; Tue,  6 Jun 2023 08:11:16 +0300 (EEST)
Date:   Tue, 6 Jun 2023 08:11:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: cherryview: Return correct value if pin
 in push-pull mode
Message-ID: <20230606051116.GU45886@black.fi.intel.com>
References: <20230605143734.73434-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605143734.73434-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 05:37:34PM +0300, Andy Shevchenko wrote:
> Currently the getter returns ENOTSUPP on pin configured in
> the push-pull mode. Fix this by adding the missed switch case.
> 
> Fixes: ccdf81d08dbe ("pinctrl: cherryview: add option to set open-drain pin config")
> Fixes: 6e08d6bbebeb ("pinctrl: Add Intel Cherryview/Braswell pin controller support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
