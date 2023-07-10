Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC974DE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGJTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGJTlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:41:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8D136
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:41:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so7607659e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689018075; x=1691610075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWqKm6QUIv0JSsGcZmR9jzvjSANP5a8f+sD83U2ywVQ=;
        b=VjwjN9xw0dHi1l+nsKHAm5isIeAJruQ+bySNLf7yg4TPoxSwFc5jy+SDXdJByzxQW1
         M6laBcQxkzlkjF52nlRWZ3xXEtpIwwf1XSMtN7qoTtKwvCL9QTUqFoMyeq++/UpNjzTL
         4gj5ImmuD997g2ALgR1Rb4TvQdYDNzzOoAiwjt5aWtBlPIm4q+KpYl2cPelcDbYdw2gW
         nBgnBJBQBDrzqmrveRqz84Msxy3ZG9PogFbjxGVxdWd9JzUcE/MnHL+Yzy/dN5FJbFV+
         9VYLUC8cPA+XQ9hLmoDkttzTi7ftToBvALBbHD6A77fQetcJ5tG6wsLvW6YjlxcU/NAM
         vLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018075; x=1691610075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWqKm6QUIv0JSsGcZmR9jzvjSANP5a8f+sD83U2ywVQ=;
        b=DDAcPjphfgi+oMzkM0DEklFc9aw+qUHEAlKWkquNZW+VKRXqYq4n+2EOB6BRWGoAP8
         uCbSWQ6W25gv3lAxu2IAdJvzA+wOumq4dBnT+qpaSpOoB09SSwj8db8mjnLZGx5m+3iG
         8jXYx/mQ7MWhanJ3u3+bVniuEnX6wLA29dQsMDE+EfmLwvkXAVzeJ9ZHEhDKUnGGr0j+
         r/lNy/OiwZ4plVhhoAEklHEsFnMInMQQWT0rMh/uuGodn5LdfyTDpljJiDXt9R7i8ekz
         in63ooaK/7yqNei03VTZP/W2jF33ZWdTZiDG3RUm2sUkReIsQK76KbpRMggttlMtjZBu
         xM3A==
X-Gm-Message-State: ABy/qLZefOESkjCyA8SvzJQ0LQ6ZpSADsU3lISNtcLkADw0MMia0kRLl
        6SVzvCbGZ2fNg2NMGBMfnHbj6JLoXV7CGeEDI4oCdQ==
X-Google-Smtp-Source: APBJJlFfPk6eGhRrtspJMFf8PNSfoVkKlSIQ/2OgWKw3VcG2CMd9n2TGvzY2gLP0RpFgSB++tX++jrG1oiLhplPpNt4=
X-Received: by 2002:a19:3814:0:b0:4fb:8fde:f60d with SMTP id
 f20-20020a193814000000b004fb8fdef60dmr9788957lfa.22.1689018075688; Mon, 10
 Jul 2023 12:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230710193329.2742-1-palmer@rivosinc.com>
In-Reply-To: <20230710193329.2742-1-palmer@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 10 Jul 2023 12:40:39 -0700
Message-ID: <CALs-Hssm=hyjSwVyUu7QrWmG8FTDz+ubrGF0Lo7EhzJZhu2tbQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: RISC-V: hwprobe: Fix a formatting error
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        andy.chiu@sifive.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:34=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I'm not sure what I was trying to do with the ':'s, but they're just
> rendered to HTML which looks odd.   This makes "fence.i" look like
> "mvendorid" and such, which is seems reasonable to me.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Ah whoops, I must have missed that one during the documentation cleanup. Th=
anks.

Reviewed-by: Evan Green <evan@rivosinc.com>
