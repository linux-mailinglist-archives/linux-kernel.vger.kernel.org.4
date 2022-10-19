Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75659604DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJSQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJSQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:48:38 -0400
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E41C5A5F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oRIooemmvL5rYb82UnBnVi3B/Pn+CODMXib3Ofvbw0U=; b=jRhB5LwA1I56IRGjW6uu22Bp1i
        O/Lm7vrEPFNpa8/r3SIbI37uekZMZj2TPWN9zyBEr2QVhpXRUfAMrqT0uMwmi+BbsqEnJ3SQVjchF
        kqKr+WA5TqRc+KNACOgb2ny2HEsDLb6gNytY7btRtz+AvQOQyWbp+x1VxRQuCO+qufxgPnds0qPg2
        V9Wr+5s1UHneAP9G84UQnwaI/BfI4QODs2BIw5BvZNL8Z6PX4GCeaJrcr3CJm81zunwbDOaLFiBw7
        Nm2srGa/YdGiBvP88sCDzNkNuXHgdOjkp+/4n4FpaDNWcEbZu1+HS7p+BI2D4FUwOKnmInKRAmTfl
        85RziXeA==;
Received: from [2600:1700:4830:1658::fb2] (port=55226)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1olC4I-00031J-GZ;
        Wed, 19 Oct 2022 12:37:31 -0400
Message-ID: <e723900c-41ae-6e01-4415-7a859ab071fd@lechnology.com>
Date:   Wed, 19 Oct 2022 11:37:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/14] ARM: davinci: drop DAVINCI_DMxxx references
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-3-arnd@kernel.org>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20221019152947.3857217-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 10:29 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Support for all the dm3xx/dm64xx SoCs is no longer
> available, so drop all other references to those.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

>   int __init davinci_serial_init(struct platform_device *serial_dev)
> diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
> index a9e5c6e91e5d..9dc14c7977b3 100644
> --- a/arch/arm/mach-davinci/usb.c
> +++ b/arch/arm/mach-davinci/usb.c
> @@ -41,11 +41,6 @@ static struct resource usb_resources[] = {
>   		.flags          = IORESOURCE_IRQ,
>   		.name		= "mc"
>   	},
> -	{
> -		/* placeholder for the dedicated CPPI IRQ */
> -		.flags          = IORESOURCE_IRQ,
> -		.name		= "dma"
> -	},
>   };
>   
>   static u64 usb_dmamask = DMA_BIT_MASK(32);
> @@ -67,14 +62,6 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
>   	usb_data.power = mA > 510 ? 255 : mA / 2;
>   	usb_data.potpgt = (potpgt_ms + 1) / 2;
>   
> -	if (cpu_is_davinci_dm646x()) {
> -		/* Override the defaults as DM6467 uses different IRQs. */
> -		usb_dev.resource[1].start = DAVINCI_INTC_IRQ(IRQ_DM646X_USBINT);
> -		usb_dev.resource[2].start = DAVINCI_INTC_IRQ(
> -							IRQ_DM646X_USBDMAINT);
> -	} else	/* other devices don't have dedicated CPPI IRQ */
> -		usb_dev.num_resources = 2;
> -
>   	platform_device_register(&usb_dev);
>   }
>   

Shouldn't the else case be kept since it applies to *all* "other devices"?
(and therfore the usb_resources shouldn't be modified either?)

