Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B78628845
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiKNSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiKNSZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:25:29 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3382AC51
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:25:28 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id s10so8826048ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FkHhNKFsHQ57OL02enGAiyqX0XUGbcyCurvdEOfJLE=;
        b=BxDOCMaGYlp7mpwI3xB4UqhzYj0Z1TRee1deSAyXEPHVLzjqJ+ur+nu1bUttc0r8Ni
         ORRHrN3mc0s4S5IJkFzEI0Nc70BK8odBQ98Vl1T9ZTlF7oCYw2fP/EIPgF/vhbqRFNBP
         8Qu5NVmwG40c/fbqDfsNEsGiT0o6quhkbROzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FkHhNKFsHQ57OL02enGAiyqX0XUGbcyCurvdEOfJLE=;
        b=finQpJlHz7Wr9UXWg4rNqcNJLweDM4nuylIwkYvWeSdx9LhieO6v292QzVw6mL6C25
         8oE1JGt90OK6KVrtd+n1EXDx3wC7Y4Eqh5WW8pbIC1KDukNU6h9Ju7Wtf8rFOyOWQ72H
         EWUUU2eG+mQqq9oQlkSZ/rywiOImcOGcsCdESzWjH02Jf+KzQgsDZv0+Bhb3iP+Ji5LT
         lhnv0FENZ+h13S+ZmAqgwaa21yRDCd3lBhLCLywTWqcxv6Ficbbq5uPkjLQ6vm8Guiuc
         X43z7MUwhy5lqqyTudzGMvf/7HjbFL2QENr6riWYox7pXtrfElJJDraB/RAXdXRXJyHz
         XqQQ==
X-Gm-Message-State: ANoB5pnpnTa7MXZmpntuG0RRD0zGNvvKVjyIKEHQidsVsq4BPsdGdSKR
        HftEukZSTL/q64t5V8xsBEDN5Q==
X-Google-Smtp-Source: AA0mqf5lTvDCjYEoE0HB9FCB/lAvDg2M+f7wU/c3U8grCXe6sDC0COy5AOuiJIYuvQrrJ+u2EF5zvw==
X-Received: by 2002:a02:7421:0:b0:375:1b97:812a with SMTP id o33-20020a027421000000b003751b97812amr6071610jac.168.1668450328001;
        Mon, 14 Nov 2022 10:25:28 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k130-20020a6bba88000000b0067fb21ad9c3sm4212159iof.22.2022.11.14.10.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 10:25:27 -0800 (PST)
Message-ID: <166d074a-77ce-f0b6-87df-7c5464d4cb1d@linuxfoundation.org>
Date:   Mon, 14 Nov 2022 11:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests/ftrace: event_triggers: wait longer for
 test_event_enable
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yipeng Zou <zouyipeng@huawei.com>, shuah@kernel.org,
        rdunlap@infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221104020931.231090-1-zouyipeng@huawei.com>
 <20221105175241.858bbd5b5337fc2b8a075ee9@kernel.org>
 <20221114131028.110a91c4@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221114131028.110a91c4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 11:10, Steven Rostedt wrote:
> On Sat, 5 Nov 2022 17:52:41 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> Hi Yipeng,
>>
>> On Fri, 4 Nov 2022 10:09:31 +0800
>> Yipeng Zou <zouyipeng@huawei.com> wrote:
>>
>>> In some platform, the schedule event may came slowly, delay 100ms can't
>>> cover it.
>>>
>>> I was notice that on my board which running in low cpu_freq,and this
>>> selftests allways gose fail.
>>
>> This looks good to me, since this can just extend the waiting time to 1 sec.
>> (and most of the platforms have no effect)
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Care to take this through your tree?
> 

Yup. I will get this in.

thanks,
-- Shuah

