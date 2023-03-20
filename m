Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387C6C1BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCTQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjCTQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:36:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C905B9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:30:48 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r4so6734189ilt.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679329847; x=1681921847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4Un7hNW3PbeTCXI5xRR+XbSkcB6FcIO6dt2utn+YNg=;
        b=OohrWwiOo/ZhWbFxtukvDzjgLrFJ28VUXWtFECfAHhUmfLVjlsgXPrSdQCYzsEcD52
         GpBfA3ZAr7XGBbJM9sLaZh8QIO0cFr3B7lHFMnKXw3Lxif2mU4KVClNB4t3IN/Rvh4xC
         vkhba0qDnAb/biH14OdO3FBPNgDvq+w1rkPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329847; x=1681921847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Un7hNW3PbeTCXI5xRR+XbSkcB6FcIO6dt2utn+YNg=;
        b=JehdU91NDEyW5cswEYIYurEW3MbUqTWOQuoG7penpoU9NF/9S/kWutVRMSziTyt5rr
         VEnW2kiGvPIoocr23zHzgly7YUIEG2cjc3i78SAPhwz4xEj39gJ/62O6nV49xjFvlJpS
         VH6oxZr+tYHw+XFahG4eSpUi60jPgz9SdImLgtu4+cVVQA5K0OCS78V9o/enlCvm2r+G
         t0qZkVN/eidvB6m1iXAK5W8iCTOAmDFLkGsg9wkx5AoyCMMRtROCbp+OYqQUoG2t2aCM
         7F9SbFkpzNXkOHKmgfYR5aN+6GK6pESFoXeOGzItWuF54W782rI6hUHRROZR1MEU0/uH
         VGaw==
X-Gm-Message-State: AO0yUKUsl1PSWmI2YYDIszFpc4FWSOnLk277DIpafdxzW/ApQP9/Wljy
        Ua0qUSF2gXEgNEGG3D4mL3ihgQ==
X-Google-Smtp-Source: AK7set8nn77jxn+h0hPf4b4DAaQcTmnI1pCVRft2K1evGr2c5JLGE1L5UMPitisPYvAQ2j8IaV1ssQ==
X-Received: by 2002:a05:6e02:12c8:b0:317:2f8d:528f with SMTP id i8-20020a056e0212c800b003172f8d528fmr105330ilm.2.1679329847628;
        Mon, 20 Mar 2023 09:30:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t23-20020a02b197000000b003c4ec576030sm3354853jah.4.2023.03.20.09.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:30:45 -0700 (PDT)
Message-ID: <495eb06b-9a86-ff55-d0c9-66d836ce456a@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 10:30:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230207135147.5ce618d6@gandalf.local.home>
 <20230213204643.39f86987@rorschach.local.home>
 <20230318144202.486c43d1@rorschach.local.home>
 <8579dfaf-11bf-cefa-c3ed-eb9b2d9d1a22@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8579dfaf-11bf-cefa-c3ed-eb9b2d9d1a22@linuxfoundation.org>
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

On 3/20/23 06:56, Shuah Khan wrote:
> On 3/18/23 12:42, Steven Rostedt wrote:
>> On Mon, 13 Feb 2023 20:46:43 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> Shuah,
>>>
>>> Can you pick this patch up?
>>
>> ping?
>>
>> -- Steve
> 
> l I will queue this up. Sorry for the delay.
> 

Steve,

The patch doesn't apply to linux-kselftest fixes branch.
Please rebase and resend with cc to linux-kselftest.
Makes sense why it got buried in my regular Inbox.

This one didn't show up in kselftest list. Fixes tag SHA
is 13 char long. I fixed it and tried to apply. When you
resend, please fix the Fixes tag as well.

thanks,
-- Shuah

