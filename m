Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2D67FA46
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjA1SzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 13:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1SzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 13:55:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE816301;
        Sat, 28 Jan 2023 10:55:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35557CE009E;
        Sat, 28 Jan 2023 18:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5355AC433EF;
        Sat, 28 Jan 2023 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674932096;
        bh=b3LC7GzJbKCQgoSIJh2AUXE2SY/l0rvrW75DR/3uPMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5Se+sjU2iJ1IBGxkJQSZfWkUmGEQHJJciDry/WOxVI2jP+O9XwMTS2mYVpstaXFt
         uTPduMZ46mj9Fonxm3rwvjctPwaGxWGGKIMGM1YkwLcqRVQa/C1/rFgB8I4FTmQM+s
         963+jkwhe77UKjqPOMU/JiriyNe4tDkMxp9fCtmfovMgwgId79LSkcbvPdUxzOpgO7
         YGPHEleqhN4eIaE9WFuvlgZ9hStjGREK3jjiuNm1NEh3kX8UqtrAbxmxj2BzNqt3nU
         fHjMOYIpjyENkhMN3mfi5RXwwLCVpfcX9laWQ/68zjHqS81+my3XIjKSIJn2Qh7zps
         ZQfiYYurRE+4A==
From:   SeongJae Park <sj@kernel.org>
To:     Hui Su <suhui_kernel@163.com>
Cc:     sj@kernel.org, corbet@lwn.net, alexs@kernel.org,
        siyanteng@loongson.cn, rppt@kernel.org, bobwxc@email.cn,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Doc/damon: fix the data path error
Date:   Sat, 28 Jan 2023 18:54:53 +0000
Message-Id: <20230128185453.131270-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y9Tm1FiKBPKA2Tcx@localhost.localdomain>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

On Sat, 28 Jan 2023 17:11:48 +0800 Hui Su <suhui_kernel@163.com> wrote:

> %s/modules/module/
> 
> Signed-off-by: Hui Su <suhui_kernel@163.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  Documentation/admin-guide/mm/damon/lru_sort.rst               | 4 ++--
>  Documentation/admin-guide/mm/damon/reclaim.rst                | 4 ++--
>  .../translations/zh_CN/admin-guide/mm/damon/reclaim.rst       | 4 ++--

I realized DAMON documentation is also translated for Chinese today!  Thank you
for letting me know this, and also thanks to the translators!


Thanks,
SJ

>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
> index c09cace80651..7b0775d281b4 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -54,7 +54,7 @@ that is built with ``CONFIG_DAMON_LRU_SORT=y``.
>  To let sysadmins enable or disable it and tune for the given system,
>  DAMON_LRU_SORT utilizes module parameters.  That is, you can put
>  ``damon_lru_sort.<parameter>=<value>`` on the kernel boot command line or write
> -proper values to ``/sys/modules/damon_lru_sort/parameters/<parameter>`` files.
> +proper values to ``/sys/module/damon_lru_sort/parameters/<parameter>`` files.
>  
>  Below are the description of each parameter.
>  
> @@ -283,7 +283,7 @@ doesn't make progress and therefore the free memory rate becomes lower than
>  20%, it asks DAMON_LRU_SORT to do nothing again, so that we can fall back to
>  the LRU-list based page granularity reclamation. ::
>  
> -    # cd /sys/modules/damon_lru_sort/parameters
> +    # cd /sys/module/damon_lru_sort/parameters
>      # echo 500 > hot_thres_access_freq
>      # echo 120000000 > cold_min_age
>      # echo 10 > quota_ms
> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> index 4f1479a11e63..d2ccd9c21b9a 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -46,7 +46,7 @@ that is built with ``CONFIG_DAMON_RECLAIM=y``.
>  To let sysadmins enable or disable it and tune for the given system,
>  DAMON_RECLAIM utilizes module parameters.  That is, you can put
>  ``damon_reclaim.<parameter>=<value>`` on the kernel boot command line or write
> -proper values to ``/sys/modules/damon_reclaim/parameters/<parameter>`` files.
> +proper values to ``/sys/module/damon_reclaim/parameters/<parameter>`` files.
>  
>  Below are the description of each parameter.
>  
> @@ -251,7 +251,7 @@ therefore the free memory rate becomes lower than 20%, it asks DAMON_RECLAIM to
>  do nothing again, so that we can fall back to the LRU-list based page
>  granularity reclamation. ::
>  
> -    # cd /sys/modules/damon_reclaim/parameters
> +    # cd /sys/module/damon_reclaim/parameters
>      # echo 30000000 > min_age
>      # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
>      # echo 1000 > quota_reset_interval_ms
> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
> index c976f3e33ffd..d15a2f20bb11 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
> @@ -45,7 +45,7 @@ DAMON_RECLAIM找到在特定时间内没有被访问的内存区域并分页。
>  
>  为了让系统管理员启用或禁用它，并为给定的系统进行调整，DAMON_RECLAIM利用了模块参数。也就
>  是说，你可以把 ``damon_reclaim.<parameter>=<value>`` 放在内核启动命令行上，或者把
> -适当的值写入 ``/sys/modules/damon_reclaim/parameters/<parameter>`` 文件。
> +适当的值写入 ``/sys/module/damon_reclaim/parameters/<parameter>`` 文件。
>  
>  注意，除 ``启用`` 外的参数值只在DAMON_RECLAIM启动时应用。因此，如果你想在运行时应用新
>  的参数值，而DAMON_RECLAIM已经被启用，你应该通过 ``启用`` 的参数文件禁用和重新启用它。
> @@ -218,7 +218,7 @@ nr_quota_exceeds
>  就开始真正的工作。如果DAMON_RECLAIM没有取得进展，因此空闲内存率低于20%，它会要求
>  DAMON_RECLAIM再次什么都不做，这样我们就可以退回到基于LRU列表的页面粒度回收了::
>  
> -    # cd /sys/modules/damon_reclaim/parameters
> +    # cd /sys/module/damon_reclaim/parameters
>      # echo 30000000 > min_age
>      # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
>      # echo 1000 > quota_reset_interval_ms
> -- 
> 2.34.1
