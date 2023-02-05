Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753B968B087
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBEPPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 10:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBEPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 10:15:28 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C91ADCC;
        Sun,  5 Feb 2023 07:15:27 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g8so10370705qtq.13;
        Sun, 05 Feb 2023 07:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2byMz+/6Sh1TLllSwNgLGo9KhlhjlVKEdxXfG0cTpSk=;
        b=bM1UPGVlukg5IZQvBlSsUkfeimYyh6tojk94DiSb623M5M8KDgOCUzzfiNdo9pIhba
         X0ju+lS1ikt2avaAwaZX6+ypsch9Kzgnh7v5wYacdHkVHOoTg1yMEtSGti/f+NU8dFbk
         olYXnyOfQ2TCRT7DR+EHomTRHXEAT5tC/FxLNiP3m4YsziYxMDUikSN/0r6cIR2r5lGD
         Tbcvzj7ZH3bxLT4Fu6s8h9fPjr3nPZim0XGZRnyTj27DZjsGkSPFSwewg0LJqdHOjkFH
         mP4U2jfYpJYXfZdjxU/YFXiz18l4yU6w/ZF/i40JCW8QQn4PlHds8xB290MfvjBlZjOO
         D3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2byMz+/6Sh1TLllSwNgLGo9KhlhjlVKEdxXfG0cTpSk=;
        b=Ej2vLog5kG2SMDD1EfzJtVjrWkGs1FBub8fmIXAk7HTNGa6z5LmMjTKqYTlEHllYc+
         APH/q4SYZlhwCn5rymZhZ3nOs+vBOGQ0BjZUdJ4ziKHvCEb49hnBcWqacaTJnrSUxmJq
         YjgLVWKGGjlzs9Jig02ZNjzvEHSkNQbaRZAMhzT3iEWuPpzNwrgw/P4EVphor02gsKPf
         KyFTftQsFSF5tX4EzOb0EW2gMRusyTa9qd1vumayMRThI/+iZTiTDpNQXxr0GQZ9Ceau
         aIN08Zq1P23OsWPV+mMjGgIZJ2obtlMJdIwkotyAlLoaEePfkPYQ3NFb2OCwxPrR1umn
         NrGA==
X-Gm-Message-State: AO0yUKWDFGUHkYfJZ9AxZQXzOq6pd8xLVXKf8Ahq1fCYJ4tjUiphEV/P
        MwuAbqGBvJZlWEiC6CB5DCif5XELZI1/
X-Google-Smtp-Source: AK7set93djiaBUljyrNcJkGIJV3koL2pnqGsfFk+j5qwUKO3nKUi/O4AiomLyV9rXpYjXRGhqrILXg==
X-Received: by 2002:ac8:59cc:0:b0:3b9:b1ea:2d0f with SMTP id f12-20020ac859cc000000b003b9b1ea2d0fmr31019703qtf.34.1675610126405;
        Sun, 05 Feb 2023 07:15:26 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u25-20020ae9c019000000b0071c9eea2056sm5684592qkk.14.2023.02.05.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 07:15:25 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4d8a:a95f:e506:25f6])
        by serve.minyard.net (Postfix) with ESMTPSA id 8F60C1800C0;
        Sun,  5 Feb 2023 15:15:24 +0000 (UTC)
Date:   Sun, 5 Feb 2023 09:15:23 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] ipmi: ipmb: Fix the MODULE_PARM_DESC associated to
 'retry_time_ms'
Message-ID: <Y9/IC9oWzxo3jjrO@minyard.net>
Reply-To: minyard@acm.org
References: <0d8670cff2c656e99a832a249e77dc90578f67de.1675591429.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8670cff2c656e99a832a249e77dc90578f67de.1675591429.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 11:04:01AM +0100, Christophe JAILLET wrote:
> 'This should be 'retry_time_ms' instead of 'max_retries'.

Oops.  Applied to my next tree.

Thanks,

-corey

> 
> Fixes: 63c4eb347164 ("ipmi:ipmb: Add initial support for IPMI over IPMB")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/char/ipmi/ipmi_ipmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> index 7c1aee5e11b7..3f1c9f1573e7 100644
> --- a/drivers/char/ipmi/ipmi_ipmb.c
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -27,7 +27,7 @@ MODULE_PARM_DESC(bmcaddr, "Address to use for BMC.");
>  
>  static unsigned int retry_time_ms = 250;
>  module_param(retry_time_ms, uint, 0644);
> -MODULE_PARM_DESC(max_retries, "Timeout time between retries, in milliseconds.");
> +MODULE_PARM_DESC(retry_time_ms, "Timeout time between retries, in milliseconds.");
>  
>  static unsigned int max_retries = 1;
>  module_param(max_retries, uint, 0644);
> -- 
> 2.34.1
> 
