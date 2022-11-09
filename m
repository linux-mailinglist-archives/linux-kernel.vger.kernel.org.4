Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8476234A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKIUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKIUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:31:33 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1654303C5;
        Wed,  9 Nov 2022 12:31:32 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5192F735;
        Wed,  9 Nov 2022 20:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5192F735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668025892; bh=YNa+HcURkuPMlpqCKKl1TcMrW9a7MI/BWrDzAjrb70M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H8nnwqv1fkPNEQQQ4gVuuMvJvjFEc8M7JHeUFSYJgsbvg+zva7tct2DdilrVpDVZW
         KmqDTi2YB+Q1OGPjRRMjlK7t3o31y0WhP05gUSwIucMJcYSDzfEUdD7bT8TyM1GJHI
         8nNnMYST6b3g4xqHfcgkcr857A7EUR14hwd87pcyB4PPAuw7v7QKx5xPrRhFTklD/b
         eLeBr7E8uVPpxEincHG543aMTgxVyl9a7p6/gW+MbQZlg36re2+8VIkar3uGEMNyRF
         BCbqiaLoxgiB0+9BIrhG+HdvuqfNNNtvBhgm89idnCXXyICr9aUxuVroCf81xICG/t
         tAm5TAIMnb15g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Subject: Re: [PATCH] docs/ja_JP/howto: Update for v6.1
In-Reply-To: <20221030115209.25924-1-akiyks@gmail.com>
References: <20221030115209.25924-1-akiyks@gmail.com>
Date:   Wed, 09 Nov 2022 13:31:31 -0700
Message-ID: <871qqblvj0.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> Reflect changes made in commits listed below:
>
>   388f9b20f98d ("Documentation/process/howto: Only send regression fixes after -rc1").
>   bc0ef4a7e4c3 ("Doc: Delete reference to the kernel-mentors mailing list")
>   bcd3cf0855c5 ("Doc: Remove outdated info about bugzilla mailing lists")
>   dad051395413 ("Doc: add a missing cross-reference")
>   9799445af124 ("Doc: tidy up TOCs and refs to license-rules.rst")
>   fb0e0ffe7fc8 ("Documentation: bring process docs up to date")
>   e7b4311ebcac ("Replace HTTP links with HTTPS ones: Documentation/process")
>   f1eebe92c265 ("Documentation/HOWTO: adjust external link references")
>   da514157c4f0 ("docs: make reporting-bugs.rst obsolete")
>   cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")
>
> Co-developed-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
> ---
> Brief history of the change:
>
> I (Akira) asked Kosuke of updating ja_JP/howto.rst after the merge of
> his earlier contributions:
>   e0bd6f14c28f ("docs/ja_JP/index: update section title in Japanese")
>   6548e96edb50 ("docs/trans/ja_JP/howto: Don't mention specific kernel versions")
>
> Kosuke made his WIP commits public at:
>     https://github.com/KosukeFujimoto/linux/tree/WIP-docs-ja-jp-howto
>     
> He moved over to other responsibilities soon after and could not make
> them ready for submission. Seeing almost half a year had passed without
> any activity, I took over and assembled those small changes into a single
> patch.
>
> I picked Kosuke's S-o-b from his github commits.
> As I also improved some of translations along the way, I assigned myself
> as the author and added Kosuke's co-developed-by tag.
>     
> Shibata-san, hopefully can you review this update?
>
> Jon, I'll ask you when I feel like this one is ready to be applied.
>
>         Thanks, Akira
> --
>  Documentation/translations/ja_JP/howto.rst | 66 ++++++++++------------
>  1 file changed, 31 insertions(+), 35 deletions(-)

Applied, thanks.

jon
