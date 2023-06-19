Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C964734BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFSGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFSGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:22:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26615F9;
        Sun, 18 Jun 2023 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687155761; x=1718691761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vmeiRnZzbOkFvE+qTA7hNhHWLaDKIdjHAhEL+adjEx8=;
  b=JAl0AUnztx0TXAlFPO3nVHxGeaVQmmWsXSVAr/+mb1sd0K8uRpXZG1bf
   6yF3Syd+Ri2kpP/o1Lus2zhfc3khwg51L1Z/FpYDYaPXJUffFMXwlZXZt
   UioYRbqTS6r1ZQvwye0twuiAqrtxLTF7ETQP/rC9rqQqwZmxvH2kxLIK2
   CSah5Du/9DjvflY6wGksacHyuVhwJpB/pqqFTEgaavzbwGjKNyBWh2pww
   ycZcIRDxuR+TRpUNUtAf72w4RVe2WU0rYQQmlUjc1SO7oBLhtyKLvlYxr
   vGVENQ0Y9ZTWrw6QI5uzPzW8BivLEVrl0qvYvwJm8iSshSkudrNGOwqUw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="362977251"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="362977251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 23:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="743323177"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="743323177"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2023 23:22:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E9A5023A; Mon, 19 Jun 2023 09:22:47 +0300 (EEST)
Date:   Mon, 19 Jun 2023 09:22:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH for-next v1 0/3] Minor improvements for Baytrail pinctrl
Message-ID: <20230619062247.GD45886@black.fi.intel.com>
References: <20230616203356.27343-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616203356.27343-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 02:03:53AM +0530, Raag Jadav wrote:
> This series implements minor improvements for Baytrail pinctrl driver.
> 
> Raag Jadav (3):
>   pinctrl: baytrail: reduce scope of spinlock in ->dbg_show() hook
>   pinctrl: baytrail: add warning for BYT_VAL_REG retrieval failure
>   pinctrl: baytrail: invert if condition

For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
