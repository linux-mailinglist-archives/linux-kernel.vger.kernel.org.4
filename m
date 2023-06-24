Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAE373CD80
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjFXXuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFXXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:50:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1308B10F4;
        Sat, 24 Jun 2023 16:50:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25edb50c3acso1483321a91.1;
        Sat, 24 Jun 2023 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687650601; x=1690242601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vL/kZXE+nVGn85mZgb8ThXLJw0qMur4rdtA1DI8IH54=;
        b=sTgxfhWbaDQQixU/c0qJ5TZTKsZIxs/zns2p45/rcSQs+pV0YrGGZKUh21MQ2gAVDX
         EhnIHP5Cn7FTKAI4a8xofaUrM5FOo+XMPhAn/NDNRUC2M5dPe9cKLExiL/1FgX3/Q1K0
         VxrkinlRa87Ps1OBVnoYGUT5Pu5qyuF+ad5j3vcCLoFP55yH9Nl1A+OPbEOnf+op8OYW
         TWpZKrVP4//ELk9jaZQzpMlPIz8mEGvHnEi29TJsOEQcdT209GS88UzXm0wz74om8T3D
         Cu2KwTM92+6sl6SJb3CLkit33Dbq+483bT1UdplHFfTNDxC68I5FueymGjKwtC/STAVQ
         pNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687650601; x=1690242601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL/kZXE+nVGn85mZgb8ThXLJw0qMur4rdtA1DI8IH54=;
        b=GwtU8N572TtdYTujOqKYMvyp2Pq/E0t6W1TM4OeogVRloTwQNDJVBe3kVBdbC9E6N3
         2mFdtbODaIViCS8/DHqoDZoUqL3hF4TGRbCcxxNANj63L9Uq6unSkgyzFLgZz7cK0lV4
         Olh1faxZ6eyWS3RYX9QJS1A2MfVCNyah60x5bVrkOET0h5R2WkfgT77JxMNfOGcu7wqQ
         geLM+uu1YEESH/XJZ8btQJo9Rowc72htFrFCIFxH0aT7YSaFu555i7fKeuWhzAy39wN3
         8LY+/bGESG67BQky87KeyEgKAALuH33XDAhMh5kglYSWg5DPW0soUNgmrhfNk07lZVk3
         iDIQ==
X-Gm-Message-State: AC+VfDw+H8bW3UwfNaifeH6AftZr5ylewmn3xj/ISjMQdCmYs5TbRm8H
        7cTuqq/BIvRyIXJ1QaXueOQ=
X-Google-Smtp-Source: ACHHUZ7zu9H1G2MfpQZo9Wgt3wE2oRGXJaataqfRDJscmsMva8feyeX7HyfJPFnQvOzRf9n0ohfjGw==
X-Received: by 2002:a17:90a:8a87:b0:25e:f6c0:8327 with SMTP id x7-20020a17090a8a8700b0025ef6c08327mr20262310pjn.47.1687650601363;
        Sat, 24 Jun 2023 16:50:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lf14-20020a17090b484e00b0026094c23d0asm1795969pjb.17.2023.06.24.16.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 16:50:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4d1d5fac-4ad1-2ea7-a349-1b174be694d3@roeck-us.net>
Date:   Sat, 24 Jun 2023 16:49:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add support for AOKZOE A1 PRO
Content-Language: en-US
To:     =?UTF-8?Q?Joaqu=c3=adn_Ignacio_Aramend=c3=ada?= 
        <samsagax@gmail.com>
Cc:     Jerrod Frost <jcfrosty@proton.me>, derekjohn.clark@gmail.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230624231637.14941-2-samsagax@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230624231637.14941-2-samsagax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 16:16, Joaquín Ignacio Aramendía wrote:
> From: Jerrod Frost <jcfrosty@proton.me>
> 
> This device is an iteration over the AOKZOE A1 with the same EC mapping
> and features. It also has support for tt_toggle.
> 
> Thanks to Jerrod for authoring and testing.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

From: and the first Signed-off-by: have to match. You would need
Jerrod's Signed-off-by: tag to keep his authorship.

Guenter

> ---
>   Documentation/hwmon/oxp-sensors.rst | 2 ++
>   drivers/hwmon/oxp-sensors.c         | 7 +++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 0ca1f7728c34..3adeb7406243 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -30,6 +30,7 @@ Supported devices
>   Currently the driver supports the following handhelds:
>   
>    - AOK ZOE A1
> + - AOK ZOE A1 PRO
>    - Aya Neo 2
>    - Aya Neo AIR
>    - Aya Neo AIR Pro
> @@ -40,6 +41,7 @@ Currently the driver supports the following handhelds:
>   
>   "Turbo/Silent" button behaviour toggle is only supported on:
>    - AOK ZOE A1
> + - AOK ZOE A1 PRO
>    - OneXPlayer mini AMD (only with updated alpha BIOS)
>    - OneXPlayer mini AMD PRO
>   
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 1e59d97219c4..e1a907cae820 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -77,6 +77,13 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)aok_zoe_a1,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AOKZOE A1 Pro"),
> +		},
> +		.driver_data = (void *)aok_zoe_a1,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),

