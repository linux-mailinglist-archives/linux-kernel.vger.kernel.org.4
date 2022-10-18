Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D76025A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJRHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJRHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:23:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98754ABF1F;
        Tue, 18 Oct 2022 00:23:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s20so21098524lfi.11;
        Tue, 18 Oct 2022 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3nyMq6EMyVRHeyxrABEnUNSYPVSUUrWhCzrtAxceXE=;
        b=Yk+TJio+V9jwykmEv7O6EUfHHYwfvpzYFuS/VgAQQmC7I4eCJjCctniv8kHx3tZ9g2
         woKFrOcAg6AHdQlbG3Ubyv/62eloXlajxefAHzQgd1PxMjmQ70Vfm1pxy5dgWERuaQZG
         jF/32taSjJH5sGTSabqTuWYcLw+Sh3MjRrBVs5HisCXc6ZUI8rXWiyCHvV6MsDvdf2ws
         z2gUR2jb/jRECe2a2q2etTWIqYMI3ZvzdEJb9Vbyjd5NHm/4Ja0dG2yul8UdsX5sC59M
         PPNyn+Em0/ONLYcWkODlFdSMX+V1F9NxlIoFpAZOK9lhulokSEiSOOyQ+7TQ62sOOYSn
         8Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3nyMq6EMyVRHeyxrABEnUNSYPVSUUrWhCzrtAxceXE=;
        b=gGGEenCfujK1cer/xEfuWVPOv8zSoRXuxhdWalAND6qpBCxK8DYgMAIvTMoLUJlvmH
         Gj6pcv19+SSM+tRjJ4LlSW5PuAe4QgPq7YCejAokY/SQiwJyZawikW9KFcTGe+IZ32wc
         XpvlQSaKKiW6e7NS++LmnvhkmRtDFdoaNha7CazgJnufMI9Z0fSp3o11IX2JLKr5sQDI
         YZAuKY3bcxS3UXT/7r1u2WaZCU8y1oZxgKFOreSmt6U/1Kft+zqN1zXQTHzN2c/EKI7A
         rF1Dur9dOXG9xinqS1/2AFbdaUGw5HOFnufwVdyRo/nmow088ww/76wb/wi4U7OaE71e
         0boA==
X-Gm-Message-State: ACrzQf2EXBf3m8FXyql/R1IBhb2chkGVZvUYmnVHAWLWfDNKazSQRwPv
        8xk0a3bBkeWDEZvXLb/dVyg=
X-Google-Smtp-Source: AMsMyM4FIi6S1pT6eltiRrryv4qE0rcqltqfJTCg+I24Bqf3BRcvPv34/82bpTDDYj7hDqtN9ZygBA==
X-Received: by 2002:a19:5052:0:b0:4a2:caa1:e2f6 with SMTP id z18-20020a195052000000b004a2caa1e2f6mr507086lfj.65.1666077802373;
        Tue, 18 Oct 2022 00:23:22 -0700 (PDT)
Received: from ?IPV6:2001:2002:2f8:bfc5:11e3:17a5:f449:1926? ([2001:2002:2f8:bfc5:11e3:17a5:f449:1926])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512361100b004a22ea5dc7fsm1750260lfs.8.2022.10.18.00.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:23:21 -0700 (PDT)
Message-ID: <7509e3c2-b3be-1330-bfa4-3ae16d049d70@gmail.com>
Date:   Tue, 18 Oct 2022 09:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] kbuild: use POSIX-compatible grep option
Content-Language: en-GB
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017150113.334571-1-newbie13xd@gmail.com>
 <CAK7LNARsUE4j7LNYsushQaXFBEcnhhXoNg9THh2wLrYoi2jp9Q@mail.gmail.com>
From:   Stefan Hansson <newbie13xd@gmail.com>
In-Reply-To: <CAK7LNARsUE4j7LNYsushQaXFBEcnhhXoNg9THh2wLrYoi2jp9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 2022-10-17 23:31, Masahiro Yamada wrote:
> On Tue, Oct 18, 2022 at 12:02 AM Stefan Hansson <newbie13xd@gmail.com> wrote:
>>
>> --file is a GNU extension to grep which is not available in all
>> implementations (such as BusyBox). Use the -f option instead which is
>> eqvuialent according to the GNU grep manpage[1] and is present in
>> POSIX[2].
>>
>>   [1] https://www.gnu.org/software/grep/manual/grep.html
>>   [2] https://pubs.opengroup.org/onlinepubs/9699919799/
> 
> 
> This link does not show the spec of grep.
> 
> 
> Did you mean this?
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
> 
> 

Yes, sorry, that's a better link. I'm new to this. Do you want me to 
send a v2 with the commit message updated?

> 
> 
> Thanks.
> 
> 
> 
> 
> 
>>
>> Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index c690361b393f..3513a6db66a2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>>         cmd_ar_vmlinux.a = \
>>          rm -f $@; \
>>          $(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
>> -       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
>> +       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -Ff $(srctree)/scripts/head-object-list.txt)
>>
>>   targets += vmlinux.a
>>   vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
>> --
>> 2.37.3
>>
> 
> 
