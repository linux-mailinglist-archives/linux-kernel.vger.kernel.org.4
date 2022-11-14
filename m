Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E1E628525
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiKNQ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiKNQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:27:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5031EB4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:27:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r18so10652689pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxQLRYAT/fu/tDZ4IEfum62GO45jJc16xAm/KzINIL0=;
        b=pC5q04cwtPPEh40nWx/tNdd1TJ1wmh5ph+JJ4GlU+ASPD4Of0rpzFGQx1RTxF2Jq6S
         Ek6Z0ckSHhC77gPT2ztEyccvRgntbfyiAc56uss8lrx4MBW5H932sN47BugL2KBUlDOE
         d4XLGtnDXvgTUUBfX6XEbMA89NxRsm7YcdOYfBJkv9RH2Np62JlWnIR2Ur4ld1/YW/pT
         1il2wE7y5H4RRwKTaokIrK5xD2Y+T0Mzp/nLqmacC1qZgXLZ5bqbCT3btIXDSnacU1a9
         IYI40XYObNHVM+bkub7q/2GQlqXL+hjpFTdOZnL8GqjhLOZtMgH5Zvwl//wdwW98EXFs
         7zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxQLRYAT/fu/tDZ4IEfum62GO45jJc16xAm/KzINIL0=;
        b=hZPHwdni3uYDj5paPK+YZRx7ogA4oE7+ACts2gL4Yv8++s8JrDUZl1C3I9XHSRDb3S
         6SlxJJh+SkXK28ufyoRBUkSzvI996a5qIvhxf1BVXQcnT5WVZoIzORx1Mc9JUo7sN/+3
         J+6fXem8gN10MOJoaL6CFFac+Bv1eKcL/FktB+0DLhvIzKkG+dLBbnsm6BnD+KADwAei
         CN/40NofX9N6PJVfC6zaQUSxOFEVaF4J20Dd9w+BXJ+bgt8hdowFE3nNjuTZXeQo4efp
         D+b0dh5C8cpZ2FHuOPKBemH2NXGddmlLHN45wxaVqVIhp3WlmjYTra3Y9sh4//7F1dkO
         2YlA==
X-Gm-Message-State: ANoB5plq95UkJpq7fRVLELV6C80dIqbUpS9q4TFQsxLgz/Mtv7MU46am
        GFJXyoGhSdwKaxVEXlXWs1hPao4b2qs=
X-Google-Smtp-Source: AA0mqf50h5iolxp7A7R3R/NbKrwM44jLyFo/Z2I/7dO4Y/7PoA8VVKkp43IziRkIhkyX8VRWV9lZdQ==
X-Received: by 2002:aa7:86d5:0:b0:56d:3de3:c401 with SMTP id h21-20020aa786d5000000b0056d3de3c401mr14723527pfo.6.1668443239112;
        Mon, 14 Nov 2022 08:27:19 -0800 (PST)
Received: from [10.114.96.3] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b0017849a2b56asm7773630plg.46.2022.11.14.08.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:27:18 -0800 (PST)
Message-ID: <ca91d564-c807-6cec-9dd3-e12acdbc270e@gmail.com>
Date:   Tue, 15 Nov 2022 00:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] f2fs: change type for 'sbi->readdir_ra'
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
 <20221112083250.295700-4-Yuwei.Guan@zeekrlife.com>
 <420531c0-2649-bf2a-140d-2f4f13036b0d@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <420531c0-2649-bf2a-140d-2f4f13036b0d@kernel.org>
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


On 2022/11/14 22:59, Chao Yu wrote:
> On 2022/11/12 16:32, Yuwei Guan wrote:
>> Before this patch, the varibale 'readdir_ra' takes effect if it's equal
>> to '1' or not, so we can change type for it from 'int' to 'bool'.
>>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> ---
>>   fs/f2fs/dir.c   | 7 +++----
>>   fs/f2fs/f2fs.h  | 2 +-
>>   fs/f2fs/super.c | 2 +-
>>   fs/f2fs/sysfs.c | 5 +++++
>>   4 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 21960a899b6a..06d9bf98f5ae 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -1000,13 +1000,12 @@ int f2fs_fill_dentries(struct dir_context 
>> *ctx, struct f2fs_dentry_ptr *d,
>>       struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
>>       struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
>>       struct blk_plug plug;
>> -    bool readdir_ra = sbi->readdir_ra == 1;
>>       bool found_valid_dirent = false;
>>       int err = 0;
>>         bit_pos = ((unsigned long)ctx->pos % d->max);
>>   -    if (readdir_ra)
>> +    if (sbi->readdir_ra)
>>           blk_start_plug(&plug);
>>         while (bit_pos < d->max) {
>> @@ -1064,14 +1063,14 @@ int f2fs_fill_dentries(struct dir_context 
>> *ctx, struct f2fs_dentry_ptr *d,
>>               goto out;
>>           }
>>   -        if (readdir_ra)
>> +        if (sbi->readdir_ra)
>>               f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
>>             ctx->pos = start_pos + bit_pos;
>>           found_valid_dirent = true;
>>       }
>>   out:
>> -    if (readdir_ra)
>> +    if (sbi->readdir_ra)
>
> I don't think this is the right way... due to below case:
>
> if (sbi->readdir_ra)    // readdir_ra is 1 by default
>     blk_start_plug(&plug);
>
> if (sbi->readdir_ra)    // readdir_ra is updated to 0, it will miss to 
> unplug.
>     blk_finish_plug(&plug);
>
Hi Chao,

Thanks for the review and pointing it out.

I will update it and send v1.

> Thanks,
>
>>           blk_finish_plug(&plug);
>>       return err;
>>   }
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index e6355a5683b7..384840216e7f 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1693,7 +1693,7 @@ struct f2fs_sb_info {
>>       unsigned int total_node_count;        /* total node block count */
>>       unsigned int total_valid_node_count;    /* valid node block 
>> count */
>>       int dir_level;                /* directory level */
>> -    int readdir_ra;                /* readahead inode in readdir */
>> +    bool readdir_ra;            /* readahead inode in readdir */
>>       u64 max_io_bytes;            /* max io bytes to merge IOs */
>>         block_t user_block_count;        /* # of user blocks */
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index f18ae5410b2c..da304861890f 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2202,7 +2202,7 @@ static void f2fs_tuning_parameters(struct 
>> f2fs_sb_info *sbi, bool is_remount)
>>       }
>>         if (!is_remount)
>> -        sbi->readdir_ra = 1;
>> +        sbi->readdir_ra = true;
>>   }
>>     static int f2fs_remount(struct super_block *sb, int *flags, char 
>> *data)
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index df27afd71ef4..53fbbb87dd0f 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -649,6 +649,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>           return count;
>>       }
>>   +    if (!strcmp(a->attr.name, "readdir_ra")) {
>> +        sbi->readdir_ra = !!t;
>> +        return count;
>> +    }
>> +
>>       *ui = (unsigned int)t;
>>         return count;
