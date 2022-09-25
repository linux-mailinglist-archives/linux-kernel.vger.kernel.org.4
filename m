Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8EE5E95C0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiIYTyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiIYTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:54:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F07FCE36;
        Sun, 25 Sep 2022 12:54:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so4839662pgb.4;
        Sun, 25 Sep 2022 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=RBrB8yKxA1oLqH3CfKSVzANSRP3M8PN3gfVC1DFu3kE=;
        b=Om6u+NaLOZJvLuAcZasCyQl+UcoDCXdblYHodbs26NDeiulNPkV5dABKv8jo5uvc7/
         5J3dm6zM3hRghZl+n9KXz0guMT+AwBcWf/masJqlT97oXCKW5qk6D0y7ScdiG5I8HbSx
         NQB+pwlcZnt6u3nHBTE4nCi8wPcHm/CzbkkxDvOMtHP4JuZ9ztb0EDQN3yWn9hAK/hqU
         ak6LzOC0jR58rd37tzew2TIoSbsh5tykddW3xLJj0MLQpu7oHHQ4qVRnC6s4OGhklsyo
         E8EIa3hclZevxkI6U4oGIvVG8o21gkz03Yh0YCIk6QnGeulbq9Dv1XpC/lp9Li2IRzTk
         ho8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RBrB8yKxA1oLqH3CfKSVzANSRP3M8PN3gfVC1DFu3kE=;
        b=oKVIz4YTnoy0Efn8rVR6QSlRC8tppd1zQ5Jg/zAQQbAHuxkrj0libnNuI/Wb+OlRDD
         x9MEiE+J8yfRvo3flQONbtjXxRaIPWPrR1xiIOJZ+LFP/JVpV2mFeGmcCHRro2hjHnVR
         qNqOYj/z+sacHvieODkn+Al0E85CBXr1U0AofSjtQ2Jln/LDqzPhsT6bjVQy2bzAhirl
         9Oxh2j4VgqE37KAmrvFxeU1hoqBpQzr1XPPTJma4lW1bwj2ArAKKk48ICXKlAc7y/Y8t
         2UhjTvaJTsSVXAQwTZtr3ZBR2kFAfmaDXk0w1gz3HEylKLqZ095Vxyw3emRaENbnINB0
         QN5A==
X-Gm-Message-State: ACrzQf2Bxi8Vh15MkD1Q1ZkBUF5YgvD0ZLAiN2Sn5+MSwZylq+YZR/mY
        Q8xiqTiliQRqtLboameZZm+482wVaWt2Hw==
X-Google-Smtp-Source: AMsMyM5XqmmjHwu6hU1zTDKqvVgOweYXdcxq5OIBeNZ8uaYYzlRNI1U9v+2sg2xk0y5clRW7bnonRw==
X-Received: by 2002:a63:8b4b:0:b0:43c:afc0:b72a with SMTP id j72-20020a638b4b000000b0043cafc0b72amr2484031pge.50.1664135682461;
        Sun, 25 Sep 2022 12:54:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00000f00b0052d4b0d0c74sm10318459pfk.70.2022.09.25.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 12:54:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 12:54:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: sp5100_tco: Add "action" module parameter
Message-ID: <20220925195440.GB546491@roeck-us.net>
References: <20220920092721.7686-1-git@vladimir.panteleev.md>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920092721.7686-1-git@vladimir.panteleev.md>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:27:21AM +0000, Vladimir Panteleev wrote:
> Allow configuring the "action" bit, as documented in [1].
> 
> Previously, the only action supported by this module was to reset the
> system (0).  It can now be configured to power off (1) instead.
> 
> [1]: https://www.amd.com/system/files/TechDocs/44413.pdf
> 
> Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
>  - Drop the rename of the SP5100_WDT_ACTION_RESET define
>  - Make the new parameter not visible in sysfs for consistency
> 
>  drivers/watchdog/sp5100_tco.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index ae54dd33e233..fb426b7d81da 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -65,6 +65,12 @@ static struct pci_dev *sp5100_tco_pci;
>  
>  /* module parameters */
>  
> +#define WATCHDOG_ACTION 0
> +static bool action = WATCHDOG_ACTION;
> +module_param(action, bool, 0);
> +MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
> +		 __MODULE_STRING(WATCHDOG_ACTION) ")");
> +
>  #define WATCHDOG_HEARTBEAT 60	/* 60 sec default heartbeat. */
>  static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
>  module_param(heartbeat, int, 0);
> @@ -297,8 +303,11 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>  	if (val & SP5100_WDT_FIRED)
>  		wdd->bootstatus = WDIOF_CARDRESET;
>  
> -	/* Set watchdog action to reset the system */
> -	val &= ~SP5100_WDT_ACTION_RESET;
> +	/* Set watchdog action */
> +	if (action)
> +		val |= SP5100_WDT_ACTION_RESET;
> +	else
> +		val &= ~SP5100_WDT_ACTION_RESET;
>  	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
>  
>  	/* Set a reasonable heartbeat before we stop the timer */
> -- 
> 2.37.3
> 
