Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714496F0D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbjD0VJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbjD0VJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:09:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75CD3ABC;
        Thu, 27 Apr 2023 14:09:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2478485fd76so6172110a91.2;
        Thu, 27 Apr 2023 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682629755; x=1685221755;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFDXJZIPaM+pqQLwG66fN/jTkXrC7sSivzGv6mtbm3c=;
        b=PPrsSTe1bAp1dKlcBnSXNSudWSQ1LnBOt426D/P/8GTHob8zTIay9PveFM+eRcMngN
         1o14jBuBCFgTWhPg9PZU5sJAca672L1ooDAWDNWb1Xx+WIe0bBJRbG2qm7EQPk+albFV
         PHjWHnrdlVvvoopHIyjfrWTrBbf+2O9StsjwdZLoYqSAsK0BezOTgXmVPVIbTdn9d9+w
         /0td/xwbq/Atcf+YC5hOMhLNfEa7x1rROCq5dvaS/xCjTrCgdb2h0SRYpxvg/bDmkuf9
         CPhQvJT7nwapn14ItSJ4BNLaiL3hf1p8NlDO4hNSLUK0ExcOO0+iLN0tLKrP1JCAAEdL
         PmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629755; x=1685221755;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFDXJZIPaM+pqQLwG66fN/jTkXrC7sSivzGv6mtbm3c=;
        b=lKEnWE3juvqIx1M2OFuJnkAtfU0Fg5Z49ITNROcKla+sq9WGVEuhTJm8qnApwRhkGS
         wDFwId/5xU0IkHyzNb3xFCzJFzQN84yREjfpEOr94J3+eITqMsevMS8tXodVorH29N3A
         Fq+L2v3mdRp+fsFeGpHoGA84o4XFTDisqhgWzfrdKyiWzy3f905vW+XOr+NeSfrYHcj5
         R8oPDhPNKQIPqfYcJat0UFJyCgMrddzjw3p8zE3180y6pWUiw0q/STbj+xDKqkMtMmrM
         r7qzNP/hiPjKWq52qsPXdyWSHbzMd3k3mRnNC+CTYA3mR1ZtZH/i5nY+P18VYjy06NPU
         E6SQ==
X-Gm-Message-State: AC+VfDwQhkywPtXGkrLNJ+DzfiTp8AQg4zymoAUwCKkTrXIJxTnS0hyL
        yGISUupWSnhGKSIqW7D++y6fSMjy0vs=
X-Google-Smtp-Source: ACHHUZ4mIsMHhH/4ygnusk5BTWZYoaP37jVx0U9QGy0Nlp9qwvJQQhf0G7EHbTbM/Dc0dn9Ftb1kgw==
X-Received: by 2002:a17:90a:bd98:b0:23d:16d6:2f05 with SMTP id z24-20020a17090abd9800b0023d16d62f05mr3019092pjr.22.1682629754911;
        Thu, 27 Apr 2023 14:09:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gv17-20020a17090b11d100b00246b0faa6b1sm11683839pjb.5.2023.04.27.14.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 14:09:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fefa43d8-e013-6656-d27d-27ac65cc953d@roeck-us.net>
Date:   Thu, 27 Apr 2023 14:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Scott Smith <scott8440@gmail.com>, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230427193533.718526-1-scott8440@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus) add ir35215 driver
In-Reply-To: <20230427193533.718526-1-scott8440@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 12:35, Scott Smith wrote:
> IR35215 is a digital multi-phase controller.
> 
> Signed-off-by: Scott Smith <scott8440@gmail.com>

Does this chip really need its own driver ? Please check if it can be added
to pmbus.c instead. If not, please provide a rationale explaining why
that does not work. Also, if you have access to the datasheet, please
make sure that the chip is sufficiently different from IR35221 to warrant
a separate driver.

Additional comments inline.

Thanks,
Guenter

> ---
>   drivers/hwmon/pmbus/Kconfig   |  9 +++++
>   drivers/hwmon/pmbus/Makefile  |  1 +
>   drivers/hwmon/pmbus/ir35215.c | 65 +++++++++++++++++++++++++++++++++++

Documentation/hwmon/ir35215.rst needed (if this driver is needed).

>   3 files changed, 75 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/ir35215.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 270b6336b76d..5c089f7e4423 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig1 
> @@ -123,6 +123,15 @@ config SENSORS_INSPUR_IPSPS
>   	  This driver can also be built as a module. If so, the module will
>   	  be called inspur-ipsps.
>   
> +config SENSORS_IR35215
> +       tristate "Infineon IR35215"
> +       help
> +         If you say yes here you get hardware monitoring support for the
> +         Infineon IR35215 controller.
> +
> +         This driver can also be built as a module. If so, the module will
> +         be called ir35215.
> +
>   config SENSORS_IR35221
>   	tristate "Infineon IR35221"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 84ee960a6c2d..fbb9cf048326 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
>   obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>   obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
>   obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> +obj-$(CONFIG_SENSORS_IR35215)   += ir35215.o
>   obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
>   obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
>   obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
> diff --git a/drivers/hwmon/pmbus/ir35215.c b/drivers/hwmon/pmbus/ir35215.c
> new file mode 100644
> index 000000000000..92d59e78bfd0
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/ir35215.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon IR35215
> + *
> + * Copyright (c) Meta Platforms, Inc. and affiliates.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon-sysfs.h>

Not needed.

> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +static const u32 functionality = PMBUS_HAVE_TEMP
> +	| PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
> +	| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
> +	| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
> +	| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
> +	| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP;
> +
> +static struct pmbus_driver_info ir35215_info = {
> +	.pages = 2,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.func[0] = functionality,
> +	.func[1] = functionality,
> +};
> +
> +static int ir35215_probe(struct i2c_client *client)
> +{
> +	/*
> +	 * IR35215 devices may not stay in page 0 during device
> +	 * probe which leads to probe failure (read status word failed).
> +	 * So let's set the device to page 0 at the beginning.
> +	 */
> +	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);

That should probably be added to the pmbus core code since
it potentially affects all PMBus chips.

> +	return pmbus_do_probe(client, &ir35215_info);
> +}
> +
> +static const struct i2c_device_id ir35215_id[] = {
> +	{ "ir35215", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ir35215_id);
> +
> +static struct i2c_driver ir35215_driver = {
> +	.driver = {
> +		   .name = "ir35215",
> +	},
> +	.probe_new = ir35215_probe,
> +	.id_table = ir35215_id,
> +};
> +
> +module_i2c_driver(ir35215_driver);
> +
> +MODULE_AUTHOR("Tao Ren <rentao.bupt@gmail.com>");
> +MODULE_DESCRIPTION("PMBus driver for Infineon IR35215");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

