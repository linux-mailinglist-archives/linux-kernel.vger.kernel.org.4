Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8186B558B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjCJXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjCJXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:22:40 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644C138692;
        Fri, 10 Mar 2023 15:22:16 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bp19so5491520oib.4;
        Fri, 10 Mar 2023 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678490536;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2ssIQISrIHKpeBzxtHxUWa47lzIYGpAzcB3KOlcNc=;
        b=Z57z/tmquclVCb9NbBh/s7yxHfwS64vNTJ+H0AMeMBA7HD4tXrklkyVcmgmV0S0BqG
         vpubeogXWwbyrC3WoWTuJSyUVx6gCeo5Xo6raUdll6r/6rRqvcCuBxdAFrfAuaDmrcw+
         s8HSC9vQ+tKhfI+d9TXMJ5h5C65tpWz1suguKf5Z87+LyAWlUHOAe9qzoAU8dvbSPWws
         gEshujcZgdoQS47FQtG4e6+S4eNkDyco5oTV809/CKKqLik4W6R/P6dsZnG1iha7rfg9
         9lO5XJA+HcYVg4zOTYe9HpOeQbaWMu9vBGLJlpoYHVp/njs6DJaq/VcBjStJPQGSJhBo
         7MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678490536;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Z2ssIQISrIHKpeBzxtHxUWa47lzIYGpAzcB3KOlcNc=;
        b=gzdzGMDdoBdh8+udlYhT/FPRYIdyDl9Nu5m3ZwIwVpwzXiwoRVyxVDa2ropLMp+U2b
         vl12ihi7ewRyhvnhANOIVtBfuDGbhILSGxXd05C9y5a0zkdTez0sM6pQLVZpaoSziS2m
         cpsCWDNp5QtWQjh8StqHdOGuEMDKsk8byMrR5WMDOTE0G4XAtM/tHZxDjQZ12uzCP+QX
         FdEzGxK1Z8u9n870snfuwpdKDsFhgKC0rCfrra5QDEt/m2u9roFOOtWbTtUgslKepkPb
         hj8KB0rE50gqW2fzv2XvROfoD26fOIExper3MVH6Kk1f75VvuGt5n2+gB7CPGHoCLLlC
         hEBQ==
X-Gm-Message-State: AO0yUKUduLmX+F6+D+twmbE6WFBpHNbc/LZKVuPKmV1ka7Lxdedd2bgr
        G6g/AKAZ+969yNq+5rCBKn0iHyIM9vg=
X-Google-Smtp-Source: AK7set9jW+jSCzI4dQa/iY0C4iudlSUofix1DRxGUNdqh53Br65OU0DdIYfuso6gTQLYz+7rMCr9nQ==
X-Received: by 2002:a05:6808:4c7:b0:384:311d:5675 with SMTP id a7-20020a05680804c700b00384311d5675mr12203642oie.3.1678490535923;
        Fri, 10 Mar 2023 15:22:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k20-20020a544414000000b00384926684b8sm434107oiw.13.2023.03.10.15.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 15:22:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e5c364fc-e53e-39fb-7b59-06573101adb0@roeck-us.net>
Date:   Fri, 10 Mar 2023 15:22:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] usb: typec: fusb302: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
 <20230310222937.315773-2-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230310222937.315773-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 14:29, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    drivers/usb/typec/tcpm/fusb302.c:1816:34: error: ‘fusb302_dt_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/fusb302.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 1ffce00d94b4..592b0aec782f 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1813,7 +1813,7 @@ static int fusb302_pm_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static const struct of_device_id fusb302_dt_match[] = {
> +static const struct of_device_id fusb302_dt_match[] __maybe_unused = {
>   	{.compatible = "fcs,fusb302"},
>   	{},
>   };

