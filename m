Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64DE6A71FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCARXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCARXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:23:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDA24106;
        Wed,  1 Mar 2023 09:23:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so12398582wmb.5;
        Wed, 01 Mar 2023 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677691397;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6q//m1CEjfpqFhjrDbSC5BAypm/0jrg06FNQbMJmJ8=;
        b=Q5AonMYOod1t7I+bD5dolZMJTkTodjSawwKXEefEu63aXYaTxfAplMseOC3l6dnInt
         IY6UOPbrQM657WfCexe0c05RmFoZMKIRNlf2ZSGjbm877dCZDXL47KHXgAqjwMbqcbD+
         fFZ9h43K2djvLOWeRaVGFJCik3wxMoXdLVWrSDdC8uSB+pIRo0TlWt0zu56efQT5N5ii
         eLdOaBqu0b/Erhf0rh/zrLuLxMd7B8/NyZwPBdbutAls82wqdk0/3nyRQFCWz4hWT6Vs
         DXy5h5dGAJqTATZErkrW6WtVKrKQ/QRNIs2TU1HnPiXSkD8bGJNwOVBcQKnrC3JRvOlY
         1w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691397;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6q//m1CEjfpqFhjrDbSC5BAypm/0jrg06FNQbMJmJ8=;
        b=iipPwXJqm3lsBE7h1AsX2ePbe+4eQ4wGbrNxCf2Nqk1w27J9TClg1mZv7b6iF6Ui8Z
         AImXiQLPky9XJJK+Rn31aWwMOQwQpF3LN80rYd4laqZI3rdOujtzgI8rp/nkVVFdwSCA
         ZYAjRBlgyIwexFuxjekp+Y8xuJeS/KvN2+D/moOY/lsUx4oX+7dF5BfReRD6BktzbbrG
         XYJiZsvmIGC81fOQqrn/GV9DosewSCdyKXEbvVlhcSAVRSk7zu4aL6P2oogO9T7NN5Po
         X++DnFuHdrTR3N8uwBtlDgHE2Gl+rvYunYIQKzyo8oFQK8QK8rYAZKtZ5DtqG88VqDYm
         QB/g==
X-Gm-Message-State: AO0yUKUbvORJNbUlPDBBm3hsoINriKT3I4ncuuiHcWAQZBTWb9erWaAo
        N6gZp7BnSkUEaY+oB6WQPnU=
X-Google-Smtp-Source: AK7set9yOFJ+2701IOZIcvtfhdWGpm6TIyV0B3HZ49V7YBtK3W44CkBO56vjco2DCs8k9rLV4Ur4bw==
X-Received: by 2002:a05:600c:35c4:b0:3eb:37ce:4c3e with SMTP id r4-20020a05600c35c400b003eb37ce4c3emr5775190wmq.16.1677691397284;
        Wed, 01 Mar 2023 09:23:17 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003e4326a6d53sm171559wmq.35.2023.03.01.09.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 09:23:16 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 01 Mar 2023 18:23:14 +0100
Message-Id: <CQV7YQW9HU8R.2HH07UP1OA6Y1@vincent-arch>
Cc:     <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asahi@lists.linux.dev>
Subject: Re: [PATCH 2/2] rust: sync: arc: Add
 UniqueArc<MaybeUninit<T>::assume_init()
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
 <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
In-Reply-To: <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We can already create `UniqueArc<MaybeUninit<T>>` instances with
> `UniqueArc::try_new_uninit()` and write to them with `write()`. Add
> the missing unsafe `assume_init()` function to promote it to
> `UniqueArc<T>`, so users can do piece-wise initialization of the
> contents instead of doing it all at once as long as they keep the
> invariants (the same requirements as `MaybeUninit::assume_init()`).
>
> This mirrors the std `Arc::assume_init()` function. In the kernel,
> since we have `UniqueArc`, arguably this only belongs there since most
> use cases will initialize it immediately after creating it, before
> demoting it to `Arc` to share it.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
