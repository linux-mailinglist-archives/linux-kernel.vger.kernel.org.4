Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4249272F407
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbjFNFOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbjFNFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:14:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3901A5;
        Tue, 13 Jun 2023 22:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686719662; x=1718255662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=icD36a7n6ocKgddwMxknQvdovYsG935WQbJhgnTH0s8=;
  b=BYHtW65jdfWOVuYq878BGEJc22cVwCKhiBtJObIW+JTGvq7wOKBU/NlH
   Htu+htd9YJ0qfiy2zEzeDoY7rmvfjzmPCen60notyhZ9mN7XIBVEAJ6Br
   YL6AcwhsvZnYG51zyMxiCDj26LHf+dH5k0WF4URSrHSgjlKyp7SUYurwt
   RsGKoonbjU8s4fl/xyQCAzA9wjGD+pXZxleJHR9ztDIQ1hrt/Fwz2rgdp
   mbEnwCeuCG5jLgeNhcjlAzgS5Zlkgz/77S1VY74LXBDK3xe2AlpoxT8t/
   p0ptnJuERXa/8kz4n/XK+5ZkIdM3lrQnOeUKdzUcN+cKek9hX68I8O9cT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386926239"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="386926239"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 22:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824671047"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824671047"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 22:14:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3B1A71E8; Wed, 14 Jun 2023 08:14:29 +0300 (EEST)
Date:   Wed, 14 Jun 2023 08:14:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v3 0/3] Minor improvements for Intel pinctrl
Message-ID: <20230614051429.GS45886@black.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613085054.10976-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:20:51PM +0530, Raag Jadav wrote:
> This series implements minor improvements for Intel pinctrl driver.
> 
> The optimizations are as tested with gcc 7.5.0 with default -O2.
> 
> Changes since v2:
> - Drop redundant patches.
> - Update commit message.
> 
> Changes since v1:
> - Update commit message.
> - Specify compiler options used to measure optimizations.
> - Drop redundant comments.
> 
> Raag Jadav (3):
>   pinctrl: intel: refine ->set_mux() hook
>   pinctrl: intel: refine ->irq_set_type() hook
>   pinctrl: intel: simplify exit path of ->gpio_request_enable() hook

For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
