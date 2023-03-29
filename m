Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42216CF672
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjC2Wey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC2Wed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2D6A5F;
        Wed, 29 Mar 2023 15:34:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-545ce8e77fcso244145927b3.1;
        Wed, 29 Mar 2023 15:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680129241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4et6HdG1VD2NnaZtQOwB20B3lCP1dqelUY97Vr3DsTc=;
        b=NmC1VuSLoCqWuaLTvqnv/3t5VdAIqk7QHXYwbEvOwfC2U6rQgZr+rgsD2Ni6AbRygC
         gbF+2JeypEwggX9f1oOqCcJDKjODOijLfW0mHGUBek8WfaI602ZxIeT6vG4dXZtYA9K2
         6NKzPZxtIeIOlbEw006ulkBrsmpZt/tfkKl6geWCFqBBnsd4CTnA0b9VuLd/BDXiDpos
         oCbn84/AC0g40l+rCmbBFiUf1CE1eKCtutqLskp7d7M8pJSXLufqIpyZaAz/53+wBASO
         Hbjfu0Ciu26IwNhQzFkYV+olrFbrw6pmuOnlFkGxKl+ZKzfLf4BHjtQLIqj0IbHWPuCU
         9yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680129241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4et6HdG1VD2NnaZtQOwB20B3lCP1dqelUY97Vr3DsTc=;
        b=OTFafiGiBVJhf5C4cSp4gCRcjLxSxFf54cL/Ny7tw2Fye4fMWTawKDNX245pni6ZkD
         i3PBGomjizKZqo+vhOpbtuJuXM97y6Akz6MNf1N9J+8xVe0Aiuvhltg3xhMcP8Pbs4tl
         ix5cEB2IaA0M8xhaOeUafa0a4Jacji4c/lUM4LGGLUkawgJRch8en4h8G4OSXl7IaWKn
         4yciFzWSvr1odqkaKGm8Bn6VLpoU65DzUD7gfwYlwegMMxaKpUw/AC34sTUguZSSpzc4
         Cagb7wty2sOyrBPZqYWvHatInYYdGT9CTkFnV5ut4TDCN/kab6amW9Qnq1Wy/5kiwZU6
         R7oA==
X-Gm-Message-State: AAQBX9fpdU1iKT61oy0XdnHXa/08gFbtsefDKfm4wbgz+idgpWh9UchM
        uc/aJ93ci7po25jnRlwAAlUlD1MepxSYQPYIKqQ=
X-Google-Smtp-Source: AKy350Y8Rz2RRJWrVe+IPbYbpilBV90OV+aKVmS2O6JZGTkN30VJPZJR1m7IkrvlSK/TR4cgrsRMkiXV6Z2k2+GvRhE=
X-Received: by 2002:a81:ae23:0:b0:52e:e095:d840 with SMTP id
 m35-20020a81ae23000000b0052ee095d840mr10509596ywh.0.1680129241495; Wed, 29
 Mar 2023 15:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-1-3900319812da@asahilina.net> <20230329213220.37d9ce85.gary@garyguo.net>
In-Reply-To: <20230329213220.37d9ce85.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 30 Mar 2023 00:33:50 +0200
Message-ID: <CANiq72=u9DgsLtZ-q8+pb6=XMKnj2g=OWJvHyuY9cjbgweh-Rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] rust: error: Rename to_kernel_errno() -> to_errno()
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Thanks Lina for implementing my suggestion.

I will add a `Suggested-by: you` too when I apply this, shout if you
don't want it!

Cheers,
Miguel
