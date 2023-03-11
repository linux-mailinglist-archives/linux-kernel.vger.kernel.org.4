Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97366B5D07
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCKOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCKOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:51:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3904113883
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:51:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bw19so7565853wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678546313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTyGiahvzsQx6sDWzDztFd/3tHnrkFadviqDemTjFAk=;
        b=VmrcOQrYSwQV3GHhymuNbikfTIPRLft+zy76bG4/a3MqV/JVBXU69qGUvIgLsWKGEf
         be5WfHPnRlIcwA15+6ctfzo+8hL2sLPtktBjekIXX+Ql0QtpFxFwsg6GwxLIEzHo6Jy3
         jSGEr/aWYJo4jC4OuX540W0v5Vj2BOh9oOBUVwhvRVVo1BH1FRlG8QNIA7087XE3B78b
         JOyjY45LBBov+aFy9nW6tM4fH+bjaCPzAOfw2ZIWcHuDrKoRwyqGmrGb1MKPDoYGGjhX
         hFvpNWkIPgm+BpooacQKs+hu4Eubkbpe0npHNYYBW7oJu0MKSOAVNSWoP6zQjfIe3CP3
         wQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678546313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTyGiahvzsQx6sDWzDztFd/3tHnrkFadviqDemTjFAk=;
        b=fwjqeLHBOVCnnKPv7qgeS1zAyIukwzKxNZU+fFBCrermPN/rDNwjEtVUhHI9rba7YQ
         rDsHgN4BTaIJI6dPmAAtu9G3OJC0aDf1GZYwlsKBYb4giwC+RG9R82hzWqQo/J7u/XmX
         9DDMa3BslXCjiO0cSfRmr62SbPgUpfnT22ZQG2q5MrDVyL48RHSX62KtsLgBnCponA6r
         +8JFGQuk/uGCwzrB9LHViOwGU9GF/QFwwY0EvDRowumFaf49VK5T5MCzJdrpUxhWul26
         vFVZTgPWEgO1JZIqTi8vkyVLkh14DPtjry4buDydikIrAH9rShEqdMscsn+NrACE8Tnw
         xkBg==
X-Gm-Message-State: AO0yUKVY2+wYnuGrsq4oI/db7FmX86WqwVASHnj9Ut8BK3ATIIINxB11
        VCv+TagsnCYpl27nyqBTIKM=
X-Google-Smtp-Source: AK7set98xG33fG+YUFZ6RdmVhMIXKcq9Ng+RDMAMc2Pv4Ch44mmJ8SD+JritEW9jgWY6pN++H95bnw==
X-Received: by 2002:adf:ff92:0:b0:2c9:6562:232b with SMTP id j18-20020adfff92000000b002c96562232bmr18070401wrr.2.1678546312881;
        Sat, 11 Mar 2023 06:51:52 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id r14-20020adff70e000000b002c5804b6afasm2527762wrp.67.2023.03.11.06.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 06:51:52 -0800 (PST)
Message-ID: <c9ae27dc-3538-5432-6a6d-3e2ff034f467@gmail.com>
Date:   Sat, 11 Mar 2023 16:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
 <10d2c15b-ff9f-4634-a013-7640c93435a7@kili.mountain>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <10d2c15b-ff9f-4634-a013-7640c93435a7@kili.mountain>
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


On ١١‏/٣‏/٢٠٢٣ ١٦:٠٦, Dan Carpenter wrote:
> On Sat, Mar 11, 2023 at 03:59:19PM +0200, Menna Mahmoud wrote:
>> " ERROR: Macros with multiple statements should be enclosed in a do -
>> while loop"
>>
>> Reported by checkpath.
>>
>> do loop with the conditional expression set to a constant
>> value of zero (0).This creates a loop that
>> will execute exactly one time.This is a coding idiom that
>> allows a multi-line macro to be used anywhere
>> that a single statement can be used.
>>
>> So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
>> fix checkpath error
>>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
> This breaks the build.  You need to compile the code before sending a
> patch.
>
> regards,
> dan carpenter


I see, I thought building the file only enough. appreciate your feedback.


Thanks,

Menna


