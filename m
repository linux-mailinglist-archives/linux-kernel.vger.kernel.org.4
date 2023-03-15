Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56356BBF67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCOVtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjCOVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:49:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ADC30D9;
        Wed, 15 Mar 2023 14:49:47 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w4so11177249ilv.0;
        Wed, 15 Mar 2023 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678916986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9/4Xc/PzCfJtouwsKgyP22po2ulc0oevszQIyPl3QU=;
        b=IVfby+N57zhlO/lS/5Tlw/MkzNb2SSfQgFV2fN4y3Zi6By7+ZEhnjUaJHMx+h1Pjc/
         GtkymPCqg7C2j6CmW/rmF6ote6Jb944j9FcYA7BDzsu0n47MIIPUZZSGO9sYtsX8Hhqo
         cztUCOso8hURad+E4dz8lgoMKspcEK23e767ooSYBTtqZmzEIwJRJzrxrd1jMlEc6/mK
         GLrq327ieuccIc+JETXH70+YtSMz7mk4IVplz1ytNVdbnf2FiyVwvXf3BnqNJyVtJfsn
         8XZAmnuNn0ppN0o0kUEtIVTPHOWPK9HzXq+RHjEIJ+RyZlg8T2JBCCWhhpCgAuSXd3j/
         q2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9/4Xc/PzCfJtouwsKgyP22po2ulc0oevszQIyPl3QU=;
        b=G8zD6P51EEttavpqkoVRYVYG6N1zud36dDZPhzmRhqmWEJaw+yghNpDI2F7TEwwTj4
         X//bRIiuVGPlHOlMN5SVzzY5z5uI0jR5bWhW+6KmP4c21AbZQ1Vm1alb8wviUlyZ79fg
         DEpWo6WO/Z9O5BaG86nmeFJcBL3XPggsWrjBXLckZrpMV9CCEc4xVkJnfdAUvJEllqw1
         uoASvIe2H0NyWScRj8Q9Kvray9DvaxrS4SU57eU/9v3VtgVdzSFUBvK75/GDcrUTvhXs
         taAHo1fXbcCzRnDovpJLdYlmqqI0Cyiy+1FFZ3alUyiDwm8W+v8+2fQaF4V/EU5QCpIb
         6ChQ==
X-Gm-Message-State: AO0yUKU+CgARXFDlqGSzTy0C5m6VYO/Z292KUpx+0DkR70Cm4v8wC5qd
        +dztAoo5QWhtVqeSjz29YhU=
X-Google-Smtp-Source: AK7set+XpUQTsmPrdSiKjc3wYPDM5cDuVj/eVRgaHuCABtp6FEdqFF9QxQCA4Up/Epc817T0KnycnA==
X-Received: by 2002:a92:ce12:0:b0:313:fea2:be5c with SMTP id b18-20020a92ce12000000b00313fea2be5cmr5492196ilo.11.1678916986566;
        Wed, 15 Mar 2023 14:49:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4-20020a02cc64000000b004035b26b6d8sm2057636jaq.2.2023.03.15.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:49:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Mar 2023 14:49:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Holger Kiehl <Holger.Kiehl@dwd.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (nct6775) add Asus Pro A520M-C II/CSM
Message-ID: <f8e1c010-c11e-4cd4-a2f8-a074b6983e0a@roeck-us.net>
References: <868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de>
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

On Mon, Mar 13, 2023 at 01:10:31PM +0000, Holger Kiehl wrote:
> An NCT6798D chip is now detected:
> 
>    dmesg|grep nct6775
>    [   23.765392] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
> 
> And sensors now shows:
> 
>    nct6798-isa-0290
>    Adapter: ISA adapter
>    in0:                      312.00 mV (min =  +0.00 V, max =  +1.74 V)
>    in1:                        1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in2:                        3.42 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in3:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in4:                        1.03 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in5:                        1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in6:                      200.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in7:                        3.42 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in8:                        3.28 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in9:                      920.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in10:                     512.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in11:                     504.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in12:                       1.03 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in13:                     256.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
>    in14:                       1.47 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>    fan1:                        0 RPM  (min =    0 RPM)
>    fan2:                        0 RPM  (min =    0 RPM)
>    fan3:                      355 RPM  (min =    0 RPM)
>    fan7:                        0 RPM  (min =    0 RPM)
>    SYSTIN:                    +25.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
>    CPUTIN:                    +26.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
>    AUXTIN0:                   +97.0°C    sensor = thermistor
>    AUXTIN1:                   +25.0°C    sensor = thermistor
>    AUXTIN2:                   +25.0°C    sensor = thermistor
>    AUXTIN3:                    +1.0°C    sensor = thermistor
>    PECI Agent 0 Calibration:  +26.0°C
>    PCH_CHIP_CPU_MAX_TEMP:      +0.0°C
>    PCH_CHIP_TEMP:              +0.0°C
>    PCH_CPU_TEMP:               +0.0°C
>    TSI0_TEMP:                 +27.9°C
>    intrusion0:               ALARM
>    intrusion1:               OK
>    beep_enable:              disabled
> 
> Signed-off-by: Holger Kiehl <holger.kiehl@dwd.de>
> Tested-by: Holger Kiehl <holger.kiehl@dwd.de>

Applied. In the future, please watch out for:

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Holger Kiehl <Holger.Kiehl@dwd.de>' != 'Signed-off-by: Holger Kiehl <holger.kiehl@dwd.de>'

Little discrepancies like this just make my life harder.

Guenter

> 
> diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
> index 76c6b564d7fc..1e6abfc7974d 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -1052,6 +1052,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>  static struct platform_device *pdev[2];
>  
>  static const char * const asus_wmi_boards[] = {
> +	"Pro A520M-C II",
>  	"PRO H410T",
>  	"ProArt B550-CREATOR",
>  	"ProArt X570-CREATOR WIFI",
