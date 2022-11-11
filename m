Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EDB625F51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiKKQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKKQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:19:43 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E658DE0;
        Fri, 11 Nov 2022 08:19:41 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id w10so3648328qvr.3;
        Fri, 11 Nov 2022 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YP1SZjbQo7XU90m5pRQJ5p+S7jKUwWZA6O51TWo4jc=;
        b=Au2sCr94zXBY5PkQWLuEw9wtJfYMU2bc5D9rUIyN+KeZOEC5Y8qx8Uo93ZhtOJ51TM
         aIcRXYjYhHjf9Q8AAv8kxrf8auvP5liaWbRaEwiZ5t0LTHZXtpc1rRk5GYb8CWcVvUoM
         OmZxqaN0sxhTYq17OaA0b3ud6VLRIIS6uGuUpFi2G2hRe0jKuruY4bwTBJgWItokIuQW
         +Eb/OmJm5FZHRga5yUy6B6BxqzraposLA+ho/s8d3bH3uEADWcRHqwvkoHf3ac0KA7/Y
         +GlC2ZChDPZPC+TAi1ugXRczSkiEfbe0iVn0yLos2VWAWb8ynNy7KgxB10pf8LEvEE3z
         Ncgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YP1SZjbQo7XU90m5pRQJ5p+S7jKUwWZA6O51TWo4jc=;
        b=B8oD7lPZ3uqz3xrqtYN/F9z90dnHd+z2GpdiL3Vw/XMPy9rUJmrbvXXBBhwqdubdzX
         TSMmK++3cOaRs2CRbJTSBpr5uPF8cOPprdUs33fUWlzcR9lcaSLv1jEoPqJWWqOxfvQy
         HAZlTKuOGz7VgHoBJ1x10Apa8uevnITU435ymaNi6hnZeIqPvHqTkZDYtkuzTz9MH0Ky
         78twivrPYUMMz/zcwKpcB73Im0NC6UC48ezdBLCR15ASFDZku9gNQC2cepE0j8ZbM6rf
         4L4C0NJGL9AC43tM9WC1yIxqw2YBSzvqDwY5VHiPMHCyYvOXQtcglQG08+fNbnvGV3dE
         L8pQ==
X-Gm-Message-State: ANoB5pnIDg2d9VtKHWLF5jMpEWIXPKeJVicw+u/PJIt2WSsr5pw/0vDw
        3tKh/sFYH/UwTpTM/xG75g2Cf2cXP5s=
X-Google-Smtp-Source: AA0mqf7V+Re858Ch7eeF8ioaZqwD4ZYm8nwsnR788dM1nav4zjVEXqmAKCilSyr9Ndy+/a8xk1wCZQ==
X-Received: by 2002:a05:6214:5906:b0:4b1:8827:adca with SMTP id lp6-20020a056214590600b004b18827adcamr2556574qvb.50.1668183580619;
        Fri, 11 Nov 2022 08:19:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006b615cd8c13sm1583946qke.106.2022.11.11.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:19:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 11 Nov 2022 08:19:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: Include <linux/kstrtox.h> when appropriate
Message-ID: <20221111161938.GA202568@roeck-us.net>
References: <51688cf50bda44e2731381a31287c62319388783.1667763218.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51688cf50bda44e2731381a31287c62319388783.1667763218.git.christophe.jaillet@wanadoo.fr>
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

On Sun, Nov 06, 2022 at 08:34:16PM +0100, Christophe JAILLET wrote:
> The kstrto<something>() functions have been moved from kernel.h to
> kstrtox.h.
> 
> So, include the latter directly in the appropriate files.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> The goal of this patch is to eventually remove <linux/kernel.h> from
> <linux/watchdog.h>.
> 
> This patch is needed to avoid indirect inclusion, via <linux/watchdog.h>,
> in fschmd.c, ftsteutates.c and w83793.c.
> 
> Changes in v2:
>    - Include <linux/kstrtox.h> in <linux/hwmon-sysfs.h> so that much less
>      drivers need to be updated   [Guenter Roeck]
> 
> v1: https://lore.kernel.org/all/0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/hwmon/atxp1.c            | 1 +
>  drivers/hwmon/gpio-fan.c         | 1 +
>  drivers/hwmon/hwmon.c            | 1 +
>  drivers/hwmon/lm90.c             | 1 +
>  drivers/hwmon/mr75203.c          | 1 +
>  drivers/hwmon/pcf8591.c          | 1 +
>  drivers/hwmon/pmbus/q54sj108a2.c | 1 +
>  include/linux/hwmon-sysfs.h      | 1 +
>  8 files changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> index 4fd8de8022bc..118297ea1dcf 100644
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -16,6 +16,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
> +#include <linux/kstrtox.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
>  #include <linux/slab.h>
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index ba408942dbe7..e75db6f64e8c 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -14,6 +14,7 @@
>  #include <linux/irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> +#include <linux/kstrtox.h>
>  #include <linux/mutex.h>
>  #include <linux/hwmon.h>
>  #include <linux/gpio/consumer.h>
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 4218750d5a66..33edb5c02f7d 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -15,6 +15,7 @@
>  #include <linux/gfp.h>
>  #include <linux/hwmon.h>
>  #include <linux/idr.h>
> +#include <linux/kstrtox.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index a3f95ba00dbf..6498d5acf705 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -103,6 +103,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/hwmon.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 394a4c7e46ab..50a8b9c3f94d 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -11,6 +11,7 @@
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/hwmon.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
> diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
> index af9614e918a4..1dbe209ae13f 100644
> --- a/drivers/hwmon/pcf8591.c
> +++ b/drivers/hwmon/pcf8591.c
> @@ -14,6 +14,7 @@
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
> +#include <linux/kstrtox.h>
>  
>  /* Insmod parameters */
>  
> diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
> index fa298b4265a1..d3ba12951324 100644
> --- a/drivers/hwmon/pmbus/q54sj108a2.c
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/debugfs.h>
>  #include <linux/i2c.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include "pmbus.h"
> diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
> index cb26d02f52f3..d896713359cd 100644
> --- a/include/linux/hwmon-sysfs.h
> +++ b/include/linux/hwmon-sysfs.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_HWMON_SYSFS_H
>  
>  #include <linux/device.h>
> +#include <linux/kstrtox.h>
>  
>  struct sensor_device_attribute{
>  	struct device_attribute dev_attr;
