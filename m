Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50392686CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBARTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBARTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:19:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26444A2;
        Wed,  1 Feb 2023 09:19:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E81DB82212;
        Wed,  1 Feb 2023 17:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C690FC433D2;
        Wed,  1 Feb 2023 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675271945;
        bh=ySnn85dryuaJrkf6GRr1nILJViUDApMqGZ1g8Scnqn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOoCoo+skX6cA7kZj+jyZoPCWodH4fJY3XarTHxQ8f9zUccbLxmWCYhaXnymvdEXY
         OMGkZ6VcgBEvyMFHQvqXx12bVB5Pu8oTq8HXJ1dRSS6bYTtUQd0qeZP6PEDld6JnSC
         YYxIScDXWbcqdkl6fhgmuiMhi/g0x3/rPWhkPKVZO0PyGRAqSqoEhYe0+p99F4rRJB
         XCpxV+G8JgMelCkYD2kIjZbDf1HfiOU0qimG3vh0NDh1DbWjk/YFg13R8e5KFU59bc
         ssjLfWx7HT1zGNvwa1RCUfGTf0gwzlOYFBrJ38yrOg1BkfWvxY5cS3NN5B1yS7HaZl
         RnVkk9V6Ze8jQ==
Date:   Wed, 1 Feb 2023 17:19:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the backlight tree
Message-ID: <Y9qfBVBTzLpIRdCx@google.com>
References: <20230127161233.5c21c04f@canb.auug.org.au>
 <Y9OaE6M9CaGYvVZD@google.com>
 <4c625a02-f500-4a49-b5b5-b5de57f5b612@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c625a02-f500-4a49-b5b5-b5de57f5b612@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Feb 2023, Arnd Bergmann wrote:

> On Fri, Jan 27, 2023, at 10:32, Lee Jones wrote:
> > On Fri, 27 Jan 2023, Stephen Rothwell wrote:
> >
> >> Hi all,
> >> 
> >> The following commit is also in the arm-soc tree as a different commit
> >> (but the same patch):
> >> 
> >>   6e9b5cad13f0 ("backlight: Remove pxa tosa support")
> >> 
> >> This ia commit
> >> 
> >>   9041bd1aff23 ("backlight: remove pxa tosa support")
> >> 
> >> in the arm-soc tree.
> >
> > This should be removed from the arm-soc tree.
> 
> I had hoped I was done with the rebases, did one more pass and
> removed this one.

Thanks Arnd.

-- 
Lee Jones [李琼斯]
