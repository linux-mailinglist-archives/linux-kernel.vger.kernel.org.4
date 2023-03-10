Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB26B558D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCJXXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjCJXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:23:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1F10D313;
        Fri, 10 Mar 2023 15:22:41 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bk32so5463698oib.10;
        Fri, 10 Mar 2023 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678490561;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QfYglAGkfr3BRMsJPjHGCJtCvEB+ftexBj7lDKr1RwA=;
        b=ezQWBvAjvehY8i9RWJU0KcevbaRrDnvcK5PJD2l6tDRUEb4BK+qI+upa3y2Rxy6eqS
         yWxoWtJiWxGrAG+1v1W343hQ+2tUjwsLQUxMJ4ePL3AKC4m+1Lr7bX93SFDZGc9SYU8M
         0Co39AqtSSTDc8LVnYC2A8XCb3aHj01AuulZNoW1HpQcJ5wG47LfNWft1K7zeWUxcoi5
         vUoBLjcvC5pzUapiD6I+4ZLFmL8twRQFH7kmEDCS3R9NyePFjGNeBiLBmkh54mnKmMw/
         3yPB07cVkg+rdxSZX7iqy6nY1Iylv4t8C4QVN30XokiTe/8ezrESpVbj0u6WcpFjR+tG
         ZZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678490561;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfYglAGkfr3BRMsJPjHGCJtCvEB+ftexBj7lDKr1RwA=;
        b=kpfM1+Q5+jpao4KAhXzxjttwQQoaZ19B37+X9QfGurQSSXX/kdw6XmV5JS9bNhz5dT
         HqOcD6Sn9VyaObZljwQx2mNCfyMkAZH89kyUyLA5UQFPx3GfJxD682rMOdbqPU4zkz83
         Q5ilK5bbiQuJV+NtXjAZSbNq48uNzsuRzHpb9AlMPG9XMw5zaOy+lNrPXqgZI7EImo1T
         NBnn1IzeykFl/hATdxJiJkITpS/eMd2BaLKU8VAfhV2yBPFdqAMY6Oj6blLOq1hjVRW8
         bc9BWFs5S5CyMcNuAwhZz9zf6ZlrEnjgwphDSrxprG4EJHWFc1ON0KTMLGAPjO9lRI8m
         3Ppg==
X-Gm-Message-State: AO0yUKUcc+js9ou71JaIi+GyUPA5kJqtsUx34x4hMQTqplaTatZY+qVR
        q3FUgfL0RUSDtyHfFVCdgyk=
X-Google-Smtp-Source: AK7set8nQsbGVqni05QAgQNbWWBHtQ9FL/McmnoCZjVMmIWVqZvcsjQSqlkRjdNG5vzNdPezaAyY6A==
X-Received: by 2002:aca:1c02:0:b0:383:c945:703 with SMTP id c2-20020aca1c02000000b00383c9450703mr11756257oic.34.1678490560900;
        Fri, 10 Mar 2023 15:22:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a056830078900b0068bbf5f2e49sm592169ots.37.2023.03.10.15.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 15:22:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f225f9a0-77a6-8238-ea68-79eda1846ebc@roeck-us.net>
Date:   Fri, 10 Mar 2023 15:22:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] usb: typec: hd3ss3220: Drop of_match_ptr for ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
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
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
> 
>    drivers/usb/typec/hd3ss3220.c:284:34: error: ‘dev_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/hd3ss3220.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 746ef3a75b76..8bbeb9b1e439 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -290,7 +290,7 @@ MODULE_DEVICE_TABLE(of, dev_ids);
>   static struct i2c_driver hd3ss3220_driver = {
>   	.driver = {
>   		.name = "hd3ss3220",
> -		.of_match_table = of_match_ptr(dev_ids),
> +		.of_match_table = dev_ids,
>   	},
>   	.probe_new = hd3ss3220_probe,
>   	.remove =  hd3ss3220_remove,

