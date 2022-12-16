Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6C64F227
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiLPUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiLPUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:10:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77442DAA1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6296462212
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3139EC433EF;
        Fri, 16 Dec 2022 20:10:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pyCvYBU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671221405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ktjs/XYJi1go8VtnmEFmOIAqaYUG65wLjlO8NnWL9sc=;
        b=pyCvYBU5Xv1tTPEOm46I2qq7CHN/InpB7h34T7NsX8iEEwOnax6LU38KuhLYNNdBEQl5qb
        r816vnMuWBKB+mklbuelXc9ogSWBZI4zEk8GG4fBGOurzz8szj1KuIiG7FyC6cadHnYC3t
        zPYyxSDGMBlglPLD+QGR6V2wbMzMOVk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04b9d900 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Dec 2022 20:10:03 +0000 (UTC)
Date:   Fri, 16 Dec 2022 13:09:53 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] x86/mm for 6.2
Message-ID: <Y5zQkbRm9LhUSsDK@zx2c4.com>
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221213174234.688534-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Dec 13, 2022 at 09:42:34AM -0800, Dave Hansen wrote:
> This includes some new randomization of the per-cpu entry areas from
> Peter Z.  Without it, these areas are a tasty target for attackers.
> The entry code and mappings are especially tricky code and this has
> caused some issues along the way, but they have settled down.
>       x86/mm: Randomize per-cpu entry area

I've got a trivial patch teed up for late in the window that I wanted to
send in after Linus merges this pull. I was wondering whether you were
going to send in another x86/mm pull during the merge window (perhaps
without LAM in it?), or if this whole thing is going to wait for 6.3.
Either way is fine with me, but it'd save me a lot of F5 refreshing if I
knew what to expect.

Jason
