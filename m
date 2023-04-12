Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8E6DF1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjDLKNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDLKN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8772B4;
        Wed, 12 Apr 2023 03:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6135B632AF;
        Wed, 12 Apr 2023 10:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E18DC433EF;
        Wed, 12 Apr 2023 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681294401;
        bh=cV0F/zXqS3VEU+Ur4CyxSlC/LnTHZyV5cWJ1O1RaC38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AI0T2oh2NykTR0ryA1L9IjPhv7FDeSWxTR8TUUZ2S5K4mm/ikoTgo3jHh/lHcs5uD
         7V1QdmXYFB/vfe1OqePSd2iRp5TIQmZVxoETgmBwzLIjRag0/ioMBPc7Vy4i3o6540
         ao2e7FgorzlFIYLsbFlNa5rqx5GpPsHYTCpK1OAY=
Date:   Wed, 12 Apr 2023 12:13:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <2023041243-clarinet-scallion-6fb0@gregkh>
References: <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
 <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
 <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
 <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
 <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
 <ca17f815-5779-d37c-e3f8-2a6c2983fe45@selasky.org>
 <CANiq72mn1nD38DGHpFQzerC=_ifR39Vpbb_PzLv5Q75SdzTxQg@mail.gmail.com>
 <8ff91d0c-624b-2704-24b0-5b7c4ca0db1e@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff91d0c-624b-2704-24b0-5b7c4ca0db1e@selasky.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:00:59PM +0200, Hans Petter Selasky wrote:
> That's why the toolchain should be included in the Linux kernel. So that the
> people using Linux know that the toolchain works as intended when compiling
> the Linux kernel.

That's not how Linux has ever worked, sorry.  So this is not even a
valid discussion anymore.

greg k-h
