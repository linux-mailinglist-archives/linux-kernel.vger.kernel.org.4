Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBF5E82E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIWUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DF31E71E;
        Fri, 23 Sep 2022 13:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B5960769;
        Fri, 23 Sep 2022 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E455EC433D6;
        Fri, 23 Sep 2022 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663963783;
        bh=Udem0E2XbKDmYLGjYyCD09WbYwix83Og0t89PUb/6DI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=hdgch+MJTOqOvbvOvRxPhymzSXm+Ho86cc7Sxe/SrppYA5ZI+o3HMjC15zELtmJck
         9Tp+unafMCybnmZSVX0kkituJDxs3advy4ifBwdDfeHvTzPvOb/KIiXdp5VsiGK0RL
         oNFlNj9uUlpnY0ZgEenahQfl9Yer0Hn7pOlMjNHiWv0v8tO708QzIBB0+a399g+apC
         hSDyCFhtxwmYBlCBuJ9goco06VG9131YwCe5COsfhJESL8lo35TmvtRwWcv7x/9+Y+
         3pN/gAaGr+Ff+iFMtDjuWvkxpOFDc6zBxC3Qzqy6a8Ztej3hdpSdVd8nQsCgHEwAxw
         3xGvtdKgX7U4Q==
Date:   Fri, 23 Sep 2022 13:09:41 -0700
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>
Subject: Re: [ANNOUNCE] 4.9.327-rt197
Message-ID: <Yy4ShVWORi6XNhCv@T470>
References: <165222469651.210737.17409564443317121708@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165222469651.210737.17409564443317121708@T470>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:03:24PM -0700, Mark Gross wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 4.9.327-rt197 stable release.
> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v4.9-rt-next
>   Head SHA1: d47e3fd2615dbd0aa6eac3745cd209fdd93a868a
corection:   Head SHA1:2ba8778e2b30c114a4c9902c6f3ead2aa2b66f39 

> 
> 
> This rebase was a tricky one.  Sebastian provided some patches and I was too
> dense to figure out where and how to apply them.  My colleague Junxiao did the
> following and I replicated the steps.
> 1) convert the v4.9-rt-rebase branch into a quilt series.
> 2) applied the series to v4.9.327 skipping patches where changes to the random
> number logic has conflicts.
> 3) apply the patches Sebastian provided.
> 4) git quiltimport and pushed it to the above branch.
> 
> It seems to compile and it passes the RT BAT testing Junxiao does.
> 
> As this was a tricky one I request people to give a good look over.
> 
> 
> Enjoy!
> Mark Gross
> 
