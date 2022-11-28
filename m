Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABD63B3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiK1VHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiK1VHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:07:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E92FC12;
        Mon, 28 Nov 2022 13:06:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k206so13685485ybk.5;
        Mon, 28 Nov 2022 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itftzGt93b0OeDPCi2gURk631oNyukZV1ceD7NGGpvs=;
        b=pLW0FCAbKb8mEawmOWM1APJCPJUuTuZR9hX1gf0Ekcjy6ofSL9NjiE9axeW98tTVZJ
         MLov5byEXqDfAQoFnV/ha6psjIa+chvC+wCtCLwCvIqBijOKokUhQ5k/Xz7hLD3c1o2z
         Hhi6zqluCRcqK1hwAbT2Z5AYV0MnJeZtujWBxEXbSKgkf0W6ihwTNQ20l4Krk+y9edWx
         p5CLHmhNl6KVCb1D03kflFk/kB933PWMciyPXuRRc12Et+mwwW1wpb2A69UqTQ72aL11
         k7fVV5h0Q56ijPjNmemPOKJA/yCVPK+Nl7LWneHInf/zJKzOAkq6VZZvoE+/YIEfJZ8e
         7F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itftzGt93b0OeDPCi2gURk631oNyukZV1ceD7NGGpvs=;
        b=nsaxgHj1m2Lfzk2xPRyBtOWs9se9j+RYj1ax88T4IOB5CoBGsrgHJ27ge90yu78Gad
         0IgCP6Oct+vctE3eGncnBDabw+1r2bVBVWifNiCDYUt9Lod+buyUGFFdiM3HnTvmjW97
         UqAoXj/fHReWgjF0yhFOCpMGog0Di0kuqmWyntqSAVtuSq+zGXWJ3HXwYSPzn+TJuI5r
         TbcYgw4xLhJZFamLG/yGMk7OqcG4uDta29reJX65J9qPmX1RL5KeuBeIsoyAvfcKnpGE
         osNKKUkRhP0qezk61gjBt6tsTEeh2VAPfEsUltE796JQu2SMH3dUsgtQvr7WOsHC9yew
         pnKA==
X-Gm-Message-State: ANoB5pk2SuD9bwCLFJyGJ9pMuz5qRL8a0XT4ZrK0ISh7WdO0WHi/uMnz
        r8/Y8s8efHyOue22Q6B1fyLf/F7+f6PBADGhWzpDwJcFThAL/A==
X-Google-Smtp-Source: AA0mqf7uNiMFNSUwfnxqjraK65Yplm6CcnRpl46qkh5m0PAatmT8z+Ai+ZjCJbLHghRi0rJcqhmQ7Ycdy8bTcteIwtA=
X-Received: by 2002:a25:44c5:0:b0:6cb:16d0:1ae1 with SMTP id
 r188-20020a2544c5000000b006cb16d01ae1mr31215823yba.581.1669669604007; Mon, 28
 Nov 2022 13:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20221128201932.168313-1-carlos.bilbao@amd.com>
In-Reply-To: <20221128201932.168313-1-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 28 Nov 2022 22:06:32 +0100
Message-ID: <CANiq72md-b75NQ2o7mDuGwK4JaPunrN36GZ2vUDm_yK+yocFtQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Integrate rustdoc-generated output to Rust docs
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Mon, Nov 28, 2022 at 9:19 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> Include HTML output generated from rustdoc into the Linux kernel
> documentation on Rust. Add Makefile target `make htmlrust` to combine
> make htmldocs and the generation of Rust documentation.

I think Konstantin (Cc'ing him) wanted us to integrate this into
`htmldocs`, rather than having a new target. That is, if `CONFIG_RUST`
is enabled, call the `rustdoc` target there.

In any case, I will also comment on this approach below. Thanks for this!

> +ifdef CONFIG_RUST
> +htmlrust:
> +       @make rustavailable

Why was this needed?

> +       @make LLVM=1 rustdoc
> +       @cp -r rust/doc/* Documentation/output/

We should change `rustdoc` to generate the docs directly in the right
place now that we have one.

Cheers,
Miguel
