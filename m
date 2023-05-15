Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC69703DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbjEOT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbjEOT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:28:36 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A491525F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:28:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c6e795650so34731539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684178904; x=1686770904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lve7AMCKBIRfrjlxTp6FW8i8QEFQiCuhMHIDwhiIss8=;
        b=RF+zVb0BamcWpTMev05W2IxnT2uUFnYaRkZtDbxP75tzhFQvg5j57Eo5NSAhgD6Dvl
         TMPlpM6Ep8MOJ/u4+nBauqltl2HcPYrERCkVZ+/gB6ey0VquOtr+CoDmsckUn2OWCf4w
         6gr35WY1uHzU1wIrgkPVCK0JOIQ044rlhbqGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178904; x=1686770904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lve7AMCKBIRfrjlxTp6FW8i8QEFQiCuhMHIDwhiIss8=;
        b=LCtNg500G1BA0/Q+DR0teQw+XzdEACzsIOpb9fOfl7Q16Av7xQb8yJUsT9ITWcOny/
         gSrwGq/4/2A98dz6ZbbTBt20PQplSi0gHdP9jiExjyjvBs1Fps1KAEJVaDvaypiXuG3s
         0/MOufzijKfMR7aEoFxMU/luu/bWKz6G7mbqRxN7/ybqGoqVhqxFVjgrYwZA1YB9EeGV
         rrIHNXnf7kKWGsPrxq+9KPh7Ej6kmRWsei9r0dsol2n8lTi+52VEe5micf2S7uNGx27T
         xwG1RGVeYWn4GpphHv7BJxOkOU4QITGYvvEA5BFqrteulMt5uFIZmJSGlJE+TSUQcBdh
         TnHQ==
X-Gm-Message-State: AC+VfDzkG5eMcaw2eEfAqlAmFV2ev8+iXFdeYZfNuG4kVLouuLlwqSyZ
        KVziSyruYEXlh5y5Q7wQMbbrcw==
X-Google-Smtp-Source: ACHHUZ4EDk8UcoxaPM0Gds09yHQNeM7fz29F3jhwT2XU2B2prmwPcovmsI+NsdcV8iVvKomYUzrWaQ==
X-Received: by 2002:a92:a010:0:b0:32f:1232:f5d5 with SMTP id e16-20020a92a010000000b0032f1232f5d5mr392211ili.2.1684178904661;
        Mon, 15 May 2023 12:28:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v13-20020a92c6cd000000b003358e4653c6sm4441930ilm.36.2023.05.15.12.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 12:28:24 -0700 (PDT)
Message-ID: <96c6fdf7-e589-ca56-9314-1d437b8082ac@linuxfoundation.org>
Date:   Mon, 15 May 2023 13:28:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: duplicate patch in the rcu tree
Content-Language: en-US
To:     paulmck@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230511090010.2916e9d7@canb.auug.org.au>
 <59c2fd36-6920-47d8-a79c-9ff3fcf7c7ae@paulmck-laptop>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <59c2fd36-6920-47d8-a79c-9ff3fcf7c7ae@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 10:52, Paul E. McKenney wrote:
> On Thu, May 11, 2023 at 09:00:10AM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> The following commit is also in the kselftest-fixes tree as a different
>> commit (but the same patch):
>>
>>    6d9ed63d8bc3 ("tools/nolibc: Fix build of stdio.h due to header ordering")
>>
>> This is commit
>>
>>    d7eafa64a158 ("tools/nolibc: Fix build of stdio.h due to header ordering")
>>
>> in the kselftest-fixes tree.
> 
> I can currently cleanly remove this commit from the rest of the nolibc
> commits in -rcu.
> 
> However, I might need to re-introduce it in some way or another, for
> example, if there are dependencies on it by future nolibc patches.
> (I expect another batch in a few days.)
> 
> So how would you like to proceed?
> 

Paul,

I can drop this from linux-kselftest fixes if that is the easier path.
Just let me know.

thanks,
-- Shuah

