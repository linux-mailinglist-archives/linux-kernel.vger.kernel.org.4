Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52F65FE655
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJNA3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:29:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91F0199895;
        Thu, 13 Oct 2022 17:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72D75B82186;
        Fri, 14 Oct 2022 00:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC082C433B5;
        Fri, 14 Oct 2022 00:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665707373;
        bh=3ZOOxwTScnHw/9MxwoJBOZ7ZaR6jPBbBLZ/pbzofgF4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=tng5R8GHgR90WNDupBkqwCsyC0a50WbLaAcEDjive8KFZukY7KQgYFnDa9QtxWH02
         8+V23OvCz54LOfSxwPAlxqnmPMvRkx+fX/myWyIuCUwUiKH4ND7bQSj/rPQkmBgIvn
         osxIF2a+HMPgOoYymPuENEylRmlAF2lg/AdqEGkJ+iTaDRbte+HmRzgEzkuqF8v6o0
         KSNj44bXdGhFSxWmEGKLQ2MsZKQjv1+jSNN1nnLPOMUSSiDkewkqXRYC7oB0rmg/eR
         BMvj+JJI/6CqEkDshHbFUbFOaZ1AtmPaFKc0klOTatg/IOe3WVfVwIGzxgTmk3MQmY
         xchJKOkVMRqdw==
Date:   Thu, 13 Oct 2022 17:29:31 -0700
From:   Mark Gross <markgross@kernel.org>
To:     Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <Y0ita2SguCALTawM@T470>
References: <165222469651.210737.17409564443317121708@T470>
 <YzwLK9outbQ/oBhv@ada.ifak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzwLK9outbQ/oBhv@ada.ifak-system.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:30:03PM +0200, Alexander Dahl wrote:
> Hei Mark,
> 
> Am Fri, Sep 23, 2022 at 01:03:24PM -0700 schrieb Mark Gross:
> > Hello RT-list!
> > 
> > I'm pleased to announce the 4.9.327-rt197 stable release.
> 
> My MUA shows the identical Message-ID for your mail on 4.9.327-rt197
> as for your mail on 4.9.312-rt193 which you send back on Thu, 12 May
> 2022 17:46:22 -0700:
> 
> <165222469651.210737.17409564443317121708@T470>
> 
> How is this even possible? Maybe some issue with some release script?

my workflow normally creates a new "anounce-rt" file and because this time I
was pushing a -next because of merge conflicts I resued my last anounce-rt file
(Message ID and all) and used "mutt -H announce-rt " to send the message.

I should have been more careful.

Sorry for my laziness.

--mark

> 
> I only notice because mutt marked the second one as duplicate.
I also use mutt.

> 
> Greets
> Alex
> 
> > 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > 
> >   branch: v4.9-rt-next
> >   Head SHA1: d47e3fd2615dbd0aa6eac3745cd209fdd93a868a
> > 
> > 
> > This rebase was a tricky one.  Sebastian provided some patches and I was too
> > dense to figure out where and how to apply them.  My colleague Junxiao did the
> > following and I replicated the steps.
> > 1) convert the v4.9-rt-rebase branch into a quilt series.
> > 2) applied the series to v4.9.327 skipping patches where changes to the random
> > number logic has conflicts.
> > 3) apply the patches Sebastian provided.
> > 4) git quiltimport and pushed it to the above branch.
> > 
> > It seems to compile and it passes the RT BAT testing Junxiao does.
> > 
> > As this was a tricky one I request people to give a good look over.
> > 
> > 
> > Enjoy!
> > Mark Gross
> > 
