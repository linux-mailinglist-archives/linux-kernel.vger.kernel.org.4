Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10186E9654
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjDTNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjDTNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:51:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C135B98;
        Thu, 20 Apr 2023 06:51:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9C5582AE;
        Thu, 20 Apr 2023 13:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9C5582AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681998670; bh=/HYRZYBMpyNaQ4v0vpG/OhEOPSI9xHRsqndtnAocw4E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bhC8AhpYrKjnmG0JnaW5RjTdER8iwG3G9nb9BVcOk0OWAqZvcmFSN+uKIUl12S50F
         9laIZQSjgAjxGM/PVJLj+W/FrOvzr3BH5VVoX87cvtjl4C/vHvyPZrP0HbZvCw90Jp
         WAcl4prNQZpTyHiOsaNNz+mkN6YzzVK6vUYj7wvmFk/NKnKrCnLTe6Slza7Ps8LEZo
         xl2lJ8YHebgy4ADc2T7yNAimxczjySSTobX4BbeTMCtB0F8Jxy3g1HN+ZXgbSQHzgo
         GQuh9SmuyoAesda/zFn2MvfWTvaNk8M1m1C1I5Vfj2Rhthd6wxZIf9AUWsz/XMHVMh
         By7WDlZJoyZxg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Zipeng Zhang <zhangzipeng0@foxmail.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        masahiroy@kernel.org, codeagain@codeagain.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        Zipeng Zhang <zhangzipeng0@foxmail.com>
Subject: Re: [PATCH] Documentation/process/changes: Escape --options to fix
 Sphinx output
In-Reply-To: <tencent_CB1A298D31FD221496FF657CD7EF406E6605@qq.com>
References: <tencent_CB1A298D31FD221496FF657CD7EF406E6605@qq.com>
Date:   Thu, 20 Apr 2023 07:51:09 -0600
Message-ID: <87sfcuu0fm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zipeng Zhang <zhangzipeng0@foxmail.com> writes:

> Add an escape character to resolve the problem of
> "--version" being displayed as "=E2=80=93version".
>
> Without such escaping, -- is rendered as =E2=80=93 (en dash).
>
> Signed-off-by: Zipeng Zhang <zhangzipeng0@foxmail.com>
> ---
>  Documentation/process/changes.rst | 38 +++++++++++++++----------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Thanks for working on improving the documentation!

I understand where you are coming from, but this may be one of those
cases where the readability of the plain-text documentation has to win
out.  Those backslashes are ugly and seem unlikely to be maintained
going forward.

The right solution, if it is possible, is to convince Sphinx to stop
messing with "--" altogether.  Substituting em-dashes is of limited
cosmetic value and, I think, is something we could do without.

Thanks,

jon
