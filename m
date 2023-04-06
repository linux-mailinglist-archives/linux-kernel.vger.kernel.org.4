Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FDA6DA204
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbjDFTyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjDFTyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:54:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00AD5253
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680810858; x=1712346858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dBwR6d65NhaZa59aMDdtZHdCzTe7JiUQkdICsAhmmks=;
  b=f8BKbrF70WSMAyIec5QLqEMfJ5RGbQ6NYsMbCZSpTPTrKX8OAd2KsKHI
   4JjK+mD9j9pvPRRoxmO1Lv5VGOOdIc4LTGkYEEOmkpXqWg0tV/IzjJAyx
   iin+b6/aTTBgDJ+nLFyi6fHCVO8pAmKXs1xoXgN9H4V7/0YGv6AvUHKdB
   fLUQS7Ob/fhMMRQlphckBEVEZyWN2gknpG3iZ6Zqhbe2LqlXt1cKbM6UV
   CvNQfcel/mk9LxKVk50KZmPDVKW5KIGOe/N4zBPfYhTtm+fzQ63awq4lI
   7+bwBpQsDURX1Y1hBrZgEQFkhu/N2Nqc3FwoUJOcMh3vHN02zTQsA7LIS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341572506"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341572506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 12:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="664620036"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="664620036"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.219.12])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 12:54:12 -0700
Date:   Thu, 6 Apr 2023 12:54:10 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: rtl8192e: Remove unused local variable
 irq_line
Message-ID: <ZC8jYs/m47SeKkuZ@aschofie-mobl2>
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
 <6ec702e12cb30501fc81693a71a96b238bf09ea0.1680729716.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec702e12cb30501fc81693a71a96b238bf09ea0.1680729716.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:48:20PM +0200, Philipp Hortmann wrote:
> Remove unused local variable irq_line.

This does more than just remove the unused variable.

> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> index 0bc3e013001e..1c3ccd2aabc3 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> @@ -33,11 +33,9 @@ bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
>  	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
>  	u16 device_id;
>  	u8  revision_id;
> -	u16 irq_line;
>  
>  	device_id = pdev->device;
>  	revision_id = pdev->revision;
> -	pci_read_config_word(pdev, 0x3C, &irq_line);
>  
>  	priv->card_8192 = NIC_8192E;
>  
> -- 
> 2.40.0
> 
