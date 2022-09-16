Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D775BA704
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIPGwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIPGwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:52:25 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201004AD6F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:52:23 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id lh5so5516022ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nhSL7n7LfRUkrV5ta4Urj9rVAqfIkVUwwI27IOsavY4=;
        b=4JKKO5r8iQm3G3IwAE/F4bcsqETh9qkH5YaldmIrsMmiMk5KBZ4Myd6lUXk3k4jJ7m
         /grVH1C8uTFqA8Eer+xbNfRcMcVxS9zsKIvVa65PIF7NvWapk+gIgpuR7nA7/C0hxLHo
         TY7eyPXq+jeU3SZ8NthOwGBF2FYduTRCp6aoH1ub7GIQ0eEcC/svaDNRSdAZo4plpBYV
         Hde+MmMT76jCSoIyE6z6iu8+fxt6kmzuaYK1qAp5/cmSD0aZan7hzqtYC2/PbsPq/ep1
         Aqi2s3OmETIHOVRQo9eMLUcDseVlD5rpGkd+tUyGS28LlAs8ap6j5TUwomIgIGkFLkCM
         gdEA==
X-Gm-Message-State: ACrzQf2p9pOU97Ws31j39q0RWFRpS3O10/X0JfytDmlztTbMSPUOM4vc
        gUr2gnJcRWaGZUUV/6ezIJw=
X-Google-Smtp-Source: AMsMyM5G1DH9iqQK3nyMcs2F1VCwqYn2aF9PbjnomJXSq728AS8hScGE7JL9jWaXOBukONtKmB+WmA==
X-Received: by 2002:a17:906:9753:b0:780:7a0a:10f4 with SMTP id o19-20020a170906975300b007807a0a10f4mr2525502ejy.621.1663311141725;
        Thu, 15 Sep 2022 23:52:21 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id gu2-20020a170906f28200b00718e4e64b7bsm9891017ejb.79.2022.09.15.23.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 23:52:21 -0700 (PDT)
Message-ID: <28f755d8-822c-99ce-831b-d9f68ae53173@kernel.org>
Date:   Fri, 16 Sep 2022 08:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 5/5] tty: hvc: remove HVC_IUCV_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
 <8c8a2c9dfc1bfbe6ef3f3237368e483865fc1c29.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <8c8a2c9dfc1bfbe6ef3f3237368e483865fc1c29.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 09. 22, 3:55, наб wrote:
> According to Greg, in the context of magic numbers as defined in
> magic-number.rst, "the tty layer should not need this and I'll gladly
> take patches"
> 
> This stretches that definition slightly, since it multiplexes it with
> the terminal number as a constant offset, but is equivalent
> 
> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/hvc/hvc_iucv.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
> index 32366caca662..7d49a872de48 100644
> --- a/drivers/tty/hvc/hvc_iucv.c
> +++ b/drivers/tty/hvc/hvc_iucv.c
> @@ -29,7 +29,6 @@
>   
>   
>   /* General device driver settings */
> -#define HVC_IUCV_MAGIC		0xc9e4c3e5
>   #define MAX_HVC_IUCV_LINES	HVC_ALLOC_TTY_ADAPTERS
>   #define MEMPOOL_MIN_NR		(PAGE_SIZE / sizeof(struct iucv_tty_buffer)/4)
>   
> @@ -131,9 +130,9 @@ static struct iucv_handler hvc_iucv_handler = {
>    */
>   static struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
>   {
> -	if ((num < HVC_IUCV_MAGIC) || (num - HVC_IUCV_MAGIC > hvc_iucv_devices))
> +	if (num > hvc_iucv_devices)
>   		return NULL;
> -	return hvc_iucv_table[num - HVC_IUCV_MAGIC];
> +	return hvc_iucv_table[num];
>   }
>   
>   /**
> @@ -1072,8 +1071,8 @@ static int __init hvc_iucv_alloc(int id, unsigned int is_console)
>   	priv->is_console = is_console;
>   
>   	/* allocate hvc device */
> -	priv->hvc = hvc_alloc(HVC_IUCV_MAGIC + id, /*		  PAGE_SIZE */
> -			      HVC_IUCV_MAGIC + id, &hvc_iucv_ops, 256);
> +	priv->hvc = hvc_alloc(id, /*		 PAGE_SIZE */
> +			      id, &hvc_iucv_ops, 256);
>   	if (IS_ERR(priv->hvc)) {
>   		rc = PTR_ERR(priv->hvc);
>   		goto out_error_hvc;
> @@ -1371,7 +1370,7 @@ static int __init hvc_iucv_init(void)
>   
>   	/* register the first terminal device as console
>   	 * (must be done before allocating hvc terminal devices) */
> -	rc = hvc_instantiate(HVC_IUCV_MAGIC, IUCV_HVC_CON_IDX, &hvc_iucv_ops);
> +	rc = hvc_instantiate(0, IUCV_HVC_CON_IDX, &hvc_iucv_ops);
>   	if (rc) {
>   		pr_err("Registering HVC terminal device as "
>   		       "Linux console failed\n");

-- 
js
suse labs

