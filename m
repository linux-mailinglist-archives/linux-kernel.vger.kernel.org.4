Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595CC6B225D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCILMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCILL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:11:59 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F5ED0F3;
        Thu,  9 Mar 2023 03:06:25 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-176d1a112bfso1894820fac.5;
        Thu, 09 Mar 2023 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=samIwn+mrYCkPDlmXVkTL6VnYSrs9OlBexxb29Tur4c=;
        b=obi3QXc3bLKBnOvmv6OSDVVFshnXDnskKZJKDTTlYE8ToK4v3PyDRmN5czpLfs7etP
         ah4OW+U38zylXSKYcJy71QeFY4XShRVdknvvc7RfDKg8zZHJmcZUOY8PSLziNRgubG/E
         IUiwmSYA0rMkLRmmZLVQNUqZn0QPCrYA8Y/X9LHMjkoHFlfDg+IIN28ZCuIu2Yj/3yUN
         CHKqYGth2G/CE5KZa+0rAmc0/2aVrEBr6N0yl7Ve1uylYR3ctY3Pcquv9Pmr9KigKVsR
         PDxwFCticS07GGCk46gFTyjIYQLxwjxurWciduvxC9kb8kTN0YpY5CtyIaH69ZHAXQdS
         5jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=samIwn+mrYCkPDlmXVkTL6VnYSrs9OlBexxb29Tur4c=;
        b=0Zo7ewVgyxvH/U8jfnJJi+6CH7ObxpKBh5eSk65E4I8rkkNr9TcHRZPVZ9VSvmuOQs
         VYtfQpvYey+3gf8sl/Kl68OujQ6b9kM474aXACjlGFohuLlJ7mADIP8TV+ROMiD2rlU0
         0EKuQydM3ZG20fqwwjJcs0R2ImAWKADADOT2I+OUobKS/872m6hRqw8JTyNUVA6nofID
         bbIWc/sMMgeM9VChUBvpsu9dWAEm1VMNwIpEJfn1QBaGbxv1XWw5zRHRId1+wB8VqGCW
         zgMVmR5PMxXZsDvQiL2rauVwvfIUvJrKL3HcRwanaiYPdc7Nd3ccfzJsOxeWZ5TR4iVl
         3Szg==
X-Gm-Message-State: AO0yUKUtQSJR4yrBKGo/MqGz5PFD2yBE9DUwA/LRpS+uQiufHvxemX9J
        dqg1vaNpVtmYOnt8O0+mfQKjnx06r8A=
X-Google-Smtp-Source: AK7set/VP49RzW8BUZKF/HspzTXzVSvnjMdvEgb0lFm/xA03cgHDo1EM1wXG6lvWFZGkJ8OBqglZNw==
X-Received: by 2002:a05:6871:711:b0:172:9b45:3730 with SMTP id f17-20020a056871071100b001729b453730mr13292002oap.56.1678359979287;
        Thu, 09 Mar 2023 03:06:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9-20020a05682003c900b0051763d6497fsm7028016ooj.38.2023.03.09.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:06:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Mar 2023 03:06:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
Message-ID: <e0579cbe-cbd6-46cf-b425-234cfed4ff00@roeck-us.net>
References: <20230309082841.400118-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082841.400118-1-jani.nikula@intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:28:41AM +0200, Jani Nikula wrote:
> Let the struct hwmon_chip_info info member be a pointer to a const array
> of const pointers, rather than mutable array of const pointers.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  include/linux/hwmon.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index c1b62384b6ee..492dd27a5dd8 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -430,7 +430,7 @@ struct hwmon_channel_info {
>   */
>  struct hwmon_chip_info {
>  	const struct hwmon_ops *ops;
> -	const struct hwmon_channel_info **info;
> +	const struct hwmon_channel_info * const *info;

As pointed out by 0-day, you's also have to change each
instance where this is is assigned to another variable.

Guenter

>  };
>  
>  /* hwmon_device_register() is deprecated */
> -- 
> 2.39.1
> 
