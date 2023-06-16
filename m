Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7173253D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjFPC0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFPC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:26:47 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F001270F;
        Thu, 15 Jun 2023 19:26:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3fddb0bd9e2so204891cf.0;
        Thu, 15 Jun 2023 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686882405; x=1689474405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nh6xty6fyMPcSsjBexapcrYm/c9xHnV2ffbthcEhTg=;
        b=W/LprF5zXfuQ1SQs577NgdEulVne7D+XEEwW+SxswFQwmyeZsqcz6fMsp0wtxMNhD+
         t/KIxNr64FVz63BCxKP6JpIyTEz1+F6mkEbw0CNZ2aJ09utikVsVrqUW+O/oMMZgdPEu
         sN+UHU/16vEF4LXCN+csfI78o71N2biicfy3Fb3WH1ciSOBj9MDrvZdkcCuvnlFX7FzZ
         rnuF+rrOagSNInCZMCdjhkPclH8ZdzuNJwShSEalN47XKXtXXo+TzxPBCxWIC7B3nxj7
         Y6HaDk6B8RPP/nQcEPFFONxQ3nyYL6XNtyn3LHyIZmLeIKAKBzG39WzW63gMYw93q/9y
         PQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686882405; x=1689474405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Nh6xty6fyMPcSsjBexapcrYm/c9xHnV2ffbthcEhTg=;
        b=huKVl20BbH3sobO35r6NlmEPR/rqTMTNfrCyoQ3UlLjOkzHJ8hzRNmf/KQCN4Fgeud
         uxBw2LXmuV82WZMlxubW3h09ivFHm5N58/pL5HC+AtylCjTyGktMlEJ/yZiOWe3tfbCP
         mbW1Fni3Bwr9ARH+8BbB+nENLyWDuo5tIUL2nAFSwbRX+Nls+I4WXFFjfeZuP8hq4nLh
         XHDgaVKTdD9jKGZkWWSaCcauqcBkutCwZTKyy7eYqae/m8V/QlcMTf8oCuTAmpzoCl44
         bX4wLEvaU+rjvA+1pp1qjkdzuWevTbvavYQ/4qCMQOgKuun7A1rJSTH+ggutaow7rVyU
         6JZQ==
X-Gm-Message-State: AC+VfDwBCCiPGfyHLLDueE/r27M5dsgdzjyyZu/7l4GXJb9rxkCDYayk
        2Ntvk0V+t7PtwEm+gk9XaKw=
X-Google-Smtp-Source: ACHHUZ4mITQ2WmBWhHdrscjaSh5CQidTZ22DVfEWY7rSvH/H2Waf4uDjtBkNO6M4cRRAFVgsnJcuiQ==
X-Received: by 2002:a05:622a:19a0:b0:3f6:a92e:7f47 with SMTP id u32-20020a05622a19a000b003f6a92e7f47mr1341480qtc.13.1686882405146;
        Thu, 15 Jun 2023 19:26:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b0065e279c5c2csm12550757pfi.181.2023.06.15.19.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 19:26:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f6c9fc11-df51-5ff8-c744-3325c20643b0@roeck-us.net>
Date:   Thu, 15 Jun 2023 19:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: usb: typec: tcpm: add get max power support
Content-Language: en-US
To:     Frank Wang <frank.wang@rock-chips.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230616022157.25877-1-frank.wang@rock-chips.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230616022157.25877-1-frank.wang@rock-chips.com>
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

On 6/15/23 19:21, Frank Wang wrote:
> Traverse fixed pdos to calculate the maximum power that the charger
> can provide, and it can be got by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> property.
> 

Wasn't this already v3 before ? What happened to the version, and the change log ?
Or is this a completely different/new patch ?

Guenter

> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9f6aaa3e70ca8..829d75ebab422 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6340,6 +6340,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
>   	return 0;
>   }
>   
> +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
> +					  union power_supply_propval *val)
> +{
> +	unsigned int src_mv, src_ma, max_src_uw = 0;
> +	unsigned int i, tmp;
> +
> +	for (i = 0; i < port->nr_source_caps; i++) {
> +		u32 pdo = port->source_caps[i];
> +
> +		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
> +			src_mv = pdo_fixed_voltage(pdo);
> +			src_ma = pdo_max_current(pdo);
> +			tmp = src_mv * src_ma;
> +			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
> +		}
> +	}
> +
> +	val->intval = max_src_uw;
> +	return 0;
> +}
> +
>   static int tcpm_psy_get_prop(struct power_supply *psy,
>   			     enum power_supply_property psp,
>   			     union power_supply_propval *val)
> @@ -6369,6 +6390,9 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>   		ret = tcpm_psy_get_current_now(port, val);
>   		break;
> +	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
> +		tcpm_psy_get_input_power_limit(port, val);
> +		break;
>   	default:
>   		ret = -EINVAL;
>   		break;

