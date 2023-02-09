Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153568FE11
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjBIDnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjBIDnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:43:11 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9A5E1F917
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:43:10 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3193h5qQ008099;
        Thu, 9 Feb 2023 04:43:05 +0100
Date:   Thu, 9 Feb 2023 04:43:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y+RrySeoRJn9GbrI@1wt.eu>
References: <20230209024044.13127-1-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209024044.13127-1-v@vda.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:40:40PM -0500, Vincent Dagonneau wrote:
> Hi,
> 
> This is version 4 of my patch to add stdint.h to nolibc. Previous
> versions of this patch are available here:
> 
> * v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
> * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
> * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
> 
> I tested it successfully on x86_64, as well as i386 and arm on qemu.
> 
> Thank you Willy for the review and the guidance!
> Vincent.

Thanks Vincent. At first glance it looks good. I'll give it a try on
all supported archs to make sure we didn't overlook anything and we'll
merge it. One tiny comment though, look below:

> Vincent Dagonneau (4):
>   tools/nolibc: Adding stdint.h
>   tools/nolibc: Adding integer types and integer limit macros
>   tools/nolibc: Enlarging column width of tests
>   tools/nolibc: Adds tests for the integer limits in stdint.h

I mentioned in the first review that it's generally preferred to use
the imperative form rather than present participle on subject lines.
This would give:

    tools/nolibc: Add stdint.h
    tools/nolibc: Add integer types and integer limit macros
    tools/nolibc: Enlarge column width of tests
    tools/nolibc: Add tests for the integer limits in stdint.h

I can perform this trivial change locally before merging without asking
you to respin a series just for this if that's OK for you. Just let me
know.

Thanks!
Willy
