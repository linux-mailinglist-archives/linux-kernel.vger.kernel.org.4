Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10FF6F0739
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbjD0OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbjD0OWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0525B87
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E209D63D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B87C433EF;
        Thu, 27 Apr 2023 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682605343;
        bh=xveGjcrIFueHGeHhCu3iZew9Rc3dsHaUsFQTri/7BtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCA9x69/fl2Yz2fjF5Qa/r9wViMl2KbNwJ7FjeT5WtcbT3FiRtN5WNcui4JgK6Lt4
         9vAB443Yi+nBvuceQg/PP8oOb+RpEM3UCHSHeP9FFdUvBrl1Y6/TOm5hUeoxy4CyAM
         VMUX9qm+eiFbm2Q4Q4OPnYwuEIqOuAf8O7JZJxQ0=
Date:   Thu, 27 Apr 2023 16:22:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.4
Message-ID: <2023042729-anthem-canary-4f72@gregkh>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
 <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
 <2023042544-cargo-reexamine-ed86@gregkh>
 <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 03:49:17AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> On 23. 4. 25. 22:22, Greg Kroah-Hartman wrote:
> > On Tue, Apr 25, 2023 at 09:58:47PM +0900, Chanwoo Choi wrote:
> >> Dear Greg,
> >>
> >> Gently ping for v6.4.
> > 
> > Ouch, something went wrong with your first email and it ended up in my
> > spam folder in gmail, so sorry about that :(
> 
> I'm sorry. I'll use the @kernel.org account on next time.
> 
> 
> > 
> > Is your tree included in linux-next already?
> > 
> 
> Yes. extcon.git was included in linux-next.
> 
> And my pull request edited the 'class_create()'
> Thus, it might have a conflict as following report[1] from Stetphen Rothwell (linux-next.git).
> [1] https://lore.kernel.org/lkml/ZBhOTW9v9jzJVY7e@kroah.com/

Ok, I've sent off my pull request to Linus now.  Let's get that merged
and then I'll take this one and get the class_create() fix in as well.

thanks,

greg k-h
