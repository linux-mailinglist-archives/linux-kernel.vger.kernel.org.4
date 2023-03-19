Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038B56C053C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCSVHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCSVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:07:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95C14993
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:07:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so39611630edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679260043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbmrmyYLLz+8SoyNGLoAb7U6FEP+DusKLIKmlsilCMA=;
        b=CsJO4yZDC2fweK9A4K6EFWmBZGZoyH5AnpsWfCPb9hwtw2SWD/HLGrKiCvTWY1YWPI
         SN1uIoVpAGTFauoN2lGFlAGVseqoAHOdfi+Ah2rGjfJLvtgT1fPalbx7q53QLLBNYsuj
         srNyVFJidoquAd2UKzmMCN1XosOlMwpw+6zb4Yw+oIXjKZYzyPykEk9nF6Kz6k4cI/av
         w5G8xFHYg8j5H7m0NKA/HKE48CA7FQGRB+7kzf8VSq09cd581/lUUJkflaFlbV3nuwcw
         eBRlYN2DF5gmwmi+G13wNOBMG0PpBQ2Z+IIPoGjWWlrgCyIoiPPrLzbhKvVHN3HsnrVc
         JL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679260043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbmrmyYLLz+8SoyNGLoAb7U6FEP+DusKLIKmlsilCMA=;
        b=tnk1NfUrzXE4ZajIsqyl0XZAq3UKbZlHowtCvhIe3NNqkbU1vFF0QpsFLOQK+qmjCA
         E9VwgY8WB42SgmlqBEi7bYZt2qGtrjT4Fogo9sUnHZbIS7zYYPIUY23Dgf6m4+OpcSVc
         WCuRqL2oySxo1DY4mBznYNgcMaZxzOpMCRTL598FfzsfvMMjgP3j3+A7uCybKRQjUM9Y
         KfDZGlAAgW8cNfRR5SYbdPiFWbhdDdeHsC/nhHpFMcmSJxYT9FQWBz4KhPy/MfJKt1hl
         9CIa8FGn0v+46ejQU2q92AyL10aCg1sxCt8bcYwH6CShzADb868Sf8/cnxpdVkhxiiRn
         u2Jw==
X-Gm-Message-State: AO0yUKV5ezUITERelmVAfU60V+a2yniYd7woqQPc3wexGo7QHRteie4J
        uLLcm6jYYKf9l+f28aeqotyRH6ZaTyk=
X-Google-Smtp-Source: AK7set+KFS+BZZVammF2uIJJrPr8RJSHYhNKSmpWsBMrqOaTcdzlMS4VNWTscUgGlVGmXbWeCUwvLw==
X-Received: by 2002:a17:907:206b:b0:8b2:5e3c:e0f0 with SMTP id qp11-20020a170907206b00b008b25e3ce0f0mr6789717ejb.74.1679260042810;
        Sun, 19 Mar 2023 14:07:22 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906195a00b00930a4e5b46bsm3570352eje.211.2023.03.19.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 14:07:22 -0700 (PDT)
Message-ID: <402ffcbe-bb29-7035-68f4-2741532a6d67@gmail.com>
Date:   Sun, 19 Mar 2023 23:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: use inline function for macros
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303192121170.2867@hadrien>
 <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com>
 <alpine.DEB.2.22.394.2303192151330.2867@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303192151330.2867@hadrien>
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


On ١٩‏/٣‏/٢٠٢٣ ٢٢:٥٥, Julia Lawall wrote:
>
> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>
>> On ١٩/٣/٢٠٢٣ ٢٢:٢١, Julia Lawall wrote:
>>> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>>>
>>>> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
>>>> static inline functions.
>>>>
>>>> it is not great to have macro that use `container_of` macro,
>>>> because from looking at the definition one cannot tell what type
>>>> it applies to.
>>>>
>>>> One can get the same benefit from an efficiency point of view
>>>> by making an inline function.
>>>>
>>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>> ---
>>>>    drivers/staging/greybus/gbphy.h | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/greybus/gbphy.h
>>>> b/drivers/staging/greybus/gbphy.h
>>>> index 1de510499480..42c4e3fe307c 100644
>>>> --- a/drivers/staging/greybus/gbphy.h
>>>> +++ b/drivers/staging/greybus/gbphy.h
>>>> @@ -16,7 +16,10 @@ struct gbphy_device {
>>>>    	struct device dev;
>>>>    };
>>>>
>>> You have made the patch against your previous patch that added a newline
>>> here.  It should be against Greg's tree.
>>>
>>> julia
>> you mean I should remove this newline, right?
> You should apply your change to the state of Greg's tree, not the state
> after your patch.
>
> Assuming that you have committed both the patch adding the new line and
> the patch changing the macro to a function, and have made no other
> changes, you can do git rebase -i HEAD~2 and the put a d at the beginning
> of the line related to the patch adding the newline.


you mean drop this patch "staging: greybus: remove unnecessary blank line"?

Menna


> If you have made
> more changes, you can adapt the HEAD~ part accordingly.
>
> julia
>
>
>>
>> Menna
>>
>>>> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>>>> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
>>>> +{
>>>> +	return container_of(d, struct gbphy_device, dev);
>>>> +}
>>>>
>>>>    static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>>>>    {
>>>> @@ -45,7 +48,10 @@ struct gbphy_driver {
>>>>    	struct device_driver driver;
>>>>    };
>>>>
>>>> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>>>> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver
>>>> *d)
>>>> +{
>>>> +	return container_of(d, struct gbphy_driver, driver);
>>>> +}
>>>>
>>>>    int gb_gbphy_register_driver(struct gbphy_driver *driver,
>>>>    			     struct module *owner, const char *mod_name);
>>>> --
>>>> 2.34.1
>>>>
>>>>
> >
