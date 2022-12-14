Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25464CE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiLNRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiLNRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:05:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41C27FEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMg0PQc/CptyCiVyI2QqrF+gy5xU5hvKC0+ULtCpJI4=; b=qtB2VM6lWBmXcMuWlZvelv2nSx
        8TuD0G6LPQcOX6p3eKtVcFSjzhOBLUVlYlMGW9HkEJKdgy5jUUXTJTatQLaCRQJgkKNtdjxLT+OVr
        79DD/H4BsbNHDbVy9xWUuB5VO3CZxtT6DVfsuhG0+yD77/8SrXuRNqnbLvvnDh38H2i8Ynk9Y962n
        ovt5PtxUA93cad9GtUuCgrj5Ol86nrJmKjbLFJ8m1/uIavfjMUGkxQap7GhHZ5IQ0ZV5xQs9FnBrH
        G18TfdH0ltGymMBxprJr7dlVN18YXb03cG/EWK/sSDla5CYFng9h/hVizFeM/0VSLlNXpIufvt150
        AQ+gYNGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5VBb-00DR1p-Ag; Wed, 14 Dec 2022 17:04:51 +0000
Date:   Wed, 14 Dec 2022 17:04:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     naoya.horiguchi@nec.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Qestion] UCE on pud-sized hugepage lead to kernel panic on
 lts5.10
Message-ID: <Y5oCM6dEewOPymZw@casper.infradead.org>
References: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 09:33:10AM +0800, mawupeng wrote:
> On current arm64 stable 5.10(v5.10.158). If a UCE happnes pud-sized

What's a UCE?
