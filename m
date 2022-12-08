Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5536473A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLHP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:56:51 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09A55A83
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:56:50 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i186so2144706ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNbwJFAlGhXnPKmcAOIi55uZWbH1qgYvnKQXwakNIPw=;
        b=OtKZsJHp4f/6i/PNOp+PEAVAYiTIdnw5cPT1i0lT8HXk+FreBS0X0s09lUuWX5UNA0
         jxfgch+LuVeS9wqwZokx5t49v24qWFC3SPeJdYm5pmmA8O6O02eKIFzAUDAMmJ3MVxu7
         1emz23Zy66CrUgoPxR7X7/22m0FCRIF6mOd/9QnZpiJw03urdpnmJDXm6zR5VAyNNGM3
         rsSuV5D1JVYsGzZmpcdJl88xbeXK/rJ0obzYaTKU7bEov9dtXUeRFoT15ydvIgMW5ls/
         oONvlTIHLrELe6oRbvd2w/+k64l5Y4VFhpUY6xKnjNjONAmn7RrqIiia90dZDrmN7DEF
         2wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNbwJFAlGhXnPKmcAOIi55uZWbH1qgYvnKQXwakNIPw=;
        b=PKrCnTx7ekdj2dBjLyRs0wuNGjd+62WCzLG+ZpJmOJYC4P42tb4z8j8KUhm56+jb6Z
         r6GWyKAGjYSt2ZSeCHxg4RPPb/pnGllbzIZzGxq7drftbTP0/PCi4zwz//mlfe+SXE8g
         y7nGbOOgFSGWe3KoFVIViDANvncXDCFfLJ7nvOS+hOlpLijvQYttItvq6vky9iZhDMIg
         gDDZusnGVBK1eZuBA2Od4J3vV5MKz3DiNphxCRyoQppE1D2sTS5Af6xM4OrbQlDVS6uy
         Jb2YR1MrxHh7+6iCkHXNBO7MVSmFAmhECskBslxZ8o3OxPhFB3fjaoW4mj9Av/xMm8iz
         I9Dg==
X-Gm-Message-State: ANoB5pm69swAcjkoeKtl2pHaAiY+vd3TkcDnuUUVeZHrOsfWyv/11HYf
        rlvmFPqlDXZPvexWX0QbmlllTpiaEfA4FUqnB7g=
X-Google-Smtp-Source: AA0mqf4t+fSdbhBYMFfnQclz52AAwfcD7MYbIW0Z7LhUtgOT6RcKd/q4AIaKxk8cB+6SC3Hf2NTuTwHMJB1QBthNf58=
X-Received: by 2002:a25:e648:0:b0:6f2:bad:1be7 with SMTP id
 d69-20020a25e648000000b006f20bad1be7mr61909972ybh.84.1670515010175; Thu, 08
 Dec 2022 07:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20221203093700.34608-1-cai.huoqing@linux.dev>
In-Reply-To: <20221203093700.34608-1-cai.huoqing@linux.dev>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 8 Dec 2022 15:56:38 +0000
Message-ID: <CACvgo53VRfHFjffgrr=sNL4Xfvy1m+usymbeP=xx559yzTXymg@mail.gmail.com>
Subject: Re: [PATCH linux-next v2 00/10] drm: Remove some obsolete
 drivers(tdfx, mga, i810, savage, r128, sis, via)
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     tzimmermann@suse.de, Sam Ravnborg <sam@ravnborg.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        Borislav Petkov <bp@suse.de>
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

On Sat, 3 Dec 2022 at 09:45, Cai Huoqing <cai.huoqing@linux.dev> wrote:
>
> Commit 399516ab0fee ("MAINTAINERS: Add a bunch of legacy (UMS) DRM drivers")
> marked these drivers obsolete 7 years ago.

As the author of said patch - calling them obsolete was a bad decision
on my part.
They are effectively orphan with no maintainer and no other driver(s)
that provide the same, or equivalent functionality.

As a DRM newcomer I would recommend sticking to smaller and more
tangible tasks. The TODO list has plenty of varying complexity.

[1] https://www.kernel.org/doc/html/latest/gpu/todo.html
