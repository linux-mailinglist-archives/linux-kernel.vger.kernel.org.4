Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE53763CA13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiK2VJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiK2VIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:08:55 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEF26122;
        Tue, 29 Nov 2022 13:08:53 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x6so4541773lji.10;
        Tue, 29 Nov 2022 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q97ihQbVZ14AqpdlWnKlV7STSDmFLlfi7EQu2jXRtSM=;
        b=czUNqp/BqZeL8YvX+EU2COiMSIrEYENpeIYI+tQ45bwu7N+g51iR8YBfnfNxOl+OS/
         bg6ss7+mnUZVyyjsUb5kT+deHZbEwltu1yrIEcPDq54ERrUmy9JPl/wShhXyjYybHG5Y
         vBYDFV7dyKAVRzgCPtNQokZlynNN/k/kWXm5rTp5Uix6RtdVCSezLnEf4rKmkEZGh3ho
         saqrfiEGVWIiE6zzty0dbonoRWHYcDxQzrp2jKN8doXWscxtdJ7aga7vdSGHVMYCMpaj
         4hKlrHRDtfaCUDy3voDi1sZDgMMfSpvpAtjWJyeOknShpAUx0N9jV3gkCty67gjCganc
         Za9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q97ihQbVZ14AqpdlWnKlV7STSDmFLlfi7EQu2jXRtSM=;
        b=j8WsxMxmQ17rsR3wZaBBQ1PSq4ToaLPNFld3oVcO6y1hgDUwD2dfB1qS8YdS6Of7AY
         D0JjDVS34fyRzRIqxvbqkfaTvP9aJpsTExtMJrBtcXq1by6LHThqMnT1dpp9/lobwr+T
         Wzz5PqBtOeXfDjKwVx5LCanIz8vxGDPF4nSM5ajUDCtOK85KuJ10igLkK77+IvKwwFW2
         RfschhX02rHo0nff7wDWANblkLW4d8RAFMredfDzVrB4IuD3MEyZdYHhgkb0PK3ln8kF
         mvRqg7f3B+2TPlwaluWu1xHsAs7NdvCcymZyoCKzINE3XCa5EoMCMpR/3+7lsrY6SHwm
         XVDw==
X-Gm-Message-State: ANoB5pkNtvXQwpg9Ko7Jkrwi34Y8Byz/yOgPANV5m7dThI1vCmQUWwB1
        1xLK41QnVgCx6o5S+qFKd7e2RsIZcW1uWTY91CY=
X-Google-Smtp-Source: AA0mqf6JE1zkXUgRDtGALuUV3c0O6nX3e7m5G2bqwSaiud4r7ZOtJIsemMV74bAuLL7ngWRWyR5DJZgj5vMvDY0gLQ0=
X-Received: by 2002:a2e:3211:0:b0:279:7e51:a1ad with SMTP id
 y17-20020a2e3211000000b002797e51a1admr9533752ljy.65.1669756131891; Tue, 29
 Nov 2022 13:08:51 -0800 (PST)
MIME-Version: 1.0
References: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
In-Reply-To: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Nov 2022 13:08:40 -0800
Message-ID: <CABBYNZKna8RHnfZJ7ZsBXLpGw-noBpJeUqMojcHkV733voKvBw@mail.gmail.com>
Subject: Re: [PATCH -next] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
To:     jinchuan li <lifangpi@hotmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        972624427@qq.com, ligongwei <ligongwei@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinchuan,

On Tue, Nov 15, 2022 at 6:38 PM jinchuan li <lifangpi@hotmail.com> wrote:
>
> From: ligongwei <ligongwei@kylinos.cn>
>
> * /sys/kernel/debug/usb/devices
> T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=b85b Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>
> Signed-off-by: ligongwei <ligongwei@kylinos.cn>

You should probably configure your email with your full name.

> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

@Marcel Holtmann Did you really signed-off this one?

> ---
>  drivers/bluetooth/btusb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 64a3febb9dec..437d0b53efe7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -498,6 +498,10 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x0bda, 0xc822), .driver_info = BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEECH },
>
> +       /* Realtek 8822CU Bluetooth devices */
> +       { USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
> +                                                    BTUSB_WIDEBAND_SPEECH },
> +
>         /* Realtek 8852AE Bluetooth devices */
>         { USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEECH },
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
