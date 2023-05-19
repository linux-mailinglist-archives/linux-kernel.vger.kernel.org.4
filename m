Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C71709B50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjESP2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjESP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:28:35 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA82106;
        Fri, 19 May 2023 08:28:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 982157C0;
        Fri, 19 May 2023 15:28:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 982157C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684510112; bh=ypzbLdEgSgVU1CkpDITC1d6zG9XwYC1dqvAA2QZn0LY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eDsN4W2vF0m4WFO6UzXjf9b7dm0et8JUuedojt1TFB66cvkW8NWnwXGiNeHIORINN
         0ynYPZeCKF6juv4ZqvzR6Jlq66OSLOB9qIycCy800f5G4PYctWl6UrNTHnGTdpdEpB
         2uGDzKhKQLHUcH7f0Yyrsksb6+pXCXePtK6OfoiMcO3Xzjl+WarNjKB9guR2byflDJ
         oIU17QKrBIOg3Zz4VVrN/LMcMGc9pNSdoI7PU5G7YCMmypgAej4neCCwH/to1xQ+/U
         evy7j6l1RREi31Wh2TvWA+I9RScqc7vyaiQPuNQ2df/laIc8TtjQpfpS8Ftxt8VkUo
         0bzJAmHBazLgQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <code@tyhicks.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Xujun Leng <lengxujun2007@126.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: submitting-patches: Discuss interleaved replies
In-Reply-To: <20230511184131.gonna.399-kees@kernel.org>
References: <20230511184131.gonna.399-kees@kernel.org>
Date:   Fri, 19 May 2023 09:28:31 -0600
Message-ID: <87ttw8mjc0.fsf@meer.lwn.net>
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

Kees Cook <keescook@chromium.org> writes:

> Top-posting has been strongly discouraged in Linux development, but this
> was actually not written anywhere in the common documentation about
> sending patches and replying to reviews. Add a section about trimming
> and interleaved replies.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Rong Tao <rtoax@foxmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Zhangfei Gao <zhangfei.gao@foxmail.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
>  - rewrite 2.Process.rst to be postive and link to new section.
>  - fix typos and phrasing (Thorsten)
>  - add missing "::" for block quotes
>  - add Greg's Ack
> v1: https://lore.kernel.org/lkml/20230510183423.never.877-kees@kernel.org
> ---
>  Documentation/process/2.Process.rst          |  7 +++---
>  Documentation/process/submitting-patches.rst | 25 ++++++++++++++++++++
>  2 files changed, 29 insertions(+), 3 deletions(-)

Applied, thanks.

jon
