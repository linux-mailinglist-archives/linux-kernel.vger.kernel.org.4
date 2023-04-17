Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E896E4F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDQRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDQRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E7B763
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A99622E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B32C433EF;
        Mon, 17 Apr 2023 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681753093;
        bh=rEAzyxGybm3t930i3fRtmlmWdxqldW0izPjcd1fyhXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDPGPBYLhFVURdZJHtNWqEZoz/b/uWxvdMZU6cNKQPp2BXmgiR76QTlxID3Ct7Gb/
         2hXJqO5HPI3EgANYE6baDdrpl37sqWFaDJkrqRbUJExa9KHLnre955AYUrVzOva+W/
         M1DoXCX1AV8E/yWGJxigGSt3MdPP0phRyYr18nMzzcJphF2Cz4pkfkCvTqhYxDMhC5
         WhI4A8arggFf6miHB27pYfm9zqJ34XIwpKEKyg2tdXIB7rFzzlbS++IXuJ7tEnIGPm
         z4S+q+BYNjKPoCz+uo5f8/lH02k/3xAKQ3AEdQJL6A130pV3mgTbjIvHpJWV0OEWG7
         NNtbpAaD0oTyg==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correct arg in reclaim_pages()/reclaim_clean_pages_from_list()
Date:   Mon, 17 Apr 2023 17:38:11 +0000
Message-Id: <20230417173811.22303-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417114807.186786-1-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 19:48:07 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Both of them change the arg from page_list to folio_list when convert
> them to use a folio, but not the declaration, let's correct it, also
> move the reclaim_pages() from swap.h to internal.h as it only used
> in mm.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
