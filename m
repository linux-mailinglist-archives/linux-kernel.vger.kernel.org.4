Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD1569AD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBQOL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBQOLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:11:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A46ABED
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gvhxIMGb+GfpdmNDiHw0ab7BkVuDVyTlk7QBWRpxMNg=; b=ZvBWgqcKoPpCtyPgbK1azB55jH
        2Dw0/95tlgFNzXTe0KVz73ZWcLyf2frKWFjcNmH/b0oJEy6WHyXNytDxPlBFkgR9geV9kYgCQKIgH
        r4+lw7+cY1x7Yx4xhIeL7b/sZjxovrkescffPrlIDZhdy72nDXrQx3hlr2s4G2Uxuznx6/Ced9o0B
        jPIJJmS7PtFAYARnVPAFwMlarJqRrzT/VRKTn3Uoanbt0+U8qlLGTmJjwu2s9YfsnXc1pkURMkM53
        dp8irjRiLmzKGw/3yRHyM3Vi7Ib1QzHTtQi9bMM4ZcMb1cbqdJFX1aaHSWcVDf6tqKZY1Jgs+mTPw
        9DNjcrRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT1Rs-009NJp-8N; Fri, 17 Feb 2023 14:10:52 +0000
Date:   Fri, 17 Feb 2023 14:10:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] maple_tree: Remove some unused functions
Message-ID: <Y++K7M+AgvMqrVtV@casper.infradead.org>
References: <20230217084647.50471-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084647.50471-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:46:47PM +0800, Jiapeng Chong wrote:
> These functions are defined in the maple_tree.c file, but not called
> elsewhere, so delete these unused functions.

These are for a feature that hasn't been implemented yet.
They're static inline, so they cost nothing to keep around.
NAK.
