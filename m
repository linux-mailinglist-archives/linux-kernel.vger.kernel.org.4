Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEC72002C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjFBLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjFBLMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:12:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E901134;
        Fri,  2 Jun 2023 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685704326; x=1717240326;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=6uwS5tU3VpEDdfZFPP/2f6PZZV0Smc/JVe9SKo6EP0U=;
  b=kgfUVigWwiBgk7h3sO9ucMaN7nekA/O+Qjdu23s61jQGF74ncuVyK4uW
   o850aPzovWgxiEoC/tLQOxUwInHgnWH4hI6dKwfm+n9kHZSqzLWDRIN5k
   l+f3QswtMIQnTG/DYjG2/VQd+lhhNKnm36/+OhAVplI8AmVZlTuD0dfQw
   Gmwe0UkkS44TDtLpA5M1fb8gYXmtSKyN6YiikBJ8Yu5Soylff50loYt3M
   2aC2OW2IQB6RTB6bz602fRuAFwGFPItzn7LC60MENJJcGEXYFZ4tjuPUC
   5IULj3PChOcxeOnKT2djBEWYMn2W6cSStzPwAHvlQ4uGWP6/Qu2De2P5R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353339188"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="353339188"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="820250604"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="820250604"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:12:03 -0700
Date:   Fri, 2 Jun 2023 14:12:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] platform/x86: think-lmi: Don't display unnecessary
 authentication settings
In-Reply-To: <20230601200552.4396-8-mpearson-lenovo@squebb.ca>
Message-ID: <bec3684e-d9d1-d88b-846a-46a1fc481ffb@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230601200552.4396-1-mpearson-lenovo@squebb.ca> <20230601200552.4396-8-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-295843162-1685703976=:1742"
Content-ID: <cf3f9d85-437a-1f94-72f-b3edfd943b19@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-295843162-1685703976=:1742
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <4f5bd94-fe6b-2043-c5f3-a71a7bdebb4a@linux.intel.com>

On Thu, 1 Jun 2023, Mark Pearson wrote:

> If Opcode support is available (which is the standard for all platforms
> going forward) then there is no need to have the encoding and kbdlang
> attributes visible.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thanks a lot, the patches look good now. One small thing for future: next 
time, try to arrange a series such that the patches with Fixes tags are 
the first patches, in here I think it's not a big deal since 2/8 doesn't 
seem to conflict with 3/8.

For all patches 1-8:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-295843162-1685703976=:1742--
