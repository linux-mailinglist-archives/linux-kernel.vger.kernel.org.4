Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACF683748
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAaUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAaUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:07:46 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B55899A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:07:45 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id l7so5138897ilf.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YEWCoXcf2J2u7H2AY1YV7N3bCCpVrI8fx7S3c1g6ao=;
        b=MDUC/BatqDG3bzqZpZwiQlyD+M1dkTS8MnyoztcvUSt1OknQAgKdpyCCukcCJsNcgw
         1+QJ2lgZ+D5D1Lj+4wXSl9osLBGZGpjERS2ewQwQhJd4a8JYAUztykMrbEHecFGIdmo/
         /6sck48ganlcgQBgoPAdReqsYyqJ2fmljrfhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YEWCoXcf2J2u7H2AY1YV7N3bCCpVrI8fx7S3c1g6ao=;
        b=sFc7c26sPMR9Wkc2ygvcMCGIb+UwO0NssWHv9z/qDEmyjeazxXEVxPjvXP0YMBqmlj
         Y7GJSemvTktp+zp8YbkFtYj3YUtTPhSVErqoWlWNRhbTWW73sM36Uan0Jyu3RtuAF5YV
         DgYi40a8WuVJB27oeFuG0HuKr/ZnJZFXLQP1ZEjR6JYmcpPnWBYSVh2c+20P7f5fzcT3
         QKI6Rn3aJuOvRcKliTGoXY/K/OiwwQEf4E1Ydk7WZXYiDwtZfF6qimOkgeMhaKyc7db8
         I66X4BTpRxdMebERtgI+jH/0Xva1iQboHw+BV+rHYGvO4CjO3i1SxSRUf/flejj+zPjY
         CjYA==
X-Gm-Message-State: AO0yUKV5nGjSR+IvwilB/6H777zB6bTLlLFEvy1Pxy2Z8k/91ilhg9rC
        X6Jp+o34PuLaYrwkGkS5i+Wvpw==
X-Google-Smtp-Source: AK7set8KB+AxhVLDxJsrwho7Tu0FZ+KSHL7eHuk5KRxPwiV6j5c82WNe4sFouSVsnzRuDb1KLEEZeQ==
X-Received: by 2002:a92:cb03:0:b0:310:b84b:c893 with SMTP id s3-20020a92cb03000000b00310b84bc893mr4842771ilo.1.1675195664260;
        Tue, 31 Jan 2023 12:07:44 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s14-20020a92cb0e000000b0030d7eb788e6sm4696799ilo.31.2023.01.31.12.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 12:07:43 -0800 (PST)
Message-ID: <cc2c8b52-43ce-48a0-600b-ada5fd67b8b8@linuxfoundation.org>
Date:   Tue, 31 Jan 2023 13:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ver_linux: add missing software to checklist
Content-Language: en-US
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230124204324.33858-1-skhan@linuxfoundation.org>
 <CAJ1xhMU3CPK9nLyx0ejqMt6KKcaeewsstQzUA7KKExumJ7hYzQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJ1xhMU3CPK9nLyx0ejqMt6KKcaeewsstQzUA7KKExumJ7hYzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 01:02, Alexander Kapshuk wrote:
> On Tue, Jan 24, 2023 at 11:04 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Update to add missing software checks to bring it in sync with the
>> Documentation/Changes list. Make improvements to the output with
>> separator between different sections.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v1: addressed review comments
>>
>>   scripts/ver_linux | 28 ++++++++++++++++++++++++----
>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/ver_linux b/scripts/ver_linux
>> index 1a8ee4ff0e32..2daee7e88c45 100755
>> --- a/scripts/ver_linux
>> +++ b/scripts/ver_linux
>> @@ -6,20 +6,29 @@
>>   # differ on your system.
>>
>>   BEGIN {
>> -       usage = "If some fields are empty or look unusual you may have an old version.\n"
>> -       usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
>> +       usage = "Minimum required software versions to build and run current kernel version.\n"
>> +       usage = usage "If some fields are empty or look unusual you may have an old version.\n"
>> +       usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
>>          print usage
> 
> The usage message is followed by three new line characters, the 1st is
> embedded in the last line of the usage message, the second is output
> by the print function, and the third by the leading new line character
> in the separator string.
> All other sections use two trailing new line characters instead.
> If the formatting of this section is desired to be consistent with all
> the other sections, this print function may be substituted with the
> printf function, which does not append a new line character to its
> argument.
> 

> 
> Other than that, LGTM. Thanks.

Thanks for checking this. Make sense to keep it consistent. Will
fix it in the next version.

thanks,
-- Shuah

