Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ECA60351F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJRVqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJRVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:45:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B886E887;
        Tue, 18 Oct 2022 14:45:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 82A3D2D7;
        Tue, 18 Oct 2022 21:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 82A3D2D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666129546; bh=5qsPLMlRPu3rzGNXOt+yBYYV8YcZ8LrTgIKLcbVlcuQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MgRXBj1zoukRMLWqFZfsDl6HbY4inU2YIGvrWjvA4XBo1ICkFMHu4tkQ654aeXpTZ
         4SsVZz1QxeURXux4p7uTkdNQjwjs6FPQlJsJBoxv/a+n7hsuxuRzieXsKOsFoAOPLu
         s8DxjVQhHQXPEk+2M/NUTakmvyHRBA57TP5o7YFSz9u4j0cQc3JzmGk9xkfIllc1nA
         Qm8jUYSsRJ19nrdU37AIYqA/rrzY4HxmKs8BYCVg/v6Ow32XmYKvQzoJuAUXRSR1vJ
         9wymD9dKYnPtUEH6GI5Vv/fK8FjjAG3wg0xnaBpdDySsrkVQpMbgG5xNiUI1156M1+
         D+aKfFmtWc1Zg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Subject: Re: [PATCH] docs/process/howto: Replace C89 with C11
In-Reply-To: <20221015092201.32099-1-akiyks@gmail.com>
References: <20221015092201.32099-1-akiyks@gmail.com>
Date:   Tue, 18 Oct 2022 15:45:45 -0600
Message-ID: <87k04wdcvq.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> Commit e8c07082a810 ("Kbuild: move to -std=gnu11") updated
> process/programming-language.rst, but failed to update
> process/howto.rst.
>
> Update howto.rst and resolve the inconsistency.
>
> Fixes: e8c07082a810 ("Kbuild: move to -std=gnu11")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
> ---
>  Documentation/process/howto.rst                    | 2 +-
>  Documentation/translations/it_IT/process/howto.rst | 2 +-
>  Documentation/translations/ja_JP/howto.rst         | 2 +-
>  Documentation/translations/ko_KR/howto.rst         | 2 +-
>  Documentation/translations/zh_CN/process/howto.rst | 2 +-
>  Documentation/translations/zh_TW/process/howto.rst | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon
