Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44A6624947
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKJSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiKJSVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:21:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C344D5CB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D6B61DDD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8164C433D7;
        Thu, 10 Nov 2022 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668104458;
        bh=wi/r7g7EKYmj4XnMc8eJm6KXDr90O2MOBuJsu80cQn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ST1siAQh+LwA7aBwQGJZCYbqQig+upyNgLyEFIIKUnU3bm+FEuo36UtsF5+MnB1As
         rB6SXkKJ6TOY9QeRI5gHyCFxl3OlOGW8FqU+BclHVImCAh7QlN6JtPaox54gYjrv0B
         KfT4oci4lrDsEBtz9wLkS611YVaJ4kcbeu8I4GWc=
Date:   Thu, 10 Nov 2022 19:20:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-kernel@vger.kernel.org,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Message-ID: <Y21BB4Mh4aQjf71c@kroah.com>
References: <0000000000002473fd05eca7540a@google.com>
 <20221109120415.55759-1-zhouchengming@bytedance.com>
 <Y208VBO9cZ5VL88m@kroah.com>
 <Y20+1otw2iwldKTl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20+1otw2iwldKTl@slm.duckdns.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:11:34AM -1000, Tejun Heo wrote:
> On Thu, Nov 10, 2022 at 07:00:52PM +0100, Greg KH wrote:
> > Shouldn't:
> > 	https://lore.kernel.org/r/Y0SwqBsZ9BMmZv6x@slm.duckdns.org fix this
> > instead?
> 
> The difference is around whether the id based lookup can see hidden files or
> not. But yeah, it makes more sense to hide it.

So your patch should not have been applied to my tree?  And I should
take this one instead?

confused,

greg k-h
