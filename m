Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB346380BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKXVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:47:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06070A37
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:47:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2D40B821DD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 21:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D68CC433C1;
        Thu, 24 Nov 2022 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669326418;
        bh=VQhrA4QvkvbVxLz5ExJ5z1Rxw/daXHI5RLFJxB9ahKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1ozBDRZygQ1WMLJFF6VpXPDDavWnzZekkaueVw0i5rerEiN/6tvhCMaYR5lvvOpoP
         REPiSFZJ/okOmuANXvVzPHOWSbcWSIBxkxXtzBcVwSfvPpOR4POhhZdc5dDATEeGWQ
         Zgo5gza6kc4z7BiBqputAd2JbQj2AE8RgQmojoqQ=
Date:   Thu, 24 Nov 2022 13:46:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Rename pmd_to_page() as pmd_pgtable_page()
Message-Id: <20221124134657.0120000e174fa1a9ad292113@linux-foundation.org>
In-Reply-To: <20221124131641.1523772-1-anshuman.khandual@arm.com>
References: <20221124131641.1523772-1-anshuman.khandual@arm.com>
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

On Thu, 24 Nov 2022 18:46:41 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Current pmd_to_page(), which derives the page table page containing the pmd
> address has a very misleading name. The problem being, it sounds similar to
> pmd_page() which derives page embedded in a given pmd entry either for next
> level page or a mapped huge page. Rename it as pmd_pgtable_page() instead.
> 

Is the new name much clearer?

There are a zillion of these little conversion functions in the pagemap
layer, all quite confusing yet we seem to have decided that they are so
plainly obvious that no code commenting is needed.  Sigh.


