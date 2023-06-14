Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FEA73072F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjFNSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFNSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:13:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0E2117
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dNBgOI/bOg8KX2RNQkTjlQVebRawMr4GVeAJsfvncwY=; b=PZ+aih2TZTskcZMZ+ukSevCVgQ
        aVWEEu4H77BEZ/MMkRe1F/qsAnmLjl4CCzqV4Os4asN3GZPKBCBhKvx/04QdtR/x5LZoZPV8siciO
        9kotjZzA2T7w4orhQAbOm1RYokq8fWmvLqulOqAgdGLkyAckq3EoQKWQ3/UiS2gLGCW1is62gAhGf
        2TDKsf96uFKAfc882+kET3ACyYlHEWY6p5M+CYpDBZc1TX2Q3z3i1jmKppi4cykmvEm8X0HryKDBr
        +5GbWPeqtp56ndUPlrElNmpWYz4SuhoZlpCaRLclImyI88G6KlE+nh46/KI81pYerKefA79eTSflv
        eR6b5pyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9UzK-006d4H-6T; Wed, 14 Jun 2023 18:12:58 +0000
Date:   Wed, 14 Jun 2023 19:12:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hexingwei001@208suo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_io: Prefer 'unsigned int' to bare use of
 'unsigned'
Message-ID: <ZIoDKqBt2uNSbblB@casper.infradead.org>
References: <20230614071804.13110-1-panzhiai@cdjrlc.com>
 <1e132a6416d673e285af610ff185fa5f@208suo.com>
 <20230614110923.b5ac015ac6e9a2d97f3b40c3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614110923.b5ac015ac6e9a2d97f3b40c3@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:09:23AM -0700, Andrew Morton wrote:
> On Wed, 14 Jun 2023 15:23:44 +0800 hexingwei001@208suo.com wrote:

All the patches from 208suo.com should be discarded.  From conversations
I've seen elsewhere, they aren't compile tested, they're whitespace
damaged and often they're just wrong.

<x> has anyone seen 208suo.com patches?
<x> so far all I've seen are either utterly wrong or won't even compile
<x> and a bunch of different email addresses/names from that domain, but all the patches coming at around the same time? it's very weird
<x> and also all the same kind of patches
<x> "remove unneeded variable" - per coccicheck, which is just not smart enough about the macro constructions
<x> and of course 20 minutes after I ask them to stop, they send another broken patch
