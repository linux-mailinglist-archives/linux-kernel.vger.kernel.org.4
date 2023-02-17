Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335F69A7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBQJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBQJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:13:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A860A5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676625192; x=1708161192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cHTsZVVdVj+0TDZz/ywFtBNXduJUWSRa2xNnchMnRh0=;
  b=ewOWWNUxbthnoOtq9jhRkHchS+itTsmZeIeODoHcZuUNtO56u4SilPzU
   buqiBOk22kls1go0rosFqYVds7eIyp9tI+l4IfwK4kJz16Dkjp2pxvKPx
   dMn9vNtAdGT63RZmI8rl/XY5EcxngGOQylqBkfqG+MEnQI+p8jZIHyakN
   /4HAI4xyc6Ow0NkwjWYc8OOJoFqQHKwGY/9bDRuXoFNeWbIUb16PtZKJn
   18yTc0Kx/96ItfRAFZQmjnm8xtFNRkD52Qj/GElIzAEIw6Dw8mhgLjxuc
   qp0iJzjDgLXVnmveBAvDoSVgGtxDOaqRL2Yv5bylfv6tJqako0DzNk87x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="311580245"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="311580245"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:13:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813311200"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="813311200"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:13:11 -0800
Date:   Fri, 17 Feb 2023 10:13:09 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     ogabbay@kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        osharabi@habana.ai, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] habanalabs: make some functions static
Message-ID: <20230217091309.GA2870547@linux.intel.com>
References: <20230217062626.63213-1-jiapeng.chong@linux.alibaba.com>
 <20230217084814.GA2862577@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230217084814.GA2862577@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:48:14AM +0100, Stanislaw Gruszka wrote:
> On Fri, Feb 17, 2023 at 02:26:26PM +0800, Jiapeng Chong wrote:
> > These functions are not used outside the file device.c, so the
> > modification is defined as static.
> > 
> > drivers/accel/habanalabs/common/device.c:2641:6: warning: no previous prototype for ‘hl_capture_fw_err’.
> > drivers/accel/habanalabs/common/device.c:2619:6: warning: no previous prototype for ‘hl_capture_hw_err’.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4098
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>
> Regards
> Stanislaw

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
