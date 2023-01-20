Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F5675400
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjATL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjATL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:59:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F25A2943
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F29361F25
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF94C433D2;
        Fri, 20 Jan 2023 11:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674215954;
        bh=P7Wl9A9Dddz4p7HgcuNKsv7iPsqoZtelM0qY2cA5nbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkXdOhHgrCvhyIVG0JltayofanG1ezhDyZu13fis70qvzxAWJvhNVzow/xGuFVmxO
         bWe2KTK2vzOm7KPP9FyZiW7aK9KHqWNXcnWR8LwKchbWN7enCkxReNwgJkcILL/xa2
         2iVVIhpXcCXRFfb5bRkPxrtL1cYg4rASVX7De8bk=
Date:   Fri, 20 Jan 2023 12:59:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] drivers: base: cacheinfo: fix shared_cpu_map
Message-ID: <Y8qCEK1yCPtbn7dl@kroah.com>
References: <20221219105132.27690-1-yongxuan.wang@sifive.com>
 <20221219105132.27690-2-yongxuan.wang@sifive.com>
 <9cfb3356-3e3b-e9f3-1e16-ff02790e5829@arm.com>
 <Y8p6ns/XNrk/CDww@kroah.com>
 <20230120113155.nsq3ufwlel3lznfl@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120113155.nsq3ufwlel3lznfl@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:31:55AM +0000, Sudeep Holla wrote:
> Hi Greg,
> 
> On Fri, Jan 20, 2023 at 12:27:26PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 21, 2022 at 10:00:39AM +0100, Pierre Gondois wrote:
> 
> [...]
> 
> > >
> > > It seems there are 2 ';' above (same in the block below).
> >
> > Yes, the kernel test robot complains about this as well.
> >
> > It needs to be fixed before this change can be accepted.
> >
> 
> Just FYI, v3 and v4 was posted and I have pulled v4 which includes all
> the suggested changes. I will send a pull request with all cacheinfo and
> associated changes later today. They have been in the next for a while, need
> to tag them and send it to you.

Ah, good, sorry, I missed that.  Am catching up on old patches in my
queue...
