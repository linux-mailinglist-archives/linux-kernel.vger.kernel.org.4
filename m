Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACA4682BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAaLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAaLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:41:10 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE9DBC4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:41:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1A33F4206F;
        Tue, 31 Jan 2023 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1675165267; bh=NNGSgAFxYihFyg4mvYbp2zktoaPOKuPr/aNGn/QY44I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GQ3bPOCO2475mTw1BGb5wB9ZlsNq+/vrGT9fccrdCcAeIXTAfzgfu76OxpHQg8BWm
         JqHrXj6K+DDCQH1Z7qvNJ8R7H06E7Vg+GHSWRl/7UGvMdM675fXHkmM/yLAA7BzpZ6
         D85rNyHYXo7wZAwcCUPdNjm4gI7qHu8SRP9XKUrJ1sPKQ0r32I+LpFZaKyIrMXoX9J
         HSC7kKZBZL3DVyJF4jJdiUjsNqgte4YgKX56feEvIBxXLpENBjcpCoEq+fRCa3p6BI
         S/AiILU3eZ7v/gDQ4PLMk6bO6WpVy81bgcBEP77b0OAUnbvVekNsXAjI/A8uUDfNv8
         9ddW8UO7VC49Q==
Message-ID: <b9e8fc37-cb68-a768-a6d4-c03640b6bf50@marcan.st>
Date:   Tue, 31 Jan 2023 20:41:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] soc: apple: rtkit: Add apple_rtkit_idle() function
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123065354.28179-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230123065354.28179-1-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 15.53, Hector Martin wrote:
> This is yet another low power mode, used by DCP.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/soc/apple/rtkit.c       | 21 +++++++++++++++++++++
>  include/linux/soc/apple/rtkit.h |  5 +++++
>  2 files changed, 26 insertions(+)
> 

Thanks for the reviews, applied to asahi-soc/soc!

- Hector
