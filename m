Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD65F972C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJJDQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJJDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:16:26 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7B48C81
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:16:20 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1665371691tcs0
Received: from SJRobe ( [255.42.121.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 11:14:49 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: hoArX50alxHrFW89+p7Rz6qnuESGNVN8RW26+DHHl0Q7QIGfaK0B975KXF1hJ
        PwWck+ilO6t2Cx6cYnnxTFWbBwMbbsFV3mVmTpiWkLitKSFHQhh/QuttUhZZUCQs1hZrxuw
        lsgjfDQuRlP8Mrd8eLd5Z4Xf65YOLfg0LjFk8OaJM2bpJ7aW2Ehklgy5Mki2D516jRG5/xH
        xS5seV0m1RxbyBu49EB+hRnHRb0Gkta6FElfbI30RETQxoPSHBPh9mSdMdgU81ZMi2d8IGv
        08LAeH8rBpMrkt6kkkrzuyCHr2Vb37sDkQ/aR6mdLzuRRpuJa8SExCraDqkWeZ9PU1qJoWl
        XwDUDWnriciTHwGUTHxm7lBeQItCYzRG/9z2vAo6uL+43TZaflIpLZeKfVlG8YxKxEpqcT1
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     <gregkh@linuxfoundation.org>
Cc:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Wende Tan'" <twd2.me@gmail.com>
References: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
In-Reply-To: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
Subject: PING: [PATCH] platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq
Date:   Mon, 10 Oct 2022 11:14:46 +0800
Message-ID: <F789F6E98A6F9BF5+1d8501d8dc56$74036f70$5c0a4e50$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjcVlxD7YgpjUoXQFWXA4+QHIYCKw==
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: soha@lohu.info <soha@lohu.info>
> Sent: Saturday, October 1, 2022 2:15 AM
> To: gregkh@linuxfoundation.org
> Cc: rafael@kernel.org; linux-kernel@vger.kernel.org; 'Wende Tan'
> <twd2.me@gmail.com>
> Subject: [PATCH] platform: use fwnode_irq_get_byname instead of
> of_irq_get_byname to get irq
> 
> >From 02df97f4d814b9893eef2c2118b85d2b4b9d61ae Mon Sep 17
> 00:00:00 2001
> From: Soha Jin <soha@lohu.info>
> Date: Sat, 1 Oct 2022 00:26:04 +0800
> Subject: [PATCH] platform: use fwnode_irq_get_byname instead of
> of_irq_get_byname to get irq
> 
> Not only platform devices described by OF have named interrupts, but
> devices described by ACPI also have named interrupts. The fwnode is an
> abstraction to different standards, and using fwnode_irq_get_byname can
> support more devices.
> 
> Signed-off-by: Soha Jin <soha@lohu.info>
> Tested-by: Wende Tan <twd2.me@gmail.com>
> ---
>  drivers/base/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> 51bb22898..968f3d71e 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -441,8 +441,8 @@ static int __platform_get_irq_byname(struct
> platform_device *dev,
>  	struct resource *r;
>  	int ret;
> 
> -	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> -		ret = of_irq_get_byname(dev->dev.of_node, name);
> +	if (!dev->dev.of_node || IS_ENABLED(CONFIG_OF_IRQ)) {
> +		ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
>  		if (ret > 0 || ret == -EPROBE_DEFER)
>  			return ret;
>  	}
> --
> 2.30.2
> 
> 

Any updates on this 10-day-ago patch?

Regards,
Soha

