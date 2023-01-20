Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80343675F68
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjATVGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:06:35 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C37AB6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:06:34 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y69so3033815iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9x1Jk27xH/5nSrM71HdjxIYAnSsIPIq8k9S2bWcy4c=;
        b=EEWpTuK3Pg8Wu/XCTxmrxgdue+HdsGSAqmRvuxXQ1TWQ0vYe1LTAEzT9b+H8r6pT4r
         aWWQN96wuIKBakJMmKqo3PJDeXBLL42oJzcutmY8vhBEJGzHt1SsYqWIyW09qk0tZl7B
         SfNCWsRcJ+pPmL3g8ExLXHbIf0eLoY2TNKNTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9x1Jk27xH/5nSrM71HdjxIYAnSsIPIq8k9S2bWcy4c=;
        b=GaLp0rFcF5JZtGmOw/lmrJxvqR3sir7YsrLUysCVIjOjjSGXnoknIUXvGdM0Kl3Uyz
         Fhigq7nZ9D5VlROWBAX0NN1TQ0b1n0/TX76K3KgMduHggfetrTa4kLB2QWtdIWoUPrUF
         uofAcleqoE6pykoKZ5WUNXqHyfdYLV080Q2Jj48mV4c/odIMdPpJvXqPjVAnvwcdHMRG
         L87BD+cJM6x816MFjeke6cxZB5dCiXWwb2iCNp6vpMrgAQZgaL0QlMFGnVCYJQCTeBed
         UyHa3RnpHfmShv7mT+yik4UZjzlPkiD+xnjhEDvaMrMJ28RL8wsjdG+nroNEk16brCCB
         nMdw==
X-Gm-Message-State: AFqh2kqAbPqisw12rm8a/5DyruEdH3LOS96dktg7AIaVOu4GlnhY732X
        sfJiMXP1ARQ4wueyebhQn9Zldg==
X-Google-Smtp-Source: AMrXdXtvirxM5O/BM/dyJs1WD4k5D4UmyDHIAjiD7XjPrW0n/qzg38oIlfD0UNCidG1lZJ1RIk/YIg==
X-Received: by 2002:a6b:7a4c:0:b0:704:eeae:67c7 with SMTP id k12-20020a6b7a4c000000b00704eeae67c7mr1778805iop.2.1674248793448;
        Fri, 20 Jan 2023 13:06:33 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t6-20020a02b186000000b003a058610fc8sm5801093jah.82.2023.01.20.13.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:06:32 -0800 (PST)
Message-ID: <2f6561ac-ac1d-7689-c0a4-83cf412ee66c@linuxfoundation.org>
Date:   Fri, 20 Jan 2023 14:06:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ver_linux: add missing software to checklist
Content-Language: en-US
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230110204225.35503-1-skhan@linuxfoundation.org>
 <CAJ1xhMXtRUnLJQKkPyUemLpYiAP4ebmgExS6cV2Kta6rCd__0w@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJ1xhMXtRUnLJQKkPyUemLpYiAP4ebmgExS6cV2Kta6rCd__0w@mail.gmail.com>
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

On 1/16/23 05:26, Alexander Kapshuk wrote:
> On Tue, Jan 10, 2023 at 11:13 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Update to add missing software checks to bring it in sync with the
>> Documentation/Changes list. Make improvements to the output with
>> separator between different sections.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   scripts/ver_linux | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/ver_linux b/scripts/ver_linux
>> index 1a8ee4ff0e32..6131f6f1b35b 100755
>> --- a/scripts/ver_linux
>> +++ b/scripts/ver_linux
>> @@ -6,10 +6,14 @@
>>   # differ on your system.
>>
>>   BEGIN {
>> -       usage = "If some fields are empty or look unusual you may have an old version.\n"
>> -       usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
>> +       usage = "Minimum required software versions to build and run current kernel version.\n"
>> +       usage = usage "If some fields are empty or look unusual you may have an old version.\n"
>> +       usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
>>          print usage
>>
>> +       separator = "===================================================\n"
> 
> Embedding a new line character at the start of the separator string
> would eliminate the need for the extra printf("\n") statements
> introduced.
> 
>> +
>> +       print separator
>>          system("uname -a")
>>          printf("\n")
> 
> Consequently, this printf could be removed as well.
> 

Thank yo for your review. Will send v2 with your suggestions.

thanks,
-- Shuah

