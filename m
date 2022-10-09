Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B55F8B4E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJIMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJIMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141562CDDD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 980AC60BFE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 12:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA862C433D6;
        Sun,  9 Oct 2022 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665319387;
        bh=bfA3IYKx0Be92w8PMyPQQIiBQ42NlAAt1mAtmJKrAg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJxgGN3NX/61miSGlo7CrAo8bGt9TAwM8pa4paB+WgHMTwJ9HPRzT4qJS09B6Tjwx
         927o7XIsgMCxmbWA6xOHz7HuhXjqx9XxFxo+5xFpsDell3omt70/JQQ1/+UVwz0M0K
         Od2wCr4UrNQ0gS1+bQ74IU+2PbJdLqZQ9MaYrfR2mzAHiZGSdqwrLHo9N78bukEYJ4
         BGJ8hfLFQKLgF0gHmaIkmuG79gu+4fJdGnYQit5bRr7ixbi7HbbtNfnI57cdlAvBk1
         +fg9wPymkfpVq8kmkLO8Y9AS8tFBH0gmORFIVVeQ5H/znhPXOqcL3UtjTe8sLxNm59
         hgctv+xb19C5Q==
Date:   Sun, 9 Oct 2022 13:43:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Cleo John <waterdev@galaxycrow.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed styling in riscv ucontext header
Message-ID: <Y0LB1oLuVIytgKI/@spud>
References: <20221009120340.GA41243@watet-ms7b87>
 <Y0K7PDzwuOPweYSm@spud>
 <1923489.PYKUYFuaPT@watet-ms7b87>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1923489.PYKUYFuaPT@watet-ms7b87>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 02:38:43PM +0200, Cleo John wrote:
> Hey Connor,
> 
> On Sun, 9. October 2022, 14:14:52 CEST, Conor Dooley wrote:
> > Hey Cleo,
> > 
> > On Sun, Oct 09, 2022 at 02:03:40PM +0200, Cleo John wrote:
> > > Fixed styling in riscv ucontext header
> > 
> > This should probably be "riscv: fix styling..."
> 
> okay yea, I will change this in a second patch.
> 
> > > This patch changes the two comments in ucontext.h by getting them up to
> > > the cody style proposed by torwalds.
> > s/This patch changes/Change
> > 
> > Looks like some typos here too & your lines need to be wrapped at 72
> > characters for commit messages. git usually enforces that automatically
> > when you do a `git commit`.
> I will wrap the lines, but where are the typos if I may ask?
>

"cody style" & s/w/v/ in Linus' name.

> > > In my opinion this also improves the readability so I think this is a
> > > useful change to do. Please also tell me if you have a different opinion.
> > 
> > FYI commentary on the patch should go below the ---.
> will note
> 
> > > Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> > > ---
> > > 
> > >  arch/riscv/include/uapi/asm/ucontext.h | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/uapi/asm/ucontext.h
> > > b/arch/riscv/include/uapi/asm/ucontext.h index 44eb993950e5..0cd6f8616985
> > > 100644
> > > --- a/arch/riscv/include/uapi/asm/ucontext.h
> > > +++ b/arch/riscv/include/uapi/asm/ucontext.h
> > > @@ -18,7 +18,8 @@ struct ucontext {
> > > 
> > >  	/* There's some padding here to allow sigset_t to be expanded in 
> the
> > 
> > Why fix the closing comment but leave the opening ones incorrect?
> > 
> > Thanks,
> > Conor.
> 
> I mixed the code style up with the one in net/ -will fix
> 
> Thanks,
> Cleo.
> 
> > >  	 * future.  Though this is unlikely, other architectures put 
> uc_sigmask
> > >  	 * at the end of this structure and explicitly state it can be
> > > 
> > > -	 * expanded, so we didn't want to box ourselves in here. */
> > > +	 * expanded, so we didn't want to box ourselves in here.
> > > +	 */
> > > 
> > >  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> > >  	/* We can't put uc_sigmask at the end of this structure because we 
> need
> > >  	
> > >  	 * to be able to expand sigcontext in the future.  For example, 
> the
> > > 
> > > @@ -27,7 +28,8 @@ struct ucontext {
> > > 
> > >  	 * ucontext, so we're putting this at the end in order to allow 
> for
> > >  	 * infinite extensibility.  Since we know this will be extended and 
> we
> > >  	 * assume sigset_t won't be extended an extreme amount, we're
> > > 
> > > -	 * prioritizing this. */
> > > +	 * prioritizing this.
> > > +	 */
> > > 
> > >  	struct sigcontext uc_mcontext;
> > >  
> > >  };
> 


