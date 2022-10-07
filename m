Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2D5F78BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJGNQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJGNQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9FCBFED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 785F961D0B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96DBC433D6;
        Fri,  7 Oct 2022 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148573;
        bh=UB2Z41XKQq+aDykwR9QkpIVEGsdZTMB900AR+oPYcEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSXl1ocwinGvuprFGb7jSMoIdmwB0YlKbG892m+6ou/R7iSAX8Gx9ptlFuniyS4Nw
         JHbOQgvRYjBdkd64K58+pJGaIy28KfBa9/euUncn7F4+j9Y+DexzKIDx8FN7jZwKqk
         7KdENGiHEIT1sKmQQAVyr/AzA3sKLGM4paLPiaeJZiNmNJsj0ZsH1NPtkcB3mo7gGb
         kHyM55Prw/j+w4BdNIq9oTIgG8IOx5yDeLiyud09FNea1c/fFa73FW7N6zckmEbo9W
         V/7IoYypN5ZdsxG5uFfokuj/DJqJLGXCbPmh8MR7PNv0L2aCL8btpjtrmqblimyNPy
         wODhS8ksNoB/A==
Date:   Fri, 7 Oct 2022 14:16:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Backlight for v6.1
Message-ID: <Y0AmmR2NfKc/Y7Mb@google.com>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022, Linus Torvalds wrote:

> On Wed, Oct 5, 2022 at 5:44 AM Lee Jones <lee@kernel.org> wrote:
> >
> >    - Add support for MediaTek MT6370 Backlight
> 
> Hmm. This new driver has a
> 
>         depends on MFD_MT6370
> 
> but there is no such symbol anywhere.
> 
> It turns out the same is true of the MT6370 regulator driver that was
> added during the previous merge window.
> 
> I do see that MFD_MT6370 in linux-next, but I don't see any pull
> request for this, and now that I started looking I do see that we had
> this already in 6.0.
> 
> I do *not* believe that it's ok to randomly take "drivers" that depend
> on functionality that hasn't even been merged yet, and that are
> basically just dead code but hidden away this non-obvious way.
> 
> I've pulled this, but I want to just state that this is bad, bad, bad.
> If it has dependencies that aren't met, it damn well shouldn't be sent
> upstream in a form where upstream can't even build test the thing.

PR satisfying this dependency was submitted the following day:

https://lore.kernel.org/all/Yz6Zi7B2RS16sXhT@google.com/

-- 
Lee Jones [李琼斯]
