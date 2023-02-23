Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599C6A0154
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjBWC4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjBWC4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:56:45 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7B9B3B226
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:56:42 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31N2ua3a008556;
        Thu, 23 Feb 2023 03:56:36 +0100
Date:   Thu, 23 Feb 2023 03:56:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Vincent Dagonneau <v@vda.io>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y/bV5D8gmG0B7DpN@1wt.eu>
References: <20230223010025.11092-1-v@vda.io>
 <b9df4ad5-0a4a-4061-a645-bda9fc42a874@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9df4ad5-0a4a-4061-a645-bda9fc42a874@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 01:53:06AM +0000, Thomas Weiﬂschuh wrote:
> On Wed, Feb 22, 2023 at 08:00:21PM -0500, Vincent Dagonneau wrote:
> > Hi,
> > 
> > This is version 6 of the patch to add stdint.h to nolibc. Previous
> > versions of this patch are available here:
> > 
> > * v5: https://lore.kernel.org/all/20230220202010.37475-1-v@vda.io/
> > * v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
> > * v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
> > * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
> > * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
> > 
> > This version integrates the feedback from Thomas, removing the limits
> > for ssize_t (not required by the standard) as well as multiple cosmetic
> >   issues.
> 
> Thanks, for the whole series:
> 
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thanks to you both! I'll take care of all this this week-end.

> Note:
> 
> When sending new revisions it makes sense to add reviewers and
> commenters of the previous versions on Cc.
> 
> It makes it easier for them and gives you a faster review or
> Reviewed-by.

Agreed. Overall I find that for his first patchset Vincent has
done a great job ;-)

Cheers,
Willy
