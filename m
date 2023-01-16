Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D866CF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjAPSou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjAPSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:44:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F376A3;
        Mon, 16 Jan 2023 10:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F3C610A2;
        Mon, 16 Jan 2023 18:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437E8C433EF;
        Mon, 16 Jan 2023 18:40:51 +0000 (UTC)
Date:   Mon, 16 Jan 2023 18:40:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/30] arm64: cpufeature: Use kstrtobool() instead of
 strtobool()
Message-ID: <Y8WaMDK6lw7cfaZx@arm.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <5a1b329cda34aec67615c0d2fd326eb0d6634bf7.1667336095.git.christophe.jaillet@wanadoo.fr>
 <Y2J0xJ61iclx6WZG@arm.com>
 <c039de1b-0412-320c-8e91-d74ab1ffbc02@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c039de1b-0412-320c-8e91-d74ab1ffbc02@wanadoo.fr>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 02:29:46PM +0100, Christophe JAILLET wrote:
> Le 02/11/2022 à 14:46, Catalin Marinas a écrit :
> > On Tue, Nov 01, 2022 at 10:14:12PM +0100, Christophe JAILLET wrote:
> > > strtobool() is the same as kstrtobool().
> > > However, the latter is more used within the kernel.
> > > 
> > > In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> > > the other function name.
> > > 
> > > While at it, include the corresponding header file (<linux/kstrtox.h>)
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> This has been A-b 2 months ago, and I've just resent patches in this serie
> that have neither been merged in -next, nor A-b or R-b.
> 
> So for this one, it is just a polite reminder. :)
> 
> Do you have visibility on when it should be merged?

When large tree-wide series turn up on the list, there's always a
confusion on how they'd get merged. I guess you are expecting such
patches to go in via individual maintainer trees. It wasn't obvious from
to me (I can now see there was some text in the patch description).

I'll add it to my list for 6.3.

-- 
Catalin
