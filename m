Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532AD63CF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiK3GHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiK3GHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:07:19 -0500
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D774ABD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:07:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW1bDq9_1669788434;
Received: from 30.221.128.235(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW1bDq9_1669788434)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 14:07:15 +0800
Message-ID: <118bb655-b645-6373-5545-4c0615bf0f74@linux.alibaba.com>
Date:   Wed, 30 Nov 2022 14:07:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2] erofs: enable large folios for iomap mode
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/22 2:04 PM, Jingbo Xu wrote:
> Enable large folios for iomap mode.  Then the readahead routine will
> pass down large folios containing multiple pages.
> 
> Let's enable this for non-compressed format for now, until the
> compression part supports large folios later.
> 
> When large folios supported, the iomap routine will allocate iomap_page
> for each large folio and thus we need iomap_release_folio() and
> iomap_invalidate_folio() to free iomap_page when these folios get
> recalimed or invalidated.      ^
  reclaimed


-- 
Thanks,
Jingbo
