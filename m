Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0996AD177
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCFWYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCFWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:24:48 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5393B3E7;
        Mon,  6 Mar 2023 14:24:47 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id k23so9733999ybk.13;
        Mon, 06 Mar 2023 14:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678141487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HcUaH1X7Qi/9+4nj4EKlp5k2Eh7c4FkvNK1y/esUSw=;
        b=d7Mv6PYebMheWEsnRKlnuNBlSyisVIT7UHqB0qDW3K/GE61M0+ebcEZ9JDPlyf6yXx
         ozMi9hC41IDegX+/ey68MvRY2ZJdCl8IOe/RAnuO4dZZQkTdT/e7O1ALJWgppNBOHub6
         XtSfoLsH7RA4ixmB2EXaBDdcpd/mHFLOVMtAG2/MXpqJwT+9JO2grSdS66Gclo1vdqpC
         sbOzvtlqdy28Ge3HsxZKF3RkfVMO83mMydWNM8wekhAxZogxZSr2u0pqKeTQTeFsHx6k
         M0pQtPxpjw6t5wHf4Lxpz0C9wupxrakjFD4RwqNhTWH9QEzs63c1nK0/97qn8oIet8+F
         7q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HcUaH1X7Qi/9+4nj4EKlp5k2Eh7c4FkvNK1y/esUSw=;
        b=7oucTAT/MHKEOFhDjS7UrFXcC7OChDIvGSRoXVBJF3lFAklDJbBFRZvQVh8jkZerk+
         h+hzKdyQY9HzNGGraVYoqEfwjL1Swb+JLH3jCaVcUC+ZgnTKzIp63ZKvPhWbmG29nm2t
         nt+IKjNfMMf5fLihrPZ3GitBTz/KVTivgcIWMPvhmp69EH59X/1LrF8/zSvxEtCRgaXN
         hu3oTsshw51N/eEaFQlxT6dCpD7qYyEeiNflq7/eKYc6dfn8sxKLWKe3odS0GRGcd7nu
         D8ziMNlduAYWyBGFstoBp3FpfeiAa8RifKs8leF8EDGrGwLLhzUsmDULO2/VCHlpWt1N
         +dyA==
X-Gm-Message-State: AO0yUKVgsp950w3XMuEW8ssaonhMaD/hLwtB0sLr99wNRpshRs15WW3h
        KMGwW0oUgOu2rdQGQDJx+yYh7hl4wr75b7hAEowiK92K4u7W2w==
X-Google-Smtp-Source: AK7set+FoDileIaD0OWvYJM64YsRE7dvxESFqPRy2decGoDFbxTaGZa22p+SBzQ/yRdESBPE9Vk2vHp2udAy77V+S9E=
X-Received: by 2002:a5b:585:0:b0:b13:7a6:f462 with SMTP id l5-20020a5b0585000000b00b1307a6f462mr1581883ybp.3.1678141486854;
 Mon, 06 Mar 2023 14:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20230306220959.240235-1-ojeda@kernel.org>
In-Reply-To: <20230306220959.240235-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 6 Mar 2023 23:24:35 +0100
Message-ID: <CANiq72kF1wy0HWTPFaF3UKOvoZ19kdWe_mCAt8KxY9364-RE-w@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: point directly to the standalone installers
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Mon, Mar 6, 2023 at 11:10=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Thus point directly to the page (and anchor) with the table that
> contains the standalone installers (plus signing key etc.).

By the way, while it is fairly easy to figure out the links to
previous stable releases, it would nevertheless be nice to have a way
to show them. At least there is a `FIXME` comment in those docs about
it:

    https://github.com/rust-lang/rust-forge/blob/793249870cf7610ffe78dcb9c7=
acc7efdbbcc713/src/infra/other-installation-methods.md?plain=3D1#L99-L101

So I opened https://github.com/rust-lang/rust-forge/issues/676.

Cheers,
Miguel
