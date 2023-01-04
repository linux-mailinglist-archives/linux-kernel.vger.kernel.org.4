Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B129065D461
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjADNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbjADNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:36:15 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254693AF0B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:34:02 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id c20so15639495ilj.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6lnHIrLeffNqYuMzqqIZDsBK+pCEcWE0LlZrei9DjY=;
        b=BWA4m8t4wHPfxNwvMoBi6UA3kZuyt9r0R37MxFbbpgIJe5FLYUXuH0TtWrjXFhThig
         CxT8nB0yVHjnoEMQ+a3Sqe5wf1E5wnsClLCq3k1pmcXSnxGgWHLBsVWuKfk3C71BESxv
         NZeFGC+KvmMQVpjeSiWgCO2VYG0o7ymoqkB3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6lnHIrLeffNqYuMzqqIZDsBK+pCEcWE0LlZrei9DjY=;
        b=PdXKEXdx2N2kOaaJrZsukYKYRjeIm3iW1eagddwVPdSsizrYmFvExVMUdlHG9kXEVC
         HrxedIA0V+QowkvC0hm1l5G2CfZwebt8mrj0XJdMxuKubUQ0NK4vnZZ0CsTyV21u/V29
         z3uPnzQ9I9h+VkcdoyDK+1Ig95MWgx8tcVlhVrAooaeKc4/T7R82r1SItP6R4K8aXKpG
         JiPFW5JAl0svW7CEhO10DMBStX/ijl30Y4SGqG5BkxepY9hjsnYgIsqAHq3YulQ2GZJE
         ckennOQbnOU1gpRr5CitbxxDaU4c+M7YVnEJPm46awS63dh3S54df4n58CUP+/qyOMgk
         ur6Q==
X-Gm-Message-State: AFqh2kocbLrpvWfrc2K5kjmT/roE0tTxoTLxJ1ipAxIDTqQ45MPMBDxD
        /b94E3TH4ljLBTsqMWDZ4SzhMw==
X-Google-Smtp-Source: AMrXdXuwjWYJ8N4s26XlYKVs8+TthVoGFb5zQvfgcG+226lExm6A3+9S6riTirOXFmyvfnVowlESjQ==
X-Received: by 2002:a92:d10f:0:b0:304:d0b7:e362 with SMTP id a15-20020a92d10f000000b00304d0b7e362mr30117562ilb.5.1672839239344;
        Wed, 04 Jan 2023 05:33:59 -0800 (PST)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id q24-20020a02a998000000b0038a360671adsm11168718jam.27.2023.01.04.05.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 05:33:58 -0800 (PST)
Message-ID: <f943d3ca-7cf7-cb4d-5dc7-1e45015ba213@ieee.org>
Date:   Wed, 4 Jan 2023 07:33:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: greybus: Replace zero-length array by
 DECLARE_FLEX_ARRAY() helper
To:     Deepak R Varma <drv@mailo.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y7T5MYfANf2xVsEx@qemulion>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <Y7T5MYfANf2xVsEx@qemulion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 9:57 PM, Deepak R Varma wrote:
> The code currently uses C90 standard extension based zero length array
> struct which is now deprecated and the new C99 standard extension of
> flexible array declarations are to be used instead. Also, the macro
> DECLARE_FLEX_ARRAY() allows to use single flexible array member in a
> structure. Refer to these links [1], [2] for details.

Thank you for citing some references in your commit, it's
a good and helpful practice.  This might have been another
helpful one:
 
https://lore.kernel.org/lkml/20210827163015.3141722-2-keescook@chromium.org/

> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://lkml.kernel.org/r/YxKY6O2hmdwNh8r8@work

FYI, Linux mailing lists hosted by kernel.org are normally
cited using "lore.kernel.org" now, e.g.:
   https://lore.kernel.org/lkml/YxKY6O2hmdwNh8r8@work
Your patch is fine, this is just so you can consider this
in the future.

> Issue identified using Coccinelle flexible_array.cocci semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/usb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> index 8e9d9d59a357..b7badf87a3f0 100644
> --- a/drivers/staging/greybus/usb.c
> +++ b/drivers/staging/greybus/usb.c
> @@ -27,7 +27,7 @@ struct gb_usb_hub_control_request {
>   };
> 
>   struct gb_usb_hub_control_response {
> -	u8 buf[0];
> +	DECLARE_FLEX_ARRAY(u8, buf);
>   };
> 
>   struct gb_usb_device {
> --
> 2.34.1
> 
> 
> 

