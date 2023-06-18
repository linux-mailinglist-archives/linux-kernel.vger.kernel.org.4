Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60B7346DF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFRPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:54:17 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA501B1;
        Sun, 18 Jun 2023 08:54:16 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-340b48c180bso13347585ab.0;
        Sun, 18 Jun 2023 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687103656; x=1689695656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRkUw/2fPCwmjqO//WQSxM/yAklAIHP55L9AcTiCTNU=;
        b=mXo4S/wRq1jnjJq05XD0CcKIhk0vcvr6OKY+uVI8TaEiSTOEB6yvZQ2+wTHJqDqKy4
         DXq4MPyzAcX5sOtiwIe/cfdFhu9PK7Wkmh/D+5MgsSbx2QdlCfMY2yB/fnfERCsj4EHR
         1ZBEHNNlRCFeeQ/pdgBgFNV6q302PV1UjINUio5mMADVWFFFsHoothfKOuyUd1WPEfbb
         FTxyD7oOBoEg2QViyod6NB4YCFZzLd3a1UkE6D8vqWVkPJ+cycHybGQTnRVlrhesqlwL
         Z1qcdK31uxniBVYJ9GyOu+t28K9gFQv1fMUOCmGCEv+OPGOn4O0CxnZ/zwa6F2UxS/wB
         7CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687103656; x=1689695656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRkUw/2fPCwmjqO//WQSxM/yAklAIHP55L9AcTiCTNU=;
        b=Y3//NwOBxl7yiPrxmhkFbl18sZ2zzt9TkFEY5Faw8OvqhaTuAHjp5RmtSOW2Ldm3b8
         7BA0EvgzbuRPN3HsLjOlnUWPa/ajHS+ScyJt3woaCQER/PzARxd+6UEm3E5xpSylq46q
         d7utWVN9F8F6YyZMCsGtTjD7cQ6vjddmdC/azWmFU6WmByFIeBw42yI+YLtGdl+XnLNr
         ZpmKUhtliFC/Q5fslVlnBvEtjr2t4KaijhiNSwS/cSU6ZpOI8XDqmCaxPyFrS/3ypFVO
         xgwWrq3BIIF6DWNs+MVStGnY05T5yB/KFIypkJtcu0xB1QHO4y+EKZ0R3iRRyyOlHRzT
         A8Pw==
X-Gm-Message-State: AC+VfDxoiy8CH9wofT7efn75ydC7j0rb47dRFelLkAyOPM5f8KfMrxVN
        rFpPr7BhTh2v4pL2qw8TLQU=
X-Google-Smtp-Source: ACHHUZ4BKHaf7XvK45/sdK9qEnBiGarMgqtI+mQuResfyEJzLMP4hxjtnt76Gaj7fOrHeuwlKNBJ/Q==
X-Received: by 2002:a92:d486:0:b0:340:d836:1f64 with SMTP id p6-20020a92d486000000b00340d8361f64mr6666293ilg.29.1687103656201;
        Sun, 18 Jun 2023 08:54:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709027c8800b001b51f6ad766sm5798371pll.284.2023.06.18.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 08:54:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 18 Jun 2023 08:54:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (oxp-sensors) Remove unused header
Message-ID: <923f828a-c8e3-4515-8723-4d4f7474a3c1@roeck-us.net>
References: <20230617181159.32844-1-samsagax@gmail.com>
 <20230617181159.32844-2-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230617181159.32844-2-samsagax@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 03:11:42PM -0300, Joaquín Ignacio Aramendía wrote:
> We are not using <dev_printk.h>, remove that.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/oxp-sensors.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index be36d38f13d9..584e48d8106e 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -16,7 +16,6 @@
>   */
>  
>  #include <linux/acpi.h>
> -#include <linux/dev_printk.h>
>  #include <linux/dmi.h>
>  #include <linux/hwmon.h>
>  #include <linux/init.h>
