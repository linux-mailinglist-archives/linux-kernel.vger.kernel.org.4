Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29A601A82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJQUnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Oct 2022 16:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJQUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:43:13 -0400
Received: from ouvsmtp1.octopuce.fr (ouvsmtp1.octopuce.fr [194.36.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120877E89;
        Mon, 17 Oct 2022 13:41:10 -0700 (PDT)
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
        by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id 271301431;
        Mon, 17 Oct 2022 22:39:42 +0200 (CEST)
Received: from sm.ouvaton.coop (ouvadm.octopuce.fr [194.36.166.2])
        by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id E7C8B5E28B9;
        Mon, 17 Oct 2022 22:39:41 +0200 (CEST)
MIME-Version: 1.0
Date:   Mon, 17 Oct 2022 20:39:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
From:   "Yann Droneaud" <ydroneaud@opteya.com>
Message-ID: <e50884573b0f88ebd1f5b495476c13f28a5f0aa2@opteya.com>
Subject: Re: [PATCH] random: use rejection sampling for uniform bounded
 random integers
To:     "Eric Biggers" <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        sneves@dei.uc.pt
In-Reply-To: <Y02ehdiCtHyLErB8@sol.localdomain>
References: <Y02ehdiCtHyLErB8@sol.localdomain>
 <20221017023752.3907-1-Jason@zx2c4.com>
X-Originating-IP: 10.0.20.16
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

17 octobre 2022 à 20:27 "Eric Biggers" a écrit:
> On Sun, Oct 16, 2022 at 08:37:53PM -0600, Jason A. Donenfeld wrote:
> 
> > 
> > In order to be efficient, we implement a kernel-specific variant of
> >  Daniel Lemire's algorithm from "Fast Random Integer Generation in an
> >  Interval", linked below. The kernel's variant takes advantage of
> >  constant folding to avoid divisions entirely in the vast majority of
> >  cases, works on both 32-bit and 64-bit architectures, and requests a
> >  minimal amount of bytes from the RNG.
> >  
> >  Link: https://arxiv.org/pdf/1805.10941.pdf
> > 
> 

> Thanks for doing this! Your code looks correct, but it was hard for me to
> understand until I read the paper that is linked to. 

Other algorithms exists that might be easier to understand before the Lemire’s one.
M.E. O’Neil has written a long blog post on many possible alternatives.

https://www.pcg-random.org/posts/bounded-rands.html

Regards.

—- 
Yann Droneaud
OPTEYA
