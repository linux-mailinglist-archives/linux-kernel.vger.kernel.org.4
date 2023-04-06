Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68C6D9FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbjDFS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbjDFS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:27:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A3BAD34;
        Thu,  6 Apr 2023 11:26:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so47157767ybu.8;
        Thu, 06 Apr 2023 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680805616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iHBcWCBEezCxpjKUtj3H1oZtv2uNUGbL/M+axm69yCo=;
        b=qccvgOU1dEgpCacMFpysZZuRBctwb2yBaV5krfvpQGwqlFQTNpjXyk+DrPrAzf6HrE
         7gh4vTQ3aepzO3zcPPAfkvPkE1GukxjbRpAnxhJeGUaxffagmC4oIJnEmn3Hj6spvO92
         KyVoMWY02IVAFBxYC1unpyWPXrohqUp7LMsXc72IH502k+H79FEBN3J3GZXtZXarg2KZ
         9NQeiPpsEXV49dDgVfjsOuti0pzAgx5kAxUJ+Xgc89uMhRIEx1nkZERcy3yzTMKb7L6B
         WCGfai9EUg35VR8aSflOPLGmorb6ksKroudnLqKNRd5mP1n986VViAw50t0nVLjPWRSu
         ze6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHBcWCBEezCxpjKUtj3H1oZtv2uNUGbL/M+axm69yCo=;
        b=VZWKX9yGJ5TuLV7NRHvDOXFRYI2ePSdT9McMt++PpOh7q3HriH9QghRYoaAnMplUrZ
         JBCDRl4ha4mwU9MNQ1zqC//4mxrU61ggOizIUpC4rqa3bQksk7XwEozEhtdUbRJ8Yf1E
         GiK0PCI3ZX6e0OVtGMGpkcQFjbguyMFFTaJHNUR1XT/x00x+X4m3n1yUnjMU1yNGaOg4
         EAbF12rBZY8N2sj5zgB4rO2C7oISC2LP45AuDGMkpcI3V/ffYKLkua2eLMcAEA7T9BnH
         FOk3I4DJx1J1p78A+crP1CUDdqM3FX+552vNhFqcepspfrODZNyZN2S9TmdiYO42c45D
         WZww==
X-Gm-Message-State: AAQBX9f4fpv+aG5T2OIU9DPAIBGwqbM3aa/Cl6f0av36Z7DLIzLfa6Ey
        8QvV4eZFEphNdTanRuG67b7UfZCmRpuvYqv1KUQ=
X-Google-Smtp-Source: AKy350YUcNuZ9sKwCppNWDnT95OSPxh1dOTPG9d/r34oqKOvx4+uhd6QdvFwWkQwWkmr2xagSuBcnOEtHR7bAt3WOU0=
X-Received: by 2002:a25:7390:0:b0:b6e:d788:eba4 with SMTP id
 o138-20020a257390000000b00b6ed788eba4mr57282ybc.6.1680805615758; Thu, 06 Apr
 2023 11:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
 <20230405201416.395840-3-daniel.almeida@collabora.com> <c2ebdc61-6aff-ab64-a0cb-e2170edfa689@gmail.com>
In-Reply-To: <c2ebdc61-6aff-ab64-a0cb-e2170edfa689@gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 6 Apr 2023 15:26:48 -0300
Message-ID: <CANeycqrG-t56KHJta1UTc9d8OHGvRnmjdW1g2swfkX5feaXoQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: virtio: add virtio support
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 at 11:22, Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 4/5/23 17:14, Daniel Almeida wrote:
> > This patch adds virtIO support to the rust crate. This includes the
> > capability to create a virtIO driver (through the module_virtio_driver
> > macro and the respective Driver trait) as well as initial virtqueue
> > support.
> >
> > A sample virtIO module is included for conveninence.
> >
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > ---
> >  rust/bindings/bindings_helper.h |   3 +
> >  rust/helpers.c                  |  25 +++
> >  rust/kernel/lib.rs              |   2 +
> >  rust/kernel/virtio.rs           | 261 ++++++++++++++++++++++++++++++++
> >  rust/kernel/virtio/virtqueue.rs | 126 +++++++++++++++
> >  samples/rust/Kconfig            |  10 ++
> >  samples/rust/Makefile           |   1 +
> >  samples/rust/rust_virtio.rs     | 195 ++++++++++++++++++++++++
> >  8 files changed, 623 insertions(+)
> >  create mode 100644 rust/kernel/virtio.rs
> >  create mode 100644 rust/kernel/virtio/virtqueue.rs
> >  create mode 100644 samples/rust/rust_virtio.rs
>
> IMO this should be split further. If I were to suggest I'd say to do it
> as following.
>
> - virtio bindings
> - virtqueue bindings
> - sample virtio module
>
> This way the size of each commit would be more amenable to reviews.

Yes, I agree with Martin's suggestion.

Daniel, please split this further.

Cheers,
-Wedson
