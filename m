Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C952E69A75C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBQIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBQIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:48:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36560F9F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676623699; x=1708159699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Mjzby5r/hrGpRXb0OnvsVYevCw+FhWz3tU0R6v4D+CE=;
  b=OTrYVcAJ9t5wEUQZqzENSkNKxAEC/cRV0sP5hw8KdzdzwMCOaJmZ1Z9L
   U3t+HmlxmVzxEpf/X4eWqXEN0ND2E+ugj+hoHFqRaOmWyt2Wv6FEl2BDU
   8NamgbsBEXa5GLN3Si50M24CPiWJcdwgeSFQWGnL0bTJADRx4JVA0Aj5+
   dEYftPV/118/vXFDaXxB1oxpF1/wnGEev8sil69Q0SzSka/uyqH3PU3FY
   8hVcgehZ2ZLhtHYD54lwrkGICtoDli8+Ak/twRsPTLfVM9iTpxixnH5Si
   HNh1MVgSPZpdyrWsEUi79lwiNI8oshGVjkLe5YG7r/w7S2YWDmGjKAykE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="334143034"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="334143034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 00:48:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="648007318"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="648007318"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 00:48:16 -0800
Date:   Fri, 17 Feb 2023 09:48:14 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     ogabbay@kernel.org, osharabi@habana.ai,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] habanalabs: make some functions static
Message-ID: <20230217084814.GA2862577@linux.intel.com>
References: <20230217062626.63213-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230217062626.63213-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:26:26PM +0800, Jiapeng Chong wrote:
> These functions are not used outside the file device.c, so the
> modification is defined as static.
> 
> drivers/accel/habanalabs/common/device.c:2641:6: warning: no previous prototype for ‘hl_capture_fw_err’.
> drivers/accel/habanalabs/common/device.c:2619:6: warning: no previous prototype for ‘hl_capture_hw_err’.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4098
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Regards
Stanislaw
