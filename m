Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0774A69244C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBJRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjBJRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:19:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F06D61A;
        Fri, 10 Feb 2023 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676049561; x=1707585561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhWB/2Mmu8TJ/nGpIXnhfEdU4wvGkNBJPFyHsBDZ8TY=;
  b=fOmby3abv8uzLHp+9fB8dMuUy056EbcOu0oP7J5c+qiIVRnYufoKId1R
   6HYP7FKIztx8oyNnplBt2rYqHFU3e2/ZvdDE5xN7DcqI2HUBZPCYGoLRm
   eRbUUZVe/2qcgqls4pDDFI+QTf+QRoLsVO70yBADf5WfL94IXraHHShmu
   9XFcbONxUCxlwvxWC1fi+hnRQRGaNOhSMT9fBMqTi1k/oSCgYNst4HAU5
   f57Dc7pIbvr+VV8lLou8Hd6H0GFuwwN/UXR0rM2Bq3MYnxnf4AgGJ2DWi
   ToMfAvDzmbJEmfIoTdQ6Qqx+xqINtlkl/ecbpbw0xqkIjdPO+GUe02rup
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328162852"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328162852"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700540490"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700540490"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2023 09:19:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2EAAA1C5; Fri, 10 Feb 2023 19:19:58 +0200 (EET)
Date:   Fri, 10 Feb 2023 19:19:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: intel: Update help text of PCI and Platform
 drivers
Message-ID: <Y+Z8vrrwvrc4e9SU@black.fi.intel.com>
References: <20230210164158.211065-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230210164158.211065-1-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 01:41:58PM -0300, Mauro Lima wrote:
> Modern intel hardware uses controllers that work in hardware
> sequencing mode. In this mode, the controller exposes a subset
> of operations, like read, write and erase, making it easier
> and less error-prone for use.
> On the other hand, most of the controllers handled by the
> platform driver use software sequencing that exposes the
> entire set of operations i.e. exposes the low level SPI-NOR
> opcodes to the software for use.
> Update PCI and Platform help text with this information.
> 
> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
