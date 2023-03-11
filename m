Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008B46B5C10
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCKM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCKM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:57:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D413E505
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:57:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p26so5088734wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678539422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqeWpaGZmWaUB81ceB/6jhQ/prrf3w9V/zttV1zTCNg=;
        b=ZxgPpCgu19gjppNxdYRtNXBW3Bbj0yJsFTnOeSqi/xXOEm/JswDKVgpr5fiJv6S4aX
         SA5cmX6pkIj/TJZnDCoOKt5hJsuYiQbecwQucxLoiK+CgE1ss5vtvEhTyv4AKxsrI79/
         B/zzd3WEotyuKkV/vimLwmhiv3BtrNnaX2LXG3BqSt0oqZycXsTz+X9o+QdKrbrXgl9O
         wg9HeLba4SZ9NkCdoaoe7zREDp9cZo7j+GRFnsC4zmgQWh851g1u+Zv+MUFeffTu107E
         wBudNG+axXabjwjTapcuiCC7xRB9MAywM3qoucrgV6u9RzJXzTsuHDEEJfET61F61pvH
         f/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678539422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqeWpaGZmWaUB81ceB/6jhQ/prrf3w9V/zttV1zTCNg=;
        b=BPslWK4oKelq1Av7qLf5M7ovvu9aEYpgYd0n8YZOro3jnX16cOO5tzFtWeoXUR6Ch7
         odKq9R0omYPesbQE90RDuoAspustT+nL6eH/YXoWqHT/wNMs4EHgi7MxJZ5UXcvrZQol
         RzHK5+FE2jX+WSJA4+Kbr7DJ91XL8kZVlM8jXiPbV/Dit+Jxxq1CY5PfRtnbyOUYt+nm
         1rc/GouMFNzwFQiL4tkwZXaRSPHhzHVgRJVrrrkTPdfduS7vW76MuBWSqy+hVFq/7qwu
         9AX/XqsO/BZIcesVOJ0avg+gSUA5m3Oj9dj+Xkax1vB/C6d4ZhU1vwT1u4DADTUe+vLK
         Nn0g==
X-Gm-Message-State: AO0yUKUvWCBAKdG8H1EIeMp5pp54IBfEccXYSM+TifTI9/YadySCHnja
        0z90qgLafNruSl+AaXq8P9c=
X-Google-Smtp-Source: AK7set8bL6wKE2LLLC1IQXV6iAHTZwh7aSfEseMbwlLVg1xdbLclZSdqdryVvs4t6E6psPfZHEchaA==
X-Received: by 2002:a05:600c:4e4c:b0:3eb:9693:3857 with SMTP id e12-20020a05600c4e4c00b003eb96933857mr5490922wmq.5.1678539422470;
        Sat, 11 Mar 2023 04:57:02 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id v6-20020a1cf706000000b003eb966d39desm2753744wmh.2.2023.03.11.04.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:57:02 -0800 (PST)
Message-ID: <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com>
Date:   Sat, 11 Mar 2023 14:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
 <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com>
 <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
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


On ١١‏/٣‏/٢٠٢٣ ١٤:٥٥, Julia Lawall wrote:
>
> On Sat, 11 Mar 2023, Menna Mahmoud wrote:
>
>> On ١١/٣/٢٠٢٣ ١٠:٥٩, Julia Lawall wrote:
>>> On Fri, 10 Mar 2023, Menna Mahmoud wrote:
>>>
>>>> Fix " CHECK: Alignment should match open parenthesis "
>>>> Reported by checkpath
>>> See the message in the other mail about the log message.
>>>
>>> Also, you should not have two patches with the same subject.  Here, the
>>> changes are on the same file and are essentially the same, even involving
>>> the same function call.  So they can be together in one patch.
>>>
>>> julia
>> okay, I will. appreciate your feedback. thanks.
> Please put some blank lines around your response, so it is easier to find.
>
> thanks,
> julia


Okay, I will.

thanks,

Menna


>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>> ---
>>>>    drivers/staging/greybus/fw-core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/staging/greybus/fw-core.c
>>>> b/drivers/staging/greybus/fw-core.c
>>>> index 57bebf24636b..f562cb12d5ad 100644
>>>> --- a/drivers/staging/greybus/fw-core.c
>>>> +++ b/drivers/staging/greybus/fw-core.c
>>>> @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
>>>>    			}
>>>>
>>>>    			connection = gb_connection_create(bundle, cport_id,
>>>> -						gb_fw_mgmt_request_handler);
>>>> +
>>>> gb_fw_mgmt_request_handler);
>>>>    			if (IS_ERR(connection)) {
>>>>    				ret = PTR_ERR(connection);
>>>>    				dev_err(&bundle->dev,
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>>
> >
