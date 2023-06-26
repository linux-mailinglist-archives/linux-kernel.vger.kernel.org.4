Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0E73D7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFZGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFZGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:16:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE318E44
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:16:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so2546335a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687760169; x=1690352169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKp2Pzn1ztlOpTdiDsoIfImYJN4Mm8E7hvJtTVZMAg0=;
        b=YRZ3YIC8PFRKWSaIjJZibIr91RkvljyDpAkC7bjS3T5cbTyIWcyQBS2ZdFUFPiJtJB
         Mi0+kLNOHxMZ+OgJnc/lh3X8QsJYYVHuug/4u31ctsnciW3Y+2oY+AUMLoh0Vyvtfr24
         7DJ+eTQ8wzBI42UXNXUdyJXYxphMpWqLF6hqXDSAyKmng5qUk3KpMQ5ebR/ur6rHLlfv
         KUj39ZtYH+TmzV2lmbJY1QsaayrRYx1IdvG/sxIwTu6nGqtXrU+G1pAr3NuRBSXRsd42
         fO5NGqhLjVgt+MhQ9BMhlbWV55UiJhixInPzmA0ZRUaw6taUGLydJ1G9GLLP7OL63rjY
         7+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687760169; x=1690352169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKp2Pzn1ztlOpTdiDsoIfImYJN4Mm8E7hvJtTVZMAg0=;
        b=LAH40vBARM0wUs+/bX0pCj7Z06WZoWefpdjyrgCO55uVftVAvrbR3pjM+YPGJAj8x8
         umyViVJoX1tXGwmnjoapCcWVzU6+Yh/4Aj9xtrnzXuNAYKlwYKRhy9+gAPUrgTS7Kjc5
         4kBbgLkvRHB0n0d5yrAQNPhDjQ6bwSIg8GyBlk35Qn67wwDqBNl+Fwfzcrya6MyFc2k7
         w1aZUQPK9qZPNI6jCE38v9Hu1pDlntJCRnpNOYSCwUwp860+HgPuLyE8uYWhcpTn4jno
         7fAWB9J8MljPPNVatKitJXpnvuas9RsSqRLKSFFtHilnTyH500CKEpBQSAU8VsPx5Cww
         hJjQ==
X-Gm-Message-State: AC+VfDyl2un8EF7yuVPpLsAOuNrcrFyUUKZXc5lmh/qkOyqawg0x3LFa
        AQFuHRTqqPS/wvMT6ul+xRKBUQ==
X-Google-Smtp-Source: ACHHUZ4ZpHEB9mlz3NMo2VnRXqXzTF6lIsZLN4wxhRHs5ZbDgLE1ySsiREgtgkPMobbggha30O+Amg==
X-Received: by 2002:aa7:ccd1:0:b0:51d:9149:6311 with SMTP id y17-20020aa7ccd1000000b0051d91496311mr2797751edt.6.1687760169162;
        Sun, 25 Jun 2023 23:16:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402135300b0051bee1eadccsm2467777edw.31.2023.06.25.23.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 23:16:08 -0700 (PDT)
Message-ID: <91731900-b8b9-000f-0faf-f6aff63342b3@linaro.org>
Date:   Mon, 26 Jun 2023 08:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] usb: max-3421: fix potential shift out-of-bounds in
 max3421_hub_control()
To:     Zhang Shurong <zhang_shurong@foxmail.com>,
        gregkh@linuxfoundation.org
Cc:     mark.tomlinson@alliedtelesis.co.nz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <tencent_D1B05B6060451EA10A64A88E122E37EDB508@qq.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_D1B05B6060451EA10A64A88E122E37EDB508@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2023 19:12, Zhang Shurong wrote:
> Fix potential shift out-of-bounds in max3421_hub_control()
> ClearPortFeature handling and SetPortFeature handling.
> 
> wValue may be greater than 32 which can not be used for shifting.

You need to use proper name after copying the commit msg...

> 
> similar patch:
> https://patchwork.kernel.org/patch/12162547

This does not belong to commit msg, but rather --- .

> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/usb/host/max3421-hcd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
> index d152d72de126..035cd6abc2f6 100644
> --- a/drivers/usb/host/max3421-hcd.c
> +++ b/drivers/usb/host/max3421-hcd.c
> @@ -1688,6 +1688,8 @@ max3421_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
>  						!pdata->vbus_active_level);
>  			fallthrough;
>  		default:
> +			if (value >= 32)
> +				goto error;
>  			max3421_hcd->port_status &= ~(1 << value);
>  		}
>  		break;
> @@ -1741,6 +1743,8 @@ max3421_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
>  			max3421_reset_port(hcd);
>  			fallthrough;
>  		default:
> +			if (value >= 32)
> +				goto error;

I am not sure if performing first port reset and then validating the
arguments is the correct way.

>  			if ((max3421_hcd->port_status & USB_PORT_STAT_POWER)
>  			    != 0)
>  				max3421_hcd->port_status |= (1 << value);

Best regards,
Krzysztof

