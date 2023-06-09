Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E181B729205
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjFIIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbjFIH7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:59:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD84449C;
        Fri,  9 Jun 2023 00:58:41 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9DED8218;
        Fri,  9 Jun 2023 07:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9DED8218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686297519; bh=2EHa8FhMrcu51fRSpi7i1IAQ7GWyQ0qfKe2xhFMGwO8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fCEbLKtxgboAcYHLsFNjqVDS5DRjl+edCxiV2VSyDF2xJ83d2LwicIKaVT+6LNfhI
         q/HkKO1FN79f7TX/O7nItREk/uFaW8H4N5luqeMrfWBd1LpYNJ5NCkQtIut343mC08
         B21x9h1+3zAUJVSPgvMWS3eRTIxqwBxM98qHhzEhv+QTDk6O/74CSysCG1XSwD8tkN
         kI74ibqoBNK1ZTj3uOMbNbrgWFqe4ZKjN79W2men0JOcIDiNmaodjslQeZ1xbHb9WE
         2bkWzHQ4ntQwSY2OuSWJuNDB/ZVmba7W+bErfvjVEovF2yKrdDiN7TS0p9XxoDw4iJ
         v5k2QL9NlFp+A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Stringer <joe@isovalent.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-doc v3] docs/doc-guide: Clarify how to write tables
In-Reply-To: <20230424171850.3612317-1-joe@isovalent.com>
References: <20230424171850.3612317-1-joe@isovalent.com>
Date:   Fri, 09 Jun 2023 01:58:35 -0600
Message-ID: <87mt19oyms.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Stringer <joe@isovalent.com> writes:

> Prior to this commit, the kernel docs writing guide spent over a page
> describing exactly how *not* to write tables into the kernel docs,
> without providing a example about the desired format.
>
> This patch provides a positive example first in the guide so that it's
> harder to miss, then leaves the existing less desirable approach below
> for contributors to follow if they have some stronger justification for
> why to use that approach.
>
> Signed-off-by: Joe Stringer <joe@isovalent.com>
> ---
> v3: Fix grammar mistake
> v2: Simplify recommendation for either simple or grid table syntax
>     Remove example, link to rST user reference
> ---
>  Documentation/doc-guide/sphinx.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

I stumbled across this languishing in my docs folder, sorry ... it's
applied now, thanks.

jon
