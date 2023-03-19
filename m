Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434266C00CD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCSL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCSL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:28:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF465FF5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:28:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h8so36548826ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679225288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYsg9F+fh9pRcm/YTvI/Kc7XzT0BxNXellA2GuZX/uQ=;
        b=XDPrlwEPBlN7/obEoEn0fWejalXZPRR5CrXIf6T4nh5usgxUiqNUzIvenLcNZkQ/Z0
         kfcM8l8EccH45qkXNZiIZDW5ugR08lF9A5V6ANBTGpLxeVC+vny0RvwSZkvEbC/FNrlv
         XDP1TfcVTa4+0WJcoce7XrWLvhFDAI5rkWmHtQfgrogwT/ctprtuvDalkTzymNz+JfIW
         irYSpwUs0YL19Qkf/K5POvvVAFHhu71hNqW9uaga5BFz2ATHcTXE04YZPui8hOKTLjr5
         Ptm3YJzRlzDBHa4QWNtvlVq8Lccph/TtKe43CbbPc5Oq4Wv+dcwW2Xjk1DY/u7kH2yfH
         lygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679225288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYsg9F+fh9pRcm/YTvI/Kc7XzT0BxNXellA2GuZX/uQ=;
        b=WBpI5F5vW+db6ZQsYnzlmn2s3m2q08OmIK8OPMJ86ZgNd5STO/SpWTP5QxLz2+JRxq
         MxU8HDExHAZ0EHYySY19t9cJirz518bXE9nt4J1AR1rgQMF8xvvt7pTI7PripZB5YjtP
         yfCxA+zIt3+1JzPLt//NFC4lCqMI+ff95Jy4A3qBn3PmMXbNp5IQtH1RVw/RpytE/TQJ
         MAxXqLvgarUqISB0xgNBj4eiug7r3DQyR8o02yf/pJXP+LLB9qUApW/VSRJKE5XB9JUF
         /dLT5mM5QfEexx3262DSsNimOGZtAYJBzUSXZJAzV/BnhniA5hOiE+9GPuhuL1Zn8aSl
         GjSA==
X-Gm-Message-State: AO0yUKXt4T7BEVDVHJhOCYWWUoeAPQHUdk6BGtCogcPuaZK0SOHwnKeS
        Tso71fkN3m2nBfjY4L7YpMbc8nQl+sU=
X-Google-Smtp-Source: AK7set9V99OLguKmluFKrH1BCT7mhfTeuklPoimct+I6fOTgV2yniFwkXZAY/LQpTTrC/CGvDumXfg==
X-Received: by 2002:a05:6402:b0d:b0:4fb:5607:6a24 with SMTP id bm13-20020a0564020b0d00b004fb56076a24mr9496773edb.8.1679225288158;
        Sun, 19 Mar 2023 04:28:08 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id mm24-20020a170906cc5800b009336687cf77sm788368ejb.85.2023.03.19.04.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:28:07 -0700 (PDT)
Message-ID: <15e81411-e40f-43c5-bb7f-907d6d5f93c5@gmail.com>
Date:   Sun, 19 Mar 2023 13:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: add blank line after struct
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20230319110831.39931-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303191216240.2867@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303191216240.2867@hadrien>
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


On ١٩‏/٣‏/٢٠٢٣ ١٣:١٩, Julia Lawall wrote:
>
> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>
>> add blank line after struct for readability as
> The log message should start with a capital letter, so "Add".


Okay, I will fix it.

>
>> reported by checkpatch script
> "reported by checkpatch" or "reported by the checkpatch script".
> The first is more concise, and it doesn't really matter whether checkpatch
> is a script or something else.


got it.

>> " CHECK: Please use a blank line after function/struct/union/enum
>> declarations"
> I guess the #define was concatenated to the end of the definition to show
> that it is closely related to the definition.  With the #define, it seems
> rather natural, but the better soltution would be to make a static inline
> function in both cases.  There would naturally be a blank line before a
> function definition as well.


got your point, so, should i ignore this?


Menna

>
> julia
>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/gbphy.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
>> index d4a225b76338..1de510499480 100644
>> --- a/drivers/staging/greybus/gbphy.h
>> +++ b/drivers/staging/greybus/gbphy.h
>> @@ -15,6 +15,7 @@ struct gbphy_device {
>>   	struct list_head list;
>>   	struct device dev;
>>   };
>> +
>>   #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>>
>>   static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>> @@ -43,6 +44,7 @@ struct gbphy_driver {
>>
>>   	struct device_driver driver;
>>   };
>> +
>>   #define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>>
>>   int gb_gbphy_register_driver(struct gbphy_driver *driver,
>> --
>> 2.34.1
>>
>>
>>
