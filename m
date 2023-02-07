Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2179368DF4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjBGRu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBGRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:50:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D42126D4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:50:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m1so2186541ejx.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+caIN1JymgogQtIiQqJeNUwIQlbruEmUvxoX1EvuhA=;
        b=OHk1wfEEjy3WxNCWGtWxdkxSo5g1i+O/BKoRD+6HAAAdccfd95vLmcJsZIj83nZhyK
         QsJuhsLlfo52+ZHnvhyiIgtlfOLEJHkgCCgmpBqQorcD5VgmFBeNp+6X+oMfp+pJN2id
         cA5FhmB7mKgSM4ZKGMkRR3DGAKv41RCEQtYUZww4CKyrK5451jU+NUVnqNx0M1vPT4+S
         v8nPPqy4e5/pPUwTk5XgmDuJnhqUosjR0buomxCdZAD+YWK0CPswdM+s4Q/R3wE+NzdC
         mED9dbfR5T/0zBSR9n//hdAtHdS2YHwaNuNawS8iqNT24il70tEhKG/z5VG0GNM1C/OE
         bnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+caIN1JymgogQtIiQqJeNUwIQlbruEmUvxoX1EvuhA=;
        b=ObuETKSjK4HWDtg8E2DgskZEQ2ie3zDDE6/BT4hfYeusaOwVxuuMrl1yeN3MAVVZdI
         JUQ6U0fFDwp0LZY5n5GS0utMmk6cFAa4DjrLem9OvPgxtf5XEMnlwCOtp7b8Lmj/e3Z5
         zLXmWFDBznRSsVrymVJHZM0kir5oT4F0V3IP8My+yAZk994waoVeCGMgT1zbf/0ZOcSf
         O2Cg4Zq8gPa8iOAEcPM2TcinoI46WrU3koREdFIsebYMGSllQ/Xvuu005z0WBukU3Bq9
         r0FXfkB5oDDA+x3ttL/KmZRICRrKrI3OIiqQwC7YGNqiZ4P4RfHabwRo28okQLZxaq4m
         oR7Q==
X-Gm-Message-State: AO0yUKVqUZPmLuy5pEZGy8zptiGKR9Z0kvl47vz8EpNnLmBcvtqTIMuW
        V6YcHa2++gdP1k1pIxf5TnCIqlwsqu9jLw==
X-Google-Smtp-Source: AK7set8iZkI0y/zHlc4U92+BgNzHp/Fpl19Hv1jtQb79wJPALBEHTT4TIV+fKzGHr2z4lD+8sgd6Uw==
X-Received: by 2002:a17:907:98b7:b0:881:44e3:baae with SMTP id ju23-20020a17090798b700b0088144e3baaemr4000996ejc.54.1675792243009;
        Tue, 07 Feb 2023 09:50:43 -0800 (PST)
Received: from [192.168.0.177] ([83.148.32.207])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm3781083ejy.219.2023.02.07.09.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 09:50:42 -0800 (PST)
Message-ID: <6a8e356c-cdb8-c535-b91f-4f5e2c793666@gmail.com>
Date:   Tue, 7 Feb 2023 18:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [dm-devel] [PATCH 1/2] Fail I/O to thin pool devices
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Joe Thornber <thornber@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
References: <20230207011849.1343-1-demi@invisiblethingslab.com>
 <CAJ0trDZsTcD43s3GQ7aKR_3eABWv0rREMrajw8xBQiu96X+B8w@mail.gmail.com>
 <Y+J6CgDVnBlW3pO+@itl-email>
Content-Language: en-US
From:   Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <Y+J6CgDVnBlW3pO+@itl-email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 07. 02. 23 v 17:19 Demi Marie Obenour napsal(a):
> On Tue, Feb 07, 2023 at 03:02:51PM +0000, Joe Thornber wrote:
>> Nack.
>>
>> I don't see the security issue; how is this any different from running the
>> thin tools on any incorrect device?  Or even the data device that the pool
>> is mirroring.
> 
> I special-cased the pool device for two reasons:
> 
> 1. I have run the thin tools on the pool device myself before realising
>     that they needed to be run on the metadata device.  It took me a
>     while to realize that I was using the wrong device.  I have not made
>     that mistake with other devices, which is why I special-cased the
>     pool device in this patch.
> 
> 2. Doing I/O to the pool device is pointless.  The pool device is
>     strictly slower than the data device and exposes the exact same
>     contents, so accessing the pool device directly is never what one
>     wants.
> 
> If there are backwards compatibility concerns, I could make this be
> controlled by a Kconfig option, module parameter, or both.
> 
>> In general the thin tools don't modify the metadata they're
>> running on.  If you know of a security issue with the thin tools please let
>> me know.
> 
> I am not aware of a concrete security problem, but in general I prefer
> not to expose unnecessary attack surface.

lvm2 introduced 'protection' layer device - which keeps   -tpool opened and 
thus avoid possibility to use  i.e.  mkfs on thin-pool itself (as it requires 
exclusive open)

Zdenek
