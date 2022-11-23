Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF4A635BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiKWL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiKWL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:29:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734CC74A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:27:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x5so24862714wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:references:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eAF2IC7vqnoge/+amySehgAT/PdR6wjI591V/JkZKw=;
        b=mqkPGnURQu6LmZgVdJVI1eTMjCpOwtxipViWnRu62Kj6+By1LHxPM/CcIOY9rgIbG0
         gvDSkV3glw6RtzuZKgtfnFOaIMPM4DoLAJsM+3JlkIz/VMTqHQz1E+wJWv/JviZBLOop
         ebqz8/N9VvJ1xeDL0L6xS2ruFlgRd5Vi+851xA8ySXTKCzrQdQE4rtMPRmXtpROR53Vg
         Cj20vvHK7JPvimrZZ+LCwpzXcVhRfL7zmfHx9xGM4DHHiwufDiNE0G7U8p6Ddllck7/3
         dOsOokb+ikqB7hMW19ShTR2G+7abUeYRXoiELNHvO/B/x9uYugAhGKftHkThaTcCbeyY
         rNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:references:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2eAF2IC7vqnoge/+amySehgAT/PdR6wjI591V/JkZKw=;
        b=alQoG7WU70SHkQ9Xhwt5+pQCOAj9kGyEnBLYZN4XtTUB+88MWAdQo/TxIGqfKJGn2T
         kTKjTVF6HPIrOCkPNp8l+mZqcrbQs73eCkfzZ7C52Gxw4J/TcQLFXG6BPM3ApUj5eYCq
         Q1MJStwSGOCn/L/dTwID+pYE1SQSBXNMcHXwEfzRNDUbJAIJEXlltMOmPqwg9xgDEXzy
         BAm1gpMPsmSlrmjMMNkgo48a0+XUfz4aGcMF5HrGSZsWpbDSBTIgUenxUVQKArtSWXhJ
         YuN85hf4fZKYAwbgilm86U5BXgQOtI658sziDk4TFILxoET4/xQ8tDamHD8Bwhg1H0Q4
         zkOA==
X-Gm-Message-State: ANoB5pkNW3+Fh4goQRYnhNXYibMqwynuy29cAuxIltRhc8gChry3Aja7
        yioyBYq7SJRS24sjpMJuQxE=
X-Google-Smtp-Source: AA0mqf6RwjAseIMXq6CK/rT/UvMHiEJ8YZpJSAlj7j0yDosJOMxkpTB+zMdbZjUuTvF4CV1owzwXkA==
X-Received: by 2002:adf:e986:0:b0:241:8435:ea7e with SMTP id h6-20020adfe986000000b002418435ea7emr16118401wrm.103.1669202870010;
        Wed, 23 Nov 2022 03:27:50 -0800 (PST)
Received: from ?IPV6:2001:1ae9:2f0:fa00:5962:fdfb:2a9a:17bd? (2001-1ae9-2f0-fa00-5962-fdfb-2a9a-17bd.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:5962:fdfb:2a9a:17bd])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b0022ae0965a8asm16358617wru.24.2022.11.23.03.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 03:27:49 -0800 (PST)
Message-ID: <dcfcb10b-10c9-eb37-b345-07735453f5b5@gmail.com>
Date:   Wed, 23 Nov 2022 12:27:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] Fix kill(-1,s) returning 0 on 0 kills
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
 <20221122161240.137570-2-pskocik@gmail.com>
 <20221123103016.GA32207@redhat.com>
From:   Petr Skocik <pskocik@gmail.com>
In-Reply-To: <20221123103016.GA32207@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 11:30, Oleg Nesterov wrote:
> On 11/22, Petr Skocik wrote:
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1600,20 +1600,18 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>>   		ret = __kill_pgrp_info(sig, info,
>>   				pid ? find_vpid(-pid) : task_pgrp(current));
>>   	} else {
>> -		int retval = 0, count = 0;
>>   		struct task_struct * p;
>>   
>> +		ret = -ESRCH;
>>   		for_each_process(p) {
>>   			if (task_pid_vnr(p) > 1 &&
>>   					!same_thread_group(p, current)) {
>>   				int err = group_send_sig_info(sig, info, p,
>>   							      PIDTYPE_MAX);
>> -				++count;
>>   				if (err != -EPERM)
>> -					retval = err;
>> +					ret = err; /*either all 0 or all -EINVAL*/
> The patch looks good to me, and it also simplifies the code.
>
> But I fail to understand the /*either all 0 or all -EINVAL*/ comment above..
>
> Oleg.
>

Thanks. The comment is explained in my reply to Kees Cook: 
https://lkml.org/lkml/2022/11/22/1327.
I felt like making it because without it to me it suspiciously looks 
like the
`if ( err != -EPERM) ret = err;` (or `if ( err != -EPERM) retval = err;` 
in the original) could be masking
a non-EPERM failure with a later success, but it isn't because in this 
context, all the non-EPERM return vals should either ALL be 0 or ALL be 
-EINVAL.
The original code seems to make this assumption too, although implicitly.
Perhaps this should be asserted somehow (WARN_ON?).

If it couldn't be assumed, I'd imagine you'd want to guard against such 
masking

         int retval = 0, count = 0;
         struct task_struct * p;

         for_each_process(p) {
             if (task_pid_vnr(p) > 1 &&
                     !same_thread_group(p, current)) {
                 int err = group_send_sig_info(sig, info, p,
                                   PIDTYPE_MAX);
                 if (err != -EPERM){
                     ++count;
                     if ( err < 0 ) /*retval is 0 to start with and set 
to negatives only*/
                         retval = err;
                 }
             }
         }
         ret = count ? retval : -ESRCH;

Regards,
Petr Skocik

