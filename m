Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0566C74A1BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjGFQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:03:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E1DC;
        Thu,  6 Jul 2023 09:03:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5774098f16eso11415367b3.0;
        Thu, 06 Jul 2023 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688659436; x=1691251436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kP3pF+XOxlc4Qv9/UJTQvZ314wf1LITEQ/lD6q6M3cs=;
        b=gf7JwHUDdQKlrqMaznOBPRjtILjUVDkaFMzAsovbd6ohVdpY6MbEtFQWKIRWoXCNKk
         T7PsTZ+oU5EETlfYxSm1t39vfALhQjOhfQXc8mTo7BPkxSNr6xL815JSq6zeCvkRNcrK
         Y7r+2ptw+2E1kophi1fPakut7byn6u7zbVgDEZMvI+bVCzJRbYFhk30j3HL2ID1RO0xX
         bbdl8n2ct/G3IXphx99hhYXH19VSkqaRLvLBlNAc0T++ZSESJn3bHrUFhnFHK4O8Ghfi
         oNzdsF3oSI2IDq/ESRAcjEvCm34Z2+7ssOnX9JZgL908OMjEPazKeIbH7c4Jjcf/z06I
         nc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688659436; x=1691251436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP3pF+XOxlc4Qv9/UJTQvZ314wf1LITEQ/lD6q6M3cs=;
        b=IDCMvcq9UCTkaMYTzkVY4fy8YqUnszCXZePm5FQbqLgp49m6+QwGF3Mbsorcfedffu
         jDfASSVpsBlx4dECZw52cJQjrv3gX4ok9tsFwX+zobwPkeX999nNwNhlDgdRblhGeAmH
         ddxse6YdpY6Ew/ksqCHRPiFfYpEFhbxrpF/3Xd1pmoY1xlfGRrWGcihQkG3S+vfsbR5H
         xbYPp1ydHjSkS+pz9RFNS6JInmpWzCH4XB+7l2e7218aGNFpNaYiZveQA+9YHtFG3Yx8
         Jx07FIalkj+U/YzMz4oLAme/4jnBLfV30PusWi5jMaBiDPFDrGBQO1b2YhdFizRFMnqw
         aY3A==
X-Gm-Message-State: ABy/qLY7t5Rn2K1gQxJvb3H19UrtKbSb6H0aAenpcHGcXEuhoRHD1MMS
        6Ql0sV6a4bshN2lQ9adm7C0=
X-Google-Smtp-Source: APBJJlG9MixangRIjPWmQQkjG9G3S//NVdJuf0043UPQkU4lQWM7HhHi5ksGYofdZ3BzvyDm46DfaA==
X-Received: by 2002:a25:aa28:0:b0:c10:7a9f:a96a with SMTP id s37-20020a25aa28000000b00c107a9fa96amr2266065ybi.16.1688659436153;
        Thu, 06 Jul 2023 09:03:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12-20020a5b014c000000b00c624de0d9absm393124ybp.5.2023.07.06.09.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 09:03:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <876f6a08-1850-21cd-83d1-b309e7e1e912@roeck-us.net>
Date:   Thu, 6 Jul 2023 09:03:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] watchdog: simatic-ipc-wdt: make IO region access of
 one model muxed
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20230706154831.19100-1-henning.schild@siemens.com>
 <20230706154831.19100-2-henning.schild@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230706154831.19100-2-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 08:48, Henning Schild wrote:
> The IO region used for the watchdog also hold CMOS battery monitoring
> information. Make the access muxed so that a hwmon driver can use the
> region as well.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/simatic-ipc-wdt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
> index 6599695dc672..cdc1a2e15180 100644
> --- a/drivers/watchdog/simatic-ipc-wdt.c
> +++ b/drivers/watchdog/simatic-ipc-wdt.c
> @@ -155,9 +155,8 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
>   
>   	switch (plat->devmode) {
>   	case SIMATIC_IPC_DEVICE_227E:
> -		if (!devm_request_region(dev, gp_status_reg_227e_res.start,
> -					 resource_size(&gp_status_reg_227e_res),
> -					 KBUILD_MODNAME)) {
> +		res = &gp_status_reg_227e_res;
> +		if (!request_muxed_region(res->start, resource_size(res), res->name)) {
>   			dev_err(dev,
>   				"Unable to register IO resource at %pR\n",
>   				&gp_status_reg_227e_res);
> @@ -210,6 +209,10 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
>   	if (wdd_data.bootstatus)
>   		dev_warn(dev, "last reboot caused by watchdog reset\n");
>   
> +	if (plat->devmode == SIMATIC_IPC_DEVICE_227E)
> +		release_region(gp_status_reg_227e_res.start,
> +			       resource_size(&gp_status_reg_227e_res));
> +
>   	watchdog_set_nowayout(&wdd_data, nowayout);
>   	watchdog_stop_on_reboot(&wdd_data);
>   	return devm_watchdog_register_device(dev, &wdd_data);

