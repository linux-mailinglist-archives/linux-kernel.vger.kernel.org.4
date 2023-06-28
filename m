Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F2740865
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjF1Cao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjF1Cal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:30:41 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6E610D5;
        Tue, 27 Jun 2023 19:30:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vm7rHK8_1687919435;
Received: from 30.221.133.165(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vm7rHK8_1687919435)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 10:30:36 +0800
Message-ID: <6d59ab08-070f-1562-2eaa-16b083f1a732@linux.alibaba.com>
Date:   Wed, 28 Jun 2023 10:30:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 0/2] update ocfs2-devel mailing list addresses
Content-Language: en-US
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230628013437.47030-1-ailiop@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230628013437.47030-1-ailiop@suse.com>
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

Thanks for this work.

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

On 6/28/23 9:34 AM, Anthony Iliopoulos wrote:
> The ocfs2-devel mailing list has been migrated to kernel.org, update all
> related kernel documentation pointers to reflect the change.
> 
> Anthony Iliopoulos (2):
>   MAINTAINERS: Update ocfs2-devel mailing list address
>   docs: update ocfs2-devel mailing list address
> 
>  Documentation/ABI/obsolete/o2cb       |  4 ++--
>  Documentation/ABI/removed/o2cb        |  4 ++--
>  Documentation/ABI/stable/o2cb         |  4 ++--
>  Documentation/ABI/testing/sysfs-ocfs2 | 12 ++++++------
>  Documentation/filesystems/dlmfs.rst   |  2 +-
>  Documentation/filesystems/ocfs2.rst   |  2 +-
>  MAINTAINERS                           |  2 +-
>  fs/ocfs2/Kconfig                      |  6 +++---
>  8 files changed, 18 insertions(+), 18 deletions(-)
> 
