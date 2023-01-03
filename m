Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82565C6D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbjACS5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjACS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:56:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8813F1D;
        Tue,  3 Jan 2023 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672772206; x=1704308206;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HVRTMi7XmWwdUqTpmRFqp97f3A9pblLnUiN8eyVbfVQ=;
  b=m2svwfRJKkxkaOTCqtDMWYt+NV2MhjYNEielM+K/gHNl1MpAVji/3Orl
   ToOjK9/oWWyv69uulZhjiSWMDbFkc1AYDFpi9NcdofLEc5Yg+u5uJ13rf
   BOhF6xdMwJxwBHarWapj9Oujuyh/PkVDVivMptdE88kMCzltP+HFAFu0v
   admtD8iSauqYy2dIxz4Iu0T52pJJpFOrGfpZV6tMUgdLoEwwHazGwXv+/
   1Ngchj11uEpE4MVjjAdp0xFMtYak0/C0yCYwqhhemOn6Kj2tC0p3wiN1v
   M56uuvXT72rVAvftxAy+AXf/zEffeTieRG7aiQjvi8ARTdTKPM77v2vHL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="309504357"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="309504357"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:56:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="762407581"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="762407581"
Received: from pdaniel-mobl1.ger.corp.intel.com ([10.252.48.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:56:38 -0800
Date:   Tue, 3 Jan 2023 20:56:40 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     lizhe <sensor1010@163.com>
cc:     jirislaby@kernel.org, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: linflexuart: remove redundant uart type
 _assignment_
In-Reply-To: <20230103170948.3777-1-sensor1010@163.com>
Message-ID: <8f433e5-fb46-d3b8-431b-4bddcc938f6b@linux.intel.com>
References: <20230103170948.3777-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023, lizhe wrote:

> 	in linflex_config_port() the member variable type will be

Rmoeve these extra spaces and start right from the leftmost column. 

And don't include the underscores (_) into the shortlog around assignment. 
Jiri just used the underscores to highlight for you what he considered 
important part to be corrected.


> assigned again. see linflex_connfig_port()
> 
> Signed-off-by: lizhe <sensor1010@163.com>
> Acked-by: Jiri Slaby <jslaby@suse.com>
> ---

When sending version xx, please remember to include the list of changes 
made per version (they go here below the first --- marker, see mailinglist 
archives for format examples if you don't know that alread).

-- 
 i.

>  drivers/tty/serial/fsl_linflexuart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index 6fc21b6684e6..34400cc6ac7f 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
>  		return PTR_ERR(sport->membase);
>  
>  	sport->dev = &pdev->dev;
> -	sport->type = PORT_LINFLEXUART;
>  	sport->iotype = UPIO_MEM;
>  	sport->irq = platform_get_irq(pdev, 0);
>  	sport->ops = &linflex_pops;
> 
