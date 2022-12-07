Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797B16459E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLGMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLGMez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:34:55 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7CC45A14;
        Wed,  7 Dec 2022 04:34:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=cuibixuan@linux.alibaba.com;NM=0;PH=DS;RN=17;SR=0;TI=SMTPD_---0VWm7CjE_1670416489;
Received: from 30.221.148.76(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0VWm7CjE_1670416489)
          by smtp.aliyun-inc.com;
          Wed, 07 Dec 2022 20:34:50 +0800
Message-ID: <19defb67-195d-6511-ad6c-96a768289754@linux.alibaba.com>
Date:   Wed, 7 Dec 2022 20:34:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: reply for ACPI: APEI: handle synchronous exceptions in task work
Content-Language: en-US
To:     Lv Ying <lvying6@huawei.com>, xueshuai@linux.alibaba.com
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        bp@alien8.de, dave.hansen@linux.intel.com, james.morse@arm.com,
        jarkko@kernel.org, lenb@kernel.org, linmiaohe@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        naoya.horiguchi@nec.com, rafael@kernel.org, tony.luck@intel.com,
        zhuo.song@linux.alibaba.com, xiezhipeng1@huawei.com
References: <20221206153354.92394-1-xueshuai@linux.alibaba.com>
 <20221207095413.1980862-1-lvying6@huawei.com>
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
In-Reply-To: <20221207095413.1980862-1-lvying6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/7 17:54, Lv Ying 写道:
> Yingwen's proposal makes distinguish synchronous error by CPER report more
> easy, however, it's not supported yet.
> Looking forward to your reply if there is any progress on the proposal and
> your suggestions about my patchset.

Originally, the arm can distinguish between synchronous and asynchronous 
errors, but the OS cannot. Therefore, it is more reasonable to 
distinguish by adding 'sync flag' bit for arm.

Thanks,
Bixuan Cui
