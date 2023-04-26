Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDCD6EFA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjDZSmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjDZSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:42:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BA7D9C;
        Wed, 26 Apr 2023 11:42:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2BAEF8B2;
        Wed, 26 Apr 2023 18:42:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2BAEF8B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682534566; bh=CKeKX1+7XNw8e7cdzJZHwaKHO4QWwRY4xQrnsdSITnk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IDe8kjL0q8lxpYPlw1a7pJ6YTzUkpRiAU7tUqq1Aekzeq/8qr71L/RLo1tGO6EoYv
         dY3RzplqioxO0gppTZGzMJZRMcUhFs7i8Y/xJ7t9klhvViJdnuBZMdXzMXlB5Hkvxh
         iAmNyNmMlmuhcY8DIVAHK+L8r+BD1C3TC4yKEaj6TZOJcAOxjCnJ9jRkX3NNO3SZi7
         fzjfn6oTvk1UL8FldRkcv/Q38fTLd/8b+FIpUFGqzinXosLBPymhw3MPcX/lsUfH/6
         GgekouEe6gU/ppnQlZwtuVEEfKxaqmdh84FWU9LbB68FA5ONgzMg2Okk35iprONgWU
         1KrGkdLjUo3mA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fabio Fantoni <fantonifabio@tiscali.it>
Cc:     federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabio Fantoni <fantonifabio@tiscali.it>
Subject: Re: [PATCH] doc:it_IT: fix some typos
In-Reply-To: <20230425110158.9755-1-fantonifabio@tiscali.it>
References: <20230425110158.9755-1-fantonifabio@tiscali.it>
Date:   Wed, 26 Apr 2023 12:42:45 -0600
Message-ID: <87o7nah4d6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Fantoni <fantonifabio@tiscali.it> writes:

> Fix of some typos spotted reading documentation in italian and latest
> changes for 6.4
>
> Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>
> ---
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 2 +-
>  Documentation/translations/it_IT/process/deprecated.rst     | 2 +-
>  .../translations/it_IT/process/submitting-patches.rst       | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

jon
