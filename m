Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359FE64D1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLNVwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNVwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:52:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EDC2EF09
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:52:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50682B81A21
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 21:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24D8C433EF;
        Wed, 14 Dec 2022 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671054748;
        bh=gG2DXUOGTObADyLgpIRItMNng/eOb9njgSqvCaN25a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GO2SXggVq7mMJUXZ45uJm/ONB7E3SqEgS87dg/z2Yy5XIjh6o8oSxDctPCVct9tAd
         3DccvhySVsxRUIm2cfREsWrFNe8OaWYAxyh0PvDGeb2e57KArcf8VUtQYebPM4UDuv
         R+EN8YXM5wSQfj6xTWSWwq2rx7bcQ+ejDwwwSUVrevvlrleuQcCJOpK9cZiL+cYCp7
         slHhavPHpNL0OfgRd44KzeR4AvZa+5S5YsDYo1eRpxepFThFc0qpAjrJeAH3Cyu0bb
         tB7jyn5pXuhJrK2xsZtaKpBHRfvMzKRVc8aT+C7b+8p6Ii/o+fGAWnFTHSBQaSNuzG
         z6YtdLbfenlUw==
Date:   Wed, 14 Dec 2022 13:52:26 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add support for counting time of submit discard
 cmd
Message-ID: <Y5pFmv4AUDxw9GI9@google.com>
References: <Y5jPyEiAtDPx7VSI@google.com>
 <20221214072830.32911-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214072830.32911-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14, Yangtao Li wrote:
> Hi Jaegeuk,
> 
> > I cut off the patches for this merge window. Please consider next release.
> 
> Alright, thanks for your reminder.
> 
> > BTW, could you please send a patch set instead of random posts?
> 
> Most of the patches were noticed when I looked at the code, and they were scattered.
> On the one hand, there is not much relationship between them, so I send patches based
> on the f2fs-dev branch every time. On the other hand, it is also to avoid that a patch
> may not be received and block subsequent patches.
> 
> > It's quite hard to find which one was merged or not.
> 
> Why not to use patchwork to manage patches?
> This tool is used by many kernel subsystems. And This tool has a more friendly
> interface and can mark the status of the patch.
> 
> https://korg.wiki.kernel.org/userdoc/patchwork#adding_patchwork-bot_integration

Good idea. I requested to add f2fs project there. :) Let's see.

> 
> Thx,
> Yangtao
