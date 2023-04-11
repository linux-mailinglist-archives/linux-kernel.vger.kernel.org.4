Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF486DD731
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDKJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjDKJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:50:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA226A6;
        Tue, 11 Apr 2023 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681206625; x=1712742625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JrVteDFyeT/P8hd4qs4Q0KWR23l+rPhB5Jf5eKrKS6c=;
  b=HjgfBTTpxnvqFCmY4iW/uBen+ZE9ZELtSLfFyXlj4bXU3Xa1LfVOWfm4
   SceXHSsMgkk5ri1cyOzwxZ0OIJ+TXTO5O3kmvvE+PQ400/yMCWxHpuM//
   Q/XE6ALoG6eC8fqFoJztfgO3AUIVpgXuNz6fMgmIdcFAKUcJf5w6bKOGy
   Rpm5pupizNf93ZqpzCzy3SkxHzSphGeLX000o5V3U9Qld1nPEzxK+1t8W
   yZh4kPIkJUFKSpyyLh/+fMGKkB41VDgoPYgO3tvruyfqyNFlrZCre/OOP
   K0XRpDk5W7PGEQzPb/+41B8tpPfP3stNI7JlKX/R8vMCCQA/QadzDO1vY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="327676608"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327676608"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018312507"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018312507"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.55.254])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:49:26 -0700
Date:   Tue, 11 Apr 2023 11:48:58 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <ZDUtCi1GFMDO9Z5L@ashyti-mobl2.lan>
References: <20230411160236.28845f80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411160236.28845f80@canb.auug.org.au>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 11, 2023 at 04:02:36PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drm tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/gpu/drm/i915/gt/uc/intel_guc.h:274: warning: Function parameter or member 'dbgfs_node' not described in 'intel_guc'
> 
> Introduced by commit
> 
>   70b5ffb393f3 ("drm/i915/gt: Create per-gt debugfs files")

that's mine to take... will fix it!

Thanks!

Andi
