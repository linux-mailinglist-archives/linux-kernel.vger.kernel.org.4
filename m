Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E765AECD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjABJpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjABJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:44:29 -0500
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F4DF1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:44:27 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id D5CD740106;
        Mon,  2 Jan 2023 04:44:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1672652666;
        bh=v8iRoS/iF5DexixrsAQZBDqZ81ArPzqnACD3dnX2Hhc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=JmuE1pQSllbP81NR+PncxxpNsC9Y91+gnqNSG0oyMapw+ayr9VZjmkpgXLWwZx+oF
         HXwpZWjhMCwIFSOWgC8ouCxlknA9nfMDUCcVD7PMaleI4OmQROXa1sUf5/9HwwiScT
         YrwCmG+Hvecaqu6UW82NdmbCase9lMxGpHYUHGQu0ALrjlIPJJP/uIzmpzC9JNFwgl
         Joeiu10r5QaXaXTTeA+b9OqkJxd8fUYzTCLVOTyCZiVrjIBekb6Dv8yYXW2snAQ0Yk
         pIPalN81Ne6VDFgJ0X4I9MnJqCZmRxC7rURnq4P6bMcKHTYdf3IxvAKZvsP8CI8ylM
         Aibnmm8+6rs+Q==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 2 Jan
 2023 10:44:21 +0100
Message-ID: <b2ec41dd-3346-c2db-d59c-9050f8ad1053@veeam.com>
Date:   Mon, 2 Jan 2023 10:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 17/21] block, blksnap: snapshot image block device
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20230101071813.3329-1-hdanton@sina.com>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <20230101071813.3329-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx02.amust.local (172.18.0.172) To prgmbx01.amust.local
 (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031555657167
X-Veeam-MMEX: True
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/1/23 08:18, Hillf Danton wrote:
> Subject:
> Re: [PATCH v2 17/21] block, blksnap: snapshot image block device
> From:
> Hillf Danton <hdanton@sina.com>
> Date:
> 1/1/23, 08:18
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>
> CC:
> "axboe@kernel.dk" <axboe@kernel.dk>, "corbet@lwn.net" <corbet@lwn.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> 
> 
> This is the first time you've received an email from this sender 
> hdanton@sina.com, please exercise caution when clicking on links or opening 
> attachments.
> 
> 
> On 9 Dec 2022 15:23:27 +0100 Sergei Shtepa
>  > Provides the operation of block devices of snapshot images. Read and
>  > write operations are redirected to the regions of difference blocks for
>  > block device (struct diff_area).
>  >
>  > Signed-off-by: Sergei Shtepa
>  > ---
> 
> Thanks for your patchset.

Thanks for the review.

> 
>  > +static int snapimage_kthread_worker_fn(void *param)
>  > +{
>  > + struct snapimage *snapimage = param;
>  > + struct bio *bio;
>  > + int ret = 0;
>  > +
>  > + while (!kthread_should_stop()) {
>  > + bio = get_bio_from_queue(snapimage);
>  > + if (!bio) {
>  > + schedule_timeout_interruptible(HZ / 100);
>  > + continue;
>  > + }
> 
> Given the wake_up_process() below, s$HZ / 100$HZ * 1000$ to avoid
> unnecessary wakeups [1].
> 
> And because of no signal handling added, use schedule_timeout_idle() instead.

Yes, this function will be rewritten to eliminate unnecessary wake-ups.
The code that Christoph proposed in the letter at Dec 15 should work well.

> 
> [1] 
> https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20210419085027.761150-2-elver%40google.com%2F&data=05%7C01%7Csergei.shtepa%40veeam.com%7C765d591d47ad4d93857208daebc92508%7Cba07baab431b49edadd7cbc3542f5140%7C1%7C1%7C638081546440884849%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=rbINOq7m31DFhjHLnQKFHQuoWB64ZhmnWbAVLuNwv7w%3D&reserved=0
> 
>  > +
>  > + snapimage_process_bio(snapimage, bio);
>  > + }
>  > +
>  > + while ((bio = get_bio_from_queue(snapimage)))
>  > + snapimage_process_bio(snapimage, bio);
>  > +
>  > + return ret;
>  > +}
>  > +
>  > +static void snapimage_submit_bio(struct bio *bio)
>  > +{
>  > + struct snapimage *snapimage = bio->bi_bdev->bd_disk->private_data;
>  > + gfp_t gfp = GFP_NOIO;
>  > +
>  > + if (bio->bi_opf & REQ_NOWAIT)
>  > + gfp |= GFP_NOWAIT;
>  > + if (snapimage->is_ready) {
>  > + spin_lock(&snapimage->queue_lock);
>  > + bio_list_add(&snapimage->queue, bio);
>  > + spin_unlock(&snapimage->queue_lock);
>  > +
>  > + wake_up_process(snapimage->worker);
>  > + } else
>  > + bio_io_error(bio);
>  > +}
> 
