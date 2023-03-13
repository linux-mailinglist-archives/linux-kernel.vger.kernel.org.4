Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9C6B7115
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCMIZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCMIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:25:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E56303DF;
        Mon, 13 Mar 2023 01:25:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id n2so14553870lfb.12;
        Mon, 13 Mar 2023 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678695902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBJ+MVwgwtIkyKpO0yCKLsxBFxykpziKwNtVfj7PP28=;
        b=dGkHmp1W69kJ0kWGmZgteojJySma8T2tk6U/O9VRhKYKJAFEt7ew6EBPUBra/kSiiK
         99Nv1+BQqbqP/X56vXL4g+gqlnKxP/n3xp3R/2y3oxGwkarDh27XPdbyQDA0n+MBwXrj
         SuIfItc9yEml+uevEDw0jLt33Lkiq1mHgT08AL57XfXYSYQaBTUYqn6uzIB/tcAemfGo
         gs6YaMy7zR6MI6i2v1hzi7QZx9YCEa3iwyRBBn9QCKjpnfeUBYKsnCGUCfp9cbOEb+p0
         tRdIAAUE1kTZVmZLdyzfrBkNIbyh8i5jbcX8xZRdUaXW5bwJd3xogxD4a0OgaRAopzDc
         oaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678695902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBJ+MVwgwtIkyKpO0yCKLsxBFxykpziKwNtVfj7PP28=;
        b=jEILvg/HsOfmAm5PJQyrzL0L794MHrEhQCA+ufOMNtBknqQuHMDpAuC9FAvisy9G68
         qwNpEbyE/BGH01v8NCJfR77kxOYjkBSkLoW6CgqdmiIjC5OMF1ZO8fG4wtDkF+zd+mu+
         QKRrGyn3rEXeiUfREESyoaDeBEgJRz4E2B0RQ+xpjuEa5yuVkVEvDYJXuZbP08Huk0mp
         ezc1QX088BETc9OQ3U+a/JoSfHpFIzIVBftL7PuvkJ/vYLi11D+l/yxADa7DdPIN3CzQ
         ALzc3Grcu3NLORBHlYm/wCh2DXTc7ivrRP2NH72NmeKzlZiKaw1Zm8ZEFY2tGZ9jyYuW
         xosA==
X-Gm-Message-State: AO0yUKUKDCR3P6XPwJO5Htku92wcCLuaNN91KKx92sl3oLfjLw1vIcSQ
        dvC98RV9drd5JiIcBoXfrpI=
X-Google-Smtp-Source: AK7set97bf4RTjqUfWvM1Tyyo3+ubA5mZTcj7G6VQav22Rj0X8ZXFBdRv9Rva7ohmFnSqdEy17TOxA==
X-Received: by 2002:ac2:46d6:0:b0:4e8:4930:df19 with SMTP id p22-20020ac246d6000000b004e84930df19mr146815lfo.22.1678695901984;
        Mon, 13 Mar 2023 01:25:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id d1-20020ac24c81000000b004da8d947c57sm893384lfl.149.2023.03.13.01.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:25:01 -0700 (PDT)
Message-ID: <cf4732a2-44a6-65ce-d3cf-168d3502d7da@gmail.com>
Date:   Mon, 13 Mar 2023 10:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv1 11/11] power: supply: generic-adc-battery: update
 copyright info
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-12-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230309225041.477440-12-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 00:50, Sebastian Reichel wrote:
> jz4740-battery.c and s3c_adc_battery.c have been removed
> from the tree and after all of my restructuring the driver
> is basically no longer based on them.
> 
> Thus update the copyright information and switch to SPDX
> license identifier while being at it.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/power/supply/generic-adc-battery.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index 436e75d226ed..ac72140dc136 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -1,13 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
> - * Generic battery driver code using IIO
> + * Generic battery driver using IIO
>    * Copyright (C) 2012, Anish Kumar <anish198519851985@gmail.com>
> - * based on jz4740-battery.c
> - * based on s3c_adc_battery.c
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file COPYING in the main directory of this archive for
> - * more details.
> - *
> + * Copyright (c) 2023, Sebastian Reichel <sre@kernel.org>
>    */
>   #include <linux/interrupt.h>
>   #include <linux/platform_device.h>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

