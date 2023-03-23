Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0338E6C7132
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCWTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:41:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E14227BF;
        Thu, 23 Mar 2023 12:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D10B82081;
        Thu, 23 Mar 2023 19:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5880BC433D2;
        Thu, 23 Mar 2023 19:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679600496;
        bh=PX6lvYGRYjaiS28foSYb5qozMIAi+w0uULCWhhV/XWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xvz2FZzn4zn6BV/AdITaKX+93PIW2AR41tEHuW1b16uKslYMJDBblVD05RfXg7Kbs
         Di8wo1WlpaPV8AqE97pAM2plz5bQrL++Vx0iORE7GwUmrfhh6GMwMLA+MmL9y1Kggu
         ovEL8fzXxkzvljl2IWyqu4VIph3qrBVc5hZuW85M=
Date:   Thu, 23 Mar 2023 12:41:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-Id: <20230323124135.a3c436d8b29dec5bddf47f34@linux-foundation.org>
In-Reply-To: <43b7534f-15ee-4cd7-a205-fa16fdb1ab14@paulmck-laptop>
References: <20230323144411.0edde523@canb.auug.org.au>
        <43b7534f-15ee-4cd7-a205-fa16fdb1ab14@paulmck-laptop>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 22:11:12 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> >   ce5e77e7b2cc ("instrumented.h: fix all kernel-doc format warnings")
> > 
> > in the mm tree)
> 
> Andrew, do you want to keep this one, or would you rather that I carry it?

I dropped my copy, thanks.
