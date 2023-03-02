Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277FF6A88F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCBTF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCBTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:05:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A155193FE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l5qCDWpQ9G8wJhD8YtMAqbLvsYvjfgCmpZrOdQitgqI=; b=KzOVU1Hl4Z+XcRfel4GCZQb/aT
        huWhNxK1qkANyXVFL+abEDd4SNM4iSwRhJQvRnau/zNMVQTYjE6zk1KZ37FKwB22EXiBJZw0Ua8qV
        gVV6GXiTBXFZM6xNSKMiejSl1VUl/WgJAP4idkMVWbv24uBTOZc1QXs6hCsxP4FCiBhD7ibeRA4R7
        jKOo0WvQJGNvr59lNW410CXkiKKIX2gACIMenKz/ZN/eOoVqQIOPIhO640N8Kpi7/PBO6BWa70jrB
        jS9HvsbMAtHp8ToGE6cpAIvPB6+RHPNYcbtn3y3xv1UzL/QVq8eCjjo6CV4lvz6WoeVn7vxjisRRG
        WOP+pcQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXoEU-002b4O-U3; Thu, 02 Mar 2023 19:04:50 +0000
Date:   Thu, 2 Mar 2023 19:04:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] mm: remove cgroup_throttle_swaprate() completely
Message-ID: <ZADzUsW4d+j77jk/@casper.infradead.org>
References: <20230302115835.105364-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302115835.105364-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 07:58:28PM +0800, Kefeng Wang wrote:
> Convert all the caller functions of cgroup_throttle_swaprate() to use
> folios, and use folio_throttle_swaprate(),  which allows us to remove
> cgroup_throttle_swaprate() completely.

For the series:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
