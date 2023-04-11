Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE546DCE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDKAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDKAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:07:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D671BE7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681171641; x=1712707641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/SkNd/K8iVvE77gyQWPYM8xlrW/4KpOW5swb5hDLO/8=;
  b=gjmdvN21O+JasG2DSHCvRQmXCFeBFEnbjl3wHP4oQ9iJWEu8oJkH2kZu
   iPSCYxL4aWiKRPBTcDaw7dthNF3RhmafzPjlEfN9oWzfge3gbm2/goyfj
   1gj+UPwDzLE4EtvzjhFvn2yDs7xCFtvvmBgNAqIP532AQeikNCZIBiM7h
   4IPAJPOOKEUFXCG5GXiZQNpZHRhfIqQOmtSf/vW6J16cEpel8BQpNkGwK
   W0RDqRDElnnzHH1+JKDYDMhMpp0Z/w5p/sjJCFX4dNATVYGDMhcPpQisP
   CRWHTy8Q1Ar1FsK7ujVHb2LaDq4j66SZQ7+g2GH641LUu3YnN8vc33ex4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371328674"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="371328674"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 17:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638617968"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="638617968"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.230.103])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 17:07:14 -0700
Date:   Mon, 10 Apr 2023 17:07:12 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix logical operator continuations
Message-ID: <ZDSksGyxnu5eIo+1@aschofie-mobl2>
References: <20230408171803.GA262580@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408171803.GA262580@sumitra.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 10:18:03AM -0700, Sumitra Sharma wrote:
> Fix logical operator continuation as suggested by Linux kernel
> coding-style. Check reported by checkpatch:
> 
> CHECK: Logical continuations should be on the previous line
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

Hi Sumitra,

That commit message can be explicit, like "Move logical operator
to previous line"

Alison


> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> index 5a1cd22f5e25..58ed394202ae 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> @@ -209,8 +209,8 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
>  					&priv->rtllib->pwr_save_ctrl;
>  
>  	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
> -	    (priv->rtllib->state == RTLLIB_LINKED))
> -	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
> +	    (priv->rtllib->state == RTLLIB_LINKED)) ||
> +	    (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
>  	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
>  		return;
>  
> -- 
> 2.25.1
> 
