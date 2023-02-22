Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D569FD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBVUyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBVUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:54:19 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C7D2F791
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:54:17 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f16so9141344ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+U/HR42fPN8hC1rLiFVx6gFnszC/TbPe/bv3kKzKu0=;
        b=CpRdXAFmOXc8IWlUDaDmIRyL492+EudgL57Ia+Ej4J/pA083GCZm2E890NYHAWXl4H
         gRWZQhMyBAx7qd1418S6eaKRYZpxK2f9a6rrfuGGAhLIeyfgzbHu8VOPxH/4ky8i3DLe
         3iCP+ka5Mg4l+T9qFxcJo6xxtYVlz9RaV5DP638kjBnr/qXm1LPXRcC5vOzGgbrQUwwS
         I1IpFPC0QW2kV2WzZ7j6NhnrZCJ2IV7ai/7LWSokyJmbaa37/+fKe5DFFlqbsWURQelG
         uOCnN4G3xvJugc1YcU67KxUC89u+i9+5qNAzFJC/xZ0fHk7COJ7G3RkJbOeERK6gfqR0
         BCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+U/HR42fPN8hC1rLiFVx6gFnszC/TbPe/bv3kKzKu0=;
        b=LfglXOYuU7BFVR4FMLOGLszoJMtVEkduuY41LdSwZ3XqA9k4CK3DEuLU5++jcgKzY+
         zKshSMNXJZVzYqqIkQly2XbfRrfuqFhXNlZJd2C/ugr8fXBkPSOwqkRg9LlHq7m2qu8h
         RKbY2x9s2HwsOpiYo1Bobr+LuA00b8twfr9IZHTYZ0OQKcEwOoR44FpMQ6R435VfOnvm
         aUlSjuvWJ5iOSzf+XIhjOkhFFwUZkjvLkTdCcj5BihjeIUCbpkIRbUVsSyV/TVquDBNh
         wd7jFtpeuM5y5p+gnymzRvU1q7YV1txlEyem6t/QBcWsdvrMJg4+nkKZE/t58GuBwjri
         RuiA==
X-Gm-Message-State: AO0yUKW5N/nnerOeqq7TxCcr1RR3dmj2kP3Lzcal3Zgw5G9qX4/au6j6
        tNgjvbRQRnGhR0uUlyCOQpRArw==
X-Google-Smtp-Source: AK7set/z3+BDrX7ucC0zd60YdqSri9mynP/jEgjOEf4l5BcziLEjl9kpQGB6RLQwxKutOQl6az8wLQ==
X-Received: by 2002:a2e:7a16:0:b0:293:806:dd74 with SMTP id v22-20020a2e7a16000000b002930806dd74mr2969798ljc.46.1677099255917;
        Wed, 22 Feb 2023 12:54:15 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id 4-20020a05651c008400b002934ad42ce1sm939198ljq.103.2023.02.22.12.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 12:54:15 -0800 (PST)
Message-ID: <ac9a36fa-5c39-d984-3056-169fd5ab405b@linaro.org>
Date:   Wed, 22 Feb 2023 21:54:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] Input: gpio-keys - add support for
 linux,input-value DTS property
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
References: <cover.1677022414.git.soyer@irl.hu>
 <3519a11b0ef5324a2befbd137cd2aa0cb8fd057d.1677022414.git.soyer@irl.hu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3519a11b0ef5324a2befbd137cd2aa0cb8fd057d.1677022414.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 01:10, Gergo Koteles wrote:
> Allows setting the value of EV_ABS events from DTS.
> This property is included in the gpio-keys.yaml scheme, but was only
> implemented for gpio-keys-polled.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/input/keyboard/gpio_keys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 5496482a38c1..c42f86ad0766 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -770,6 +770,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  					     &button->type))
>  			button->type = EV_KEY;
>  
> +		fwnode_property_read_u32(child, "linux,input-value",
> +					 (u32 *)&button->value);
> +
>  		button->wakeup =
>  			fwnode_property_read_bool(child, "wakeup-source") ||
>  			/* legacy name */
