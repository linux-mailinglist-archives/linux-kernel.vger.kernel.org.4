Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4961F384
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiKGMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiKGMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:41:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B11B7AF;
        Mon,  7 Nov 2022 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667824868; x=1699360868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JrFUNJUR+xfBmaFKXTf1XB9n1c5qjS+akAmoKJWoy8o=;
  b=CTKRrZWcjIFUT/nYqSTFt6GzEXbBA0wKj7SswhMGSAxolaL8Ldkx41Sj
   +avB/Vfaks6OJf6CmZ/GVyAnB2H9DUF2PoIE+hZLgra6AaycwWhhl5Le/
   zwdnbLIoCk53JWl6Ypzd/xhyjPZtwF0PwLBnHr4vmgx2b48rIhtRYjYd4
   /SpcHazLDp4dNK4bR7B5mXNUKQbjUoOkamFR+qXYMJekkmmPA5Cp5GCA2
   XXCF/3yNrv7rX2mHJo/dHI2wBegpzJJNCE8eANt4IOpIVdp66Qq3xtOgi
   jkM0vCIR7YrkVzk+C5hWdtvHoAMEfuRMnc047N295es8Uv1Il/MsI1WHJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="311533783"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="311533783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 04:41:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="669123382"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="669123382"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 04:41:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 59A19155; Mon,  7 Nov 2022 14:41:29 +0200 (EET)
Date:   Mon, 7 Nov 2022 14:41:29 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>
Cc:     michael.jamet@intel.com, YehezkelShB@gmail.com,
        andreas.noever@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt: Add wake on connect/disconnect on USB4
 ports
Message-ID: <Y2j8+f/wAvUCDii5@black.fi.intel.com>
References: <20221101115042.248187-1-rajat.khandelwal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101115042.248187-1-rajat.khandelwal@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:20:42PM +0530, Rajat Khandelwal wrote:
> Wake on connect/disconnect is only supported while runtime suspend
> for now, which is obviously necessary. It is also not inherently
> desired for the system to wakeup on thunderbolt/USB4 hot plug events.
> However, we can still make user in control of waking up the system
> in the events of hot plug/unplug.
> This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
> attribute and only enables wakes on connect/disconnect to the
> respective port when 'wakeup' is set to 'enabled'. The attribute
> is set to 'disabled' by default.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to thunderbolt.git/next, thanks!
