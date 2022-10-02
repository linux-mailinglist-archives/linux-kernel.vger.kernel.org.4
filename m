Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484065F22E5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJBLZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJBLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:25:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB2220CC;
        Sun,  2 Oct 2022 04:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC9C8B80D22;
        Sun,  2 Oct 2022 11:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EF1C433D6;
        Sun,  2 Oct 2022 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664709918;
        bh=yOdkbG7x/zuJIVtdlyZkg/evkalmf0sviGxVjdRR6fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gnlKmRD6098S93iBOOkSh6f6WpQwuzqhTmE55Fkt0Xq+FFBLBCFn+ISlhfXTR/a1y
         WnVm9yjTSVfqEtsMwq7PBMHp8/W7RMacV+ECEWMEart9i/NE89FSqvO9vugY0y3j+M
         LP1vAg6mCuQ0RHaqhy4/DSS9shPL1yVzXZcjjuWoETp9PsV5sBlFUAMtgGI46t+p7F
         8BJjg4jPQJ42Unzte1c2TjRMMBUpPGkn2DYqUAsFf/LgTMW0PqImke/mM/145C/bjV
         gm9gsElw1NwBHbmS99VKFET4cKOdswE0lMdcQSz2leJuEaGVY5nMfU1tRHubtplzT/
         pe/LEsGz3HC7g==
Date:   Sun, 2 Oct 2022 12:25:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 0/3] iio: temperature: mlx90632: Add powermanagement
Message-ID: <20221002122535.07d66ab3@jic23-huawei>
In-Reply-To: <CAKv63utk0r+PJXkkY3PpAmKp3WT6H5GxnBLdtJm28W1kz01E+g@mail.gmail.com>
References: <cover.1663834141.git.cmo@melexis.com>
        <20220924173221.1174608b@jic23-huawei>
        <CAKv63utk0r+PJXkkY3PpAmKp3WT6H5GxnBLdtJm28W1kz01E+g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 15:20:16 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Sat, 24 Sept 2022 at 18:32, Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
> > > hardcoded to 3 times as much as MEAS_MAX_TIME.
> > >  
> > Hi Crt,
> >
> > Applied. However, we are cutting it very tight for the coming merge window
> > so I'm not sure I'll get a 3rd pull request out (this just missed the 2nd
> > one as I only queued up material that was in a final state last weekend)
> > So for now pushed out as testing and we'll see if Linus hints at an rc8
> > when he releases rc7 tomorrow.  If not this will be 6.2 material now.
> >  
> I sure hope you mean 6.1 material... It would be great to get into 6.0
> as i think that is a most likely candidate also for Android kernel
> baseline (which is what I am also targeting).

Sorry, I do mean 6.2.

The merge window for 6.0 was months ago and we have to line 6.1 material
up a week or so before the 6.1 merge window (which probably starts today).
That allows us to get build bots and similar results before the merge window
and with time to fix any issues.

So unfortunately this will only be in a released kernel in about 6 months time:
3 months for the 6.1 cycle that this just missed and then it'll go into Linus'
mainline tree, but the release will still be 3 months after that.

In the meantime it'll be in linux-next from just after 6.1-rc1, and in
Linus' tree for 6.2-rc1.

Kernel cycles are short for a bit project, but they still have about
3 to 6 month delay for new code reaching a release.  This just happened
to hit the maximum.

Jonathan


> 
> > Thanks,
> >
> > Jonathan
> >
> >  

