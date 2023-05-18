Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91EA708488
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjERPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjERPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:03:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7374B1990
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d18d7738dso584142b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684422136; x=1687014136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoK00IvDzsh9+aKqB45P/1hvIg+G2G4PV8ZXqUFsdcU=;
        b=V1fbw1T77nRy/lhnGOpp6lridH1ahnJP6ytYDL0MYFtupEvD6uoYezzJsYe2+E3879
         laMaQ9LsISaOIja7y6pYu3b8NQd5tMKkr/tjDzsYcxhRVoBTEbxmfyulNB7LldaFpsYO
         WxzN1hjcHlYlu0XWY+Y4P7aBSCSi3nGrzehFBTvS848iOA1wNG2aB8KsYfHCVJD+392T
         +zukQrqVmKd6Dv8DNLRStWH0CZJN/NCMfs97IyqyDDPsOPkPuZmuH2l2ssMTxR9z0T4r
         nh5GHbz8iy58BKDk/SNC0TFQzaHGJNgUUr0fa9tqEqfODOBAs6a9HphFNMF4jsdNb8Gz
         h4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684422136; x=1687014136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoK00IvDzsh9+aKqB45P/1hvIg+G2G4PV8ZXqUFsdcU=;
        b=Im43OzjJtCEqNau13iEg3pOvaJOOJv93WfhkJiCCJZzpiENfZd4JmqoFhZNE0XqPPd
         VaF58HQT13fpmM+hyilXN580rsNht2KgIgh2hGRIC5lUqb5f7nmEMd3I0A6NXG1tAFYv
         sWk+x9ve3gFaJfKd84LIPQF61onElBxcANxjmD4ROuTzrmyrxu3paxFxNWSAfe3/fXT4
         moNbZgDNJH0KDztjw43aHV8fY48mc7yJBK7cNT40f9mplU8YnSavMTjMNuhs2zNw3kTu
         6nW/r9xsXDhIn8KApwkzL9UsMO2GIE96cdzkQ+iUaKsDwnpxo+eqz9cdFpltj2eODlXy
         7vEw==
X-Gm-Message-State: AC+VfDzk6ASBG9gcfgYMeeuGZLBpji4tKS1Ao4vAqFlqRkvzAUonI8rM
        ua48hjZv7NJPP7uA7BvurJk2xr7/zDpiZ3plOMw=
X-Google-Smtp-Source: ACHHUZ5qzHzd+aA8YOxF00DGxYrRuJgDbYOuvZESK2dR2HifWO/8GD9pCKskudbbvr8UsaZuio7iNQ==
X-Received: by 2002:aa7:88cf:0:b0:625:efa4:4c01 with SMTP id k15-20020aa788cf000000b00625efa44c01mr5329631pff.3.1684422135734;
        Thu, 18 May 2023 08:02:15 -0700 (PDT)
Received: from [192.168.50.227] (n119236112082.netvigator.com. [119.236.112.82])
        by smtp.gmail.com with ESMTPSA id e19-20020aa78c53000000b0063d2bb0d107sm1465767pfd.64.2023.05.18.08.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 08:02:15 -0700 (PDT)
Message-ID: <ff35b3fa-5af8-ac9b-3fae-d60c422c4393@gmail.com>
Date:   Thu, 18 May 2023 23:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: pass I_NEW flag to trace event
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <45eb63c6-a147-776a-99b5-7ac06848ede8@kernel.org>
 <20230517035953.47810-1-bo.wu@vivo.com>
 <94958409-f726-9da6-3b9f-76efa022ee9d@kernel.org>
 <4a512db8-cfca-80a5-ba62-780f56d014f6@gmail.com>
 <ZGVyOTqQy5ZhNvAr@google.com>
Content-Language: en-US
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <ZGVyOTqQy5ZhNvAr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/18 08:32, Jaegeuk Kim wrote:
> On 05/17, Wu Bo wrote:
>> On 2023/5/17 16:36, Chao Yu wrote:
>>> On 2023/5/17 11:59, Wu Bo wrote:
>>>> On 2023/5/17 10:44, Chao Yu wrote:
>>>>> On 2023/5/16 20:07, Wu Bo wrote:
>>>>>> Modify the order between 'trace_f2fs_iget' &
>>>>>> 'unlock_new_inode', so the
>>>>>> I_NEW can pass to the trace event when the inode initialised.
>>>>> Why is it needed? And trace_f2fs_iget() won't print inode->i_state?
>>>> When connect a trace_probe to f2fs_iget, it will be able to
>>>> determine whether
>>>> the inode is new initialised in order to do different process.
>>> I didn't get it, you want to hook __tracepoint_f2fs_iget() w/ your own
>>> callback?
>> Yes,  to use 'tracepoint_probe_register ' to register a probe at
>> trace_f2fs_iget
> Why?

Sorry, I don't understand what is your real question.

In my understanding, a trace_event is also a  non-volatile point in 
kernel for probing.

And for my case, I want to develop a tool by trace_probe to collect some 
information.

Thanks

>
>>> Thanks,
>>>
>>>>> Thanks,
>>>>>
>>>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>>>> ---
>>>>>>     fs/f2fs/inode.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>>> index cf4327ad106c..caf959289fe7 100644
>>>>>> --- a/fs/f2fs/inode.c
>>>>>> +++ b/fs/f2fs/inode.c
>>>>>> @@ -577,8 +577,8 @@ struct inode *f2fs_iget(struct super_block *sb,
>>>>>> unsigned long ino)
>>>>>>             file_dont_truncate(inode);
>>>>>>         }
>>>>>>     -    unlock_new_inode(inode);
>>>>>>         trace_f2fs_iget(inode);
>>>>>> +    unlock_new_inode(inode);
>>>>>>         return inode;
>>>>>>       bad_inode:
>>>>>
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>
