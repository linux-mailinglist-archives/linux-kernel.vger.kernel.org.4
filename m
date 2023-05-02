Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70766F3CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjEBFCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:02:31 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3511FD8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:02:29 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94f910ea993so542780566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 22:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683003747; x=1685595747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtskkw5ZJ2vrfvf6HOcwc+0pw1LLoNNzIpwQavAw5L0=;
        b=WK3o7xY+rgJS4bRZOYYo554HclfndISXR2o2Uap982OosXZkHP+h9VqTZE7qHKfEKx
         BHhH3qECnecENc0siMFBcCX7iMIidSPhAVxA3jpVFnDTBrmGsabMqZ0LYrqM2TdBh4So
         9UbjZqMCc/gpq4nQ8OHSLSksV/9ImQ3ZdDWtMM5vjBIWvsWh2vYmmgMUw5/A1IOQF5G/
         8kSUUHxOAk464fiE1AWk69OwghZswDj1nQUcI1BbCgmcz6pp7Xz/iPd5kHOp2k6CeQR/
         YhHONWz4JpLKjVr8ReL8mSxTCxoAyGBcEvvudxPG9FsM44UR7fZ+Fr0pKV0qZr5PCiRr
         YQZw==
X-Gm-Message-State: AC+VfDx0myP4tXJ2jZL5+mJ4ark8xknZhBiz2oEYGtPz0+2PP9e357qi
        hsb8dv+dtE0NWSWR1c1NQsg=
X-Google-Smtp-Source: ACHHUZ4MjpXqjft1n7TNoPWCGXavhrJBlwqCJEoMTPvRonwb4Hxbqo8IwosORHLrL0cr8pW1YQG7dQ==
X-Received: by 2002:a17:907:16a9:b0:951:756d:6542 with SMTP id hc41-20020a17090716a900b00951756d6542mr16305446ejc.32.1683003747378;
        Mon, 01 May 2023 22:02:27 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090610c800b0093313f4fc3csm15578570ejv.70.2023.05.01.22.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 22:02:26 -0700 (PDT)
Message-ID: <67eeec7d-a114-07e0-de56-08a63d91af58@kernel.org>
Date:   Tue, 2 May 2023 07:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tty: define hung_up_tty_compat_ioctl with CONFIG_COMPAT
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20230501025602.2905173-1-trix@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230501025602.2905173-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 05. 23, 4:56, Tom Rix wrote:
> gcc reports
> drivers/tty/tty_io.c:446:13: error: ‘hung_up_tty_compat_ioctl’
>    defined but not used [-Werror=unused-function]
>    446 | static long hung_up_tty_compat_ioctl(struct file *file,
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> hung_up_tty_compat_ioctl is used conditionally with CONFIG_COMPAT,
> so it should be likewise defined.



> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/tty/tty_io.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 553182753098..7fe404d56ce7 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -443,11 +443,13 @@ static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
>   	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
>   }
>   
> +#ifdef CONFIG_COMPAT
>   static long hung_up_tty_compat_ioctl(struct file *file,
>   				     unsigned int cmd, unsigned long arg)
>   {
>   	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
>   }
> +#endif
>   
>   static int hung_up_tty_fasync(int fd, struct file *file, int on)
>   {

Hi,

Arnd sent a better fix already:
https://lore.kernel.org/all/20230429203523.538756-1-arnd@kernel.org/

thanks,
-- 
js
suse labs

