Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5C662AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjAIQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAIQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:14:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D2D30B;
        Mon,  9 Jan 2023 08:14:02 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE60D6602D67;
        Mon,  9 Jan 2023 16:14:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673280841;
        bh=U4zJPSycmuqT3X1Dt+urwjkAtNfIlHgsRIu0PRYfBn4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bSKhk1TenCQDhDwByWPWAEGMRiBUeMjljC3CvE50L9bvdSqcBJwm6JD/WZVAr/D8A
         nu3nzbOaWotx3ssATm7tyx0sqzJBDBENav1xQUIICRSV7X3rK0yEVsAkAqkmgre17T
         RtL239ljqyKrddt0qhD7NkLAko+of3Do0/siY76lUmCTozl/hPQBpziz/J4OwC2lAU
         Qsd0ZQHmVPGL85Tiif2augwCrSTs8c8iKPGScTrX01OwngG4rnS2PJ4/gi3heR0tn6
         xgBaMmJmwe+hMno70rVp+Pl8/LqQBCL1MyluG2bynT8JlJ7GGf1FSO6bbF15/Fn3HW
         wPGkQQlSwkY2A==
Message-ID: <49d1dece-cb90-23f3-977e-98905b1a0abc@collabora.com>
Date:   Mon, 9 Jan 2023 17:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] pr_info("I changed uvcvideo driver in the Linux
 Kernel\n");
To:     XiaxiShen <shenxiaxi26@gmail.com>,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221230034634.7809-1-shenxiaxi26@gmail.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221230034634.7809-1-shenxiaxi26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello XiaxiShen,

 From Documentation/process/researcher-guidelines.rst:

"The Linux kernel community expects that everyone interacting with the
project is participating in good faith to make Linux better."

Please explain how your patch will make Linux better. "I added a pr_info()
which emits information unrelated to work of the driver" is not enough of an
explanation.

Failing to do so and to adhere to the expectation quoted above
you risk any patches to the kernel submitted by you being disregarded.

Andrzej

W dniu 30.12.2022 o 04:46, XiaxiShen pisze:
> Signed-off-by: XiaxiShen <shenxiaxi26@gmail.com>
> ---
>   drivers/media/usb/uvc/uvc_driver.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e4bcb5011360..60778a5a2b4e 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2082,6 +2082,8 @@ static int uvc_probe(struct usb_interface *intf,
>   		(const struct uvc_device_info *)id->driver_info;
>   	int function;
>   	int ret;
> +	pr_info("I changed uvcvideo driver in the Linux Kernel\n");
> +
>   
>   	/* Allocate memory for the device and initialize it. */
>   	dev = kzalloc(sizeof(*dev), GFP_KERNEL);

