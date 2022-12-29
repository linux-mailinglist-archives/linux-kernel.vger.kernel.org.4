Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F2658E01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiL2Osy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiL2Osv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:48:51 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D14F71;
        Thu, 29 Dec 2022 06:48:50 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id e205so17280238oif.11;
        Thu, 29 Dec 2022 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z84XJBrbjjgB7h6MX2cW9/mDdKRwVfj1W8PqW92axJc=;
        b=Jnn8vCpC3ojrwjucR7qWhO1zZEk9/l3T8EVUhorm59/XOcagERH65A3GJYyg2aDsmb
         60Bk3dpMCvqindTn5nYUbYAhMUqgK5vjyT3HAEqftXnQUYVl/uUWJMXHYvDpopvBe4BT
         Eha8MzidOvGdtTX0YydMuWjAaRTcAwOOf+b3h22ZErf+VJjPCzn2/flmLxKpK16Z0EEU
         zUaMo/Yl4ZZQFfXkVMiaEDZ7DIFqyLEV5vUuGMGgKUsodXaZ4eBXxlyNlSz4ETbiyTHJ
         sC8rMJWUJiYZgT3eob0ObB5Bkhh2TAIQCk7MIf3zuA90CDimC1m52QlD3dCfi4LwgD1n
         dJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z84XJBrbjjgB7h6MX2cW9/mDdKRwVfj1W8PqW92axJc=;
        b=OPeqoG7fL9mCRfOxUowS8JJAISKjj4eni0nKl9cAieAk+tOel2z9RHR5BKaF05v451
         ytfkDD8gNTEWDTKhHW8cLOghj3SE266GUcaRU8wp05lKUPkiGAhTPv94moiTMurpZ8cq
         jvuqrscBrzPe3KbKmzcFYnAep9nnE2Tklyb092kYXlhdqLLyPxuBiw4rqEunjExlorKs
         sg90HKSw/Y5tKh6baFw+1jGgIT07sCvWTPI2f0oTnocWR6Sh1YLn9m2G51yb0PjFADAF
         RacmEnwh/Or29+e0e8n1A7PwdbCAsUvb1nHBIfKHy43onEZCePX8AfQ5b1tQ8u5vYDdy
         O6YQ==
X-Gm-Message-State: AFqh2kr1El0ZtPiHP+HGVgLOGhz5AwQP01KfEFSA63CvLZYDD5ij0oMQ
        BXvFYNCVlZoBskJXIYb4ACM=
X-Google-Smtp-Source: AMrXdXsR/rcyw6Jmz9APYvRqTKULocldelJOCZqFgYZsylS3OkOFfRiKv0Eaj1cTMkfXChcVDuEkJg==
X-Received: by 2002:aca:1b09:0:b0:35e:18a6:cf70 with SMTP id b9-20020aca1b09000000b0035e18a6cf70mr15664574oib.50.1672325329908;
        Thu, 29 Dec 2022 06:48:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d125-20020acab483000000b0035a921f2093sm8120587oif.20.2022.12.29.06.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:48:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:48:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] hwmon: Fix some kernel-doc comments
Message-ID: <20221229144848.GA21999@roeck-us.net>
References: <20221223081056.88345-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223081056.88345-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 04:10:56PM +0800, Yang Li wrote:
> Make the description of @aht10_data to @data in aht10_read_values()
> and remove @client in aht10_init() to clear the below warnings:
> 
> drivers/hwmon/aht10.c:87: warning: Excess function parameter 'client' description in 'aht10_init'
> drivers/hwmon/aht10.c:131: warning: Function parameter or member 'data' not described in 'aht10_read_values'
> drivers/hwmon/aht10.c:131: warning: Excess function parameter 'aht10_data' description in 'aht10_read_values'
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3543
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This onlyt affects a single driver, which should be mentioned in the
subject. No need to resend - I'll fix it up -
but please keep it in mind for future patches.

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/aht10.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/aht10.c b/drivers/hwmon/aht10.c
> index d76f3441ecf1..9babd69d54a3 100644
> --- a/drivers/hwmon/aht10.c
> +++ b/drivers/hwmon/aht10.c
> @@ -79,7 +79,6 @@ struct aht10_data {
>  
>  /**
>   * aht10_init() - Initialize an AHT10 chip
> - * @client: the i2c client associated with the AHT10
>   * @data: the data associated with this AHT10 chip
>   * Return: 0 if succesfull, 1 if not
>   */
> @@ -124,7 +123,7 @@ static int aht10_polltime_expired(struct aht10_data *data)
>  
>  /**
>   * aht10_read_values() - read and parse the raw data from the AHT10
> - * @aht10_data: the struct aht10_data to use for the lock
> + * @data: the struct aht10_data to use for the lock
>   * Return: 0 if succesfull, 1 if not
>   */
>  static int aht10_read_values(struct aht10_data *data)
