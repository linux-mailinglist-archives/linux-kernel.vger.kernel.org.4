Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA57725340
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjFGFP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjFGFP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:15:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67A19F;
        Tue,  6 Jun 2023 22:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686114955; x=1717650955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7KfrFRmyGckj4L6s2O7ojZxA3ZO1iGwZD5VMPWnt20=;
  b=T5DKmHHJZ7nmlErBK757lrzhX+BBK6IIoXjjaYrEe98pPkP7kHXHSGl4
   Bu4Wf9lmqwLtwoaFE3MxzsCgyYy2nER2T2tjRw6axrMeNB94PAPjpOdUn
   uELE6Al5i17H6J8fPEWve41mrd3vfNfqTUds0A9uSbKSlpR+Bw99r1fPn
   4Br6JXv9famXs4l2qe0YtwwQK7oeoMq6Z1RGvY274Z/EZdmyeASvHhsi+
   ccyG1fj6lFYHPjCC4JPAihryuu1UuH6dVXqgMUoojVh30/7YmdgufK5d/
   qbNR2290hPlVG9H2SEPUXbvcFCCrVbv6yQesN99V+NabixjW9Q4WxSCyf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="354376404"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="354376404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 22:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774369315"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="774369315"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 22:15:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A496834F; Wed,  7 Jun 2023 08:15:59 +0300 (EEST)
Date:   Wed, 7 Jun 2023 08:15:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Lake-S pin
 controller support
Message-ID: <20230607051559.GC45886@black.fi.intel.com>
References: <20230605164943.3641-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605164943.3641-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:49:43PM +0300, Andy Shevchenko wrote:
> This driver adds pinctrl/GPIO support for Intel Meteor Lake-S.
> The GPIO controller is based on the next generation GPIO hardware
> but still compatible with the one supported by the Intel pinctrl
> and GPIO core driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
