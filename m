Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70BB6DCDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDJWzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:55:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B702B1FE2;
        Mon, 10 Apr 2023 15:55:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h198so12723122ybg.12;
        Mon, 10 Apr 2023 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681167309; x=1683759309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZMGcCTlE+zHI0tSBZIhG1RUtOrAXSPTg9DRTosSr84=;
        b=V3AWAMswbv3KXy6gRUE5e6i77GX2Q+KHI2CeJXconURp7tnipLoUMF58wfer5mZ17Y
         J0VlEPLxrm4P7JMb2jf2LRYsweR1vII1OMHBAIsV/m21CWfMtnhyeBi+nmysrBGAmxkM
         kfXA7lG2HLxrIo3C3GZhvLaFkFUAF+J9NMl3ACDvClw4ox1ahgrmi88q26dyoFrqgyxY
         KXM8Nqyw/R1AcSiAlaWbP9gc7NciM3gsYxJqH85E5qY5pi/3b6v8OBIedR4W4eOYkfUZ
         jPbpkcYr2fvh0q5EQ78E2aZnFDWdKKoNRUqVfbg3fluu+6hLm5YAYxtBAr88exiruGYj
         hQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167309; x=1683759309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZMGcCTlE+zHI0tSBZIhG1RUtOrAXSPTg9DRTosSr84=;
        b=xJiYqxJzZYsbuL8jFHXUg/QSHjHUUbPuvlnFhjQW8zSWNBN3lA13iG0p0kLEq+mxUS
         m6qG/HOQD3CUlk0STb+LD9Iljs54025zySRTgUDPhbDgL3VqIlBwpOuw/U2nF4gCy+hG
         VkHQ6QQoERVdLOPfhei3zQUGEyLjWKl1CdM+HGBdivwIK/9SYq3sAFYulHtV+neg7ma4
         BDwvr2joVY4Zqfs/4fgD6mvlqX6rTnvJblMXObOYi14ACDvkxEypoi+//QhCG675obmt
         PX5Sv4ZPFyVF2WT3Sb04DJ6v1dsNllRLKG2v6lAseNPzgNvtDtoQUyt2r0ygbEntuYOR
         NWxg==
X-Gm-Message-State: AAQBX9fd54kalQPcJT9RYvTK1+OEd16HdB6vRkmHKZgRI6LZHLXRbBvD
        GkT1IOODpvdmx8vDNCuehwfWvnhpFEphA0F5fCw=
X-Google-Smtp-Source: AKy350bgn7KVMwsTMtrTJFSi6z+5NSo5iZGnhQdP/RRXvV29DIqkb/r7UGXavV9Ze5Tc2GnK0BI5Z+OuzTjwVW6f1f0=
X-Received: by 2002:a25:d4d1:0:b0:b80:2bf9:2f78 with SMTP id
 m200-20020a25d4d1000000b00b802bf92f78mr8219512ybf.11.1681167308928; Mon, 10
 Apr 2023 15:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230408122429.1103522-1-y86-dev@protonmail.com>
In-Reply-To: <20230408122429.1103522-1-y86-dev@protonmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 00:54:58 +0200
Message-ID: <CANiq72kQ95gLdfSMNNbB5qn2WdJ7ujbXFwTpuHJQLK8v-qha6A@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Rust pin-init API for pinned initialization of structs
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
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

On Sat, Apr 8, 2023 at 2:25=E2=80=AFPM Benno Lossin <y86-dev@protonmail.com=
> wrote:
>
> This is the seventh version of the pin-init API. See [1] for v6.

Applied to `rust-next`. Thanks!

The `assume_init` patch was dropped from this one as discussed
elsewhere with Lina who sent a similar patch, which required adjusting
that patch's `SAFETY` comment. I also applied the `Reviewed-by`s from
here to there since it was essentially the same patch.

Cheers,
Miguel
