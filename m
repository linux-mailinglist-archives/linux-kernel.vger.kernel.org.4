Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083A70C25B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjEVP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjEVP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:27:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55075100;
        Mon, 22 May 2023 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684769273; x=1716305273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5crpyEy1rn+lvXpPtXwxbGGt4Zts4+J3/lEaIbB0iV0=;
  b=dZAoE/ityQAWo+qp6K4rqPsIPGIteSlyez4a5ZfK0VVKh2eXSKTDoV8J
   JEe5HmFTZGjyZlEqAx97Z+kC4FA43Ler3NrGDzr2oi4IWqn+BtL/2EbW7
   9jryyKkEHp1ez6sPnVa19VQKPkT2DWt/jqHDgZlvFmOOIEiIfZl7aLRSl
   u1CSdDsR2gBFdHUaTWXfT8k3GQmIK9c5TnfMDCSY8I1hE/tZrSCYcYa9I
   hgz9uu49ucLQ+s0acTSILo96ePrJdoBPcYGPPQ7KS/x8ahySOIcctcBJN
   UhYxQBNkD1aQUfSzpZ1qOCqSL+6EHlA6BtWhuoE9RXISOveB1Sf1Jd1yM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350460808"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="350460808"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793338382"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="793338382"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:27:42 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 24E72122FB0;
        Mon, 22 May 2023 18:27:40 +0300 (EEST)
Date:   Mon, 22 May 2023 15:27:40 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     nicolas.ferre@microchip.com
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        Songjun Wu <songjun.wu@atmel.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan the OV7740 driver
Message-ID: <ZGuJ7GqxDI0aZxK6@kekkonen.localdomain>
References: <20230522134751.30489-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522134751.30489-1-nicolas.ferre@microchip.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Mon, May 22, 2023 at 03:47:51PM +0200, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Wenyou's email is bouncing, remove him from this camera driver's entry
> and mark it as orphan.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Wenyou, all,
> 
> If you want to take this driver, please don't hesitate to update this patch for
> a better maintenance. My only concern is the @microchip.com email address
> bouncing.

What about the driver author (cc'd)?

> 
> Best regards,
>   Nicolas
> 
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..bae9c7591144 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15577,9 +15577,8 @@ F:	drivers/media/i2c/ov772x.c
>  F:	include/media/i2c/ov772x.h
>  
>  OMNIVISION OV7740 SENSOR DRIVER
> -M:	Wenyou Yang <wenyou.yang@microchip.com>
>  L:	linux-media@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/i2c/ov7740.txt
>  F:	drivers/media/i2c/ov7740.c
> -- 
> 2.34.1
> 

-- 
Kind regards,

Sakari Ailus
