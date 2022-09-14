Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2A5B82D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiINITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiINITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:19:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A311145E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663143575; x=1694679575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UrXNo+gWqBURZ2nQFRzRtZFaCTDBNxWoEIRfC6m6I7o=;
  b=ThAUya2olv8ohEMGOkq8c3Nq9DoJw48NxSKLHLEYC5DODeseRx6Ge9qd
   He+Wsxbl9qoh75vaLspzddJMVaE3ILwoMDGzyIlY+HIcZFmELIINWfzE7
   KhjyZ5rM9wF3xBIggZVyxpTRkl74S5AlucmBoWDlNSQxpswZV45+W+/KL
   HCl4S2u++E/CZ7NTQMFeRJQ6QMzT0gp1PpYuUPehqGWXTA0RFmLX7GweX
   f78hwoaWrIm2in5+v/xOEgWx7YnflTSxZbcac+uNPPsepatEbVTS6l8mu
   g36fwaGiTyGgGsfYU/gnXNmVbE9LRpsrRHOroFr7o0GrLbm6SMTtDnx9+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278756340"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278756340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:19:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="567921671"
Received: from blaesing-mobl.ger.corp.intel.com (HELO [10.249.45.209]) ([10.249.45.209])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:19:31 -0700
Message-ID: <b13fa907-6893-c4e2-4da5-204e15271a11@linux.intel.com>
Date:   Wed, 14 Sep 2022 09:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] soundwire: intel: Remove unused parameter ret
Content-Language: en-US
To:     cgel.zte@gmail.com, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, Zeal Robot <zealci@zte.com.cn>,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220914015256.22378-1-cui.jinpeng2@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220914015256.22378-1-cui.jinpeng2@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/22 03:52, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> The parameter ret = 0 has not been used.
> Return 0 directly instead of returning ret.

That code will be modified by a cleanup series that is going to land
upstream shortly, see https://github.com/thesofproject/linux/pull/3835

It's not an incorrect change but it will introduce unnecessary churn IMHO.

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>  drivers/soundwire/intel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index b006ae6efcb0..26fdf3577454 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -395,7 +395,6 @@ static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
>  {
>  	void __iomem *shim = sdw->link_res->shim;
>  	unsigned int link_id = sdw->instance;
> -	int ret = 0;
>  	u16 ioctl = 0, act = 0;
>  
>  	mutex_lock(sdw->link_res->shim_lock);
> @@ -427,7 +426,7 @@ static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
>  
>  	mutex_unlock(sdw->link_res->shim_lock);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
