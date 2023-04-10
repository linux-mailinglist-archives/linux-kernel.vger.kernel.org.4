Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3876DCE48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDJXss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJXsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:48:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F81715;
        Mon, 10 Apr 2023 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681170524; x=1712706524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLABFzxIaBKdwMWhvhRoqNf4XliHa9M847b79qETyi0=;
  b=n3oaUx3W4B5p+hfxHTzGsD62dKB2EcYFNEOQUPEfdhID0YodKSAH4u4f
   jLSMiEtM39stn4jFcM4H9f2zj1hEgP6x8XNCiv2c2NYFFSmJSj7tHw7SQ
   BftouZNbh+mXJ+BVkC4z+3xeP3RlBY7WS1ikLDnNWlxG8hcss4UpQuHBU
   FunXwNBaaav8TO3Fq8biY1EzDD8pNZSJfnptTSKkBPv9dW6co0Zc2sKSD
   MnlDSHvmLjpuz4F1inlBXx/oWmmxAfF6r+gQSDKO65yPRj8f1ZIdELiNe
   mfGiDWCgWtplhocoxw376KqENA5vhyvLj48+1jLy2UF5pyhXmNnFwteom
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="332160674"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="332160674"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="718761257"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="718761257"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.230.103])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:48:43 -0700
Date:   Mon, 10 Apr 2023 16:48:41 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Angel Alberto Carretero <angelalbertoc.r@gmail.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx: fix macro style error
Message-ID: <ZDSgWU5GXPFdJ99o@aschofie-mobl2>
References: <20230409200135.1033677-1-angelalbertoc.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409200135.1033677-1-angelalbertoc.r@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 10:01:36PM +0200, Angel Alberto Carretero wrote:
> Wrap macro in parenthesis to fix checkpatch error.
> 
> Tested it by compiling the driver successfully.
> 
> Signed-off-by: Angel Alberto Carretero <angelalbertoc.r@gmail.com>
> ---

Hi Angel,

The code change looks fine. Here are a few patch style suggestions:

- If you do 'git log --oneline imx-media-utils.c' you'll see that
  changes in utils file only, seem to have utils in the patch subject
  prefix. "media: imx: utils:"

- Commit message is vague. How about being explicit so anyone persuing
  those one-liners knows exactly what change was made.
  "Enclose IMX_BUS_FMTS macro in parentheses"

- The commit log 'why' is to conform to the kernel coding style, not
  to fix a checkpatch error. It is good to say Issue found by
  checkpatch, but that itself is not the 'why'.

Alison

>  drivers/staging/media/imx/imx-media-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 411e907b68eb..eb44c09071de 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -7,7 +7,7 @@
>  #include <linux/module.h>
>  #include "imx-media.h"
>  
> -#define IMX_BUS_FMTS(fmt...) (const u32[]) {fmt, 0}
> +#define IMX_BUS_FMTS(fmt...) ((const u32[]) {fmt, 0})
>  
>  /*
>   * List of supported pixel formats for the subdevs.
> -- 
> 2.40.0
> 
