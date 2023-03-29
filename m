Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22ED6CF0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjC2RPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjC2RPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:15:13 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BB126;
        Wed, 29 Mar 2023 10:15:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B3AB237E;
        Wed, 29 Mar 2023 17:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B3AB237E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680110112; bh=M41nAelz0FnGebI5ROuNuD79pssF1GT6mHbcCQbxI3k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j+sCFhH/C9k9EuIh6R5bPCpZH3Cq3Qt98THQt/4bcgXMYrAFzV2MEk5mXWJCkRatR
         1ucNin3UnvtX2gY3x/CLBhwOyQIKrJjWUI5JbkNGspGTPZihkvZsJWvXK2oCiKu5Op
         354l/4yOLWhb7A9a3sH+1ZmOFziKgmruLL4qJ+y0cs5L7oHxunizLvegISU9Nwu9ZS
         UtfjblqN6i36ag0XU2j6USNEXqwJRG31txO+3FHQ9+hg242F8Cxaq4yGIwAuiI+7BJ
         rphNEp7mH7hLkyuyYVJAwGD1d7PAvIGbe2MbJRte5Et5XEeUQxC85tMa3cIPps1bcN
         UZwFEXI8j5JZw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mauriciofb@gmail.com, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add translation of process/adding-syscalls
In-Reply-To: <20230315143526.1213813-1-carlos.bilbao@amd.com>
References: <20230315143526.1213813-1-carlos.bilbao@amd.com>
Date:   Wed, 29 Mar 2023 11:15:11 -0600
Message-ID: <87wn2ziin4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Translate Documentation/process/adding-syscalls.rst into Spanish.
>
> Co-developed-by: Mauricio Fuentes <mauriciofb@gmail.com>
> Signed-off-by: Mauricio Fuentes <mauriciofb@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../sp_SP/process/adding-syscalls.rst         | 632 ++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |   1 +
>  2 files changed, 633 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/adding-syscalls.rst

So for whatever reason, I can't get this to apply to docs-next; care to
respin and resend?

While you're at it ...

> + - un puntero a un struc conteniendo un puntero (por ejemplo
> +   ``struct iovec __user *``)

You might want to fix that "struc" typo :)

Thanks,

jon
