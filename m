Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40662611048
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ1L7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJ1L7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4FD767B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35375B829B8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B769C433D6;
        Fri, 28 Oct 2022 11:59:38 +0000 (UTC)
Date:   Fri, 28 Oct 2022 12:59:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
Subject: Re: [PATCHv2] mm: introduce NR_BAD_PAGES and track them via kmemleak
Message-ID: <Y1vEJo0d9GkzJY1Q@arm.com>
References: <1663730246-11968-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663730246-11968-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:17:26AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Bad pages could be introduced by extra reference among high order pages or compound
> tail pages which cause the pages failed go back to allocator and leaved as orphan
> pages. Booking them down and tracking them via kmemleak.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As I commented previously, I don't understand what bad pages have to do
with kmemleak. Well, you could argue they are memory leaks but kmemleaks
are about logical (software) errors rather than hardware issues.

-- 
Catalin
