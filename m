Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F497236B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjFFFMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjFFFMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:12:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F81B1;
        Mon,  5 Jun 2023 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686028355; x=1717564355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QrXiX8zNy2sKYpmtg9xW3Qho1FeCSFqevWUagjn/jPs=;
  b=HPs8ZY5ToJU5itMb7iAbqyzu9JhOsCzpYVEYOHKohIxJ2hq4n+YsQiIr
   I7hdyi5S2ttYeFxjEypODRIY6wdYrWPY1x/7F+GeGz/wsEM+jbAWSwFQW
   9LFOh1NgfKY1jwDC/51FtP7U7cQqWx92BkAgMEKjQu8M8sZRajlq5n1aw
   5BIvSrFDuQdgkOclqZ4+sLZw/V+Kx6RbtMAkAqJPjgYWfU9Lp1d210Z9v
   6LfdYuXUKzVmqbeAxHV7LzSix6x7f1jc5dnMARhbF5vRTHOi60EboMYzy
   R73jcBE1BqjXq9UmQAihaLA5xq4jPRqIOh/HAobvrXBqEyIgLrBGJux5i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356573861"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="356573861"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773989665"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="773989665"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 22:12:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id ADB1534F; Tue,  6 Jun 2023 08:12:40 +0300 (EEST)
Date:   Tue, 6 Jun 2023 08:12:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] pinctrl: merrifield: Use BUFCFG_PINMODE_GPIO in
 ->pin_dbg_show()
Message-ID: <20230606051240.GW45886@black.fi.intel.com>
References: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
 <20230605154509.11616-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605154509.11616-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:45:09PM +0300, Andy Shevchenko wrote:
> Use explicit comparison to BUFCFG_PINMODE_GPIO instead of implying it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
