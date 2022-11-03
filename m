Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4476D6173EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKCB54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKCB5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:57:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBFB11C1B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0LkUSKcG6bxtyXieHL63gCYJOej0vClgGGZrSOYVIyk=; b=dBnkmIMdihVSi+bsTP7LYSrzwe
        M/seaUI9+O4K3PBUx8/lKf4/Gvuy6FZVZ1OcB/XWFuJMDXl/4pzld137Oav463GP3j+KtBgpa9Am3
        /ErUWtQPvgSHZK0cYqIOCn+5M6SB8dGKMt7JTxqR9U+BNbxZiTMgvEiunYIQwlKwNnht1dP+brD/8
        OMIbA4b9Q31KEN+MWF785U35H4icJ+cGxqBe2v6MNbu15/NVp8YRpWShXwKdFF+bSo60IcQkY1bqA
        5Bd+JFSVxK50eCDnkghWJXgbYNpfrIg4qzxaIDpO1iyd1mJHxYGB7vkTYfrPLcfUixd4b7WGvSRkS
        8Gh4aoJg==;
Received: from [2601:1c2:d80:3110:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqPUJ-00FaTe-9y; Thu, 03 Nov 2022 01:57:47 +0000
Message-ID: <71ae2e25-1af5-b8b3-0451-6f3955cb1050@infradead.org>
Date:   Wed, 2 Nov 2022 18:57:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] platform/x86: ISST: Fix typo in comments
Content-Language: en-US
To:     chen zhang <chenzhang@kylinos.cn>, hdegoede@redhat.com,
        bagasdotme@gmail.com
Cc:     linux-kernel@vger.kernel.org, chenzhang_0901@163.com,
        k2ci <kernel-bot@kylinos.cn>
References: <20221103013313.13278-1-chenzhang@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221103013313.13278-1-chenzhang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 18:33, chen zhang wrote:
> Fix spelling typo in comments.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
> v3: Change "interace" to "interfaces", Change "share" to "shared"
> Thanks for your advice.
> v2: update the comments
> There is a bug with my company's mailbox with kylinos.cn, and sometimes 
> I can't receive reply emails. I cc my personal 163 mailbox, so that I can
> receive feedback from reviewer on time.
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index fd102678c75f..a7e02b24a87a 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -623,7 +623,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
>  
>  /* Lock to prevent module registration when already opened by user space */
>  static DEFINE_MUTEX(punit_misc_dev_open_lock);
> -/* Lock to allow one share misc device for all ISST interace */
> +/* Lock to allow one shared misc device for all ISST interfaces */
>  static DEFINE_MUTEX(punit_misc_dev_reg_lock);
>  static int misc_usage_count;
>  static int misc_device_ret;

Looks good to me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
