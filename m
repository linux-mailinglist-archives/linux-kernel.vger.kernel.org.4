Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A75624210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKJMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKJMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:14:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD145646B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:14:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so2929993lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEs1aMGP9LW44ZUweId2R+Pxisx4LxpDfdrPZ0QsYUg=;
        b=ieLBsIMRV3Xy51oVcGvpcL3AIddCR924D6gSou5uosacKAQXXvn8Hi8p3/Jz2xaIlm
         3OXYRcYN4TYUQ928Qh/b/SE93qXTOXRlV/hG74fv/XFc4pntePS5XNXqByLzPv9Z2HAi
         7MPthbp9EKP5rOJgtV7JBYdfkDAM2Fs4i7yiaJ1tHoL9UcZ3HurcA+L7h5GnV2yNYeiO
         JL1WtIsABFdU9ld8hYquHGXo6kuFUbtppjmr8mVP44tZuIfthSjC7p1koxnd6VJ3/5+k
         zEZFbzIEZ9qiD41xgfU2TgZxbIwux8dGoemmV44GUeY2Kqd4hu/m8tLegBuqWx2Nv3X4
         /C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEs1aMGP9LW44ZUweId2R+Pxisx4LxpDfdrPZ0QsYUg=;
        b=VFIWTHN8ib/XrM8JWMp/mCJAe4B84S4XG1ZIrzOz6wnYDtqVr/xLF4GvMnc/giidQ3
         n1mgcxRgckXuTX3QKcubmAU5TtaG7ats8HQ4HoJ1aovEDi1+/s735JLFAAzSlnkjPJbt
         UMXxhyELWPpHFHl+7LuYCb+8xCcLmy5kUBHuNMpqMLsUaqyVZlQ6FBtjhlIZ7+GuC7Cc
         haAra3+sQUEaCscWnOBL1AAWuvhIAnTCcgTSQfxmN0SlwLqVc7fOOkdhsRKKvXIUOD22
         +eyM7V0veSgr/KThJebUG7GV/4FfGtD+p9h8mGTTeWJEDbeeGAWGkxxu2A7TMhN9a8/q
         Z6jg==
X-Gm-Message-State: ACrzQf0jS90tQVgJEgYQv7tHs/GyiuULu92bNg4dzBfs1k4YGmoeyCjx
        OTVZGHi9OPWzf9CnJAu/33o=
X-Google-Smtp-Source: AMsMyM7/gN5g85DWGIji/5XlvWUE1v8K3U1iQhcnugR/gj0iWpyvKGEWm3IvNlRFkt5no1ejMgL7eQ==
X-Received: by 2002:a05:6512:968:b0:4ab:bfeb:d4f3 with SMTP id v8-20020a056512096800b004abbfebd4f3mr23268470lft.630.1668082475991;
        Thu, 10 Nov 2022 04:14:35 -0800 (PST)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id d9-20020a05651233c900b0049fb08e91cesm2714871lfg.214.2022.11.10.04.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 04:14:35 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:14:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        wsa+renesas@sang-engineering.com, benjamin.mugnier@foss.st.com,
        dmitry.torokhov@gmail.com, cmo@melexis.com,
        u.kleine-koenig@pengutronix.de, error27@gmail.com,
        justinstitt@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: idt_89hpesx: Fix error handling in idt_init()
Message-ID: <20221110121432.dtbuumgglj36v5kt@mobilestation>
References: <20221110020030.47711-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110020030.47711-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuan,

On Thu, Nov 10, 2022 at 02:00:30AM +0000, Yuan Can wrote:
> A problem about idt_89hpesx create debugfs failed is triggered with the
> following log given:
> 
>  [ 4973.269647] debugfs: Directory 'idt_csr' with parent '/' already present!
> 
> The reason is that idt_init() returns i2c_add_driver() directly without
> checking its return value, if i2c_add_driver() failed, it returns without
> destroy the newly created debugfs, resulting the debugfs of idt_csr can
> never be created later.
> 
>  idt_init()
>    debugfs_create_dir() # create debugfs directory
>    i2c_add_driver()
>      driver_register()
>        bus_add_driver()
>          priv = kzalloc(...) # OOM happened
>    # return without destroy debugfs directory
> 
> Fix by removing debugfs when i2c_add_driver() returns error.
> 
> Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Don't know what I was thinking back than. Thanks for fixing this.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index bb3ed352b95f..367054e0ced4 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -1566,12 +1566,20 @@ static struct i2c_driver idt_driver = {
>   */
>  static int __init idt_init(void)
>  {
> +	int ret;
> +
>  	/* Create Debugfs directory first */
>  	if (debugfs_initialized())
>  		csr_dbgdir = debugfs_create_dir("idt_csr", NULL);
>  
>  	/* Add new i2c-device driver */
> -	return i2c_add_driver(&idt_driver);
> +	ret = i2c_add_driver(&idt_driver);
> +	if (ret) {
> +		debugfs_remove_recursive(csr_dbgdir);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  module_init(idt_init);
>  
> -- 
> 2.17.1
> 
