Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836926DFF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDLUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:15:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF1F4217;
        Wed, 12 Apr 2023 13:15:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h198so19655056ybg.12;
        Wed, 12 Apr 2023 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681330552; x=1683922552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjWPW5g/tI7kRaXJYWv/Y0jNJBy/VRCl5rMUtgvvIjg=;
        b=hB3C8eZ9Gfj3V5MenI/wgzALzYauvc6YP7uwtsx2OgPhWmdP5PxyKRSIFNmk6Qg2ts
         pUuDSnQVvlE+h28ETo8X3hKVAykXnk6qq+gZGe79VAZqzybDfLGCw3hMeHm7n8iYU2pR
         3C9LitPPel4kH3kG3KoEoPjCVJLwWJTTQqHJYL0y3dXja7qmqmt35PS2wgMX2l8hpVa5
         2vnDL+pjkPfjYnE0VAzRbV7lJEsIzHo22u/dsnXH5QQ03uGfSddOBzdcLiC9DhJYjwGJ
         p7jd8Xhcrg95AEYQVNCVb8hh3RSAuPpiOSyFma3288I1gcYM9kKnlZk7jXx3HgZ8cRXJ
         vezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330552; x=1683922552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjWPW5g/tI7kRaXJYWv/Y0jNJBy/VRCl5rMUtgvvIjg=;
        b=NXtgunvOVaqR7+71tTYup/CHzQ2Sa3rsJDIjtXhsGctFzIg7XG01rr0IRpVju5Wwbv
         yQIXZ1MMxivnipvwH5Sh0aY/y2f38Yi4Ul7pv/2WWFAfQze5L+9HanlMDj3aF8/PKzdG
         A9LesMslqQHmL6AFZwMH+1cTP7hdS8OGqjBhexBw6mRwXyy3UCiGSOtuKGL/dKzuAjZk
         2oQn1+4eJOVy0UefeBqF+iwOiYSQxTB0BCV9hlDj4eaK6WrAcIWPJz6B2Dxd2p62imzp
         46yi0QE4ZP4e9aAIHPfdksAiecK0QewnXX4a23/+wFXJ+8Czrjnfz/gGWwjWOCJWkvI3
         bdQQ==
X-Gm-Message-State: AAQBX9efCZ64cPia9BQcKjtwZgod+BSvudiETBhXLQpzztkAPCxIX/zB
        wVUtgL7YWv9QCXEckqPKHfFY7sgDYG6djwYf3dk=
X-Google-Smtp-Source: AKy350b9E6cd+NcqFn/q0TD/thUquuWGqAf5xaJrJVUDw1lxXwBCQg+m95Vi9zfGFCE2tvaCX8o9SUZOIM4xKbWpMFY=
X-Received: by 2002:a25:d8cb:0:b0:b8f:566d:2570 with SMTP id
 p194-20020a25d8cb000000b00b8f566d2570mr59526ybg.11.1681330552418; Wed, 12 Apr
 2023 13:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230408122429.1103522-1-y86-dev@protonmail.com> <TTE27GJ76877W-sIzVb_b80o8dCEf-CSDOKHLMTeYD23mET-2EymYGp9PII26HWZb0vF-emqnkIVdVKNwEqQHmWNZq_7P_GiL_U9Eyk0R58=@protonmail.com>
In-Reply-To: <TTE27GJ76877W-sIzVb_b80o8dCEf-CSDOKHLMTeYD23mET-2EymYGp9PII26HWZb0vF-emqnkIVdVKNwEqQHmWNZq_7P_GiL_U9Eyk0R58=@protonmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Apr 2023 22:15:41 +0200
Message-ID: <CANiq72m-GgYEyest0n2i9L_mApB-3LL32Gmvh7jghicc0HGGPA@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Rust pin-init API for pinned initialization of structs
To:     y86-dev <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:13=E2=80=AFPM y86-dev <y86-dev@protonmail.com> w=
rote:
>
> could you please change my current email on the patches from
>     <y86-dev@protonmail.com>
> to my new email
>     <benno.lossin@proton.me>
> Please do this for the Signed-off-by tags as well as the actual
> git-author. Lina's patch to introduce `UniqueArc::assume_init` has
> my Co-developed-by tag, also change the email there.
>
> Much appreciated!

Done in `rust-next` -- my pleasure!

Cheers,
Miguel
