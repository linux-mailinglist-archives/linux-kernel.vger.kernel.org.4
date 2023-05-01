Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102F6F318D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjEANb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjEANbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:31:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76710DC;
        Mon,  1 May 2023 06:31:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 10E5D31A;
        Mon,  1 May 2023 13:31:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 10E5D31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682947884; bh=/rKIweSHI02rJxXKnCYdSb6MwADDoPC+NZUBY7Y5bEE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OSe4i2M4kNMpT07pSbJ57tVfvfKLRZMNtesEncNfhNHpCfcXdvzhPg2mUoDtkOb95
         YVCWde5tW82mYtCePFEDX9XgxXc3Y4Zj52a8NYu/9l9WbWCaivg0+ui79mUIBlV9qH
         RaudZsd502CPEMkodxacUQh8xJ8S+Q87TxDWL6Xw6tyUL0DVZzkGIVXm8vI5K6QZOR
         oY9HkVuzt9lqcvbu8ZDcOD23xhXrjQdirixd84etbHHCpBB/wFIZKWcazhnmvy4LBi
         zimiSvGT8BDQZvYHle9M+NBBcfPRq4OyL7pl800vFDcqmgVnBsZkDOSrySAb2fEyvb
         2vENeJVZCCRuw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] docs: automatic redirects for moved pages
In-Reply-To: <20230501021338.182770-1-costa.shul@redhat.com>
References: <20230501021338.182770-1-costa.shul@redhat.com>
Date:   Mon, 01 May 2023 07:31:23 -0600
Message-ID: <87lei89o0k.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> Problems:
> - The documentation is not well-organized
> - Relocating pages disrupts external links to
>   the documentation and causes confusion for users
>
> Benefits:
> - Users can easily access relocated pages from external resources
> - Using redirects frees up options for reorganizing the documentation
>
> The solution:
> - To prevent the need for ongoing maintenance, extract renames
>   from git log since specified age
> - Input the renames into sphinx_reredirects module
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
>
> Changes:
> - added the extraction of renames from Git.
>
> ---
>  Documentation/Makefile                |  8 +++++++-
>  Documentation/conf.py                 | 17 ++++++++++++++++-
>  Documentation/sphinx/requirements.txt |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)

So this adds another time-consuming process to the docs build,
generating over 2600 redirects, and breaking the build if it's not done
in a git tree.  All for a problem that still has not actually been
demonstrated to exist.

Costa, I appreciate that you are trying to help, but this is getting
worse, not better.  Please, let's wait until an actual problem arises,
then we can talk about the best way to address it.

Thanks,

jon
