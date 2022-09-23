Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76FA5E825A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiIWTGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIWTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:06:17 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13217124C06;
        Fri, 23 Sep 2022 12:06:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A7153735;
        Fri, 23 Sep 2022 19:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A7153735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663959976; bh=QCxlk2C203yiZmH3NcY7ljKSsBSBefRBwRjTA6IL/TQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ICp5cAvPkCiRqpGuumh0+rH/JABU12A+n9wQLyG7X7Bs1ur7+B402rlZAh53DfOpn
         5Z82QY3IN9UYrzy2bptcQS2p3Y/BdTGGKvXJC0H7YyrdQIi1pWxArxqGIMVllTxz4b
         b5A7SX/9Kf+fPBPEXx+hrdMx2g9REUoJVNaMM1DetPOKbgxYTJiH/2pw44ojn89YWS
         cFUXdiRVAtPfudHZvaQVDykeD277fwcLAAQZz1d9Wg26HWUoU3xy0iSqizbU8W4xd5
         gKdUkvy4Y42djnkoXbO7TB76cxqmKxT7fdlrgsqaf9QL0jZQGLAgNUs2HjU1qJQz6U
         aMieER5Ny2MtQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt
 into the core-api book
In-Reply-To: <a22ed923-754a-b757-e0ca-87b6d6e6e8d2@infradead.org>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
 <a22ed923-754a-b757-e0ca-87b6d6e6e8d2@infradead.org>
Date:   Fri, 23 Sep 2022 13:06:15 -0600
Message-ID: <874jwx9ahk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> When I look at https://static.lwn.net/kerneldoc/,
> I want to move these 3 from "Other documentation":
> Atomic Types
> Atomic bitops
> Memory Barriers
>
> to "Internal API Manuals", then I saw this patch...
> Maybe I am misunderstanding. Is this patch supposed to move those 3 items
> from Other or not?

*Sigh*  I somehow pushed an intermediate build of the web pages to that
site.  That is fixed now; apologies for the confusion.

Thanks for taking a look,

jon
