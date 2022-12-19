Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF81650EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiLSPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiLSPoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:44:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41813D05;
        Mon, 19 Dec 2022 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671464591; x=1703000591;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=jY3jHYLAYkAS0aE4T0DejdVw3nwg6vnENj2h5kDjznY=;
  b=bxrpn8SkNLS3nnu63lkVuiW+tHm6ZgdU5Il4ozdL9LROjYRzFE1xDcnB
   4TKf8QHLRAbh9lVbGY5zIOFj4kc0ow+eE3UTrR/6fstHGLr6ueqZpTdh0
   Ud4JcWLJMwfJLubIIT3m9qC2BZPZYzgeaJi/GW2gTDp5Pq0SnV8/IhPJE
   2tFXfeI/LvHY2oywiCe8T60kAjk9pG6DRPQk1UHFSojWgCjmZY/Cee7j9
   PmdYZGaqhSfjMXTQMh/cRLFTZ56gzGmDKLqLve7z51Ms0e+PtMjhR8G0u
   1uzwMqLyuNaFR9DWXujO1G9r238AONjQ8fMtyVppiQ3PYA2oFkbIrkTpC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="317014312"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="317014312"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 07:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="600708356"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="600708356"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga003.jf.intel.com with ESMTP; 19 Dec 2022 07:43:08 -0800
Message-ID: <90f6c531-1fed-2d0a-c6a9-46685517f02b@linux.intel.com>
Date:   Mon, 19 Dec 2022 17:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Content-Language: en-US
To:     Gongwei Li <lifangpi@hotmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ligongwei@kylinos.cn
References: <SI2PR02MB4603295B418781879CE88751DDE59@SI2PR02MB4603.apcprd02.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH V1] usb: Fix typo in comment
In-Reply-To: <SI2PR02MB4603295B418781879CE88751DDE59@SI2PR02MB4603.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2022 3.38, Gongwei Li wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> Spelling mistake in comment.
> 
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>   drivers/usb/host/pci-quirks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index ef08d68b9714..9710425e69aa 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1103,10 +1103,10 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
>   	pci_read_config_dword(xhci_pdev, USB_INTEL_USB2PRM,
>   			&ports_available);
>   
> -	dev_dbg(&xhci_pdev->dev, "Configurable USB 2.0 ports to hand over to xCHI: 0x%x\n",
> +	dev_dbg(&xhci_pdev->dev, "Configurable USB 2.0 ports to hand over to xHCI: 0x%x\n",
>   			ports_available);
>   
> -	/* Write XUSB2PR, the xHC USB 2.0 Port Routing Register, to
> +	/* Write XUSB2PR, the xHCI USB 2.0 Port Routing Register, to

xHC isn't a typo in this case, just refers to the actual xHC Extensible Host Controller itself.
The port routing register isn't part of the  xHCI specification.

Thanks
-Mathias


