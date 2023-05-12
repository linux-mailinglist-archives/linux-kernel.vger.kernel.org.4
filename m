Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD406FFE1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjELAni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:43:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909BF2101;
        Thu, 11 May 2023 17:43:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b8bf64a4999so1420489276.1;
        Thu, 11 May 2023 17:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683852213; x=1686444213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA9GTBUaLlTL5Dbrc7x2OWFAgSUirYMQNpAhJ3u77zc=;
        b=H6aBAxY3wFF6Kt5Q/Y8uQ7NlsoJyI40Fa4BBxOhfdK+6FQIjv7OWSZ0IWj4xWsGTv/
         m6RgetZqbEuwK/8+DAisyYV+yLEnhVqT01ChTlllvMTndZI1mCZjIOfPwxDvgHo7XNm4
         ffuRw2hS698UDlRVNfZGdg+gPq5aRJZ9FLkxxm3b9Z6hNMB+mrVSAoHaywADN4LMpjbW
         WIUIYNdkM2iPx4LSaWDfGk41QJPjOo7RPlWiyNsBHLGGBc8QwwxSy8R0BUl3jYFGi1HJ
         Y8OkEDMLwKN7e2srUMI6gNo7sAQsqYWcAXR8WXS2cQG82RQcv+H1hetKvVORqzNDGOJQ
         ZyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852213; x=1686444213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA9GTBUaLlTL5Dbrc7x2OWFAgSUirYMQNpAhJ3u77zc=;
        b=clzgGGSG/g1iR7HUz/URka4pdrGxHZOC13myn79ooNFCYUjkUCwNWTgGadKaz1o1Cz
         Z3vtJjgRaonOXfMU9TxOiU0S2Z8bSAK7D8IxJkOPE5yu6oFHEJ3RvywxWzhmLtsr8V7N
         JSi1ouJHkP+pCK5cevxaoio2yVbDlJGaWntvEypeZpiRRrZVVGoYhz2GP2Fh8jt8TsNE
         33SEndhMP2QGL10aNWpoJxC8XYHMi+zI2OIjNHFCjd/NP3vFNdorAKxI4qRCGgBtc3uw
         kH8LHpEs7nc9xM1KzZkeKf4ueBEne0n6jBMWsShcHnadJN8k1cV6dRfDf1Q1e10rh5O6
         Pmhg==
X-Gm-Message-State: AC+VfDz1JM61VGnue1Y/7k8lv+jYFtxWB5LYqNxtR6ntLf0LKvZ5tmxO
        ve0ljTxJ05RayJH6mWPnps8=
X-Google-Smtp-Source: ACHHUZ7lIqTYfEZVb6Rcz5y0htJbbqBQfSC+qrZdesnQVQbgeZE5eKfJD2KZM2NkkjD1OO0o6+hf/g==
X-Received: by 2002:a81:1ad7:0:b0:55d:9a9c:f19e with SMTP id a206-20020a811ad7000000b0055d9a9cf19emr21949258ywa.0.1683852212629;
        Thu, 11 May 2023 17:43:32 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:e2d5:5eff:fe88:4a55? ([2604:2d80:4d87:cd00:e2d5:5eff:fe88:4a55])
        by smtp.gmail.com with ESMTPSA id l62-20020a0de241000000b00560c2e3ec63sm2377401ywe.77.2023.05.11.17.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 17:43:32 -0700 (PDT)
Message-ID: <e25468f4-e3a3-bcf7-c2c0-826edb0600c2@gmail.com>
Date:   Thu, 11 May 2023 19:43:28 -0500
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 2/5] Input: add driver for Focaltech FTS touchscreen
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
 <20230415020222.216232-3-joelselvaraj.oss@gmail.com>
 <ZEXr1hC+Q5Bo/3Tc@nixie71>
Content-Language: en-US
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <ZEXr1hC+Q5Bo/3Tc@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff LaBundy,

On 4/23/23 21:39, Jeff LaBundy wrote:
> Hi Joel,
> 
> Great work so far! It's coming along nicely. Please find my latest
> feedback below.

Sorry for the late reply, university semester end got me hooked up.
I have a sad kind of good news... As pointed out by Hans de Goede, the 
edt-ft5x06 driver works out of the box for the fts8719 touchscreen in my 
device. So I think this patch series is no longer needed. I did have a 
look at the driver once when working on this patch series, but it looked 
different/not compatible at that time. After mentioned by Hans de Goede, 
I had a more closer look and the main touch buffer handling seems to be 
the same.

I am sorry as we put some considerable time in this patch series. I 
should have noted more carefully. Thank you though as I learnt things 
working on this patch series.

I guess I will send a different patch to add the compatible data to the 
existing edt-ft5x06 driver and dts changes to include that driver to my 
device.

> On Fri, Apr 14, 2023 at 09:02:19PM -0500, Joel Selvaraj wrote:
>> The Focaltech FTS driver supports several variants of focaltech
>> touchscreens found in ~2018 era smartphones including variants found on
>> the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
>> This driver is loosely based on the original driver from Focaltech
>> but has been simplified and largely reworked.
>>
>> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
>> ---
>>   MAINTAINERS                                   |   8 +
>>   drivers/input/touchscreen/Kconfig             |  12 +
>>   drivers/input/touchscreen/Makefile            |   1 +
>>   drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
>>   4 files changed, 453 insertions(+)
>>   create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7ec4ce64f66d..1a3ea61e1f52 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8028,6 +8028,14 @@ L:	linux-input@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/input/joystick/fsia6b.c
>>   
>> +FOCALTECH FTS5452 TOUCHSCREEN DRIVER
>> +M:	Joel Selvaraj <joelselvaraj.oss@gmail.com>
>> +M:	Caleb Connolly <caleb@connolly.tech>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
>> +F:	drivers/input/touchscreen/focaltech_fts5452.c
>> +
>>   FOCUSRITE SCARLETT GEN 2/3 MIXER DRIVER
>>   M:	Geoffrey D. Bennett <g@b4.vu>
>>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 1feecd7ed3cb..11af91504969 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -388,6 +388,18 @@ config TOUCHSCREEN_EXC3000
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called exc3000.
>>   
>> +config TOUCHSCREEN_FOCALTECH_FTS5452
>> +	tristate "Focaltech FTS Touchscreen"
>> +	depends on I2C
>> +	help
>> +	  Say Y here to enable support for I2C connected Focaltech FTS
>> +	  based touch panels, including the 5452 and 8917 panels.
> 
> This language is a bit misleading, as it seems to suggest three or more
> models are supported. It seems the title should simply be "FocalTech
> FTS5452 touchscreen controller" with the description as "...FocalTech
> FTS5452 and compatible touchscreen controllers."
> 
> As more are found to be compatible (e.g. FTS8917), the compatible strings
> can simply be appended.
> 
>> +
>> +	  If unsure, say N.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called focaltech_fts.
>> +
>>   config TOUCHSCREEN_FUJITSU
>>   	tristate "Fujitsu serial touchscreen"
>>   	select SERIO
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index 159cd5136fdb..47d78c9cff21 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>>   obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
>>   obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>> +obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FTS5452)	+= focaltech_fts5452.o
>>   obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>> diff --git a/drivers/input/touchscreen/focaltech_fts5452.c b/drivers/input/touchscreen/focaltech_fts5452.c
>> new file mode 100644
>> index 000000000000..abf8a2f271ca
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/focaltech_fts5452.c
>> @@ -0,0 +1,432 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * FocalTech touchscreen driver.
>> + *
>> + * Copyright (c) 2010-2017, FocalTech Systems, Ltd., all rights reserved.
>> + * Copyright (C) 2018 XiaoMi, Inc.
>> + * Copyright (c) 2021 Caleb Connolly <caleb@connolly.tech>
>> + * Copyright (c) 2023 Joel Selvaraj <joelselvaraj.oss@gmail.com>
>> + */

[skip]

>> +static const struct of_device_id fts_of_match[] = {
>> +	{ .compatible = "focaltech,fts5452", .data = &fts5452_chip_data },
>> +	{ .compatible = "focaltech,fts8719", .data = &fts8719_chip_data },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, fts_of_match);
>> +
>> +static struct i2c_driver fts_ts_driver = {
>> +	.probe_new = fts_ts_probe,
>> +	.id_table = fts_i2c_id,
>> +	.driver = {
>> +		.name = FTS_DRIVER_NAME,
>> +		.pm = pm_sleep_ptr(&fts_dev_pm_ops),
>> +		.of_match_table = fts_of_match,
>> +	},
>> +};
>> +module_i2c_driver(fts_ts_driver);
>> +
>> +MODULE_AUTHOR("Joel Selvaraj <joelselvaraj.oss@gmail.com>");
>> +MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
>> +MODULE_DESCRIPTION("Focaltech Touchscreen Driver");
> 
> Nit: mixing 'FocalTech' and 'Focaltech' throughout.
> 
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.40.0
>>
> 
> Kind regards,
> Jeff LaBundy

Thank you,
Joel Selvaraj
