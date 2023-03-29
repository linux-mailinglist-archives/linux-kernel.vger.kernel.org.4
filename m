Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCA6CEFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC2QwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjC2QwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:52:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1794C33;
        Wed, 29 Mar 2023 09:51:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 24C04378;
        Wed, 29 Mar 2023 16:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 24C04378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680108713; bh=3eg3T5+ppWpqlruOz5BEP/AWJEx6stCZC64N06mPlAs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DwIWoJ20E8Ma0vao+1MUUsEe+9gmQ5o6RSNJYpauu3nJfthqV8fv13sYv5QjQ1Ey7
         BURllWR/iFj2oZlULZATPhWf/j2gJup5mGsEOrhlFPsdrGfBvEvJjWDe0Se9Y+vKXT
         TTWYSbueWLGtOT09wkyIt3latv+j6kVoTUSgqTm08OwcM0l+KvLcGzHuyr1jnaVEBc
         np5+dQhGGaX/CICVlef5BdJtd5pyDnhRFhcagGBHANxzT0Gidpy9tzFv7PqR0Lum+G
         OdXQiE7liooF3BIMdhqBXL4hPtalU2Lj20olpTSpMBDRJqAWGwcnrdOH6+pDiB8uVm
         JCeYJDH48rDpQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: translation alignment
In-Reply-To: <20230326130213.28755-1-federico.vaga@vaga.pv.it>
References: <20230326130213.28755-1-federico.vaga@vaga.pv.it>
Date:   Wed, 29 Mar 2023 10:51:52 -0600
Message-ID: <875yajjyaf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Italian translation updated following these changes:
>
> commit 901578a45950 ("docs: recommend using Link: whenever using Reported-by:")"
> commit 775a445d9a63 ("coding-style: fix title of Greg K-H's talk")
> commit 1d2ed9234c85 ("Documentation: process: Document suitability of Proton Mail for kernel development")
> commit 9d0f5cd16744 ("docs: promote the title of process/index.rst")
> commit d4563201f33a ("Documentation: simplify and clarify DCO contribution example language")
> commit e7b4311ebcac ("Replace HTTP links with HTTPS ones: Documentation/process")
> commit 0b02076f9953 ("docs: programming-language: add Rust programming language section")
> commit 38484a1d0c50 ("docs: programming-language: remove mention of the Intel compiler")
> commit b8885e2615f4 ("Documentation: front page: use recommended heading adornments")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../it_IT/core-api/symbol-namespaces.rst      |  3 +-
>  .../it_IT/doc-guide/parse-headers.rst         |  5 +-
>  Documentation/translations/it_IT/index.rst    | 47 +++++++++----------
>  .../translations/it_IT/process/5.Posting.rst  |  7 +--
>  .../it_IT/process/clang-format.rst            |  2 +-
>  .../it_IT/process/coding-style.rst            |  6 +--
>  .../it_IT/process/email-clients.rst           | 25 ++++++++++
>  .../translations/it_IT/process/index.rst      |  1 +
>  .../it_IT/process/maintainer-pgp-guide.rst    |  2 +-
>  .../it_IT/process/programming-language.rst    | 25 ++++++++--
>  .../it_IT/process/submitting-patches.rst      |  4 +-
>  .../process/volatile-considered-harmful.rst   |  4 +-
>  12 files changed, 84 insertions(+), 47 deletions(-)

Applied, thanks.

jon
