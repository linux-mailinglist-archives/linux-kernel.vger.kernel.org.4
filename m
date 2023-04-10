Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B826DC637
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDJLS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF02D69;
        Mon, 10 Apr 2023 04:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3A8560FEF;
        Mon, 10 Apr 2023 11:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD9BC4339B;
        Mon, 10 Apr 2023 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681125536;
        bh=SVRaPmsADY+kGtCmqrnVbpIWM5lv7xkVCJpqPdGwPAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uPaHE+Yp9a7HbS+W7jmVFEem3AbNgtgbI14lmFtAvkLHLvHxFxpjSw1v1Z+eDk74V
         8HdU81tjMs3dqG7V0h6D+qznGgWcYQOpkP9+zFjlg/I9MntURTPnmA2ZJqJk1gyBCh
         BAi5kOlTDd4kqZ0y/Lh6lOLgTB1rA05jTlfsP8BzkpetC8tuCkVY4iITiG1FWczJhq
         itGBU/cfkIIlVgumNmUaP91Wk9wO48pvKyYDt8YH/3Ou3TcmSYCGoYFEbHSpn3OMPd
         Y6gyU66CJRMJ/9vFwsIwDJPwYwjY59ogCN9bTcGYTPTgkyrhVbL/SzUIXuM2DcfyWd
         8lTgZ5sOjxSig==
Date:   Mon, 10 Apr 2023 12:34:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagath Jog J <jagathjog1996@gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Improve kernel docs
Message-ID: <20230410123413.0bbd39d3@jic23-huawei>
In-Reply-To: <CANhJrGPBdJwaoDFy=Rp38k_uSsZrzzMSSKxswwbur67YGG0ZrQ@mail.gmail.com>
References: <cover.1680610554.git.mazziesaccount@gmail.com>
        <20230408104938.74a36f7a@jic23-huawei>
        <CANhJrGPBdJwaoDFy=Rp38k_uSsZrzzMSSKxswwbur67YGG0ZrQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 13:16:22 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> la 8. huhtik. 2023 klo 12.34 Jonathan Cameron (jic23@kernel.org) kirjoitti:
> >
> > On Tue, 4 Apr 2023 15:24:15 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  
> > > IIO has very nice facilities for efficiently providing data from a
> > > device to user (and probably also vice-versa - but I've not used that
> > > direction). Getting started with IIO may not be so simple though - some
> > > of the concepts like triggers and buffers are quite unique.
> > >
> > > This series tries to make it easier for a newcomer to write his/her first
> > > IIO driver by adding some documentation to used enums. Series does not
> > > provide extensive documentation but just documents those few entries I
> > > have become familiar with - but it still aims to be a starting point for
> > > others to add missing bits and pieces.
> > >
> > > This series is marked as v2 because the patch 1 was previously sent as a
> > > stan-alone RFC to collect the missing channel units. RFC can be seen
> > > here:
> > > https://lore.kernel.org/all/10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com/
> > >
> > > Patches 2 and 3 were added as a result of discussion followed by the
> > > RFC.  
> >
> > Something odd happened on this resend. Patch 1 didn't make it to me
> > or patchwork.  I'll reply to previous posting instead.
> >  
> 
> It seems checkpatch.pl + some of the patches were only picking the
> huawei.com address. Maybe that is the reason?

Nope. Patchwork gets it straight from the list and b4 gets it it from
lore.kernel.org which is also missing patch 1.

> 
> This really was a resend with no changes other than rebasing it -
> hence reviewing the v2 was absolutely fine. Thanks for the review!
> I'll check the suggestions and send v3 later this week.
Great.

I'm behind with a few other discussions including the looking at your
questions around that color sensor you want support.  So may be
a while before I circle back round to this anyway!

Jonathan

> 
> Yours,
>   -- Matti

