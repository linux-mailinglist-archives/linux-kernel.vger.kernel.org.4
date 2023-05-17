Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8B706B21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEQObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjEQObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:31:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8A768C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:31:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64390dc0a7fso49821b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684333894; x=1686925894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWvt0pedQunu8y2B0dtBKUYcryiAQ5WtFEwu7jjInYQ=;
        b=MIV2fh6ELNK78jb9gvMfIOe2uEDfrKxtE2ojMULHIRLz4i4iXtzCLNratojT9TW1Ua
         b083dw3ij/fH38M2P57SwErE1GLSf7Nykqpp3IItLlbiuHL/b+hTuR/RtKTlEEax4TdT
         A6GQF1F/qzVJtLfNcuJxNQ16YErrIGoNCD51yBr6RM320MA6uYsn2HFmk8JpMj3n/gd8
         4VFUq+IRKpmxneADrWO88/f/TI7Jd4pbXRSxnbJRVXCv48fp/Ub3ltn7bflHguzEc1dk
         AefzsUiSKAPmCZJuZ+JL751v5Jtk8gZ348B+0ktLYVnVS8tlFD6yzSthWJoxREptkOAD
         3MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333894; x=1686925894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWvt0pedQunu8y2B0dtBKUYcryiAQ5WtFEwu7jjInYQ=;
        b=Bnv223D9aUA6s8JKnrys+vEXL213718WYOjisEh6XcyVmD4R0jPD2y4J1qp0+n4zcQ
         OGRMSEOmGqb+BYx/4qmez4jhmujSFgNoZWzStFZOtvPoa+TCYpAiA1txW+SvWpLajRH2
         CcQRqu90LvkCJlsZscczpzD9Qr6RqbyGK1vtlrwMXKqr22/06A+ya5Ccw+h7mBgmFZDp
         GrxJ4nATulMdknsb9IMUdpuZ9WUvHVMZGcYAbBy3+JMVKPnaaGh8lFxC08HFshS0GIur
         89EBL87RmQETIbGbm9rXyYlIS2jamAhNioKznMgeM2GoW8/XB6Yj1qxiE3QabZ8PNPLp
         WXzw==
X-Gm-Message-State: AC+VfDykdZNigEnXkZU3BjD9k8WBtmqQCyKZX9JuPPOGgorKDIlPxJcG
        a6soq61VXkNoc2OgBMerPZU/NaNEbugkp96OPug=
X-Google-Smtp-Source: ACHHUZ5ye1FEZZFsU4xlkJyo1mk/CmW5gKsew58ycKJPvNMps2pYFthAZO0QlSpEMEcJ4y0SPY4cBA==
X-Received: by 2002:a05:6a20:8e15:b0:101:281c:494 with SMTP id y21-20020a056a208e1500b00101281c0494mr3079789pzj.27.1684333893627;
        Wed, 17 May 2023 07:31:33 -0700 (PDT)
Received: from [192.168.50.128] ([157.245.157.44])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b0063b7b811ce8sm15232130pfo.205.2023.05.17.07.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:31:33 -0700 (PDT)
Message-ID: <4a512db8-cfca-80a5-ba62-780f56d014f6@gmail.com>
Date:   Wed, 17 May 2023 22:31:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: pass I_NEW flag to trace event
To:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <45eb63c6-a147-776a-99b5-7ac06848ede8@kernel.org>
 <20230517035953.47810-1-bo.wu@vivo.com>
 <94958409-f726-9da6-3b9f-76efa022ee9d@kernel.org>
Content-Language: en-US
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <94958409-f726-9da6-3b9f-76efa022ee9d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/17 16:36, Chao Yu wrote:
> On 2023/5/17 11:59, Wu Bo wrote:
>> On 2023/5/17 10:44, Chao Yu wrote:
>>> On 2023/5/16 20:07, Wu Bo wrote:
>>>> Modify the order between 'trace_f2fs_iget' & 'unlock_new_inode', so 
>>>> the
>>>> I_NEW can pass to the trace event when the inode initialised.
>>>
>>> Why is it needed? And trace_f2fs_iget() won't print inode->i_state?
>>
>> When connect a trace_probe to f2fs_iget, it will be able to determine 
>> whether
>> the inode is new initialised in order to do different process.
>
> I didn't get it, you want to hook __tracepoint_f2fs_iget() w/ your own 
> callback?
Yes,  to use 'tracepoint_probe_register ' to register a probe at 
trace_f2fs_iget
>
> Thanks,
>
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>> ---
>>>>    fs/f2fs/inode.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>> index cf4327ad106c..caf959289fe7 100644
>>>> --- a/fs/f2fs/inode.c
>>>> +++ b/fs/f2fs/inode.c
>>>> @@ -577,8 +577,8 @@ struct inode *f2fs_iget(struct super_block *sb,
>>>> unsigned long ino)
>>>>            file_dont_truncate(inode);
>>>>        }
>>>>    -    unlock_new_inode(inode);
>>>>        trace_f2fs_iget(inode);
>>>> +    unlock_new_inode(inode);
>>>>        return inode;
>>>>      bad_inode:
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
