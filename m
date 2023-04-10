Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A86DC796
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDJODe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:03:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7025527B;
        Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id px4so2172682pjb.3;
        Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681135384; x=1683727384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qY72AomAbMje6jRkZ+K0dBVO8y8e5SQs2AgwhNQHgaI=;
        b=oEWIIxAFZGUXoIe7xm1Ww8Nz5Z1O+m6YP4HtPpJ8p7hF+bFb+WyuYjq7x04iikFM+V
         rHVxzwXXMnvyiYcVtj5wcGfCt4t4q87NA1P1H95JgxzGknyyU/CEkZpl31YynsD+Jsrz
         gumTPlz6ysQsp2NrISfE2b94qiWJga0fqfYEIii2PDW/4rLJyrHlDvXpeFWhbL/zT0U6
         3BLmHxrSQwc14m5nuP+gak300fknTJrwK3qrf5wgFiUNEI1OF/qNEgjLUlIx+FspC1N3
         knJ1AP9JfKHwmN7tg4SvgsKxGmFR2wSHr3Fv5TxK+a4J4zs3QkdFX5fwwamB0n/e+xX6
         BpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135384; x=1683727384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qY72AomAbMje6jRkZ+K0dBVO8y8e5SQs2AgwhNQHgaI=;
        b=qo5RnXUCgIx6Vl1orv5RofG0Da0iCx53XddGsGgsgKoR+pqay7ruJlpZvQGams58Yh
         0s4GZcD4E3TQ5cVIo9sPU2pl0Q7vxk08JPucC6Hyd8sB4zBOAPx/L+OvJH8GRhpX3KC0
         ONBvctjQEquqp8/n8C+HVybnzGlLIjyaOEC5ojsJPgyToIaKobo1fTBEGJ2iUO/Z6W6j
         mMkM0jKbaPEH4T1lcXmEkAqeS0IfbosPstF6YMVvMzocRcPls6/Ib0Vg3jW9DpYfCjIN
         4ZzyplnaI16Ym/8OuOLrtDYQqY/SZOJY4OZWQICz8/iwyg6jPsRUl2ybz18JimtKAFkQ
         sukQ==
X-Gm-Message-State: AAQBX9c4yDqWfZJ32LMXVCTkVZM68ioAnu76XNOZ9hM4XqYku2Q8DlKT
        lcMaLyp4qIdM31rLNUXwUIQnUqO7rtE=
X-Google-Smtp-Source: AKy350ZhmibEj2DixzKyVcxxNP46/k57WPd2OqJaXKP90aKYHVrwKh1KvVPgM74ZIbICsziOKIE9Sw==
X-Received: by 2002:a17:902:f544:b0:1a1:d70f:7114 with SMTP id h4-20020a170902f54400b001a1d70f7114mr13250142plf.14.1681135384043;
        Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709028a8c00b001a63deeb5e2sm2108819plo.92.2023.04.10.07.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 07:03:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
Date:   Mon, 10 Apr 2023 07:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230410055634-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 02:56, Michael S. Tsirkin wrote:
> On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
>> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
>>> Statically allocated array of pointed to hwmon_channel_info can be made
>>> const for safety.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> This depends on hwmon core patch:
>>> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
>>>
>>> Therefore I propose this should also go via hwmon tree.
>>
>> I am not going to apply patches for 10+ subsystems through the hwmon tree.
>> This can only result in chaos. The dependent patch is available at
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> 
> Doesn't it cause build errors or warnings there?
> 

Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
I have not seen any such reports, and I don't immediately see why that would be
the case. Please elaborate.

Guenter

>> or wait until after the next commit window to apply this patch.
>>
>> Thanks,
>> Guenter
>>
>>>
>>> Cc: Jean Delvare <jdelvare@suse.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: linux-hwmon@vger.kernel.org
>>> ---
>>>    drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
>>> index e695e36ff753..65304354b34a 100644
>>> --- a/drivers/vdpa/solidrun/snet_hwmon.c
>>> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
>>> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
>>>    	.read_string = snet_hwmon_read_string
>>>    };
>>> -static const struct hwmon_channel_info *snet_hwmon_info[] = {
>>> +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
>>>    	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
>>>    			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>>>    	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> 

