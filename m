Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A626B5BF8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCKMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCKMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:50:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76684CB051
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:50:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso5115156wmo.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678539043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2VdX4B2dld6wqCG5ZYqlFsLHmtCsviZq3SzvbHDBPs=;
        b=ZfYzmvLpq056KSe0wR6z4s3lzk4PhtaVkXSEToFZYVD2Yj760N7KNPhkJgqfv4m18L
         Xu0lAVTfbJt35TthbdG6zWvBUT5p1F1EzO7WsYmS7TgHvZmtKjjKkHVT2dw4u45+92ej
         Gm9RjAkkPRK6RtlDqgr/MOxUB+0lWAyWyRwS3yy7n+l5dpxSe2ODI3XF2q1PV4Agab26
         UWcALghrZIYngj6OKxgNp7l4+fN0Dm0douW7eN//mOY6KOHwQPwH9l5dhKU9ndfsK/Ha
         +5whzgXkAUaI49XXG+Xl1f4OwCZ2LQMylEkpDCM+VIHoF+ebqcsBvWV5dFqcGV0ttOZC
         yi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678539043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2VdX4B2dld6wqCG5ZYqlFsLHmtCsviZq3SzvbHDBPs=;
        b=kAFTEnLSOmbpCpdT1+Tii+nOfQG5K/EL7ygDk5cHZ0iuBnw9nMXwfXAgPTQ9lAM3pc
         oZzH0h98vAm6in7S7KBm9vpDHiLsx5F0ltjrcWwvyQq0K8a8gNJ2nXQX6AlUbXcP6vaC
         rrmM7b1gMxSdU9I6YsNngRW9fCSAhNmnXYDGG/G30a3eorauO8fO5CdrnJn1LuwQ8mQy
         AcOj7HVU02P+jRwwl9F9IbsK6o8ZrrU3YFo7zUsgbZZWObKBUqeiiGWhEy2k11peTckK
         WPkWBjD3Bk1sysQnuLlHOLpbHcHvq4lmQkErcxK9R4duaZ3UT1a1+owiaeUS0w2Md3/3
         OyEw==
X-Gm-Message-State: AO0yUKVCyUqrcWh+2qn7z6O4EZeOoHPhLnSSvqtvgpc3pOXm3v3D8OtR
        tOI3sNII5/spu6/hUn52Bh0=
X-Google-Smtp-Source: AK7set+DiHVrKM3fDR7GG4dpN6xZ67nadAC84Vqy3UVBeouj5FR1ozUtQTmdo+/DFkAKzt4C0RHmhQ==
X-Received: by 2002:a05:600c:5009:b0:3eb:39c9:ecb0 with SMTP id n9-20020a05600c500900b003eb39c9ecb0mr5630622wmr.8.1678539042876;
        Sat, 11 Mar 2023 04:50:42 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003dc521f336esm2771887wmb.14.2023.03.11.04.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:50:42 -0800 (PST)
Message-ID: <7590a38f-4be2-b237-71db-6b5bc620d9de@gmail.com>
Date:   Sat, 11 Mar 2023 14:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] staging: greybus: Fix Alignment with parenthesis
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <ccd27442c1ad9a33b0b7564176fa68f7b153fa20.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110956591.2802@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303110956591.2802@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١١‏/٣‏/٢٠٢٣ ١٠:٥٧, Julia Lawall wrote:
>
> On Fri, 10 Mar 2023, Menna Mahmoud wrote:
>
>> Fix " CHECK: Alignment should match open parenthesis "
>> Reported by checkpath
> The log message could be better, to explain what you have done and why.
> The word "fix" doesn't express any of that, and should be avoided if
> possible.
>
> julia
got it, thank you
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/fw-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/fw-core.c b/drivers/staging/greybus/fw-core.c
>> index f562cb12d5ad..0fb15a60412f 100644
>> --- a/drivers/staging/greybus/fw-core.c
>> +++ b/drivers/staging/greybus/fw-core.c
>> @@ -110,7 +110,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
>>   			}
>>
>>   			connection = gb_connection_create(bundle, cport_id,
>> -						gb_fw_download_request_handler);
>> +							  gb_fw_download_request_handler);
>>   			if (IS_ERR(connection)) {
>>   				dev_err(&bundle->dev, "failed to create download connection (%ld)\n",
>>   					PTR_ERR(connection));
>> --
>> 2.34.1
>>
>>
>>
