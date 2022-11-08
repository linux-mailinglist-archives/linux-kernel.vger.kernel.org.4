Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A3621638
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiKHOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiKHOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:24:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89712124A;
        Tue,  8 Nov 2022 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917387; x=1699453387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2WavLr3MTefaumdPXWdllt3kTx6JgjBoL4oUVNHXSqQ=;
  b=H8ADtzHpou/d0mmlcxsouvsBGlGbxUCla3YPOdORtfEcbii2xWhWVxPG
   qqTno510llq7a8RvkL0dew334mnrr7nGxPZ2FA4U9QIYt8pPLsfJfqYnB
   OeOecmxH0AObu2WIKhuzaylm8YqSRPw4Ps/leaySgz3zg246q7+3eeDuS
   G8La/C0/sJmSmp2CfDUHHMK4OZpNfVDSbc0qEoQrpV9gKy6Z+kSqrm2Gu
   GTWpvUDSuE678PLPps8lHeXlsan2/mv02rQ2LLWX2Le5mAc9bQiJ3zL3N
   v8O01il8RXNivVRAYqjzsEc0sSC8rm0zKcuc+3X+36jgBJxC6EczomOd0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="294072872"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="294072872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669562342"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669562342"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2022 06:23:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2CD7D15C; Tue,  8 Nov 2022 16:23:28 +0200 (EET)
Date:   Tue, 8 Nov 2022 16:23:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Moorefield pin
 controller support
Message-ID: <Y2pmYOKcVcMZ+lF1@black.fi.intel.com>
References: <20221108140931.62910-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108140931.62910-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:09:31PM +0200, Andy Shevchenko wrote:
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Moorefield SoC pinctrl driver
> + *
> + * Copyright (C) 2020, Intel Corporation

2022

Otherwise looks nice to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
