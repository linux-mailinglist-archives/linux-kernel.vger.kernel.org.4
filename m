Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482476A1522
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBXDBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXDB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:01:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E55BB8D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:01:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE7D061808
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9DAC433EF;
        Fri, 24 Feb 2023 03:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677207687;
        bh=kvfsn2+ZdZM0fqeRRqjBlVABargZmLOk6XdX/QcR5YA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ijfj1uun6qolEZ68l2ZinNG90dUZqt1z+Xq3U2nTZk3ltok4b+qwRnDUoMHuSqa5u
         OtO5aG7ZcbzsE19oXzu9QFOLBUCWTrqGisO5O8NyL7raibILaIqASHY+4aBl4smtHh
         ufl/9b/2v+sQvhKNTsI1VNSx6XsyFSY0idjoKm9I=
Date:   Thu, 23 Feb 2023 19:01:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, joe@perches.com,
        linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: [patch 1/1] submitting-patches.rst: suggest a Link: after
 Reported-by:
Message-Id: <20230223190125.207776ed24553e7608b1a378@linux-foundation.org>
In-Reply-To: <f41176a6-173b-7b20-c287-f49a503fb0f9@gmail.com>
References: <20230224014731.ECB6DC433EF@smtp.kernel.org>
        <f41176a6-173b-7b20-c287-f49a503fb0f9@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 11:59:31 +0900 Akira Yokosawa <akiyks@gmail.com> wrote:

> Hi Andrew,
> 
> On Thu, 23 Feb 2023 17:47:31 -0800, Andrew Morton wrote:
> > It seems to be the new way and I find it super useful.
> > 
> > Cc: Joe Perches <joe@perches.com>
> > Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> JFYI, Jon has just applied a similar patch from Thorsten:
> 
>     https://lore.kernel.org/lkml/87ttzc40y9.fsf@meer.lwn.net/T/#t
> 
>     "Re: [PATCH v1] docs: recommend using Link: whenever using Reported-by:"
> 

Oh, OK, I preferred my version ;)

Whatever, I'll drop this.
