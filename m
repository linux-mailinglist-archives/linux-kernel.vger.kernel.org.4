Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC75650D62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiLSOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:34:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0432C;
        Mon, 19 Dec 2022 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460493; x=1702996493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zAGziaGm9rGl6jFCDpOLMDMSONSnLjCuWr4BVYFe4hg=;
  b=XH4ao2dBrD+i+5U/mRmnOzOEifSeHwsi8YRgLSt8q6bAvUWhx7K3+tBa
   OZL5LJLkFAOoYnQ7Lz6RW8/vC3//pexQdFMFwCUB8835zViava0G8G+DJ
   we0/sB+RTxfZNg20FGVAROBRzTXNHcbmhusyCUCe7gB/zCb2Vkd9OSo8+
   KdXbRrp7m+sH4+vBFCiO9EzFXJ5kXLH+6oUJk8o+zj44UIbLkRd3fI/6X
   BeOD0dSODz1i/1WDac0QyptTr+LfsBm1e4HJj3TTtOb0k/aAeN9pzqkOR
   TvJu6/Z+qR7xs51aADyj937a9p6Li4PQmdc9JlzzZhDtH1X4040HkGbNd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299037420"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299037420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="757640891"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="757640891"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Dec 2022 06:34:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 17A9E11D; Mon, 19 Dec 2022 16:35:08 +0200 (EET)
Date:   Mon, 19 Dec 2022 16:35:08 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Define maximum pad number in the
 group
Message-ID: <Y6B2nIy4hXQLjgvU@black.fi.intel.com>
References: <20221219123240.5601-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219123240.5601-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:32:40PM +0200, Andy Shevchenko wrote:
> Instead of using hard coded magic number here and there,
> define maximum pad number in the group in newly added
> INTEL_PINCTRL_MAX_GPP_SIZE.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
