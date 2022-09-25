Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440EE5E9542
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiIYSGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIYSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:06:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B698B252B0;
        Sun, 25 Sep 2022 11:06:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fv3so4448008pjb.0;
        Sun, 25 Sep 2022 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=5Xcc3MJJCcZWTzK1jPZ9K1qMqtCQR5hPQZvH2+q5UX4=;
        b=X2MvfRndaV0RauigstwDwhfOZXbV6gZ3DJvvRugSLt3mrHfuNQ/OX7YRWPBesfyWzU
         Pnj2+4NG1skf56jresn6Jv/eI/FHxnBRTkyG3LmmIl6dQNq+yn7mzARAg1qxJV0j2Asg
         OTa8w+2S9SLMmFRNlxDVe/7y0+Gl/pp7K8w/fiw3Y2lVFMi6crhMypZIrmWQuUSnb3Gy
         Q77i0FBU0fFR2ANPQKqR8rdvUXb4OQ4lHrAHtxcgRyPP2jKicwO7G7d9diiYNCdvAqjm
         6TtMawJGgJkaIr+BEA1c1Tc8MpiIQ3yVLh6zQBVLbHzi5eKj6xPNBp+KCfx4rtfxONjk
         4yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5Xcc3MJJCcZWTzK1jPZ9K1qMqtCQR5hPQZvH2+q5UX4=;
        b=AGWS6PZR/Xlvujo8T/3e3QI5G8BOD0RMsbtc4d+LZY9qLSpfxUOmzum5esRvniuWkX
         9+pCKuBWHFXRxYZ3zaMrx5d8QlCJxrMLRuHeTXZUwk2pmel/XKRoFEJORgwv/OCkNINE
         4zmDdTwH4WQ8Oa13fXpQEHMUdbiX5c6xQi2LCxY0lozzPcXTX4eO/MGIUWM6b0LNR2NB
         d4axpaXJHx9xUj7ENk/niPgmZDeX+CW9kLOh9UWsDOuiWg16zb9guLtbXf57kO6E9WZ7
         USEHmRu9lRsSXT1qcPMAd/a4oeuBlrXXAO75tADMuwa56LK/VpDduTltv3yOcAjLmxsC
         jbZg==
X-Gm-Message-State: ACrzQf1oLtUTkElr07WiT/ndQ+IkHz09HwqcwoaIVVFR6cWS/L+IlCYy
        3HdZNSK90n62l250bKsY27kxRb2fFSeY8Q==
X-Google-Smtp-Source: AMsMyM6+xq7GdV5F+gAFVO4xOB9L7aiWhqgzWItIKLtcodE6L/JSsSF5y0v7Io5dfYp7flrKZKOsTg==
X-Received: by 2002:a17:90b:3b81:b0:202:597a:c71d with SMTP id pc1-20020a17090b3b8100b00202597ac71dmr32052900pjb.105.1664129194154;
        Sun, 25 Sep 2022 11:06:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ad20100b00203c0a1d56bsm4992243pju.35.2022.09.25.11.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 11:06:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 11:06:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     joel@jms.id.au, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] hwmon: (occ) Check for device property for
 setting OCC active during probe
Message-ID: <20220925180632.GA1766526@roeck-us.net>
References: <20220809200701.218059-1-eajames@linux.ibm.com>
 <20220809200701.218059-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809200701.218059-4-eajames@linux.ibm.com>
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

On Tue, Aug 09, 2022 at 03:07:01PM -0500, Eddie James wrote:
> A previous commit changed the existing behavior of the driver to skip
> attempting to communicate with the OCC during probe. Return to the
> previous default behavior of automatically communicating with the OCC
> and make it optional with a new device-tree property.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Assuming this patch is applied as part of the series outside
the hwmon subsystem.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/hwmon/occ/common.c | 11 ++++++++++-
>  drivers/hwmon/occ/p9_sbe.c |  9 +++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 45407b12db4b..dd690f700d49 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -10,6 +10,7 @@
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/property.h>
>  #include <linux/sysfs.h>
>  #include <asm/unaligned.h>
>  
> @@ -1216,8 +1217,16 @@ int occ_setup(struct occ *occ)
>  	occ->groups[0] = &occ->group;
>  
>  	rc = occ_setup_sysfs(occ);
> -	if (rc)
> +	if (rc) {
>  		dev_err(occ->bus_dev, "failed to setup sysfs: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (!device_property_read_bool(occ->bus_dev, "ibm,no-poll-on-init")) {
> +		rc = occ_active(occ, true);
> +		if (rc)
> +			occ_shutdown_sysfs(occ);
> +	}
>  
>  	return rc;
>  }
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 4a1fe4ee8e2c..3adcf8d0b4a6 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -7,6 +7,7 @@
>  #include <linux/fsi-occ.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/string.h>
> @@ -179,9 +180,17 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id p9_sbe_occ_of_match[] = {
> +	{ .compatible = "ibm,p9-occ-hwmon" },
> +	{ .compatible = "ibm,p10-occ-hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, p9_sbe_occ_of_match);
> +
>  static struct platform_driver p9_sbe_occ_driver = {
>  	.driver = {
>  		.name = "occ-hwmon",
> +		.of_match_table = p9_sbe_occ_of_match,
>  	},
>  	.probe	= p9_sbe_occ_probe,
>  	.remove = p9_sbe_occ_remove,
