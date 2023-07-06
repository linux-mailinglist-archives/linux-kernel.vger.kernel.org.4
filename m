Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083FD749CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGFNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGFNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:01:56 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC430E65;
        Thu,  6 Jul 2023 06:01:53 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5C3AD61E5FE01;
        Thu,  6 Jul 2023 15:01:05 +0200 (CEST)
Message-ID: <37c7a3f7-f769-a313-3279-e8e415369ba4@molgen.mpg.de>
Date:   Thu, 6 Jul 2023 15:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next 2/3] md/dm-raid: cleanup multiple equivalent goto
 tags from raid_ctr()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, heinzm@redhat.com, neilb@suse.de,
        jbrassow@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230706071622.563073-1-yukuai1@huaweicloud.com>
 <20230706071622.563073-3-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230706071622.563073-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for your patch. Some minor nits, if you are interested.

Am 06.07.23 um 09:16 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are four equivalent goto tags in raid_ctr(), clean them up to use
> just one, there are no functional change and prepare to fix that

Maybe:

There *is* no functional change, and is a preparation to fix an 
unprotected `md_stop()`.

> md_stop() is not protected.

In the commit message summary/title, I’d spell the verb with a space:

     Clean up four equivalent goto tags in raid_ctr()

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/dm-raid.c | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)

[…]


Kind regards,

Paul
