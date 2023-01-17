Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5135266E00D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjAQOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjAQOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:12:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D3D3B642;
        Tue, 17 Jan 2023 06:12:09 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C23F96602D6D;
        Tue, 17 Jan 2023 14:12:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673964728;
        bh=aAHqpSHezj64XN3vQEe2TtvhP96Kmge0hexlgDAiT8Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LSZVuc0JnlkIaNNgPS8EiqqYvtSYV36JXM2l8NBJavrOTeNDloY/MKY5UkGWeK8kw
         e87lczfbS003VeZQCyuqQC7oAtPMBnwy1fTG481CiROYZnLKH4lpg+rCOmkzeKrLbZ
         Eg+hcc/b5FT54dHJKeeRnPTvhlUKUTZSYB0gbeeNLILJ+X74q9K6dZymOqRezr36AY
         vDDoiizNlC/QOuxBLI3VjfMF3E19BTTseUnWXgjYulDZawYEHNOpYniics9wHw02/a
         0xmk1dMSgVOhsmBskZKM5YUYQqZiLZgaO/JE4/t1h9/8b7z5JoPwbkVYTypoxdsunj
         RhghWkJpSccgg==
Message-ID: <3fe691cc-f5ac-e7f3-dc2e-73f9065884cf@collabora.com>
Date:   Tue, 17 Jan 2023 15:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/2] usb: gadget: u_ether: Improve print in
 gether_setup_name_default()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230116155545.101391-1-jonathanh@nvidia.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230116155545.101391-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 16.01.2023 o 16:55, Jon Hunter pisze:
> The print in in gether_setup_name_default() does not provide any useful
> information because a random MAC address will always be generated when
> calling this function. Rather than removing the print, update the print
> to show MAC address that is generated which is similar to other ethernet
> drivers.

I'd say the above part is redundant. It is supposed to be a message understood
by future readers of the commit log, who will not necessarily know that we
were considering a complete removal of these messages.

> 
> Finally, given that the strings 'self' and 'host' are static we do not
> need to pass these strings as an arguments.

Just drop the "Finally, ", the indefinite article "an" before the plural noun 
"arguments" and the above sentence will accurately describe what the patch is
about.

With that

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> V1 -> V2: Added this patch
> 
>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 8f12f3f8f6ee..be8e7b448933 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
>   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>   
>   	eth_random_addr(dev->dev_mac);
> -	pr_warn("using random %s ethernet address\n", "self");
> +	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
>   
>   	/* by default we always have a random MAC address */
>   	net->addr_assign_type = NET_ADDR_RANDOM;
>   
>   	eth_random_addr(dev->host_mac);
> -	pr_warn("using random %s ethernet address\n", "host");
> +	pr_warn("using random host ethernet address %pM\n", dev->host_mac);
>   
>   	net->netdev_ops = &eth_netdev_ops;
>   

