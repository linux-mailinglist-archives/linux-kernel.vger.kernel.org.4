Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B86E6F48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDRWRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDRWRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:17:31 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AB900D;
        Tue, 18 Apr 2023 15:17:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fc337a650so225895217b3.4;
        Tue, 18 Apr 2023 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681856250; x=1684448250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb2s/DWEwvCew7IiBKqmaCUL3AUYlAJqbW50mt5B9Nk=;
        b=hDtShXc3PhXwEbKRY4G2WLgsSyRF+JlOKSwb7zF8RpLSWYw1Ui0KT7RIu1xgItuaxI
         86GyFY1+9B+v7UwYAl+PRbu6tHmqgKonS3DRDuLmbC4R2rzGfofv4mXSqo7UPX8POTs3
         DcQpSzckH5HDYYfmb6xSuDFxN2RjgBuWjvPa31FSQwFs3WqvlFVF1ar742iW/0IIEAB+
         UTWwyxQRGX2nJuUC8I3xr/UHfXUcmwOURrTqMvXsCYiAY6GvoL7uqdw4DUKVxS21uRAP
         ElFkX5TOvMm1Mzwxw0o/yrRzbJ0a5lJvP/djpsBn0k9QzcK4lbWWiFzwkSyEFFviJyQE
         YUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681856250; x=1684448250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb2s/DWEwvCew7IiBKqmaCUL3AUYlAJqbW50mt5B9Nk=;
        b=KXxGYuAd85LyJaHVKS1DjGLo0W5lXh7P0iMKWcakN1somWQ00ZElMBmBQOA6D7TqTk
         ibsbENCHIW1FCZ1iXDp6ioaV1IHNZ5XM2g2lKcgGHTI86+3GDs9BPUa15lyS2x5IjbdL
         OfsRwUt8hstAmPqD9i46/OGrDYToJL3cYEEAkr0V6iLtwH8+yNXyYub44/941HC/X5Mr
         yloo6USZmoQKvV6BSCix3rPj5M4p1msN4LHqTmapi5nSGsVjNELdwrdMD0Xievv7fCRv
         56a5HCWdh2O7sCEpJBgQd4Hoh/TVrAO4gajPqjLCiUDdUe6eszLNW82hTfKc0FCXuMRC
         N5lQ==
X-Gm-Message-State: AAQBX9elOlR4DFGEB8YCsN+NZjSiUb7Xju1Tx0BLF/jmMP2ZBBap3zi6
        XYTaUasLDqoUx1XvYqsA5GR6V0X1+sv++pxnd2k=
X-Google-Smtp-Source: AKy350aKpMRZeEGfnc9bETCHrbDggSQVw30EgyEAxHgEaM9A0/+OWAUgagoXXsySH3ULOC9RpQdNrADkLYmFLckQmHw=
X-Received: by 2002:a0d:c185:0:b0:54f:cc36:2fae with SMTP id
 c127-20020a0dc185000000b0054fcc362faemr1431271ywd.41.1681856249759; Tue, 18
 Apr 2023 15:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org>
In-Reply-To: <20230418214347.324156-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Apr 2023 00:17:18 +0200
Message-ID: <CANiq72m1TpRDscA9E6PrZRtEogDsSXF8XQZ6bbhXCfptb34tbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This is the first upgrade to the Rust toolchain since the initial Rust
> merge, from 1.62.0 to 1.68.2 (i.e. the latest).
>
> Please see the last patch message for a long explanation of the upgrade,
> the policy for future upgrades and some indications on how to easily
> review this.
>
> The series is based on `rust-next`.

The third patch may be too big for vger -- for those looking for it,
Lore has it at https://lore.kernel.org/all/20230418214347.324156-4-ojeda@ke=
rnel.org/

Cheers,
Miguel
