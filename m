Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FAC693910
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBLRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 12:33:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8F46B9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 09:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2400860DC0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005ABC433D2;
        Sun, 12 Feb 2023 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676223204;
        bh=RoVeouo2WSoPCdbG1BYhN5N2qKoHVh22DZo/2vMJ+TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raIyiPkACHgloJOuggQXxTyAVZIoyXx8oEnn0teQ0SmH3U5I5vVUEIPQEeF3gL+Fz
         t5CCCAePJtEPjftls+7MzGlroQjQBZjlwtWxfZeJj8iC/ncAIDLSGgwH6PzRq/QdZ9
         25hshk8LmhWS/F9rvKLqiABHaoKdMSauySCbtazQ=
Date:   Sun, 12 Feb 2023 18:33:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     jirislaby@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in n_tty_open
Message-ID: <Y+ki32mgN21UrFTJ@kroah.com>
References: <CANX2M5ayFcJsq7P2-mPAt0rvmfjYB9PaL0E2K7mKUxUC=TCTwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANX2M5ayFcJsq7P2-mPAt0rvmfjYB9PaL0E2K7mKUxUC=TCTwA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 09:00:17AM -0800, Dipanjan Das wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.

Do you have a proposed patch for this issue as you seem to be able to
reproduce this?

Wait, this is a fake problem:

> memcpy((void*)0x20000000, "/dev/ttyS3\000", 11);
> 	inject_fault(13);

You are manually injecting faults.  That's not a normal operation.  If
you can reproduce this without fault injection, please let us know.

Or propose a patch to resolve this?

thanks,

greg k-h
