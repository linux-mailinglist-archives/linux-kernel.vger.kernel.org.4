Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486A86DB6E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDGXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDGXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:08:51 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737CE066;
        Fri,  7 Apr 2023 16:08:33 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17aeb49429eso47092748fac.6;
        Fri, 07 Apr 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680908913; x=1683500913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z0hkBEX5cpOKVX71KoRB/i1EOEt0Xqxcn4gT4+N0vLI=;
        b=iBqyp/jfYd0IxkbcZPs/0btgSFWI/JIraYpK7PCOrdtyMDj0HmP6kPFZ4axjxY18a8
         T3S4xFrnQ/bz/Tzv3yo0FOq0A5YZfjk2PD4ljxaOvz16xLbgHXN9JWM54ob2/wNel51P
         EoVe7niHaIuuoSms5WXmuQl6A6AnwGsgZVGmYen8zJTEn/fKFh34Tw1rOP3apNeem8lI
         6pNsTFaJgplSTHFitOpYgSsUySdVf1ndDjVCMOsfY9rW9e9nGxqIS/t2glPMiDtPjdQn
         xYMhQafqWtiX1MjXERMZ7/jmmLZCA8Pe5EPVUUBSdN4wUv49x/2IRUGZesG+NcLMaqsy
         vYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908913; x=1683500913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0hkBEX5cpOKVX71KoRB/i1EOEt0Xqxcn4gT4+N0vLI=;
        b=cI+e8rd4kufWgVo3tRBKxkQpn6u9YELewbT1YljSTwzzcIEFHxUwoJbQ2wS6ctPJXw
         oKLzUDR/N39mX+sM/efSo625rKdqlrWsr5Zj6BQy2s3WLCnqcVM8+1pRXx2lh4AoFgTn
         DOpetL4CEIHj/cWHBMkHgP+D7MYFzfrqFE5dNW7uCLRd4HUXEFNkslW5MiYakrNXx9iE
         aX/h3+qPdbRuWBnDmnYZpDGLAaLWmELxqxmAh714mzptvotIQu+HAb/Rooal1YAkhEV4
         xFj9ZTTpD3/DEy60te5+rsDpay/bvQ+Anr+GT0QbJhTaJmDiciKE96++GFbfgTLMz26a
         cEeg==
X-Gm-Message-State: AAQBX9f/qz9oVXlVLYemavLZ5ri7pUZgSZzcDRDlhNEE3Q2POmnWRmu/
        qahorl5rcrpwm2cqzrJFg+A=
X-Google-Smtp-Source: AKy350ZimLsqaUdfR8lke4vOG1f+tCvH1NBCHAkQpCqddi4hjPOjf5aYAn1yAgh2kUEUfcgwTL2z8w==
X-Received: by 2002:a05:6871:90:b0:177:c62f:b059 with SMTP id u16-20020a056871009000b00177c62fb059mr268188oaa.49.1680908912809;
        Fri, 07 Apr 2023 16:08:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21-20020a9d5915000000b006a13dd5c8a2sm2084662oth.5.2023.04.07.16.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 16:08:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
Date:   Fri, 7 Apr 2023 16:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.

I am not going to apply patches for 10+ subsystems through the hwmon tree.
This can only result in chaos. The dependent patch is available at

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

or wait until after the next commit window to apply this patch.

Thanks,
Guenter

> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>   drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> index e695e36ff753..65304354b34a 100644
> --- a/drivers/vdpa/solidrun/snet_hwmon.c
> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
>   	.read_string = snet_hwmon_read_string
>   };
>   
> -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
>   			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>   	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),

