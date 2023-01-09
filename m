Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A26634E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbjAIXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbjAIXPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:15:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D603F464
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD9C8B810A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47880C433F0;
        Mon,  9 Jan 2023 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673306113;
        bh=tyQ2xvMTBFowxzlQRQp8kh7Rofi9QArKOmcBqhi5n6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1FiPfp+ZFUPzoXWaKkF5heaHIxX+pgDw8//YKdOV6h8u6A/rsWOpCkb2WOBFRCoOe
         1C/FTMvLfFhWCp3YKrbTXWfRW4Fyu0BE5n9HqjjEIs2kadMFLWNGn4FZTZoXNY97BS
         MtFqmF69T228h3lkrmXFa8pkNqJNpAlwz6LvGKRs=
Date:   Mon, 9 Jan 2023 15:15:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] mm.h: Fix
 "mm: Add temporary vma iterator versions of vma_merge(), split_vma(), and __split_vma()
Message-Id: <20230109151512.6d06b1d73895414885a698d7@linux-foundation.org>
In-Reply-To: <20230109205300.955019-1-Liam.Howlett@oracle.com>
References: <20230109205300.955019-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 20:53:22 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> The extern definition of __split_vma() was removed too early.  Re-add it
> and remove it once the users are all converted.

I think I sorted this out.

__split_vma() can be made static to mmap.c?
