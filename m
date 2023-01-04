Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5665DCBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjADT3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjADT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:29:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256215F16
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jUv41z1gP47WvrSWReHxYxlDem0sBsM4uktsd/tNnmQ=; b=cIopn4ES5pJSicz/ZY5kapGlif
        4nNmPDZpZUVoU/QKIS3OcM7YWDxb6KxTrBovRQolYNDp+lqaPJsR7FHA8355EEaST6+NcTHLKgpVk
        m6LC6GjNtri7LO7NxZ0Nh9pAHV4SlbZuN3Ay6UDb7BtXzI34Hp1Z/tsvflgblZ1zITGUFsVyZXCnR
        RvJjMV6WjlbDOakh7MJ8eeslUiB4qpm8oPBJcM7nBJE50mYVdsNDze5IgsiQ1LT1+3e2LGzfdb4tm
        hQlVBAZofIhIqIHD911L1Pj5Jz74vBAXJJ5Rgz8Fo2McKiGWsl1G8RqBI1pC/eNkOt9nSAuIzhWJP
        ovpFZePw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD9Rk-00BSGh-Jm; Wed, 04 Jan 2023 19:29:08 +0000
Message-ID: <f72f03b8-0dc7-5b9b-9a44-d10821684bb2@infradead.org>
Date:   Wed, 4 Jan 2023 11:29:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] scripts/spelling: add a few more typos
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     colin.i.king@gmail.com, dfustini@baylibre.com, joe@perches.com,
        linux-kernel@vger.kernel.org
References: <20230104184017.1724-1-sj@kernel.org>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230104184017.1724-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 10:40, SeongJae Park wrote:
> Add a few more typos that found from real patches[1,2] to 'spelling'
> file.
> 
> [1] https://lore.kernel.org/linux-mm/4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com/
> [2] https://lore.kernel.org/damon/20221228174621.34868-1-sj@kernel.org/
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes from v1
> (https://lore.kernel.org/lkml/20230103175901.128262-1-sj@kernel.org/)
> - Remove the line adding covert as a typo of convert (Randy Dunlap, Joe
>   Perches)
> 
>  scripts/spelling.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index ded8bcfc0247..a2ef42eb70d9 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -664,11 +664,13 @@ feauture||feature
>  feautures||features
>  fetaure||feature
>  fetaures||features
> +fetcing||fetching
>  fileystem||filesystem
>  fimrware||firmware
>  fimware||firmware
>  firmare||firmware
>  firmaware||firmware
> +firtly||firstly
>  firware||firmware
>  firwmare||firmware
>  finanize||finalize
> @@ -1558,6 +1560,7 @@ tunning||tuning
>  ture||true
>  tyep||type
>  udpate||update
> +updtes||updates
>  uesd||used
>  unknwon||unknown
>  uknown||unknown

-- 
~Randy
