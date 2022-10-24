Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5307E60BD22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiJXWJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiJXWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580F2FD28E;
        Mon, 24 Oct 2022 13:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BBA61589;
        Mon, 24 Oct 2022 20:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C76DC433D6;
        Mon, 24 Oct 2022 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666642863;
        bh=Z5RTPdWdqul8fJi7QbJUjS/tMdTLaDHR/Y0eodA5IxY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fJpxPHCoyL6Ylss5MyHvAiCop6BDTc8U4nbRNrkjkEZLH2bRXNxWu2VRforyAZh27
         CUyWxOENeSX+1Y0zEnn9pabPNpPfBW/rBZzilNgDZKeoQoEDnkk1sM292MJ894wH/R
         IzvjnFRyWwdm0x6DHmNF+Dtdmrvjd+Sqg+Xrao2zVf2wP8SFwUl9uiUuXlsAVpHMIV
         fizKOK03FESukfGbrrKEUT8cXDanfMWWaSxaKQ3ZmHFADweLMZLSICh0TRWcB3akh0
         YDNXwaEVit+grIXvoxnczwn41Hnasn9mEhMyrsD7W+Cb2XPKJpqKetT3Vg9BE3XoEu
         4GNnNjHVRYqAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B063D5C0DDA; Mon, 24 Oct 2022 13:21:02 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:21:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early
 boot
Message-ID: <20221024202102.GF5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
 <20221024200446.GD5600@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wi5fhyHfabjN6kDD+ow5m1JF4iduq0SHDkidqK1+G9aLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5fhyHfabjN6kDD+ow5m1JF4iduq0SHDkidqK1+G9aLA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:06:12PM -0700, Linus Torvalds wrote:
> On Mon, Oct 24, 2022 at 1:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Please accept my apologies for my confusion!
> >
> > Please see below for a pull request for a better-formatted commit.
> 
> Oh, it was such a small nit that I already pulled your tree - my note
> was really just a "not a big deal, but in the future it would be nice
> if.."

Thank you, and at least I got practice for the future.  ;-)

							Thanx, Paul
