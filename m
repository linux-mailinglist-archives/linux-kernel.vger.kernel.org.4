Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB10670EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjARAmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjARAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100E5528C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D765CB81A63
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABA1C433D2;
        Wed, 18 Jan 2023 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674001099;
        bh=chNFHUlN28DER9rui9ejEk9u0ZDm3x0bDdM5RgT8GgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R8Y/mkGw+XISglIct6nR4jEjT0GyILnCo/QaoFbW++Ecd4obwKydAU2sHG+3XCSTJ
         D5ft3EWUp2P6ARRQqaGY7yp/Lx11VknmvMNB52lGaQe+B3ATAWNaQkivJcXeG6qpKS
         YOTXG+ydFBGkwM7qNcAgpFdIX460LTZU8kjJPmlg=
Date:   Tue, 17 Jan 2023 16:18:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
Message-Id: <20230117161818.2dba77f3ee9b8709947b58f2@linux-foundation.org>
In-Reply-To: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> done by moving kmemleak stuff to mm/Kconfig.debug.

Are we able to identify which commit caused this regression?

Thanks.
