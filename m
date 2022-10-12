Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4C5FBFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJLE2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLE2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:28:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0439C219;
        Tue, 11 Oct 2022 21:28:41 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 203so18739649ybc.10;
        Tue, 11 Oct 2022 21:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qomAT3N+hK4b5Bvm7JX7qxyixZQ6XmjdUGo6Oxe9QHc=;
        b=ZL6CTGwIAfg0lO2smafnYj3WOJO8nHLuVUEQ29brNzXGtKXor6QxnADQ5T/YeHPfh2
         bZCFxFTTKUJsJVQj+ybu21JHDCLWwiPFxPt0dGObMnDDgU/HJf5fG2AH9hbsMFQmKZwC
         9DcYWyl+A9kH7d3jQIsI3T0ajeENaTs5rt4UAiPZZEOFyhch1bba4+C1xSpDo95Mu3N1
         +CYhHUowiU3/yMkacpYrzSw8CtRPgE8uxAJ8yrXLWc8oFkYjrGBDWkxx4aMRmFdj5QWd
         /0KC+uPfyRciPdZUV6zl0G9r/mxM4amiYpuGke4gCHyom5iKLQBHtNAZHYSvi8I1zPB2
         uH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qomAT3N+hK4b5Bvm7JX7qxyixZQ6XmjdUGo6Oxe9QHc=;
        b=5F9GPnlbg9lp153inC4Z/XP8Sz4RBfWK9x5xgTFEuJNY4O2f7+yJ2kPaY/Um3hWIZV
         C1MTL68PuGo6AGTZyQ5hkQutHL4ga3EERthhavAev+i/8p2jtZbxZACDVd56jurAkCNQ
         ep8DExwGy3IYDRrUZ9WJ8YsZRfpvM9T3uYGkcC/Rz9/yzE1drxIW6sV0uOvu3QuwUg2Z
         4KpZFWqQI8fssw6ovJI/n1p6CXyIRx4d9hIFUKSEMuRSjnRTdfCT3z6cukhFDb/zSAXE
         PR+mheJkvdDxuENjjEzFfzuZ8GPJZsNSzFeSzh/g2B5Mv0xiGU+QgZz0p1h5MYxdsnkJ
         9jpQ==
X-Gm-Message-State: ACrzQf1OLTWqtl4JEOC0GiYzW7cr7LkziNJ9f4OE/G14EX6prlIUW2dD
        fE6YkRPdti/1JKlyT/Y309hYL5wHhETfsuXh0sgPL60N
X-Google-Smtp-Source: AMsMyM40FDIBdYuTm6Bleka3ecGRzzJ8kF504WA+je9XHGdeeFlwdZyyNf7P77E6LxFmVUBXirJfO8/uLVA6j2hrBq4=
X-Received: by 2002:a25:1606:0:b0:6c1:7c57:ee97 with SMTP id
 6-20020a251606000000b006c17c57ee97mr9370080ybw.503.1665548920942; Tue, 11 Oct
 2022 21:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220803090218.1313187-1-kkamagui@gmail.com>
In-Reply-To: <20220803090218.1313187-1-kkamagui@gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 12 Oct 2022 13:28:29 +0900
Message-ID: <CAHjaAcSsQtXJyRFFAyPggKTdsNEejReEQ3qFgFv4dQej6Tdo5g@mail.gmail.com>
Subject: Re: [PATCH] net: usb: cdc_mbim: adding Microsoft mobile broadband modem
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, linux-usb@vger.kernel.org, oliver@neukum.org,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
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

Does anyone have comments on my patch? If there are some points to
improve, please let me know. I'm waiting for them.

On Wed, Aug 3, 2022 at 6:02 PM Seunghun Han <kkamagui@gmail.com> wrote:
>
> Microsoft branded mobile broadband modems typically used in the Surface series
> don't work with the Linux kernel. When I query firmware information to the
> modem using the mbimcli tool, it always returns the Failure (0x02) value like
> below.
>
> === Start of the firmware id query ===
> $> mbimcli -d /dev/cdc-wdm4 --ms-query-firmware-id -v
> [26  Jul 2022, 05:24:07] [Debug] opening device...
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Queried max control message size: 4096
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Sent message...
> <<<<<< RAW:
> <<<<<<   length = 16
> <<<<<<   data   = 01:00:00:00:10:00:00:00:01:00:00:00:00:10:00:00
>
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Sent message (translated)...
> <<<<<< Header:
> <<<<<<   length      = 16
> <<<<<<   type        = open (0x00000001)
> <<<<<<   transaction = 1
> <<<<<< Contents:
> <<<<<<   max control transfer = 4096
>
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Received message...
> >>>>>> RAW:
> >>>>>>   length = 16
> >>>>>>   data   = 01:00:00:80:10:00:00:00:01:00:00:00:02:00:00:00
>
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Received message...Message Type 80000001
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 864
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 897
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 923
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 930
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 935
> [26  Jul 2022, 05:24:07] [Debug] getting open done result failed: closed
> error: couldn't open the MbimDevice: Failure
> === End of the firmware id query ===
>
> After kernel debugging, I found that the modem reported that the dwNtbInMaxSize
> value of ncm_parm was 16384 during the initialization sequence.
> So the cdc_ncm_update_rxtx_max() in cdc_ncm_bind_common() didn't send
> USB_CDC_SET_NTB_INPUT_SIZE command because the default input size was the same,
> 16384.
>
> It's good and proper behavior. However, Microsoft branded MBMs (including the
> latest one in Surface Go 3) fail until the kernel explicitly sets the input
> size.
>
> This patch adds a new table and code changes that explicitly send
> the USB_CDC_SET_NTB_INPUT_SIZE command to support Microsoft branded MBMs.
>
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> ---
>  drivers/net/usb/cdc_mbim.c  | 24 ++++++++++++++++++++++++
>  drivers/net/usb/cdc_ncm.c   |  2 +-
>  include/linux/usb/cdc_ncm.h |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
> index c89639381eca..c0c23cfc02a7 100644
> --- a/drivers/net/usb/cdc_mbim.c
> +++ b/drivers/net/usb/cdc_mbim.c
> @@ -618,6 +618,22 @@ static const struct driver_info cdc_mbim_info_avoid_altsetting_toggle = {
>         .data = CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE,
>  };
>
> +/* Microsoft branded modems do not work properly without setting the input size
> + * explicitly in cdc_ncm_bind_common.
> + * CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY flag is used to set the input size
> + * during initialization.
> + */
> +static const struct driver_info cdc_mbim_info_set_input_size_explicitly = {
> +       .description = "CDC MBIM",
> +       .flags = FLAG_NO_SETINT | FLAG_MULTI_PACKET | FLAG_WWAN | FLAG_SEND_ZLP,
> +       .bind = cdc_mbim_bind,
> +       .unbind = cdc_mbim_unbind,
> +       .manage_power = cdc_mbim_manage_power,
> +       .rx_fixup = cdc_mbim_rx_fixup,
> +       .tx_fixup = cdc_mbim_tx_fixup,
> +       .data = CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY,
> +};
> +
>  static const struct usb_device_id mbim_devs[] = {
>         /* This duplicate NCM entry is intentional. MBIM devices can
>          * be disguised as NCM by default, and this is necessary to
> @@ -665,6 +681,14 @@ static const struct usb_device_id mbim_devs[] = {
>           .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
>         },
>
> +       /* Some Microsoft branded mobile broadband modems used in the Surface
> +        * seires are known to fail unless the input size is set explicitly.
> +        * Applying it to all Microsoft branded MBMs.
> +        */
> +       { USB_VENDOR_AND_INTERFACE_INFO(0x045e, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
> +         .driver_info = (unsigned long)&cdc_mbim_info_set_input_size_explicitly,
> +       },
> +
>         /* default entry */
>         { USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
>           .driver_info = (unsigned long)&cdc_mbim_info_zlp,
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 8d5cbda33f66..915e29c987cb 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -407,7 +407,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
>         val = cdc_ncm_check_rx_max(dev, new_rx);
>
>         /* inform device about NTB input size changes */
> -       if (val != ctx->rx_max) {
> +       if (val != ctx->rx_max || ctx->drvflags & CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY) {
>                 __le32 dwNtbInMaxSize = cpu_to_le32(val);
>
>                 dev_info(&dev->intf->dev, "setting rx_max = %u\n", val);
> diff --git a/include/linux/usb/cdc_ncm.h b/include/linux/usb/cdc_ncm.h
> index 2d207cb4837d..a24f84b31a54 100644
> --- a/include/linux/usb/cdc_ncm.h
> +++ b/include/linux/usb/cdc_ncm.h
> @@ -88,6 +88,7 @@
>  #define CDC_NCM_FLAG_NDP_TO_END                        0x02    /* NDP is placed at end of frame */
>  #define CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE  0x04    /* Avoid altsetting toggle during init */
>  #define CDC_NCM_FLAG_PREFER_NTB32 0x08 /* prefer NDP32 over NDP16 */
> +#define CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY        0x10    /* Set input size explicitly during init */
>
>  #define cdc_ncm_comm_intf_is_mbim(x)  ((x)->desc.bInterfaceSubClass == USB_CDC_SUBCLASS_MBIM && \
>                                        (x)->desc.bInterfaceProtocol == USB_CDC_PROTO_NONE)
> --
> 2.30.2
>
