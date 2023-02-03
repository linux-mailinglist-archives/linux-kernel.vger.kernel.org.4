Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECC689E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBCP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjBCP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:27:56 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF157677BF;
        Fri,  3 Feb 2023 07:27:41 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o66so4417713oia.6;
        Fri, 03 Feb 2023 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXm+hpllSIQNMkNep4ye09yixlp//tAbb+UJfitnNNg=;
        b=WHEPVmCa00Gnj8C4TL8UOv0RbMq+SQukXE8AFuLrLoiFaNOcG0RoH7w0I7chjUm/jV
         26P5Z4ZLpx4pw9b4AEsd5ZyqucNhzVVVPhtBd6WZL5OHbDVWB6/uXMyhsy0lfmj5GJ98
         pwiOAQis2lBF1vx1Yw4SOmzadti+Zt/XAfqVCYA7+tYAzkaG/3+Vo+5nwmzgbN+g2s93
         DqUyAIV8Hsw9oE8aKw67WwViXf5ycf+I90dSlAtnypm/VWhZQ26XQ/kfgXIw2pJrz5SQ
         VUffvHfMJjpGUejKAqUral44kQcHXGKXLa0O/qNf7coFsLQjg5655mhvyqQDIbMBMkgS
         rhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXm+hpllSIQNMkNep4ye09yixlp//tAbb+UJfitnNNg=;
        b=HFqPs7NBqpR7f+QJG4aev6Atuic/k7sDAL1CxkC4l7zcvxfApxgijwNSNu+IaBMLs4
         6MEtHRkOee4aGBvFC0XvHmhDpVWCDyUAj7ZkC6X9NB1gapwCIwUTk7OpXISfgTGVbNHC
         3YC4NIAMzA3klINJoD7zkSRbs9nCaB1uNzreRv6kUqgp5MShSFrQqniBSbQTuESjT1t0
         dKmbIYh9bG7TQRqL4IUZgwSezyIU4aT8kgprJ2eYGooUAFVmhMay6P2sAcl+Dqb4ePTa
         xq1p4qsZGhuEWpguKeSmokPqpzH36k3YGo0rpS1B1/xl0CzFEoMgQatm3K8ZQMUHc2y0
         Q5tg==
X-Gm-Message-State: AO0yUKUGUzjOXq8F7p05O8oLYeJfVHLym9njO8TeA2bvkbgHPikJ/O8W
        KFD875Zjcc1LxcvTXRU1Ly4=
X-Google-Smtp-Source: AK7set8BTQlNl8LupUMlwDcJzmGeNjwThXz0aB9feck/TbWf5mkUKD/M56jKy/7EDzlvp9EP6KFqhg==
X-Received: by 2002:a54:478a:0:b0:37a:2bf0:501b with SMTP id o10-20020a54478a000000b0037a2bf0501bmr2218331oic.9.1675438061155;
        Fri, 03 Feb 2023 07:27:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c187-20020aca35c4000000b003780403286fsm900169oia.26.2023.02.03.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:27:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Feb 2023 07:27:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] hwmon: (peci/cputemp) Fix off-by-one in coretemp_label
 allocation
Message-ID: <20230203152739.GA2507173@roeck-us.net>
References: <20230202021825.21486-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202021825.21486-1-zev@bewilderbeest.net>
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

On Wed, Feb 01, 2023 at 06:18:25PM -0800, Zev Weiss wrote:
> The find_last_bit() call produces the index of the highest-numbered
> core in core_mask; because cores are numbered from zero, the number of
> elements we need to allocate is one more than that.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Cc: stable@kernel.org # v5.18
> Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")
> Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/peci/cputemp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index ec9851daf2e8..f13cc4170f58 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -431,7 +431,7 @@ static int create_temp_label(struct peci_cputemp *priv)
>  	unsigned long core_max = find_last_bit(priv->core_mask, CORE_NUMS_MAX);
>  	int i;
>  
> -	priv->coretemp_label = devm_kzalloc(priv->dev, core_max * sizeof(char *), GFP_KERNEL);
> +	priv->coretemp_label = devm_kzalloc(priv->dev, (core_max + 1) * sizeof(char *), GFP_KERNEL);
>  	if (!priv->coretemp_label)
>  		return -ENOMEM;
>  
