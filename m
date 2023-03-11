Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CF6B5C9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCKOHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCKOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:06:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB712D439
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:06:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p16so5157925wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678543613;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHLAIzc+GmiWBlK16hvBHcIL2RgKMlFXd7qg8d6tzz0=;
        b=clznqfjoXpVBWxFJpYNEApaXb5B24L94OTY5WjXa8hMFUJSfEXpDYgqJtv5lIu6pRv
         dbD/PW16AhwcYIRjEdpYvJmcRWK1K2XCQeRmpaHxQc+t4Sk21l86IvDpPUQyUJe1EW6s
         BWAIrQ4+kxyq2IHKEwBU1G03s7xYLSOiWe+gYZREe7k8AHog6C9Tiq4ZUJJr3PR9wisV
         bslBH7FtNqap6bfiFNkmbQPi5C0Db0B2td7hqegzuZU7nDV5oXV7nDTzNtDsXw2avO6M
         vYrWU9LrY1FVcBjc2Wlkqm/UjHMtfZBAH3cCVXLBl+3DxydLQpf50GgV69oKGySm1JNA
         vCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543613;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHLAIzc+GmiWBlK16hvBHcIL2RgKMlFXd7qg8d6tzz0=;
        b=jEqj9T5JPvqHXiTjswlgS+keLx2Y7dj4aWXE0hYhYrTfy1/kXHmG5lv4vzcLXxW/j1
         b+5KIx2MjE+O2Blwf01y7Wj4QvLIiYdnwQlwEOsRbp3m1FJ0MhqC4Pk4IgCwdTDFn5y/
         oFYZzgLz6QIKKPtKythRUeoXnEm55ogQdeTvsaodOCdWMl2r3V2jmcuC72N0auMuIMdy
         EuDNlfzlW2/ObTXx72PMqi6Ocpg4sAjxIUn2KzxG+b1gBYixBHkt5Tv9dfgCk7Ro0e2A
         zE1VmO6H2DmR9krA6nMzhsjQoC5MNePsrO6icELSDbmnPS3MJYRsUv+6fKlzDOAZi/vg
         1w1w==
X-Gm-Message-State: AO0yUKVJtPyBrQdzUpSTSlMdpHbye0O4tQhpkVat6rNVlZQYjy/DWz5w
        wLMJT/g+2fpa8Amr+87wCL9yOuSVliNXwA==
X-Google-Smtp-Source: AK7set9KsaidIkzAnDLCxIaUvaXd2BbuKHxUXSBqTPm7xDCfRhsZE0EKNiXlZBXgfm7IC31OeR8YKQ==
X-Received: by 2002:a05:600c:1f0f:b0:3df:ef18:b0a1 with SMTP id bd15-20020a05600c1f0f00b003dfef18b0a1mr5825500wmb.12.1678543613212;
        Sat, 11 Mar 2023 06:06:53 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003daf672a616sm2900260wmc.22.2023.03.11.06.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 06:06:52 -0800 (PST)
Message-ID: <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
Date:   Sat, 11 Mar 2023 16:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
 <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com>
 <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
 <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com>
In-Reply-To: <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com>
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


On ١١‏/٣‏/٢٠٢٣ ١٤:٥٧, Menna Mahmoud wrote:
>
> On ١١‏/٣‏/٢٠٢٣ ١٤:٥٥, Julia Lawall wrote:
>>
>> On Sat, 11 Mar 2023, Menna Mahmoud wrote:
>>
>>> On ١١/٣/٢٠٢٣ ١٠:٥٩, Julia Lawall wrote:
>>>> On Fri, 10 Mar 2023, Menna Mahmoud wrote:
>>>>
>>>>> Fix " CHECK: Alignment should match open parenthesis "
>>>>> Reported by checkpath
>>>> See the message in the other mail about the log message.
>>>>
>>>> Also, you should not have two patches with the same subject.  Here, 
>>>> the
>>>> changes are on the same file and are essentially the same, even 
>>>> involving
>>>> the same function call.  So they can be together in one patch.
>>>>
>>>> julia
>>> okay, I will. appreciate your feedback. thanks.
>> Please put some blank lines around your response, so it is easier to 
>> find.
>>
>> thanks,
>> julia
>
>
> Okay, I will.
>
> thanks,
>
> Menna



Hi Julia,

according to Alex feedback

" I think this type of alignment is not a major problem,
and alignment isn't done this way in general in this
driver, it's probably OK to keep it that way. - Alex "


,I won't resubmit these patches, right?


  -Menna


>
>
>>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>>> ---
>>>>>    drivers/staging/greybus/fw-core.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/staging/greybus/fw-core.c
>>>>> b/drivers/staging/greybus/fw-core.c
>>>>> index 57bebf24636b..f562cb12d5ad 100644
>>>>> --- a/drivers/staging/greybus/fw-core.c
>>>>> +++ b/drivers/staging/greybus/fw-core.c
>>>>> @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle 
>>>>> *bundle,
>>>>>                }
>>>>>
>>>>>                connection = gb_connection_create(bundle, cport_id,
>>>>> -                        gb_fw_mgmt_request_handler);
>>>>> +
>>>>> gb_fw_mgmt_request_handler);
>>>>>                if (IS_ERR(connection)) {
>>>>>                    ret = PTR_ERR(connection);
>>>>>                    dev_err(&bundle->dev,
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>>
>>>>>
>> >
