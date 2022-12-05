Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC652642257
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiLEEnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiLEEnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:43:18 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6BDEC2;
        Sun,  4 Dec 2022 20:43:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VWMo53a_1670215392;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWMo53a_1670215392)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 12:43:14 +0800
Date:   Mon, 5 Dec 2022 12:43:12 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, Gao Xiang <xiang@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <Y4124Jod9kS+sHGY@B-P7TQMD6M-0146.local>
References: <20221205092415.56cc6e19@canb.auug.org.au>
 <Y41h7hz12QXQaSYS@B-P7TQMD6M-0146.local>
 <20221205151107.05579d52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221205151107.05579d52@canb.auug.org.au>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 03:11:07PM +1100, Stephen Rothwell wrote:
> Hi Gao,
> 
> On Mon, 5 Dec 2022 11:13:50 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > On Mon, Dec 05, 2022 at 09:24:15AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the vfs tree got a conflict in:
> > > 
> > >   fs/erofs/fscache.c
> > > 
> > > between commits:
> > > 
> > >   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
> > >   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
> > > 
> > > from the erofs tree and commit:
> > > 
> > >   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
> > > 
> > > from the vfs tree.  
> > 
> > Is the commit from the vfs tree correct?
> > 
> > The conflict fix looks good to me (we tend to enable large folios in the
> > next cycle.)
> 
> The commits should be
> 
>   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
>   a21274e993a6 ("erofs: support large folios for fscache mode")
> 
> from the erofs tree and
> 
>   de4eda9de2d9 ("use less confusing names for iov_iter direction initializers")
> 
> from the vfs tree.
> 
> Cut and paste weirdness caught me again :-(

Thanks for the confirmation!

Thanks,
Gao Xiang

> 
> -- 
> Cheers,
> Stephen Rothwell


