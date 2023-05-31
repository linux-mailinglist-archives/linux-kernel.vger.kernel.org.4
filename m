Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03967717800
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjEaHXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjEaHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:23:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F9E52;
        Wed, 31 May 2023 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685517787; x=1717053787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQamFbPHk7jhRFeasP//s4TdVJOiGc/kNVR3XMXPQf0=;
  b=LFJrLKtM+SpQH3JpBgW7sCK1kIQwFUzh5qiTe5G6/IlvDh7otVJmtmsS
   ktu66KOdKNlz7gtpCGyq2f7hvjo9E4UEECmqQ1swEYBTouFbUHfGVQfkP
   ACq1hY3n+TC05kJBmgcyJrq8B7ftPrVoZ7I9vb4giQbsa4eyCA5F6X5/Y
   RGkxft4O+GfKMgFVF4mrIIVdJLSCV2o5dY9qWM22AC79YJ7lSbycfvd3m
   4x2vYNZM3C6WAkCFxVIZY141bzUN0eNE6Qks5JM+UTVyylz4oeydnymaz
   931Zj15IKvGCo2bjA+2+auFiVJ049FBfhP+rV3Iu0GoJqdg1QSGprD7WA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334781366"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334781366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739837831"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="739837831"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 31 May 2023 00:23:04 -0700
Date:   Wed, 31 May 2023 23:22:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the fpga-fixes tree
Message-ID: <ZHdmPm1F56QGrKME@yilunxu-OptiPlex-7050>
References: <20230531101925.39360756@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531101925.39360756@canb.auug.org.au>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-31 at 10:19:25 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the char-misc.current tree as different
> commits (but the same patches):
> 
>   d8bdc50012fe ("dt-bindings: fpga: replace Ivan Bornyakov maintainership")
>   feeb9c9219bd ("MAINTAINERS: update Microchip MPF FPGA reviewers")

I'll remove them in FPGA tree as they are already accepted by char-misc

Thanks,
Yilun

> 
> These are commits
> 
>   9da6225bc737 ("dt-bindings: fpga: replace Ivan Bornyakov maintainership")
>   929f4e7c06ca ("MAINTAINERS: update Microchip MPF FPGA reviewers")
> 
> in the char-misc.current tree.
> 
> -- 
> Cheers,
> Stephen Rothwell


