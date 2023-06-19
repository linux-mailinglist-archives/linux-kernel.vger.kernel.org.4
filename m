Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88961734C30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFSHQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFSHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:16:14 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC32106;
        Mon, 19 Jun 2023 00:16:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VlR1tor_1687158967;
Received: from 30.221.149.136(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlR1tor_1687158967)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 15:16:09 +0800
Message-ID: <705ffdff-fe52-d617-9184-5e9bc6fb5de0@linux.alibaba.com>
Date:   Mon, 19 Jun 2023 15:16:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/2] block: fine-granular CAP_SYS_ADMIN for Persistent
 Reservation ioctl
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
References: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens,

Would do you think of this series?


On 6/13/23 4:40 PM, Jingbo Xu wrote:
> changes since v2:
> - patch 1: disallow reservations on partitions entirely and make it into
>   a separate patch (hch)
> - patch 2: rebase to hch's series of converting fmode_t to blk_mode_t
>   and execute permission check upon blk_mode_t (hch)
> 
> changes since RFC:
> - only allow unprivileged reservations if the file descriptor is open
>   for write (Christoph Hellwig)
> - refuse the unprivileged reservations on partitions (Christoph Hellwig)
>   (maybe this checking shall also be done when CAP_SYS_ADMIN is set?)
> 
> 
> RFC: https://lore.kernel.org/all/20230609102122.118800-1-jefflexu@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20230612074103.4866-1-jefflexu@linux.alibaba.com/
> 
> Jingbo Xu (2):
>   block: disallow Persistent Reservation on partitions
>   block: fine-granular CAP_SYS_ADMIN for Persistent Reservation
> 
>  block/ioctl.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 

-- 
Thanks,
Jingbo
