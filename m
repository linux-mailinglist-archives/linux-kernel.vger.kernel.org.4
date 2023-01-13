Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBD669E35
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjAMQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjAMQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:34:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E5820D0;
        Fri, 13 Jan 2023 08:29:25 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 28F6A734;
        Fri, 13 Jan 2023 16:29:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 28F6A734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673627365; bh=ZNRhUjjlgNmkU/RD+ngluE/Vpdur4euGqpGflJgp1LU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mkQUmhrG6T86LUvMxIQCzjPPLxPfaj/0uM8JDbDuPyjkedlTJmWUGSnZNGrK1ABCf
         LcJBp/+55Q73JpypoSQoGY0Dy6yjJDJxdV0ueZHxCvs8g+1RSfK9pqdRmlXPJGAXHO
         uaaL8622LNRCD0lZuJ+PG4lu569oNqZud95CeN2vv12pZTvUTKj10RAjlr5kboNQh+
         NMAFHbpky6wMQa31cqAyOYKd0C/yMQPNR0A0QyHEwS6egQCS4lgQigZON10NAWwzuQ
         RU+kD6UF6QkV9jtwOiIYcNwAeSYSo9vL88tOdn+g7jPqzLhigNaHvkD9nNaC73id6T
         wQjskfTzyvtUA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the jc_docs tree
In-Reply-To: <20230113111102.22a27ae3@canb.auug.org.au>
References: <20230113111102.22a27ae3@canb.auug.org.au>
Date:   Fri, 13 Jan 2023 09:29:24 -0700
Message-ID: <87y1q6qty3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> The following commit is also in the mm-hotfixes tree as a different commit
> (but the same patch):
>
>   ded24dfdddd1 ("Docs/admin-guide/mm/zswap: remove zsmalloc's lack of writeback warning")
>
> (commit 1beb8ae302a0 in the mm-hotfixes tree).

Offending patch removed.

Thanks,

jon
