Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C5F6284BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiKNQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiKNQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:13:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB291B79F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:13:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d20so10453268plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRFNvdT6JF7qDcu72Zo5uuOCp8Sjc0UsAWSJNwKBJQI=;
        b=SlW0nDP57gbIrWUJ7Dex9ol8lyx6anoIM9qrgwjefov6ZN8gmL5tLzEfG7+StvEb3Q
         J31o2fjGnDDJGZYkziNU6tm0xbZv338Y3mVPqkkEa/ElUtqdZ1HBkCCQFrJB/BRTC19K
         I/FKBy/Wnn44vEfnc/Lo3qJ6jm0lfeNqV0Gx2nJinFmbI9MFIfvctT+tXoJyQ2sJ1HQw
         vnm6GEIvNWI/VO6jYBIII5rxFHo+A1hmwToEHiFBpbojfZp+W4zSDMdPLMivuHbsreEk
         YHiZSm3MZYavQPPibHU3Mw1I8L+ubxE/cGNYyWJsFcbVGzUEum2q7M43+vNENmSHjORB
         vjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YRFNvdT6JF7qDcu72Zo5uuOCp8Sjc0UsAWSJNwKBJQI=;
        b=GnbZFajJqPRx6HDXHqY8u5Lb8WjuPzi/ABCrmhlGTTPfqTHGvoTeKbEidSkcLazaj+
         Avn1xZ4H8P+Uy3WCzlfefLyNT1q5p9aELr5f1hHXymvefdMWkNU0LPzo+XH1wjfufyBM
         wz3ZbQ7kvpvA5vB3QMyFlO8ey6+b+u6MYP7YnGhMXIfdn463IQv61icQmU4mMXexmMyN
         48/R51Rijl2I/O0a0iIkCAtZttD1oh2ZeB2qMJOCeyCiPvSN00s30wIzbas4W+W4J/uD
         YqH4zHD8SRflpOD+jan9j8/EqBxW98Zr2WSkByvlw0c3KxSQhO3I5FV6lUbClt3xDnVc
         3RXg==
X-Gm-Message-State: ANoB5pm1GwV6fLYAiZEGac7NIkn/9rPRJFym66pCp/j8yZlTVLfZ9ERg
        qKx/ETdpzqzzCwn6Wv7OvoWCOjUjr3U=
X-Google-Smtp-Source: AA0mqf6xIx26A00pMZkyp36B+w6OvI0rKJFClARwvLr/LQ97vfqPL6rx9bmPiS/LP4ywhvhUnFfZRQ==
X-Received: by 2002:a17:90a:558c:b0:213:b4ad:7290 with SMTP id c12-20020a17090a558c00b00213b4ad7290mr14564288pji.197.1668442396250;
        Mon, 14 Nov 2022 08:13:16 -0800 (PST)
Received: from [10.114.96.3] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm5378643ple.124.2022.11.14.08.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:13:15 -0800 (PST)
Message-ID: <7f221206-a29c-08ee-dfae-d4875bf7205d@gmail.com>
Date:   Tue, 15 Nov 2022 00:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] f2fs: fix to alloc_mode changed after remount on a
 small volume device
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
 <20221112083250.295700-2-Yuwei.Guan@zeekrlife.com>
 <983de611-a9e7-56d0-d375-f2b54e1f4d05@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <983de611-a9e7-56d0-d375-f2b54e1f4d05@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/14 22:42, Chao Yu wrote:
> On 2022/11/12 16:32, Yuwei Guan wrote:
>> The commit 84b89e5d943d8 ("f2fs: add auto tuning for small devices") add
>> tuning for small volume device, now support to tune alloce_mode to 
>> 'reuse'
>> if it's small size. But the alloc_mode will change to 'default' when do
>> remount on this small size dievce.
>>
>> The commit 4cac90d5491c9 ("f2fs: relocate readdir_ra configure
>> initialization") relocates readdir_ra variable to tuning process.
>>
>> This patch fo fix alloc_mode changed when do remount for a small volume
>> device.
>>
>> For a small device,
>> - alloc_mode will keep 'reuse', if no alloc_mode option in remount
>>    command,
>> - alloc_mode will be set as remount command, if it has 'alloc_mode='.
>>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> ---
>>   fs/f2fs/super.c | 37 ++++++++++++++++++++-----------------
>>   1 file changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 3834ead04620..2f36824ff84b 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2190,6 +2190,23 @@ static void f2fs_enable_checkpoint(struct 
>> f2fs_sb_info *sbi)
>>       f2fs_flush_ckpt_thread(sbi);
>>   }
>>   +static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool 
>> is_remount)
>> +{
>> +    struct f2fs_sm_info *sm_i = SM_I(sbi);
>> +
>> +    /* adjust parameters according to the volume size */
>> +    if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
>> +        F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
>
> How about moving above logic into default_options()?
>
Hi Chao,

'sm_i->main_segments' init in func 'f2fs_build_segment_manager()',

when do fill super process, so it cannot move into default_options().

> Thanks,
>
>> +        if (f2fs_block_unit_discard(sbi))
>> +            sm_i->dcc_info->discard_granularity = 1;
>> +        sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
>> +                    1 << F2FS_IPU_HONOR_OPU_WRITE;
>> +    }
>> +
>> +    if (!is_remount)
>> +        sbi->readdir_ra = 1;
>> +}
>> +
>>   static int f2fs_remount(struct super_block *sb, int *flags, char 
>> *data)
>>   {
>>       struct f2fs_sb_info *sbi = F2FS_SB(sb);
>> @@ -2248,6 +2265,8 @@ static int f2fs_remount(struct super_block *sb, 
>> int *flags, char *data)
>>         default_options(sbi);
>>   +    f2fs_tuning_parameters(sbi, true);
>> +
>>       /* parse mount options */
>>       err = parse_options(sb, data, true);
>>       if (err)
>> @@ -4054,22 +4073,6 @@ static int f2fs_setup_casefold(struct 
>> f2fs_sb_info *sbi)
>>       return 0;
>>   }
>>   -static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>> -{
>> -    struct f2fs_sm_info *sm_i = SM_I(sbi);
>> -
>> -    /* adjust parameters according to the volume size */
>> -    if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
>> -        F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
>> -        if (f2fs_block_unit_discard(sbi))
>> -            sm_i->dcc_info->discard_granularity = 1;
>> -        sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
>> -                    1 << F2FS_IPU_HONOR_OPU_WRITE;
>> -    }
>> -
>> -    sbi->readdir_ra = 1;
>> -}
>> -
>>   static int f2fs_fill_super(struct super_block *sb, void *data, int 
>> silent)
>>   {
>>       struct f2fs_sb_info *sbi;
>> @@ -4475,7 +4478,7 @@ static int f2fs_fill_super(struct super_block 
>> *sb, void *data, int silent)
>>         f2fs_join_shrinker(sbi);
>>   -    f2fs_tuning_parameters(sbi);
>> +    f2fs_tuning_parameters(sbi, false);
>>         f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
>>               cur_cp_version(F2FS_CKPT(sbi)));
