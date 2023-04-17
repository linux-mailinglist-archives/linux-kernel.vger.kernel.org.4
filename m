Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7E6E4A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDQNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDQNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:53:25 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B749C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:53:24 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2a8b8aea230so13214541fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739602; x=1684331602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hmCccGexZIiRh/1I7iZDEFYLfwZktUSP2S+aYl6td4=;
        b=Y+5aYQSdgxoTXyrHOMj+4pES/aGfRf1QolkToTiiOLlt6N5NY84DFjKhYK+wUU1TbC
         nD2vnX39L7LN3rSths33hQF/e/+4fEJWVJLD0/AR2kUK2FYJyfDr4xyfV07RHXXATEhw
         hARHDtQJQ7J/nSdM4GpcRkyYoUsoGjdQBBvvOj2p+t3Ev1pYggyUPzhJx+5ahNsTjBTx
         M0wObnr3VMv4oJmo4CD88+fKXmWMd9x1aCLkOoas6ftDz0I22iO6yDxIIoMCgGCvOBms
         P8M214wk2fNvmGnwWSMRIlfiV7xBHvS862jm5ruxvcksgYj/4VFSJ63zZcvgXUQacXWw
         JKnA==
X-Gm-Message-State: AAQBX9deS2VehJHxUfuEhxC4QkxksPWFyYjKi9eP2EDBYUaVp8PvUFP0
        +xKbUM8N4jXw+4ADyiwhjjc=
X-Google-Smtp-Source: AKy350Yy+wajw0elFulz0kYJQgXcWdwvAWpdbgClX6vRQk82sJ8/Tn5yW8klkbxqosVgskCtwAvilA==
X-Received: by 2002:a19:f50a:0:b0:4cb:4362:381d with SMTP id j10-20020a19f50a000000b004cb4362381dmr1444306lfb.62.1681739602276;
        Mon, 17 Apr 2023 06:53:22 -0700 (PDT)
Received: from [192.168.70.5] ([87.200.205.114])
        by smtp.gmail.com with ESMTPSA id z5-20020a19f705000000b004edb2cb3500sm1644395lfe.279.2023.04.17.06.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:53:21 -0700 (PDT)
Message-ID: <6f6e01f2-b485-40c2-30fe-7b7ebbdb4010@linux.com>
Date:   Mon, 17 Apr 2023 17:53:17 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: efremov@linux.com
Subject: Re: [PATCH] driver core: class: mark the struct class for sysfs
 callbacks as constant
Content-Language: en-US, ru-RU
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wade Mealing <wmealing@redhat.com>
References: <20230325084537.3622280-1-gregkh@linuxfoundation.org>
From:   "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20230325084537.3622280-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 3/25/23 12:45, Greg Kroah-Hartman wrote:
> struct class should never be modified in a sysfs callback as there is
> nothing in the structure to modify, and frankly, the structure is almost
> never used in a sysfs callback, so mark it as constant to allow struct
> class to be moved to read-only memory.
> 
> While we are touching all class sysfs callbacks also mark the attribute
> as constant as it can not be modified.  The bonding code still uses this
> structure so it can not be removed from the function callbacks.
>

...

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index b7bb52f8dfbd..3feadfb96114 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2424,8 +2424,8 @@ static int zram_remove(struct zram *zram)
>   * creates a new un-initialized zram device and returns back this device's
>   * device_id (or an error code if it fails to create a new device).
>   */
> -static ssize_t hot_add_show(struct class *class,
> -			struct class_attribute *attr,
> +static ssize_t hot_add_show(const struct class *class,
> +			const struct class_attribute *attr,
>  			char *buf)
>  {
>  	int ret;
> @@ -2438,11 +2438,10 @@ static ssize_t hot_add_show(struct class *class,
>  		return ret;
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
>  }
> -static struct class_attribute class_attr_hot_add =
> -	__ATTR(hot_add, 0400, hot_add_show, NULL);
> +static CLASS_ATTR_RO(hot_add);
>  
> -static ssize_t hot_remove_store(struct class *class,
> -			struct class_attribute *attr,
> +static ssize_t hot_remove_store(const struct class *class,
> +			const struct class_attribute *attr,
>  			const char *buf,
>  			size_t count)
>  {

This looks like a security regression (CVE-2020-10781).
Previous fix 853eab68afc80f59f36bbdeb715e5c88c501e680.

Thanks,
Denis Efremov
