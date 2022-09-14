Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F35B800B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiINEKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiINEKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:10:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD2557249;
        Tue, 13 Sep 2022 21:10:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so13244924pjh.3;
        Tue, 13 Sep 2022 21:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=s6RMZZfZ0gcDsG9fPCyVRz0L989FwPqu+I8MX+yJlGY=;
        b=qiRVsTGhnvlE1m+pMCntrFRx3wUzlHW/bMApXRELV1y/ayHAmqjVcV1gTtBbJ1GXWG
         QyL6wz9BzSWAtWf/uFYwqQ7Hh+VQrw3uDVKtO1qLLcGrFhhRda0CaVTeaoImQCXj7s7+
         EAYqy9RdWGiCeK9NGrjnEvlkIiEdQ3645n0I0sDZ2eEA8GyhktkdSxE7r+KQ3NmlSg7a
         owvppM3QvuzqP5UdZYXYM9A+/N3tQPaOyJqoYDbUHnA6iu8TnE2os7VLGRYRNFeOPAaC
         6P5gxGoFv3P3uAJy3Jf1vh7Q5QpbdZ/0JxCxYmEjdDM2898pWDp4YwOHfa4VG8rlo1ND
         xK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s6RMZZfZ0gcDsG9fPCyVRz0L989FwPqu+I8MX+yJlGY=;
        b=K+neaNQoBDl70sdHtQhKG6IyFLf9sh8b9jyTT5WMfYhLJyknupWPapOLde5GxCdKcr
         c7wFMlFSKUYLovaoKExR0PDSWe3u18Yc1NPrM8DluDpOJ3o6D79ToSqBCzjbdv251Sr7
         dTR/z1SSl/s8ZSMhT0fL24xv9WrPPZ7COOR/IL4yau+AuPJcKbDCfeSzMRgPl0+0+HVx
         ayDAFBS+HfwWFmAjYdyVsNI3m3uNRkx1iB4qH78C6CsNZoQWi3Xp2GENeQmw68B0JQ7K
         t1DEwx30Wbngb5e+g1J9+MMgLkL6jMLJNTNvAutJzVmJbdE21/+4ab227dCQMDsQQ51L
         wVFg==
X-Gm-Message-State: ACrzQf3LQVl2oCV0dS6WMlZqJXeyJ5tGm9wqxEaLAYtAWt9rASf9B1i5
        MQk1z1Igk1D0VP9BzeNULlZL6WE37Lfy4w==
X-Google-Smtp-Source: AMsMyM6NK7aFkcq9HZSrAhDHBlYbDVs3iZfZDtuwDn+OKtSFtcDi1ejVbD726Gpsyc28sBfreKzX7Q==
X-Received: by 2002:a17:90b:4a03:b0:202:d026:c9d6 with SMTP id kk3-20020a17090b4a0300b00202d026c9d6mr2669548pjb.55.1663128616962;
        Tue, 13 Sep 2022 21:10:16 -0700 (PDT)
Received: from [192.168.1.5] ([110.77.218.34])
        by smtp.googlemail.com with ESMTPSA id y16-20020a17090264d000b00176b66954a6sm9384800pli.121.2022.09.13.21.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 21:10:16 -0700 (PDT)
Message-ID: <621867a7-e513-c0c8-fb4f-2116d3aa8c7c@gmail.com>
Date:   Wed, 14 Sep 2022 11:10:12 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        johan@kernel.org, gregkh@linuxfoundation.org
Cc:     hyamamo@allied-telesis.co.jp, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
 <20220914025541.1018233-3-chris.packham@alliedtelesis.co.nz>
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <20220914025541.1018233-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2022 09:55, Chris Packham wrote:
> Add support for the docomo L-03F modem.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>   drivers/usb/serial/option.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 2065f0fb2fa0..14eaff50820b 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -527,6 +527,7 @@ static void option_instat_callback(struct urb *urb);
>   /* LG products */
>   #define LG_VENDOR_ID				0x1004
>   #define LG_PRODUCT_L02C				0x618f
> +#define LG_PRODUCT_L03F				0x6366
>   
>   /* MediaTek products */
>   #define MEDIATEK_VENDOR_ID			0x0e8d
> @@ -2079,6 +2080,7 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_AND_INTERFACE_INFO(VIETTEL_VENDOR_ID, VIETTEL_PRODUCT_VT1000, 0xff, 0xff, 0xff) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(ZD_VENDOR_ID, ZD_PRODUCT_7000, 0xff, 0xff, 0xff) },
>   	{ USB_DEVICE(LG_VENDOR_ID, LG_PRODUCT_L02C) }, /* docomo L-02C modem */
> +	{ USB_DEVICE(LG_VENDOR_ID, LG_PRODUCT_L03F) }, /* docomo L-03F modem */
>   	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x00a1, 0xff, 0x00, 0x00) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x00a1, 0xff, 0x02, 0x01) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x00a2, 0xff, 0x00, 0x00) },


Hi,
this doesn't seem to be correct. Since this is a LTE CAT3 highspeed 
device and the modem manual mentions MS Win NDIS driver then one 
interface is likely to be a QMI interface which you must blacklist in 
the option driver.
Please provide a usb-devices or verbose lsusb output for the modem.

thanks
Lars
