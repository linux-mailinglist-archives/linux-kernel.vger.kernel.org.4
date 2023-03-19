Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADD36C04DC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCSUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCSUnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:43:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3213535
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:43:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o12so39436051edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679258578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wi0bX3JqTakeGXxWvpXGZVOlMhk3ADDxc4r74Taidyw=;
        b=U2i01dmI/ax16E+zBa6gnlgrOHXETSXUhtau3Bly0BrRaNPmU8uoYvQa78h3j7gT2Q
         4XqljDFSoHrn3VJoxxbRuGLcwsdnp+HnNnKGvE6RkOmdTt3lw78dA+Xw1QpZBaZBLpFE
         H2j1+mqTTGjlVpgNUExADB9e8TAJZYJpuXsEiJrLWkbb2q7tlGVkDbsiNWNn1EvpT5Dr
         m/ojYpjmzOVO6AYiYdwMwgfKWBEGWh18r1C4/SA5+jlqupyhU+Zhe9u6G2BXelXCHjDF
         tp1Xs0a8wMi+02PBMzxKFuUU/SrddIf/9CR7agn5BpwJaMctYHNeA6VvbL96L7cwXSgO
         da2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679258578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi0bX3JqTakeGXxWvpXGZVOlMhk3ADDxc4r74Taidyw=;
        b=W82M9kn7Ltxd/wzFOIr3OStkzp68AW8zEv/6y+VUHHkPC86oL9ve7p5QetSKAABMMG
         8w5g2Snl9L9wKVD1E4H9OnKgCZb8dy97NrIsrRlBphdOG19rnmDan1CU0eK8bTY8k7ZT
         RHQGrW0FqrjRFeHKj+q+8WZQEloINoENEttU9FHa3lHdaQkMCY/LkZ0pWsjycjVZsEsS
         Leqd9Rq+aj6uhCBbtR/2kELdMtuK6icN8Dzo1aW6zpR+WTTwKRdz3uHGwyJBIYwvvQ2q
         3Jt13nU3ujPEZgnQNFhCJfRBFR9MU02a6goTeiH7hflDdB4nu2N7euLHiZ+yLkf6LI70
         etCQ==
X-Gm-Message-State: AO0yUKV8kQjyfxxgMXrWyW0yCVjlSAA2OCa1326/gBewO6Wl2ENoYwkT
        et8aga5jmBtO1furC2PfUB2l4yYydQc=
X-Google-Smtp-Source: AK7set8cACjEkPCdba0ClqL8EkOLYJ3IReh4c65ZcskextOulM57aoevCrR7mBVaqZfEs012M1ScLw==
X-Received: by 2002:a17:906:3ada:b0:92f:a0d5:211c with SMTP id z26-20020a1709063ada00b0092fa0d5211cmr6563376ejd.35.1679258578711;
        Sun, 19 Mar 2023 13:42:58 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm950795ejc.100.2023.03.19.13.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 13:42:58 -0700 (PDT)
Message-ID: <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com>
Date:   Sun, 19 Mar 2023 22:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: use inline function for macros
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303192121170.2867@hadrien>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303192121170.2867@hadrien>
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


On ١٩‏/٣‏/٢٠٢٣ ٢٢:٢١, Julia Lawall wrote:
>
> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>
>> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
>> static inline functions.
>>
>> it is not great to have macro that use `container_of` macro,
>> because from looking at the definition one cannot tell what type
>> it applies to.
>>
>> One can get the same benefit from an efficiency point of view
>> by making an inline function.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/gbphy.h | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
>> index 1de510499480..42c4e3fe307c 100644
>> --- a/drivers/staging/greybus/gbphy.h
>> +++ b/drivers/staging/greybus/gbphy.h
>> @@ -16,7 +16,10 @@ struct gbphy_device {
>>   	struct device dev;
>>   };
>>
> You have made the patch against your previous patch that added a newline
> here.  It should be against Greg's tree.
>
> julia

you mean I should remove this newline, right?


Menna

>
>> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
>> +{
>> +	return container_of(d, struct gbphy_device, dev);
>> +}
>>
>>   static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>>   {
>> @@ -45,7 +48,10 @@ struct gbphy_driver {
>>   	struct device_driver driver;
>>   };
>>
>> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
>> +{
>> +	return container_of(d, struct gbphy_driver, driver);
>> +}
>>
>>   int gb_gbphy_register_driver(struct gbphy_driver *driver,
>>   			     struct module *owner, const char *mod_name);
>> --
>> 2.34.1
>>
>>
