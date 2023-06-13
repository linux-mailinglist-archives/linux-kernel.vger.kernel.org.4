Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF772EBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbjFMTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjFMTLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:11:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D21BD7;
        Tue, 13 Jun 2023 12:11:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f6170b1486so7191464e87.0;
        Tue, 13 Jun 2023 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686683499; x=1689275499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fj+Ip2BCprc+rlLncGJe/EAXRZh5CYhi5myNlBBps7A=;
        b=kcZQJpGCBI3FDyKJ4CI+DwMxrZlNPuhVMc9TmU9CHKEmXsRB2+os1Ol280Qb28bxhZ
         3v0ZNAk2R4R/EpV/mGlJdTRw3m9B9Ln98TFwZb0p85QwItHDBrtAFAzd5T1Ld53pVW2R
         H6v1FwWp7J32lPqHnOwGadhMVMGn4ELalJl5CIbdC+UgmypTKbwNHnpPZYq7U/7wly9F
         OpaJqNodezo69yj1P2/kWW6fc0pehFhxwaPaZ3RRGifBsuMmZ1+AwOThyudSUge0LxH6
         SXRhEYLrKu1Sdcs+tsTnxMi6ruYoUhi5PZMZtGB9FTq5rRQd2uTxA+Uqx9sBmIFpKVFs
         YLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683499; x=1689275499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj+Ip2BCprc+rlLncGJe/EAXRZh5CYhi5myNlBBps7A=;
        b=S/Nfjk18d4hmei9UcnmVB0dNVXFa49UnLgxpy5gv7hJQsiv5uQgF6bCPne4auUFvsI
         OAwx2URYKFucA9D60uWDNKkYprNWnRifq7L2rA9Oa7wTm6Ys0qM8I9lMHvKN0vKmq+fl
         nl7/updk86jCmvBGFJmWg01vZ2RiHmSm+8OmcVPGhmRJUmhus5cV3fK//iAxcynEwxg6
         dJu55ogRi7NlRoDIaUyCiCOajioOMNBBubWhD8jsXxcekhLbtQtIeC+WHbB2eGvbz1nY
         TKRlLJug4pA/CwaU2LcSDK6m5FPulPRMTp7CA2cDtBT+2Ajd+RR3t4WsiBxhb0nbSlSp
         q/Pw==
X-Gm-Message-State: AC+VfDyTS/33C6iY71yM/WcXd9v+HKphiwbe1ESsJ5PLNLKzlIlBw2ay
        3uzNxo56+K5mP6ArZMj3wBG2CknDpocfQg==
X-Google-Smtp-Source: ACHHUZ7QwMsaS+cIIe0SExSsgxCnjlmVpNKHyv+kwpgqfdJg4s7XE9gBU9tLEGf8iZAJ9zp4AT/15Q==
X-Received: by 2002:a05:6512:329a:b0:4f3:89e6:23c0 with SMTP id p26-20020a056512329a00b004f389e623c0mr4270840lfe.31.1686683498639;
        Tue, 13 Jun 2023 12:11:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512025100b004f763e3c0c6sm40283lfo.115.2023.06.13.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:11:38 -0700 (PDT)
Date:   Tue, 13 Jun 2023 22:11:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Message-ID: <20230613191136.2yol2kwyqtge3o4u@mobilestation>
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
 <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:10:11PM +0300, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make the driver code
> agnostic to the OF/ACPI. This makes it neater. As a side effect
> the header inclusions is corrected (seems mod_devicetable.h was
> implicitly included).
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

C/P v2:
I don't think the driver will get to be fully agnostic after this
patch because for instance the ahci_platform_get_resources() method
directly uses the OF-available functions, walks over the OF subnodes,
touches the OF-properties, etc. So AFAICS in order to be fully OF/ACPI
agnostic the entire libahci_platform.o driver needs to be converted
too, but it's not trivial at all.

Anyway as a start this patch looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/ata/ahci_platform.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index ab30c7138d73..81fc63f6b008 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -9,14 +9,14 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/device.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/libata.h>
>  #include <linux/ahci_platform.h>
> -#include <linux/acpi.h>
>  #include <linux/pci_ids.h>
>  #include "ahci.h"
>  
> @@ -56,10 +56,10 @@ static int ahci_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> +	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
>  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>  
> -	port = acpi_device_get_match_data(dev);
> +	port = device_get_match_data(dev);
>  	if (!port)
>  		port = &ahci_port_info;
>  
> -- 
> 2.40.0.1.gaa8946217a0b
> 
> 
