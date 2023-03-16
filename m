Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251C96BC39F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCPCLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCPCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:11:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B33A4B24;
        Wed, 15 Mar 2023 19:11:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w4so260941ilv.0;
        Wed, 15 Mar 2023 19:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678932696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E0wPHL5tG0y6TTLnk5Nwov0SWBJZgv5AdCy7yKorfXU=;
        b=PTeTEX8U0RSI7iE3YTurBMueiTtBZbKTZmF+mSjXq6uM/qfHDlNEL8tDL4YtA+Qq9r
         hIWBbpck4nvDsqM2p949doiKLTL6ac0U3gACGG0J/JAU1Zi14mEbTunNptqK5dFP8W4s
         Vf9VkPpg2BqkJCcpjN3/Sz5+qBgrOYw4YjAl6USBZusPsSKXNSQi5wpuFLi5FIWOx8nR
         5O/bitXCV4Zq82+PawspbhQxGcIQKdxuVMDo6DV8f7gMvHleSV0bKXhurcuRrR1TvqaS
         WJsUSLHPqooEX5SZoEJEjB1EnPTQRj4A+I9K/l50pTJSL8uCtE1UKGI68wWpYSC3EmlY
         X5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678932696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0wPHL5tG0y6TTLnk5Nwov0SWBJZgv5AdCy7yKorfXU=;
        b=U/mVQ0qbr6YC7oAGrEoeXrLBVg0H69Qc7MZgMmQTizgFM82n/5deKb5Mz2qF+FIZ3A
         W9ZX0ewcua93oMWsCvXPjz6Y5KbgHVRN2X8zU87bFd7hAUj7s/nRlZO2hbnAKeIeIrSn
         6hF7ALwRLbRqhtG1kXmQ/UBkg78Q2+lFjV1/vK2cj64iR+4ttFI81m62BLlfsJDE0vQZ
         IiQqOqpgEXSL19KqoPINUHlL4imXPqf90gsVgYT5e2o8RmHisVdcJphHiroBlVrahSCb
         7qIOest/lniZNoDjEjOoNU0QlCak6JyBed8Ba13vIzxLMov25JuQGm49DLpV3fMdvpFt
         x6Dg==
X-Gm-Message-State: AO0yUKVx9uL0vTLlGBf64bEkfM6CejK+gdpet5nceiXwDwg+4YR38ARa
        z6IOBXjnBl3yK9gctq2Pc4w=
X-Google-Smtp-Source: AK7set+Uiwr9aRlQrfzIKnd/Q+T1cb6r3ELsyNXB6t6Ob0UIM5MNT2jw5VdCumuowm0gNc8C7p+kcg==
X-Received: by 2002:a05:6e02:1d82:b0:317:99c6:2791 with SMTP id h2-20020a056e021d8200b0031799c62791mr7992191ila.26.1678932695852;
        Wed, 15 Mar 2023 19:11:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20-20020a056e0211b400b003158e48f1e9sm2071154ilj.60.2023.03.15.19.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 19:11:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <970802b8-f99d-0d26-cfcd-5b2079ed4d6f@roeck-us.net>
Date:   Wed, 15 Mar 2023 19:11:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Content-Language: en-US
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
References: <20230315210135.2155-1-pauk.denis@gmail.com>
 <20230315210135.2155-2-pauk.denis@gmail.com>
 <20230315233054.5ac21db0@gmail.com>
 <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
 <20230316000453.553bf6a8@gmail.com> <20230316001749.44e51d08@gmail.com>
 <20230316003519.27224216@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230316003519.27224216@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/15/23 15:35, Denis Pauk wrote:
> On Thu, 16 Mar 2023 00:17:49 +0200
> Denis Pauk <pauk.denis@gmail.com> wrote:
> 
>> On Thu, 16 Mar 2023 00:04:53 +0200
>> Denis Pauk <pauk.denis@gmail.com> wrote:
>>
>>> On Wed, 15 Mar 2023 14:58:24 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>> On 3/15/23 14:30, Denis Pauk wrote:
>>>>> On Wed, 15 Mar 2023 23:01:35 +0200
>>>>> Denis Pauk <pauk.denis@gmail.com> wrote:
>>>>>
>>>>> Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
>>>>>
>>>>> Pro A520M-C II/CSM is also tested by Holger Kiehl
>>>>> https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de/
>>>>>
>>>>> Could it be applied as single patch or need to rebase over "Pro A520M-C
>>>>> II" patch?
>>>>>        
>>>> Sorry, I don't understand what you are trying to say. I just applied all
>>>> patches in sequence as received, with no conflicts. Should I undo that ?
>>>>
>>>> Guenter
>>>>      
>>>
>>> No, Thank you!
>>>
>>> I just like to mention that Holger Kiehl sent separate patch with
>>> "Pro A520M-C II" support and it could create conflicts. I have found it only
>>> when I have sent my patches.
>>>    
>>
>> I have rechecked repo and "Pro A520M-C II" is added twice after apply both of
>> patches (my and from Holger Kiehl), could you please remove one of mention of
>> it?
> 
> I have resent updated version of this patch without duplication of adding "Pro
> A520M-C II",
> https://patchwork.kernel.org/project/linux-hwmon/patch/20230315222702.1803-1-pauk.denis@gmail.com/
> 
> you could revert this patch and add apply new one, or fix this one.
> 

Done. You could avoid this kind of problem by keeping board names
in alphabetic order.

Guenter

