Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8C708DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjESCgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjESCgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:36:16 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A6E4D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:36:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Viyg9rg_1684463767;
Received: from 30.97.48.167(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Viyg9rg_1684463767)
          by smtp.aliyun-inc.com;
          Fri, 19 May 2023 10:36:10 +0800
Message-ID: <9eb43d73-335d-e30f-ed49-4e0527eeddc3@linux.alibaba.com>
Date:   Fri, 19 May 2023 10:36:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: move erofs_{allocpage,release_pages}() under
 CONFIG_EROFS_FS_ZIP
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230519023313.24892-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230519023313.24892-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/19 19:33, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> These two functions are only used for compression side now. Also,
> eliminate unused pagevec.h inclusion.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

That seems unnecessary since utils.c shouldn't be included with
some inner Kconfig.

BTW, I'm now cleanup such stuffs for folios as well.

Thanks,
Gao Xiang
