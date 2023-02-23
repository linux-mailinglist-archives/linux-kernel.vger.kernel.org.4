Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07BC6A00E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjBWBxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjBWBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:53:13 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5CA5E5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:53:11 -0800 (PST)
Date:   Thu, 23 Feb 2023 01:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1677117189; bh=EmqQ91mcbYJIWc4nC8fhMHyVlPDFa7UyaC6JIek+qdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IolI9Hho9X3nu2XEFASu5nFj6ncV86jhVzYzhN8/QSuxzSpr48jqW6Q+vF0jA38J6
         dP83CxNaWtXS/mT5Fsnw8jwCZZ2yHNkZtoAbBuQliU6mi6sG4XmYy57lWCowsbNxdY
         4X3NuYdu3LCIgwsu4yjorKFIYzW3odmoEHvIWA3o=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v6 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <b9df4ad5-0a4a-4061-a645-bda9fc42a874@t-8ch.de>
References: <20230223010025.11092-1-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223010025.11092-1-v@vda.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 08:00:21PM -0500, Vincent Dagonneau wrote:
> Hi,
> 
> This is version 6 of the patch to add stdint.h to nolibc. Previous
> versions of this patch are available here:
> 
> * v5: https://lore.kernel.org/all/20230220202010.37475-1-v@vda.io/
> * v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
> * v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
> * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
> * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
> 
> This version integrates the feedback from Thomas, removing the limits
> for ssize_t (not required by the standard) as well as multiple cosmetic
>   issues.

Thanks, for the whole series:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

Note:

When sending new revisions it makes sense to add reviewers and
commenters of the previous versions on Cc.

It makes it easier for them and gives you a faster review or
Reviewed-by.

> Vincent.
> 
> Vincent Dagonneau (4):
>   tools/nolibc: Adding stdint.h
>   tools/nolibc: Adding integer types and integer limit macros
>   tools/nolibc: Enlarging column width of tests
>   tools/nolibc: Adds tests for the integer limits in stdint.h
> 
>  tools/include/nolibc/Makefile                |   4 +-
>  tools/include/nolibc/std.h                   |  15 +-
>  tools/include/nolibc/stdint.h                |  84 +++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 139 ++++++++++++-------
>  4 files changed, 177 insertions(+), 65 deletions(-)
>  create mode 100644 tools/include/nolibc/stdint.h
> 
> -- 
> 2.39.1
> 
