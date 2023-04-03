Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8106D3CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjDCFke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDCFkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:40:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F135BD;
        Sun,  2 Apr 2023 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680500431; x=1712036431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXJUcYBGFL5MP3coHiaccUxhl+8VNzgubmuD/7J11jc=;
  b=WpQCMqSDAQPbm2sjrSpla05gnA7MpOwqNc3f1yOrANdIqwYnOgK0mIVZ
   z5RH4jFnQX24yioEJEEG0EHPj2UKPxH/jbzzonhK13qf+WgoSDBYUNY8B
   Jb9uor9d96r6W2Fs7vDBbINcXRhQov3sM6BgmuELnDPsAywtxNkoI6Iuu
   +JIioMP4NnbCtBGKoqXRDx9yh/9fc2+znhtBSM7nUVXCRDFYJloz1Iscr
   kwNxZT6x8L/TV3q+aoP/zJ9m+oxy2otjzhSf78gfnhO3H5/KmT9y3BgZK
   PGAkj7i9xGEV9HUkIwrcALJZeARqayJHT0wgqMDH0/qXTmt2ScGUm2/OG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="340543740"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="340543740"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 22:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="755108398"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="755108398"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2023 22:40:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4DFDC133; Mon,  3 Apr 2023 08:40:30 +0300 (EEST)
Date:   Mon, 3 Apr 2023 08:40:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/1] thunderbolt: Introduce
 usb4_port_sb_opcode_err_to_errno() helper
Message-ID: <20230403054030.GO33314@black.fi.intel.com>
References: <20230330102342.44090-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330102342.44090-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 01:23:42PM +0300, Andy Shevchenko wrote:
> The usb4_port_sb_opcode_err_to_errno() converts from USB4 error codes
> to the Linux errno space. In particular, this makes the intention
> of the repeating usb4_port_retimer_read() call in the
> usb4_port_retimer_nvm_authenticate_status() clearer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to thunderbolt.git/next, thanks Andy!
