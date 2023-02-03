Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5959F688F88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBCGMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBCGME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:12:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09789FAE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92745B82916
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CBCC433D2;
        Fri,  3 Feb 2023 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675404676;
        bh=MAggVnzFKDMQ6sFkdhtLT/WSLZ0MVSVv/6OXYW3ftB4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QJlRH8umlV+0TMBPBrCGs0UJ1hukXG5vVraOL+qqlSLAxvO3P9jW4ehrIwXKF8dT5
         JPB62P/JXtyB4Xh+bx0ixF/EJwYYOecTbNkJ7/pkJ97AGuskaKAYX4HZ15UUHEhTmH
         vAbdw2cUvUuBkq1GUsTi62QSNQPypOKRQkfoMs46BCzoeqYWwyfGItoEsvqBhtGzrX
         XnHoijtn72lUlJ0NcirHRR40uRkaGr+jsGH170McSW4ZqFQX854XdTtAaPKM2HFe8I
         ylUlXal6ItW+H2gY7OKYco/r8/VikioBB3mARdWrsykGkSKqmfu9F41IRp9VvcbV7e
         zLnNlu16i3Wfg==
Message-ID: <f7fba117-ff4a-2c5d-2206-fd039de19ddc@kernel.org>
Date:   Fri, 3 Feb 2023 14:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2 v3] f2fs: fix wrong calculation of block age
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Ping Xiong <xiongping1@xiaomi.com>,
        Xiaoyu Qi <qixiaoyu1@xiaomi.com>
References: <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
 <20230202082028.9013-1-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230202082028.9013-1-qixiaoyu1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/2 16:20, qixiaoyu1 wrote:
> Currently we wrongly calculate the new block age to
> old * LAST_AGE_WEIGHT / 100.
> 
> Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
>                  + old * LAST_AGE_WEIGHT / 100.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
