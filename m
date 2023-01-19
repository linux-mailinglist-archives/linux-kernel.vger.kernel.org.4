Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9820F674287
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjASTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjASTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:14:29 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057BF485B6;
        Thu, 19 Jan 2023 11:13:09 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id a9so3864049ybb.3;
        Thu, 19 Jan 2023 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f66M40S9HUafYr8hVajn8DVAsyr9TRcLXW/GMSQFYTg=;
        b=TfdQOo0L5L7tRei4gTZQorDhEqkwLnIcUwjUkQ5nAUhG3adcGnD6aApx5mVazXjz8G
         BKhASFxhlmU79yGq2yYeB7ddF5FQzvqefzN90g3fCYjYV/9sFaZ0LDQ3hJo2xA6cu2GN
         lld1fXQg5qPS2DBEMwaxNTCpjmFZcbBeKU49OPbifSyy2uMi1ixSRTiydAInHXYJKKzE
         wvBavFk9xhLq2N00xTLR41SV4jXSPGVygDS47MqvDluRTjxkeRN0CfD1LQeH9FKLjLpZ
         dkLR7EexO2NPd68tPR7TjSKVS1btSYjLdr1QXKL8PGFhIoS9WrTU13eWGZ+1Yu/ekS5D
         t3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f66M40S9HUafYr8hVajn8DVAsyr9TRcLXW/GMSQFYTg=;
        b=3vWHd0KoPm0MXsBIRCgfb3mkYgcUEOr625g5xgNlXEQPUUpolnvyzZQB5F6LhU9Hcy
         iBs4Zh0G0jbw5FwTXUD/Nbm/gLwVXREV1kqP+PtSqr/ZARGc5nO9MPsvtOT0RDVAzcga
         p1katRQkK31f86P8N+YNe340dA1TDnMM5nopJzYwI8P8YPizA+Y7EpXoNSB6XmNjJ8md
         aEG1Ad0e0GytlAlX4VK8ewSg3bEBxkpofE6x6Ra0adLzzFUFpGk2YPta72qKCBqmCgcg
         B9468zNb3SXo0VhB32IvoDSN8XHHZiPP/0duluKqbkUJ5iyL3iwAQ9fiYL+bNhty96CV
         E1Og==
X-Gm-Message-State: AFqh2krxkatH1mlK3u/CfOWLzKa7pTa8SitdRCPV1qtDcLMo0nPo0EtV
        SBUOm1ECmQZxwaukG7PnBTEm5iLBK57auHzB9GWcm0bvlc3w/SjGZ4M=
X-Google-Smtp-Source: AMrXdXumWEsfO8yQUnD942SmOi0Y3bznUxHvZmVpHNlFlXQoQITYE3p8CLDqSTQjynmP8x3QEbD3SlTm3TDvC5kC0xs=
X-Received: by 2002:a5b:688:0:b0:7e1:ed59:4e43 with SMTP id
 j8-20020a5b0688000000b007e1ed594e43mr1580106ybq.323.1674155587313; Thu, 19
 Jan 2023 11:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20230118160220.776302-1-varmavinaym@gmail.com>
In-Reply-To: <20230118160220.776302-1-varmavinaym@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 19 Jan 2023 20:12:56 +0100
Message-ID: <CANiq72m66PbmDmGUoQecOzJRSFg+G+3KKGkkqS3ySNAPxCe1Ag@mail.gmail.com>
Subject: Re: [PATCH] scripts: `make rust-analyzer` for out-of-tree modules
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 5:02 PM Vinay Varma <varmavinaym@gmail.com> wrote:
>
> Adds support for out-of-tree rust modules to use the `rust-analyzer`
> make target to generate the rust-project.json file.

Thanks for sending this! A few nits below...

> When this parameter is passed, I have chosen
> not to add the non-core modules (samples and drivers) into the result
> since these are not expected to be used in third party modules.

Sounds good to me.

> changes are also made to the Makefile and rust/Makefile allowing the
> `rust-analyzer` target to be used for out-of-tree modules as well.
>
> Signed-off-by: Vinay Varma <varmavinaym@gmail.com>

A `Link: ` to the GitHub PR would be nice here:
https://github.com/Rust-for-Linux/linux/pull/914.

Possibly another one to the out-of-tree approach at
https://github.com/Rust-for-Linux/rust-out-of-tree-module/pull/2.

>  import logging
>  import pathlib
>  import sys
> +import os

Please keep the `import`s sorted.

> -    for folder in ("samples", "drivers"):
> +    extra_src_dirs = ["samples", "drivers"] if external_src is None else [external_src]

If you send a v2 for the above, this could be a tuple like in the
original line, to minimize the diff.

> +            if os.path.exists(path.parent / "Makefile") and f"{name}.o" not in open(path.parent / "Makefile").read():

In Python one would typically go with the EAFP style instead
(https://docs.python.org/3/glossary.html#term-EAFP), which would also
reduce the duplication of the path computation. But it would take more
lines... Not a big deal in any case.

Thanks!

Cheers,
Miguel
