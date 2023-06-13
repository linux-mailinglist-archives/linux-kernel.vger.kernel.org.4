Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5596D72EBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbjFMTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFMTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:10:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B2F92;
        Tue, 13 Jun 2023 12:10:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1b8593263so73186721fa.2;
        Tue, 13 Jun 2023 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686683416; x=1689275416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukmpjB2evvzV+K2dRegWsqshz7MHYI5yA57E91qt//0=;
        b=nPHkhuVZ50BUfD5nmyyGwqL93NQQxldU7AZOOnAHMzhVjBYHfFHQJmWxSDp1pxKfQS
         iylZlWVAsZoTs5+ETrcrSdgIWamclgcY6/cpimQIA3WDt2RhRV9DmEdo3cW2u/A/1kS9
         9mqF6pAECK637jyxKuqN+0F/AQM/LBDSbtpOdELMA+CZCI4pLk8o3qpPKdqYQUyL4tPy
         9BILBQ3s6mbHBxqk/GT6Sa5Kaw2bj9IFl1bVesPVcgu+8pDSKdcE/4x6Bb64CCUnr6Fj
         HqS/aZSbPm8fp6WTRUqbX6MWo5+jdFl7B7MGRKZDAFMjuBrLzA1MNEudpxuYAVaBvdxh
         5/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683416; x=1689275416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukmpjB2evvzV+K2dRegWsqshz7MHYI5yA57E91qt//0=;
        b=QT85RbkrDqpw9Jll18et23ZENYWzzBdQ1LsmPgc4tmFe3ntGmPyeXBvESZAdO1OtwJ
         +QmE4aqIWGCx6XllmKYl9waS0OkFzjgeTGSec989q4YQF/AYJruBawUDSBzCECU16Xe1
         DYeIw+v9N064Ob6K6Xvv3Y+pr/neFFACxUwhSD7+rOIvQL980P3BMbQRFW8b6DNaiQHT
         RZTiE1P9n0PfyAaznfZ7tbKnI3TOq/ttWu9ve1YXGotCXFak2BadNksEWSg/JGyEdgps
         mn+9duRPJnxkLVb1jjot8zlmZJyYfXkh30Xui7WXOsoac3RExHBFLujPLq8jzTn5Dcig
         0njg==
X-Gm-Message-State: AC+VfDxxpynTzZuY8O9KQE7RYlXnBnftyqbvlyGe4F+zOQke9YKO0NOW
        Ujw9AjNJw9e0bo0bgTp5NLo=
X-Google-Smtp-Source: ACHHUZ6LhivEpT+kIkT56ptSismUuMBZk55INPEJh0MnrMG32kXvZiffmuLV0Sy1V22n/MLjQJkQoQ==
X-Received: by 2002:a2e:9f4e:0:b0:2af:47b2:3f6c with SMTP id v14-20020a2e9f4e000000b002af47b23f6cmr5174305ljk.31.1686683415625;
        Tue, 13 Jun 2023 12:10:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id k13-20020a2e920d000000b002adadef95c0sm2264765ljg.124.2023.06.13.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:10:15 -0700 (PDT)
Date:   Tue, 13 Jun 2023 22:10:13 +0300
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
Subject: Re: [PATCH v3 2/3] device property: Implement device_is_compatible()
Message-ID: <20230613191013.gwkeco4abvcgxsvf@mobilestation>
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
 <20230612161011.86871-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612161011.86871-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:10:10PM +0300, Andy Shevchenko wrote:
> Some users want to use the struct device pointer to see if the
> device is compatible in terms of Open Firmware specifications,
> i.e. if it has a 'compatible' property and it matches to the
> given value. Provide inline helper for the users.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


C/P v2: IMO much useful wrapper. Thanks for the patch.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  include/linux/property.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 3df7e10156d8..0251138c7c88 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -90,6 +90,18 @@ bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char
>  	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
>  }
>  
> +/**
> + * device_is_compatible - match 'compatible' property of the device with a given string
> + * @dev: Pointer to the struct device
> + * @compat: The string to match 'compatible' property with
> + *
> + * Returns: true if matches, otherwise false.
> + */
> +static inline bool device_is_compatible(const struct device *dev, const char *compat)
> +{
> +	return fwnode_device_is_compatible(dev_fwnode(dev), compat);
> +}
> +
>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  				       const char *prop, const char *nargs_prop,
>  				       unsigned int nargs, unsigned int index,
> -- 
> 2.40.0.1.gaa8946217a0b
> 
> 
