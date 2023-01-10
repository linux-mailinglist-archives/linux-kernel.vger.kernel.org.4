Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA04664219
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjAJNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjAJNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:39:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D2BE16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:39:42 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a184so8828601pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9OvcnmdO53ixVMeNek4UhHR3Wd+j2hjHv0PhllLmX4=;
        b=P6oImwwMBoEN/vsSooxhWbo09zhKFIBMTyFezHlUlAwbeL5T1bc7YR1IgHjHmjf3YS
         ElgAnNs0K6VC05QGt05R92n2Iy76W+o/u5vA4Zc7M1u7Q7YE/jLe9u6FGqsRpkHvB44b
         LuDl7nRTrOGJUAS3sbX5ioGOvAWJzy5eQZTC0kGcETJHlvVlfjkfJQgYFxbjxzvYi+4s
         Z4oHaVCldck0YXGkJ1arVZconl2onZBrE1Z6QDfteeFiPchW+6Bp58twdh4qcwcoabx2
         LMDxUJBOc5EGDJfvWTvYgsBhgmZhzGtQq4c2EcS/skQB2O+FeZoo0xCfiipvp+FuANJL
         jqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9OvcnmdO53ixVMeNek4UhHR3Wd+j2hjHv0PhllLmX4=;
        b=eAtDCB7f1Dz+QP0yV35P9veAx1KZw6/FhTWemDpaVfFwj+Zm7pTdqe2qtGEd+c4H6Q
         bLIig8v+Bjeeg7g+Yjzp6siGXgJc7FzMJxUKEI4YYFEaHs/DRQKReDVCYM2DkKseMevA
         5dqFnFcF5X48yfVm19h9rv03v6Vf8BAGwxexUrzPmqb8s12DXlDJvPqbRdK/TYcYNVN2
         z2tO7daVky1kwJRKf0YmAs8UMnxOUYlCTM1RdtPUNDIUEhjyREnVl7oEO3UJKU2Tl5G+
         eTZgPbHKX3OXW6WKwE77+yMIC0SHvsQPL05LimYRa/GkiM+7tNDqLkp7HnWyTCxNDKCI
         q1OQ==
X-Gm-Message-State: AFqh2kpFWcBVjGOkQeg5n+dSU2L0qZZTKiFw54hmbjylqrAyIi9zXo5n
        3+ajeIL8Qu6rauremMh9Igc=
X-Google-Smtp-Source: AMrXdXvcMtscR1xZU+uguVApcHXe3AWgti7Z3QTd/jMDMeF8JRaAGwkjZ/k3MCF059ipe4KM5b8w+w==
X-Received: by 2002:a62:506:0:b0:56d:d678:aecd with SMTP id 6-20020a620506000000b0056dd678aecdmr65298411pff.23.1673357982024;
        Tue, 10 Jan 2023 05:39:42 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w1-20020a627b01000000b0058217bbc6f5sm8081568pfc.215.2023.01.10.05.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:39:41 -0800 (PST)
Message-ID: <dc62d036-dcab-532b-1c3c-fbebcd1705fa@gmail.com>
Date:   Tue, 10 Jan 2023 22:39:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] extcon: Add EXTCON_BATTERY type for battery presence
Content-Language: en-US
To:     andrew lien/WHQ/Wistron <andrew_lien@wistron.com>,
        myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
References: <20230110023656.1334114-1-andrew_lien@wistron.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230110023656.1334114-1-andrew_lien@wistron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 1. 10. 11:36, andrew lien/WHQ/Wistron wrote:
> This information can be useful to device that support battery swap,
> for example allowing them to indicate that a battery is present or not,
> so provide a standard way to report it to userspace.
> 
> Signed-off-by: andrew lien/WHQ/Wistron <andrew_lien@wistron.com>
> ---
>  drivers/extcon/extcon.c | 5 +++++
>  include/linux/extcon.h  | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index b4df4372f097..6c47d23244c3 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -184,6 +184,11 @@ static const struct __extcon_info {
>  		.id = EXTCON_MECHANICAL,
>  		.name = "MECHANICAL",
>  	},
> +	[EXTCON_BATTERY] = {
> +		.type = EXTCON_TYPE_MISC,
> +		.id = EXTCON_BATTERY,
> +		.name = "BATTERY",
> +	},
>  
>  	{ /* sentinel */ }
>  };
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index b0b4abb018ee..88210b481b6c 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -81,8 +81,9 @@
>  #define EXTCON_DOCK		60
>  #define EXTCON_JIG		61
>  #define EXTCON_MECHANICAL	62
> +#define EXTCON_BATTERY		63
>  
> -#define EXTCON_NUM		63
> +#define EXTCON_NUM		64
>  
>  /*
>   * Define the properties of supported external connectors.

Actually, battery is not external connector. The power_supply
subsystem already provided the POWER_SUPPLY_PROP_PRESENT
for the battery present. You have to develop the power_supply device driver
and then use power_supply_changed() to send the uevent to user-space.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

