Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB36FBC5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEIBJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEIBJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:09:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2108E184;
        Mon,  8 May 2023 18:09:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643aad3bc41so4041580b3a.0;
        Mon, 08 May 2023 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594583; x=1686186583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJnx2f3sXSSrhC3+3mHpnxe1r3Cp8bqHnQ2WAmhKzRs=;
        b=c9G8/lFCDbIQ2Lt8NlDQmzUR4Mmr/H8b9Jc7ZLAYTlteDovE8iEvC9w4jWBQbIZYjR
         IXHgDo9j85ADaUa9+i3nEby0tmfN1JzuEYQcSIdQgCk50vnENodVlybeUwkjzA5/IZfJ
         rDlMzv9j/1UuvSUCpYvMdbpRfmAH4IIPv6mJgki25TdmDkfJxQGUkVzPHm0w6GErIrXX
         WPQHlSoqCzWvx2vSzQ6+isShM7AMLvSWnLnyDM4olfbcu0naoH2jdUc/uJI/2EKgjI+w
         naBmo1Yg/539FmJk1JUSh/CxYxvPzrku8+NHw0hvdFgZ7CmWBkoCaVMIJD0LBRNJ8/6L
         qwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594583; x=1686186583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJnx2f3sXSSrhC3+3mHpnxe1r3Cp8bqHnQ2WAmhKzRs=;
        b=WaPZYYayNMCaRwYVj4aYsc5loZiQ0a12HrsvARgMloLMa9/oXrnSHCFLoGMdIlFU+2
         oq6/GFCtECXj/txWMIMJ4Go+LpZluyii/O244JTefWi7htndc+adHD7G0UxEMH08BrV1
         NHFMp+UiZTBCpJhK70Cd+ZoINUj+5YbggVIP8+QBgwZ2mddi+AzSf2s6VIkP5J++OWol
         sPbOfQCvcBBGecmemn7RZe8Fl9LSGIS65z4zswgKgWIGlUJijqA+yTJ/3q67x/HhAeuA
         OnZWeEtwn8VhLi/NYos6kvZmdydicqKSjTOeNfBosW1xv94k9mJMvBWVnlhpmq82ggQ+
         GzpA==
X-Gm-Message-State: AC+VfDwPgCU2KTm0cW/9S/1cV0f85JPrJSn694hJVTxYDkenmGz+kI8b
        cP9JJeEQydiLDzDNoWS49IA=
X-Google-Smtp-Source: ACHHUZ5dzwu0YRY8ZNRrpOmdQtDXncyRjy6d0AwRRlWcdeFmjbmAKdW6nVanTZBJugap1961XomYBg==
X-Received: by 2002:a05:6a20:429b:b0:101:4c8c:d1fa with SMTP id o27-20020a056a20429b00b001014c8cd1famr476055pzj.5.1683594583425;
        Mon, 08 May 2023 18:09:43 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t23-20020a62ea17000000b0062cf75a9e6bsm539061pfh.131.2023.05.08.18.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 18:09:42 -0700 (PDT)
Message-ID: <a64a2da0-893e-52ce-c784-cac70d7cfeb2@gmail.com>
Date:   Tue, 9 May 2023 09:09:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 09/10] reset: Add Nuvoton ma35d1 reset driver support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-10-ychuang570808@gmail.com>
 <1ec43550-9aee-3a36-6ca5-ed56e98628f@linux.intel.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <1ec43550-9aee-3a36-6ca5-ed56e98628f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/8 下午 07:00, Ilpo Järvinen wrote:
> On Mon, 8 May 2023, Jacky Huang wrote:
>
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This driver supports individual IP reset for ma35d1. The reset
>> control registers is a subset of system control registers.
> registers are
>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
>> new file mode 100644
>> index 000000000000..19ed323981df
>> --- /dev/null
>> +++ b/drivers/reset/reset-ma35d1.c
>> @@ -0,0 +1,234 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/container_of.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/spinlock.h>
>> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +struct ma35d1_reset_data {
>> +	struct reset_controller_dev rcdev;
>> +	struct notifier_block restart_handler;
>> +	void __iomem *base;
>> +	spinlock_t lock;
> Please add a comment about what this protects. After adding that, feel
> free to add also:
>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>
Dear Ilpo ,

Thanks for your review. I will fix them in the next version.


Best Regards,
Jacky Huang



