Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930FE6DC2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDJCxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjDJCxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:53:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144312D5E;
        Sun,  9 Apr 2023 19:53:13 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id u13so3530852ybu.5;
        Sun, 09 Apr 2023 19:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681095192; x=1683687192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/hTO2X8KzwIXSVHvKRYRC8lZzPKpxmV9rFGAQvm7mg=;
        b=h8jxDm0w4AptuXwbXmcqzdsrPjn/1L9p9/SB6ogf6bIF71GBYOC8kGxJAn3cmcMfJI
         tt5CyVmoI8vJ/8mcSXWAP0wQODevLmItoZCELS5SN8iVfoS/p3giizgPzuhh9tXbezl7
         r/lCY01Uj8QmFD02/qEcjEZISQjgZThgcxLzx/Ew4tbeEkKuTxeCfLSC4hYuhFu/iHT7
         qjLs48gfsxHSmUFm8IOSHuWl19XrKZlnm8YS+mkqmMxAawRroEcnjaUJ/eEYFq9mnfqJ
         MXd3SMxE7hLOd0THq6GRmprH6QO+jrInRXMaoS5HRZWhIjHZ6V27x61Cq9YsqXwcE9UL
         BIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681095192; x=1683687192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/hTO2X8KzwIXSVHvKRYRC8lZzPKpxmV9rFGAQvm7mg=;
        b=g3CR16i7FcjbU76dHHn2N7V9EP63ZJZLiuQvY/MVVl8aT4WtFsYwDh11HcCGjCEfQ2
         BJ6N42ar1Tgv9VWz09zoEGpDDNx6UgkXchvllpxNyzBpJx6B3YyUM4xuvwGtBVw8RT8N
         KXe2Wz8rDKwULYvgzsWJTPBfsdyn69KNZeycCynStJRG80osU8qLLr5ulW75faAWOjd8
         vXN28+rxX6R3JW3ho58HJKoe3+l9VEFJ/K3U++dY0O/X9fd+NA8ip7QtHdwdO8+GK82h
         Fe+7vSP7HgneRDT32L8uW1Q39zClF6fYe1JN1UesAdukSGhe/tE7wCNpEJwmnRM1Lu+M
         mjsA==
X-Gm-Message-State: AAQBX9f0IWll1blb732hqpnGhur6GYz9lIt9hJpGanJKe5QyA2Q+Jjpe
        nNsu4Z+EkUNMK3J2Wpy+FJOjBMWMnyviqr8C5C8pPsXBearVmQ==
X-Google-Smtp-Source: AKy350ZM/WynsspzU+CckbDyxq3T23S1DvmXWbfl60r2KL+0vrtnNh2PPE+Pwi7vZozDjtpWUujESwrJo8l6q/dcrBM=
X-Received: by 2002:a25:df47:0:b0:b8e:ce2d:290a with SMTP id
 w68-20020a25df47000000b00b8ece2d290amr2994885ybg.11.1681095192308; Sun, 09
 Apr 2023 19:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
In-Reply-To: <20230207185216.1314638-1-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Apr 2023 04:53:01 +0200
Message-ID: <CANiq72keEKc4=c-Mkm38vTHXbA5MdiZa3sqFZsRN45zUKTsvpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: sync: Arc: Implement Debug and Display
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        Finn Behrens <fin@nyantec.com>
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

On Tue, Feb 7, 2023 at 7:52=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> I found that our Arc doesn't implement `Debug` or `Display` when I tried
> to play with them, therefore add these implementation.

Applied to `rust-next` (with the few changes mentioned). Thanks!

Cheers,
Miguel
