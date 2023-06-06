Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09AF7236AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjFFFMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFFMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:12:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CC19C;
        Mon,  5 Jun 2023 22:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686028325; x=1717564325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TbfrnAGzn1jEvjRTj+1UlLHPxrWqY/OLvMihFNAckWo=;
  b=dsjGxcMQxdIwKwnfd2E6p+NxO/DwDxCIBPmUsTpc92QgmkgCv01XfO7u
   MuNTTvgHlI8CYtQUjBZJZ+F6g2aoahVtA1e9DmuUYsVZEbgHqVuOO53F/
   yYur02s0BgOksfUkEVyNr3u0jNJSZ/bjGrEtQHQ/n76kAhqFzxUyWwcQu
   VLt0dcfGnw7tmB2gMLT71hem5e9ulG+g7lJi3UfrpwAeli+KxN6afHWi0
   6JTlgG5aSE6Oui3/adu/0jhHaLDqt6v18E4YJwARm7UsOgLOWNDd+Lvot
   zwj2urmkC5QZ2Mrf6O79mdc8QAi58s6b8IdXBF4B3ukZcqPpq1NqHZIaH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336188264"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="336188264"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039036014"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="1039036014"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2023 22:12:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BE06C34F; Tue,  6 Jun 2023 08:12:10 +0300 (EEST)
Date:   Tue, 6 Jun 2023 08:12:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: merrifield: Fix open-drain pin mode
 configuration
Message-ID: <20230606051210.GV45886@black.fi.intel.com>
References: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:45:08PM +0300, Andy Shevchenko wrote:
> Currently the pin may not be configured as open-drain in some
> cases because the argument may be 0 for the boolean types of
> the pin configurations. Fix this by ignoring the argument.
> 
> With that, allow to actually restore pin to the push-pull mode.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
