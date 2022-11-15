Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4EE6291B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiKOGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiKOGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:01:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3312D3F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:01:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w23so5791541ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiPp9wXW5sYNgbM5DvpWBRIpbsokJEIfqnGv+ONh+jQ=;
        b=o91OP2cOwAObkCIdomSMPtkVh6/AFSANjM2FOi4LPfy1Aj2zyJwkc7rL57VXp+v+JV
         U0bEhqJwnlrO4HzpqBgAcgv0dgghmslptSEyr0gxJTEHufW4CglBymNmqd+c0KZkQPSl
         xIKOGlRTAz7TVH6tNAouThmUSj9zbjA2/AZ9yXwlJb4PxUHat4PduEdDQmCu2QANiCyy
         2b62vsfXZ1K2PvtPEicXTmY6/nm01myJKTXJcKX2DwTGSl1jPlIbNEBBbh+1w8uhfy0o
         kNs415tq0ipywjBRTZSWV+ubdILzKne1myp8AZSp7fC2+U34617r+VfMLyI+8v0BL6cP
         K9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QiPp9wXW5sYNgbM5DvpWBRIpbsokJEIfqnGv+ONh+jQ=;
        b=c5lvCw6qu1HAqv7OogaPxfgC6ly9mddPb2dXR7cvRBFboxAkRtNZ3uLdymPC4WX3Ty
         EQYkzV2CSj0KsULs+adKtUUFLUpsqpfwKZcYw9EPTpJ40d7Bp0rKrrs/nC4kCZHYWUeJ
         VidN4LY69FErwgseXEwB3LtNmo6f92t9kJZ47HM7qmYhqNJjCaa3ACCz0NNsAgEoJbq4
         kD9ZB+TzG4e5QzCzizYN1DlHsdvtM6alczV4ECarqwocGB02EyoRL7LqBwVt12xJRJfo
         nGWIZ74W4G/KaR3d+QTa9orgnFReJr2XP3CxfKBOMUhR0PxW2lOORPaDqHzUHsi8BG0m
         00gg==
X-Gm-Message-State: ANoB5plemBozwS+Vpur5troCrwzUdF3XUsxJPTZNm5ae+f0aZMEwFMH2
        9kQUpolMXYPLC6c631WCfOfqxdBiTtQ=
X-Google-Smtp-Source: AA0mqf73GV1ED3D3eOWsTAvWueAS/bMZagXzDGgkSkpTUN/TrPs2S2pXi9pb7C/bjNlVg4kGA9q6Fw==
X-Received: by 2002:a17:902:aa0a:b0:186:944a:2560 with SMTP id be10-20020a170902aa0a00b00186944a2560mr2614507plb.84.1668492105905;
        Mon, 14 Nov 2022 22:01:45 -0800 (PST)
Received: from [10.114.96.21] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id 187-20020a6206c4000000b0056d2317455bsm7732431pfg.7.2022.11.14.22.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 22:01:45 -0800 (PST)
Message-ID: <abaa605d-a288-b6d5-49f5-932d4497c207@gmail.com>
Date:   Tue, 15 Nov 2022 14:01:42 +0800
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
 <7f221206-a29c-08ee-dfae-d4875bf7205d@gmail.com>
 <29fa9df4-dc5f-a944-a150-68d34904cc91@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <29fa9df4-dc5f-a944-a150-68d34904cc91@kernel.org>
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


On 2022/11/15 9:23, Chao Yu wrote:
> On 2022/11/15 0:13, Yuwei Guan wrote:
>>
>> On 2022/11/14 22:42, Chao Yu wrote:
>>> On 2022/11/12 16:32, Yuwei Guan wrote:
>>>> The commit 84b89e5d943d8 ("f2fs: add auto tuning for small 
>>>> devices") add
>>>> tuning for small volume device, now support to tune alloce_mode to 
>>>> 'reuse'
>>>> if it's small size. But the alloc_mode will change to 'default' 
>>>> when do
>>>> remount on this small size dievce.
>>>>
>>>> The commit 4cac90d5491c9 ("f2fs: relocate readdir_ra configure
>>>> initialization") relocates readdir_ra variable to tuning process.
>>>>
>>>> This patch fo fix alloc_mode changed when do remount for a small 
>>>> volume
>>>> device.
>>>>
>>>> For a small device,
>>>> - alloc_mode will keep 'reuse', if no alloc_mode option in remount
>>>>    command,
>>>> - alloc_mode will be set as remount command, if it has 'alloc_mode='.
>>>>
>>>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>>>> ---
>>>>   fs/f2fs/super.c | 37 ++++++++++++++++++++-----------------
>>>>   1 file changed, 20 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 3834ead04620..2f36824ff84b 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -2190,6 +2190,23 @@ static void f2fs_enable_checkpoint(struct 
>>>> f2fs_sb_info *sbi)
>>>>       f2fs_flush_ckpt_thread(sbi);
>>>>   }
>>>>   +static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, 
>>>> bool is_remount)
>>>> +{
>>>> +    struct f2fs_sm_info *sm_i = SM_I(sbi);
>>>> +
>>>> +    /* adjust parameters according to the volume size */
>>>> +    if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
>>>> +        F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
>>>
>>> How about moving above logic into default_options()?
>>>
>> Hi Chao,
>>
>> 'sm_i->main_segments' init in func 'f2fs_build_segment_manager()',
>>
>> when do fill super process, so it cannot move into default_options().
>
> How about checking le32_to_cpu(raw_super->segment_count_main) directly?
>
Hi Chao,

Thanks a lot for it, I will update with v1 patch.

> Thanks,
>
>>
>>> Thanks,
>>>
>>>> +        if (f2fs_block_unit_discard(sbi))
>>>> +            sm_i->dcc_info->discard_granularity = 1;
>>>> +        sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
>>>> +                    1 << F2FS_IPU_HONOR_OPU_WRITE;
>>>> +    }
>>>> +
>>>> +    if (!is_remount)
>>>> +        sbi->readdir_ra = 1;
>>>> +}
>>>> +
>>>>   static int f2fs_remount(struct super_block *sb, int *flags, char 
>>>> *data)
>>>>   {
>>>>       struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>>> @@ -2248,6 +2265,8 @@ static int f2fs_remount(struct super_block 
>>>> *sb, int *flags, char *data)
>>>>         default_options(sbi);
>>>>   +    f2fs_tuning_parameters(sbi, true);
>>>> +
>>>>       /* parse mount options */
>>>>       err = parse_options(sb, data, true);
>>>>       if (err)
>>>> @@ -4054,22 +4073,6 @@ static int f2fs_setup_casefold(struct 
>>>> f2fs_sb_info *sbi)
>>>>       return 0;
>>>>   }
>>>>   -static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>>>> -{
>>>> -    struct f2fs_sm_info *sm_i = SM_I(sbi);
>>>> -
>>>> -    /* adjust parameters according to the volume size */
>>>> -    if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
>>>> -        F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
>>>> -        if (f2fs_block_unit_discard(sbi))
>>>> -            sm_i->dcc_info->discard_granularity = 1;
>>>> -        sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
>>>> -                    1 << F2FS_IPU_HONOR_OPU_WRITE;
>>>> -    }
>>>> -
>>>> -    sbi->readdir_ra = 1;
>>>> -}
>>>> -
>>>>   static int f2fs_fill_super(struct super_block *sb, void *data, 
>>>> int silent)
>>>>   {
>>>>       struct f2fs_sb_info *sbi;
>>>> @@ -4475,7 +4478,7 @@ static int f2fs_fill_super(struct super_block 
>>>> *sb, void *data, int silent)
>>>>         f2fs_join_shrinker(sbi);
>>>>   -    f2fs_tuning_parameters(sbi);
>>>> +    f2fs_tuning_parameters(sbi, false);
>>>>         f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
>>>>               cur_cp_version(F2FS_CKPT(sbi)));
