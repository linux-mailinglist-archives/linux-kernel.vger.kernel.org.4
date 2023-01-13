Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECADC66A6C7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAMXNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjAMXN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:13:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97065347;
        Fri, 13 Jan 2023 15:13:16 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 188so24140727ybi.9;
        Fri, 13 Jan 2023 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q6fjwFARDZpPxSIIIp1tFOycB9wl1pphbajvby7rx9s=;
        b=n5a3CaKEcj5VYNkID/sozPmUYqTpPAJeD+VL/ZpwAP/hLzaTNm47kX6XjMwYYa5rI+
         Zxl/2B/jyvSg/xiP+T9dw+MMkK/av9LiXPvq0U2FTvI27LLAuM4zog/Asf7rmdJD3RJp
         9xMGAzig24loJnaqcw+yBuQYqrwFkiERy/HYjsEkcd0UFh1mawt2AnMTxUq6AdTIU/5c
         r7q30QM1WD3jhFTidzev453cuwMpZcKrKdE/jKgZNwQ6SOR1hNfQ68gz8fh7+PugjUMo
         Wipl7XEeyS5Y7c3gFxs5RfZ++Pd0Gab575mEr/jg2LdKPUsqNKYsqvc09giFQYRgbVNm
         OC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6fjwFARDZpPxSIIIp1tFOycB9wl1pphbajvby7rx9s=;
        b=ZPuZH6HXiLt8cvpqoXgVQXJdpej9yX0kaicTmTvdSoMgOo7pETNJNmVmCZ0k/mZ7zk
         mu/rA9bvaoo1rAVWkiKnP1MUSCsifh29wpR//0ojaMGIzY3jJEgl0DxJkHIxk8GCLPPY
         GDqRhitLwQrtq/p6V8VS1G9cd2K/DO7dtaHf6ywUiTcJ2hGxZOvFo7tWotrwjOxKmQzm
         EwO/+vgA7WsJbLVeW3u9HF51bjkHwECj14kxwhLp0RGEztbllHC9vSjNNpvs6Mf2HXdx
         YZj+lCiHj3huQsWVYs4RInmfMiT8RLHFooxMwqpHlHs9h9hYGBFoXeSg99d6gPeTKYtb
         Drlw==
X-Gm-Message-State: AFqh2kqoL8FWK+ydjdAflVzu0r7FtVKtIYWxCCRN6JhoqtQIqM9y+ica
        BhGj1BoWH6v1ydf0f7tmpadNh1HpNkatHHJI/bE=
X-Google-Smtp-Source: AMrXdXvoTnn8SvkX6vZq37n4LxAUyWFzoyi5yBE3W0VJpCla3kdj2cETTQMc/PmuTAwpfi51GTfwJM3siTKFcxcg1sI=
X-Received: by 2002:a25:1004:0:b0:712:faac:e6b2 with SMTP id
 4-20020a251004000000b00712faace6b2mr8662761ybq.632.1673651595940; Fri, 13 Jan
 2023 15:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <CANiq72m_+xJYUxrwFc7vNLkuOb6zC-W-wDzXjbPb8Ursqzwiaw@mail.gmail.com>
 <CAK7LNATmRkSU2n6AaeJenE-18gbUd4ZShFNfKysEjyCo4Q-eAA@mail.gmail.com>
In-Reply-To: <CAK7LNATmRkSU2n6AaeJenE-18gbUd4ZShFNfKysEjyCo4Q-eAA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 00:13:04 +0100
Message-ID: <CANiq72=G0P-XZ6Kn2XYFwbSdqG7Yh4f5zgAr-fn+85QJCMRZUA@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs: rust: add paragraph about finding a suitable `libclang`
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Thu, Jan 12, 2023 at 7:05 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Yes, I can take this, but the doc change
> is independent of the rest, and will not conflict with
> any Kbuild changes.
>
> So, you can apply this one to your tree.

The doc change is not fully independent: this patch is first because
the next commit uses the fact that the documentation is written (to
point the user to it), and the commit message mentions this.

Not a big deal, but it would look better if all are in at once.

Cheers,
Miguel
