Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28CD6DA7C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjDGCmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjDGCmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:42:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C583D1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:42:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-503e7129077so452675a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680835361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8X/ofNJxOyXBKtu6E6tFhvwKT4AgBrWgfgReTBYBmo=;
        b=rho/IPf5hqzPDcmZdhV1K7zLDdw33k6FbSbSB5xn0zILh6XsXvisZTDlSj2FlKPjBh
         4OzQKMAF6WBjsbimCTiXST58KxhQXaTd2OS4JdDEdas4MvZVPxm6J7xZIfYrjA9WK6TK
         Ct4XvZBpJHudMPE+XP9bZkPHjJ1gebV8Ia/Swb+cgFopMjGaEbKbDm8mTcBRvBYaDhhd
         HKWUzIl7eeUfa+wGP5h+q4/3pR2qQ1aeQKEoBAF/AEkqlFrbZiXquqJK5vberByqwNKV
         dJeeLQNyxhaTMSAithk/l/OyiPpVIL2tgSNm73AgqBCN31Z4RQdBT+Tusv84cQX4ZiAu
         4lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8X/ofNJxOyXBKtu6E6tFhvwKT4AgBrWgfgReTBYBmo=;
        b=vgXSDBqwPW8nJFjiiB3PnivC09QQGAlDS3DOsPsUhI/JVDb1CTGQH7/+ktPjcLaHi5
         aFwJGTjeioki/IW13kSKuAB5uTzqFFExpPhZ16cJb94tQ2Fx4nkIXgukw12Ndx+fIAIa
         CAsQtPwrDPFaEPgMH0HpphjyqGHkusM50ybjrZAS6DZpEzsT7l9tuY2NUC4cPBjqd/Qq
         Rvt7LmMxbosnob9WFt4gjkdAIBoiZhxfcG+/PMa1ZwGUmV6j7CDQSi5FIpePJp0Ac5HD
         lT/3E4K20M3dPEc6+17PJTl+wSDTPLgHQYax5sHP9dWlkJtjwQu0j836CmAlp4014SwT
         NW6g==
X-Gm-Message-State: AAQBX9cvwCwwiTX/Gqq6syQJPDlKJlDzwC4iC5GvvoS3SytoraMdfjMC
        8HLGmQ5l8hJ9InmSeXGw9ckIEw==
X-Google-Smtp-Source: AKy350Ym3MrcHI3b7iLaVIx9TXp2e+6vuJ1zWNUYE3bufQbkuJ7KmcRxvXvMwwWClIsImjvU3eX1NQ==
X-Received: by 2002:aa7:8194:0:b0:627:e180:ac04 with SMTP id g20-20020aa78194000000b00627e180ac04mr1222717pfi.0.1680835360677;
        Thu, 06 Apr 2023 19:42:40 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0062607d604b2sm1986897pfd.53.2023.04.06.19.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 19:42:40 -0700 (PDT)
Message-ID: <32e9b9e0-0748-4e03-624d-a31c1df6b045@kernel.dk>
Date:   Thu, 6 Apr 2023 20:42:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
 <b3817e92-80ca-8eea-ebdd-f2172f3390c8@kernel.dk>
 <ZC95kzpiZnD9m7GY@ovpn-8-24.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZC95kzpiZnD9m7GY@ovpn-8-24.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 8:01 PM, Ming Lei wrote:
> On Thu, Apr 06, 2023 at 04:29:43PM -0600, Jens Axboe wrote:
>> On 4/5/23 9:42 PM, Yu Kuai wrote:
>>> Hi, Jens!
>>>
>>> 在 2023/03/22 11:59, Yu Kuai 写道:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
>>>> set, and partition scan will be proceed again when blkdev_get_by_dev()
>>>> is called. However, this will cause a problem that re-assemble partitioned
>>>> raid device will creat partition for underlying disk.
>>>>
>>>> Test procedure:
>>>>
>>>> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
>>>> sgdisk -n 0:0:+100MiB /dev/md0
>>>> blockdev --rereadpt /dev/sda
>>>> blockdev --rereadpt /dev/sdb
>>>> mdadm -S /dev/md0
>>>> mdadm -A /dev/md0 /dev/sda /dev/sdb
>>>>
>>>> Test result: underlying disk partition and raid partition can be
>>>> observed at the same time
>>>>
>>>> Note that this can still happen in come corner cases that
>>>> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
>>>> device.
>>>>
>>>
>>> Can you apply this patch?
>>
>> None of them apply to my for-6.4/block branch...
> 
> This patch is bug fix, and probably should aim at 6.3.

Yeah I see now, but it's a bit of a mashup of 2 patches, and
then a separate one. I've applied the single fixup for 6.3.

-- 
Jens Axboe


