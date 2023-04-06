Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC16DA5D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjDFW3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbjDFW3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:29:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9929767
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:29:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-242cb01a788so357101a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680820186; x=1683412186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k4qsFqiHaAzNp6afujXpgmsXu2FPMDvZlLtZE20tc4=;
        b=1y4uhP9vs2w603pMlq/oT5QHMF+3601WSDLcMR0D0p5ucvKWV5W9ltQHO+vzcccDcb
         Mv7gaJO/9eNxKNzE85QCG+3tYiTxdLOrHbtJ91h4fKrPZMlYFBDTN5EUKdQBOoq70Wyz
         USEXLDfHilRgWN1P+9DDPgA+Ynp5i89CS7nyjO0C/CsXJNMiiDVbWQzGSKMuZoaLyPo/
         FKABeF/ywAFSgZmHct5AbaxeShHCVxXewaaSFQ5sdHb8kyiw2Jk6Do9a8fg5kY96Li2a
         Io9111MNXsldf+UePoNHDy5t5xmU54/Kp3PBsdGrjy/CmCF3aPOjhe8slqkrjd1yScOq
         DgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820186; x=1683412186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k4qsFqiHaAzNp6afujXpgmsXu2FPMDvZlLtZE20tc4=;
        b=l1Fxz0JBhTmk0zob/naCwAO2/YJVpQ1pJMRiPvkZ+tTMlh+piIoVahv8h95vhOCzGu
         aJV3Mx136uayctgUOKkHd17Y+Cq84e1O4Lc3bQRPxB8394sMUolUVSUO+QTTCYHwiDqo
         VcdMyljDixe7HZaHtX0YD2Gt8+EX1mUdBmMV//rvl9D/nwiaj0JAFY0liRXSJbWPQ+t1
         7G3kTB+gSRQRF3JS/RVCl3UUu7buV672K2lAc50KxUQ9VInNzb2RYfNL7b5ugcXeRogj
         SEW2QkvQRmaHqhh+1wSuYRPAra/AQFm/hzQehtd0t1XSV7VqsPuJskLyodJJqzMI8a8H
         OIDw==
X-Gm-Message-State: AAQBX9fX+FC9q0IHuBYLrHGy72jOZI0fow6AanYQqZVUV+GHHsw59TYl
        wH51eW0NJ/nb3RXYGdUOttuNNg==
X-Google-Smtp-Source: AKy350bN+48xlZ2wTnEU3QC1ywsQFykc+qHdijNBklHvZGPnhieRd9+bURJ8OZdfBNF65SQ1jcC2RQ==
X-Received: by 2002:a17:90a:e386:b0:240:cf04:c997 with SMTP id b6-20020a17090ae38600b00240cf04c997mr159190pjz.2.1680820185747;
        Thu, 06 Apr 2023 15:29:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001a21a593008sm1807328plb.306.2023.04.06.15.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:29:45 -0700 (PDT)
Message-ID: <b3817e92-80ca-8eea-ebdd-f2172f3390c8@kernel.dk>
Date:   Thu, 6 Apr 2023 16:29:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
        jack@suse.cz, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
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

On 4/5/23 9:42 PM, Yu Kuai wrote:
> Hi, Jens!
> 
> 在 2023/03/22 11:59, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
>> set, and partition scan will be proceed again when blkdev_get_by_dev()
>> is called. However, this will cause a problem that re-assemble partitioned
>> raid device will creat partition for underlying disk.
>>
>> Test procedure:
>>
>> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
>> sgdisk -n 0:0:+100MiB /dev/md0
>> blockdev --rereadpt /dev/sda
>> blockdev --rereadpt /dev/sdb
>> mdadm -S /dev/md0
>> mdadm -A /dev/md0 /dev/sda /dev/sdb
>>
>> Test result: underlying disk partition and raid partition can be
>> observed at the same time
>>
>> Note that this can still happen in come corner cases that
>> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
>> device.
>>
> 
> Can you apply this patch?

None of them apply to my for-6.4/block branch...

-- 
Jens Axboe


