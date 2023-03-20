Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC56C0D57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCTJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCTJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:32:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C51911E;
        Mon, 20 Mar 2023 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679304740; x=1710840740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bO+5pP+LnkUbJcOR9Lz3DMOji7iPTXgGrtDs+N4xVKo=;
  b=DE3i+InrIqhvn+CHMoONqF2/rxe1C/ToK1kXHp9huvEHaV4SlzJv81yH
   JI8YhX/7ZttaNharXjwJAHsVipoyflXHLFQfLyUo3BInJ8UOD71UGDvE5
   BquUcJpkbZMm8r9gRDJQDCnzHIvparr4Fs7l/z0SxzvKOEKqv9itoOqCZ
   QHlWp8Yv5u3pu+/5IG56Ildi0xSECe0xISV9VPpXDWw5cm/NnEcdGTAMM
   QmE1D3is5+fbpARHK9aGEUrKOm3c4EUdngVG+JthuSxU7OGzwDfy0WcX/
   DXpkJLUsdxgcpQCkGGgVsaomOrdfwI7VWPmKuNUAvKpd8h34faocZCIHu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340160435"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="340160435"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713516842"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713516842"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:32:16 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 14343122400;
        Mon, 20 Mar 2023 11:32:14 +0200 (EET)
Date:   Mon, 20 Mar 2023 11:32:14 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] media: i2c: imx290: fix conditional function defintions
Message-ID: <ZBgoHvg3kxsVoSzg@kekkonen.localdomain>
References: <20230207161316.293923-1-arnd@kernel.org>
 <Y+J+7lsf083k4x80@pendragon.ideasonboard.com>
 <c5383d0e-d33c-d59f-3ee6-4635c1c4d334@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5383d0e-d33c-d59f-3ee6-4635c1c4d334@leemhuis.info>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 20, 2023 at 10:18:23AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 07.02.23 17:40, Laurent Pinchart wrote:
> > On Tue, Feb 07, 2023 at 05:13:12PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The runtime suspend/resume functions are only referenced from the
> >> dev_pm_ops, but they use the old SET_RUNTIME_PM_OPS() helper
> >> that requires a __maybe_unused annotation to avoid a warning:
> >>
> >> drivers/media/i2c/imx290.c:1082:12: error: unused function 'imx290_runtime_resume' [-Werror,-Wunused-function]
> >> static int imx290_runtime_resume(struct device *dev)
> >>            ^
> >> drivers/media/i2c/imx290.c:1090:12: error: unused function 'imx290_runtime_suspend' [-Werror,-Wunused-function]
> >> static int imx290_runtime_suspend(struct device *dev)
> >>            ^
> >>
> 
> I might be missing something (if so, please tell me), but to me it looks
>  this fix for a build issue in 6.3-rc (which shows up in Guenters weekly
> reports to Linus) didn't make any progress in the past few weeks. Is
> there a reason why? Who actually needs to pick it up and send it towards
> mainline? Manivannan Sadhasivam? Sakari Ailus?

Mauro has recently pulled my PR including this and I understand it's in
Mauro's tree now.

-- 
Kind regards,

Sakari Ailus
