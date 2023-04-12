Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182236DE97D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDLCf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:35:25 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FA172B;
        Tue, 11 Apr 2023 19:35:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VfuJbUW_1681266919;
Received: from 30.221.132.52(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfuJbUW_1681266919)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 10:35:20 +0800
Message-ID: <67aed69a-b28a-587b-b88b-3d8ffc88e767@linux.alibaba.com>
Date:   Wed, 12 Apr 2023 10:35:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: linux-next: manual merge of the erofs tree with the vfs-idmapping
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <xiang@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230412101942.75e3efa9@canb.auug.org.au>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230412101942.75e3efa9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/23 8:19 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the erofs tree got a conflict in:
> 
>   fs/erofs/xattr.c
> 
> between commit:
> 
>   a5488f29835c ("fs: simplify ->listxattr() implementation")
> 
> from the vfs-idmapping tree and commit:
> 
>   3f43a25918ac ("erofs: handle long xattr name prefixes properly")
> 
> from the erofs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Hi,

Thanks for the fix up. It looks good to me.

It passes the corresponding testcase [1].

[1]
https://lore.kernel.org/all/20230411103004.104064-1-jefflexu@linux.alibaba.com/

-- 
Thanks,
Jingbo
