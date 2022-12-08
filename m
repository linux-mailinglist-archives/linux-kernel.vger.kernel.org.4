Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D61646596
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLHADf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHADd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:03:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97EAF7B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670457812; x=1701993812;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RW6fdvIXpCxTU4dqxR6X8OMdODJuBSPa3qWNunPaM2w=;
  b=WuqfdCp1evXYNv89NF6FcyP1SI8koeYgqUspRNOeB2T03OSETWWAilog
   jBAzMFY++K3SFDb8NKw9Txzjn8pWAdfE9yo42wOVzuy13/lDZj+iF72hK
   VqTOMVC03mlX7RKb3GKTpiPUSRlk3X6In3708BpYel2TCAH59b0OeAesW
   diziuHyu0JIlgjtm0s/okfQkaJ1eEOYFocEzBK4iEuDK8OLuLPq34Zwdq
   xqRHv9pzgmY+DBEdnArIknsVNevBvUEE5DwuaPTFidW1CqBrvjcGvYBTk
   3C+149NN1DzuvDKx+4uqfFmF5+pSyRF7sgtLM2z1NKqop9awBAbvNeH8L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297391549"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="297391549"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:03:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="753321015"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="753321015"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:03:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wang Yong <yongw.kernel@gmail.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix typo in struct pglist_data code comment
References: <20221207074011.GA151242@cloud>
Date:   Thu, 08 Dec 2022 08:02:02 +0800
In-Reply-To: <20221207074011.GA151242@cloud> (Wang Yong's message of "Wed, 7
        Dec 2022 07:40:11 +0000")
Message-ID: <875yemzrt1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Yong <yongw.kernel@gmail.com> writes:

> change "stat" to "start".
>
> Fixes: c959924b0dc5 ("memory tiering: adjust hot threshold automatically")
> Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
> ---
>  include/linux/mmzone.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5f74891556f3..128f3cde800c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1200,7 +1200,7 @@ typedef struct pglist_data {
>  	/* start time in ms of current promote threshold adjustment period */
>  	unsigned int nbp_th_start;
>  	/*
> -	 * number of promote candidate pages at stat time of current promote
> +	 * number of promote candidate pages at start time of current promote

Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>  	 * threshold adjustment period
>  	 */
>  	unsigned long nbp_th_nr_cand;
