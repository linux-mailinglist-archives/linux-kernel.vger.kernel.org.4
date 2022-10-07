Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B785F7DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJGTWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJGTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:55 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4EAE4D;
        Fri,  7 Oct 2022 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1665170448;
        bh=WSOw/wYZM9nPRhOgiR6PK0gTS1xb4ZHpESGts5kdqzw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=lOV8KdTusafn3Lq6RXI7fFuXucpETkNkOWtsmfoHc7wQftnLQG4o6aFl5EVdZLgQO
         KsQ3t5oG773Bvxvd8qIRb2ppZ7ROL0Sf5Pwp33tmcCbFNnY4Lcrk2fwLBOm37+nCzF
         sPh4443k6gnm0bKkOBsq6NI7b+pCjqXOwYzI9VaA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B12511286FAE;
        Fri,  7 Oct 2022 15:20:48 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C7gAieNRKEC6; Fri,  7 Oct 2022 15:20:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1665170448;
        bh=WSOw/wYZM9nPRhOgiR6PK0gTS1xb4ZHpESGts5kdqzw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=lOV8KdTusafn3Lq6RXI7fFuXucpETkNkOWtsmfoHc7wQftnLQG4o6aFl5EVdZLgQO
         KsQ3t5oG773Bvxvd8qIRb2ppZ7ROL0Sf5Pwp33tmcCbFNnY4Lcrk2fwLBOm37+nCzF
         sPh4443k6gnm0bKkOBsq6NI7b+pCjqXOwYzI9VaA=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1745F1286FAD;
        Fri,  7 Oct 2022 15:20:48 -0400 (EDT)
Message-ID: <8daacf52af60a30c37d74dc6b957c62f5bd3f351.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.0+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Oct 2022 15:20:47 -0400
In-Reply-To: <CAHk-=whAUVVgVQWHig=rK1sw7RhjVENrqXDcKGF_mP8mmU9oFA@mail.gmail.com>
References: <3727e267ba5a03e021ba06e46a97f260dcccc3e7.camel@HansenPartnership.com>
         <CAHk-=whAUVVgVQWHig=rK1sw7RhjVENrqXDcKGF_mP8mmU9oFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 12:17 -0700, Linus Torvalds wrote:
> On Fri, Oct 7, 2022 at 9:16 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > The patch is available here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-
> > misc
> 
> Nope. Nothing there. That's just very old state from July.
> 
> And since the pull request isn't even standard 'git request-pull'
> format, there's no indication of what the top commit *should* be.
> 
> Please fix and re-post a proper pull request,

Hm, yes, that was a screw up and a half: I pushed the wrong tag.

Hang on.

James


