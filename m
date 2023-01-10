Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4006E6646E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjAJRBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjAJRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:01:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF76302;
        Tue, 10 Jan 2023 09:01:04 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B644C6602D2A;
        Tue, 10 Jan 2023 17:01:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673370062;
        bh=HrdE2o6CJtMLfe6kBvN/SET4X3fpGFmG4oO76QwkFQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mQaRAIgSqCYn60wLEk2Oxjna89BtnbObavyXDy3q0iN071F/S1YMSr10SQSL1PXKH
         vUNFSYKyPS3RbsdnIYd3Z4y2yAqQVYBr5tNiEXIW/xxh8xjy/kaYrMiA89O8aWxUrG
         lsKlVYMPautNjM5J6yR0uPgu2xWPTMja2LrGMfsG/p7nBLaIkSfMq1qJKKNIgpilND
         8E8JJGdfZ/TWSMULeNtJl3unGD77Hp77xGLTzzquDiGnG+AlgVVkSHRNy3LGKQiTu6
         n8Onz+7WNfAtp9jyoHfgG/y9sETqGmgAEI7O+R4cOwNEPsFEaKB/ByBh2lApT818Wl
         EdWZGKkUewG4w==
Message-ID: <a440a001-e9d8-ff8a-32c0-68df328d1c89@collabora.com>
Date:   Tue, 10 Jan 2023 18:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] pr_info("I changed uvcvideo driver in the Linux
 Kernel\n");
Content-Language: en-US
To:     Xiaxi Shen <shenxiaxi26@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221230034634.7809-1-shenxiaxi26@gmail.com>
 <49d1dece-cb90-23f3-977e-98905b1a0abc@collabora.com>
 <CABtBSabksqweaDjhSVEaETYtCoQCVE1stPN7wwJr=eLPEU3X2w@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <CABtBSabksqweaDjhSVEaETYtCoQCVE1stPN7wwJr=eLPEU3X2w@mail.gmail.com>
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

Hi,

W dniu 10.01.2023 o 00:39, Xiaxi Shen pisze:
> Hi Andrzej,
> 
> Thanks for your advice.
> It is my first time to send a patch, I will definitely check my explanation 
> according to relevant guidelines before my future submission

I recommend reading:

Documentation/process/*.

Regards,

Andrzej

> 
> Yours sincerely,
> Xiaxi Shen
> 
> Andrzej Pietrasiewicz <andrzej.p@collabora.com <mailto:andrzej.p@collabora.com>> 
> 于2023年1月9日周一 08:14写道：
> 
>     Hello XiaxiShen,
> 
>       From Documentation/process/researcher-guidelines.rst:
> 
>     "The Linux kernel community expects that everyone interacting with the
>     project is participating in good faith to make Linux better."
> 
>     Please explain how your patch will make Linux better. "I added a pr_info()
>     which emits information unrelated to work of the driver" is not enough of an
>     explanation.
> 
>     Failing to do so and to adhere to the expectation quoted above
>     you risk any patches to the kernel submitted by you being disregarded.
> 
>     Andrzej
> 
>     W dniu 30.12.2022 o 04:46, XiaxiShen pisze:
>      > Signed-off-by: XiaxiShen <shenxiaxi26@gmail.com
>     <mailto:shenxiaxi26@gmail.com>>
>      > ---
>      >   drivers/media/usb/uvc/uvc_driver.c | 2 ++
>      >   1 file changed, 2 insertions(+)
>      >
>      > diff --git a/drivers/media/usb/uvc/uvc_driver.c
>     b/drivers/media/usb/uvc/uvc_driver.c
>      > index e4bcb5011360..60778a5a2b4e 100644
>      > --- a/drivers/media/usb/uvc/uvc_driver.c
>      > +++ b/drivers/media/usb/uvc/uvc_driver.c
>      > @@ -2082,6 +2082,8 @@ static int uvc_probe(struct usb_interface *intf,
>      >               (const struct uvc_device_info *)id->driver_info;
>      >       int function;
>      >       int ret;
>      > +     pr_info("I changed uvcvideo driver in the Linux Kernel\n");
>      > +
>      >
>      >       /* Allocate memory for the device and initialize it. */
>      >       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> 

