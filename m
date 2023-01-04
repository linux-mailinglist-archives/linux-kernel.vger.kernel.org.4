Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429D965CBB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjADB4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjADB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:56:11 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0F178A2;
        Tue,  3 Jan 2023 17:56:10 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id t15so35080496ybq.4;
        Tue, 03 Jan 2023 17:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4wOmTH7AdBL4iuOzbwjUMBRytNfhWEyWPFeK4sWBy4=;
        b=cKbWf6w24QFBgI1EnWW1sqJLqUmNNKOe5fdQS52IiG+HlxVu21dtgYAQz25SYKQt67
         5y7xctc3LUwSQWoWvO4NTRT1p1yH2pJyQTNZugd6YPnFfN89F+FKAJrV52qhoEsGLSbc
         9avlrOQgjWz3tI8Vxr9Xk4V1QbyHIHr5SC8KiEU0Sp0lJ3co64y/eTcrKICX+nNh3AHD
         NtY5HWdQeF/R+fbOtEBRt+7SbdCiSg0oXEKdqHQA7GY5LCS5Or8dRu1ZlU1obZsoHRBi
         AhcesjMJLsprvMduauH4uMAW3jjLeVdcd507heZFLGDlbbE/zNV7GyVVoL8NV7KzBMe7
         x9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4wOmTH7AdBL4iuOzbwjUMBRytNfhWEyWPFeK4sWBy4=;
        b=wHui8zbYgxJBWUHTcnQ/FBlBCIKTbOK2B28c+7egwqERTOrxezYOwNuF2aL3jLEcfV
         zLmIz1mhQQq/koo2Q1Ph2my4+PwkNE9P0tPrf6hb4kmgATBsI+k3XAKGfDE9KVRlXLmy
         OG27hOA20Wj37vL59TNEbusUuy1zdMixR6tzZuKskUsHHhNvGcRPLp4AMNZg771KHlVd
         YYQt5msm935yyVqD9tR7HTD2QbLkmTa6BxUa4h5FpniNH2HPYHLcP7Zk++oEzAPlBIjl
         e3Y7KLo7zlmr9OL2SLkXgOonRSwya9hAnn9pIpHXCBdUDrJVNptKBKX8SEKAR66+nxuj
         WOGA==
X-Gm-Message-State: AFqh2kpLUe1yn3OYkJnP7JubmKjDiJrZAfCGO8lH8VsnKcB8QyscrYWs
        ruajVn3kPXLh6b2V7FMUO013DCbn5L/2Zyn52Ew=
X-Google-Smtp-Source: AMrXdXt4GnqdkyJnjP8zMXH7iI+c+15e0+LPvhTq1mbGSgQzKC0W+H2/9Zu8ROxMsaOHO++Oeb/fRvRxQc9KuE8d6O8=
X-Received: by 2002:a25:e6c1:0:b0:761:d9ec:328f with SMTP id
 d184-20020a25e6c1000000b00761d9ec328fmr4371243ybh.507.1672797370167; Tue, 03
 Jan 2023 17:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com> <87wn64fq7d.fsf@meer.lwn.net>
 <CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com> <87h6x7cfiy.fsf@meer.lwn.net>
In-Reply-To: <87h6x7cfiy.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Jan 2023 02:55:59 +0100
Message-ID: <CANiq72n3qnWwDjp0E1xY1m15qhMHz8_AXcL9hstVM8Xwfi=pbw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org
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

On Wed, Jan 4, 2023 at 1:25 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Does it really need objtool?

No, it does not. That is a byproduct of using the `prepare` target to
setup Rust for the descend, but we could rearrange some things for
`rustdoc`.

> A certain amount of extra building is OK as long as it doesn't radically
> slow down the (already glacial) docs build.  I'd like it to not *break*
> the docs build if the right dependencies aren't there, though.

I agree if we go with a fixed/preset/configless approach, because in
that case we will always have `CONFIG_RUST=y` and therefore the
generation of Rust docs is really just an attempt that may or may not
fail (or we could only attempt to do so if the dependencies are met
exactly as expected).

On the other hand, if we went with the current setup, where a config
is used, then if the user has specified `CONFIG_RUST=y`, I think it is
fair to fail, since the operation cannot be completed, just like the
normal build. Of course, we could also do the "just attempt it"
approach and print a loud message if it failed, but I think, as a
user, would still prefer as a user if it just failed.

> It seems like that step should fail regardless, not just for the docs
> build, no?

The bindgen step should fail the same way for both normal builds and
docs, indeed.

I think I understand now what you meant by "fail more gracefully". I
thought you meant fail with a better/proper message given versioning
information or similar, but you primarily meant avoid breaking the
entire docs build if the Rust part fails, right?

Cheers,
Miguel
