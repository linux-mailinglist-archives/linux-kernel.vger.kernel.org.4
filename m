Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3035BA615
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIPEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIPEwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:52:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04881A0318;
        Thu, 15 Sep 2022 21:52:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E8FD280A7;
        Fri, 16 Sep 2022 04:44:19 +0000 (UTC)
Date:   Fri, 16 Sep 2022 07:52:14 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: x15: kernel crash: LR is at sysc_enable_opt_clocks
Message-ID: <YyQA/oKmurTV72Oy@atomide.com>
References: <CA+G9fYsaxK30=z0vBcNW-NRVHHkWxaoSNDt1bE-mfXQquMONKQ@mail.gmail.com>
 <97b5728e-e8ed-44a6-a777-a7f56370761a@www.fastmail.com>
 <CA+G9fYsUEmhHT_YsZSvLBiUStuTPJ_DW4Gp0=p7umvfpngSABA@mail.gmail.com>
 <ac63bc50-3375-4877-a4f3-aa998cb148f9@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac63bc50-3375-4877-a4f3-aa998cb148f9@www.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Arnd Bergmann <arnd@arndb.de> [220915 13:12]:
> On Thu, Sep 15, 2022, at 1:55 PM, Naresh Kamboju wrote:
> > On Wed, 14 Sept 2022 at 19:19, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> What is the easiest way to find out how long this job
> >> has been failing, and what the last successful build
> >> was?
> >
> > It is not reproducible easily and I have checked when it got
> > started but failed to find it. Because on v6.0-rc3 kernel the x15
> > did not boot pass.
> 
> To clarify my question: how to I look up on the website what the
> previous results for this boot were? Surely it must have passed
> at some point, and I would like to know e.g. whether this test
> setup booted 5.19, but I don't know how I see that.

Yeah it would be good to know if v5.19 boots OK. And if this happens on
every boot, or only sometimes. I have not seen this on beagle-x15.

Note that booting will fail between v6.0-rc1 until -rc4 because of
because of the fwlink deferred probe issue. The issue did not get fixed
until -rc4 with [0] below. Those fixes would need to be carried along
if trying to bisect this between v5.19 and the v6.0-rc series.

Regards,

Tony

[0] Commit 0b3acd1cc022 ("Merge tag 'driver-core-6.0-rc4' of
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core")
