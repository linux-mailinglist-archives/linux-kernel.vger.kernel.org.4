Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3824679D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjAXPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjAXPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:11:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD34949975
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:11:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21B1F4B3;
        Tue, 24 Jan 2023 07:12:14 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FE4F3F5A1;
        Tue, 24 Jan 2023 07:11:30 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:11:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [GIT PULL] cacheinfo/arch_topology: Updates for v6.3
Message-ID: <20230124151128.4d57tpkuahaw2kex@bogus>
References: <20230120121856.1407369-1-sudeep.holla@arm.com>
 <CAMuHMdUZzLkWvhQ=YeH2KfQ_FRidemfOvbbHf_b1AHROK9HFNA@mail.gmail.com>
 <20230124144245.ddphvqbcxpzrlgek@bogus>
 <Y8/xJZOourqBvxVR@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/xJZOourqBvxVR@wendy>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:54:29PM +0000, Conor Dooley wrote:
> On Tue, Jan 24, 2023 at 02:42:45PM +0000, Sudeep Holla wrote:
> > On Tue, Jan 24, 2023 at 02:44:10PM +0100, Geert Uytterhoeven wrote:
> > > Hi Sudeep,
> > > 
> > > On Fri, Jan 20, 2023 at 1:22 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > It has been tested on RISC-V which is the main users outside of arm64.
> > > 
> > > Has it?
> > >
> > 
> > Hmm, I might have mixed up things then. I was on a vacation for quite some
> > time and might have assumed Conor response on the thread with testing.
> > Extremely sorry for that. However it was in -next for few days before
> > Greg applied to his tree.
> 
> Sorry chief! The CI stuff we run on the RISC-V patchwork only provides
> build coverage etc & my CI against linux-next doesn't check for this kind
> of thing.

No worries, it was holiday hang over from my side. I did check and repond
to the other thread during holiday and then mixed up things, my bad.
Sorry for that.

> I'll put it on my todo-list to add that, both for patchwork and in our
> internal CI.

Thanks.

> I only reviewed the patch that was moving the code to common group and
> not the others unfortunately. Next time I'll be sure to review the lot!
>

Also I really hope we don't have to change this much but who knows. I
thought so few years back yet we are changing it so much in the recent
days. Hope that will enter quiescent state soon ;) yet again.

--
Regards,
Sudeep
