Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10D6E011A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDLVni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:43:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72211993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:43:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id q5so16211970ybk.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681335815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYL7UJvmXY+72PZZAoYB2b5fs5LzTaN0imSHSQ4nVPQ=;
        b=nk65qN35KIRNpPIqpWhPERKnu9gtCW2yFneGxHjVF+n1XP8QzFL4uZtw6T1YkOlgMz
         jVbeWdtdLnLqkaihohcsbhU7uW6NQ+n63kwNAuz3hFhHruRNhWiieIkSWzNv+BsPlwsD
         DzZkQI1B1pSQrdgPa67008dfKuUIZkw3ZIm3x9cegnYnsE0lf2UEjnQSjLsDVj7pM78L
         qpsOQt5k7NxbkZmgCdetahTsPay/bnc6qCeDNUOKlyJ5uFAtOnsjhxo3eGlsfCLikuuY
         EQ6YhNZtc3tlOBew6makfHTwejUxbBtnBPYhKe3fAmAoOs+F8IML2TC8C/HSBNewl3Vl
         QdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYL7UJvmXY+72PZZAoYB2b5fs5LzTaN0imSHSQ4nVPQ=;
        b=PH7M/zoLfivWojjfIzhxUjxin1lr3vEuJ7r00T5Gxg5acmGH61ZGmm0mvSlyygECmk
         2leHAPnrZwrodvy4w9ZBeartrBuCYTtNFZxmGs4Xd1KmUTZ9S7DwxKcU/HhItUPfu6+8
         8iJZT7GEPfYKWg/AM1HHGcXluNxmS0+ZhrkaHV181LQSVpjPSf9cdysJs+Cnj5lsuxZa
         A4MguYGdqNkBQIIvajpcbqR8o53K3CkRhCKKXIxLneLw3N9D4rgZGlCT8h9U3K3/HH4g
         gkZ5MVq8gxK3mp5DiVPvZ6V34EssfggTd9LibOYyZQSR8RdG8K+leMWd3wSEJ7SfvApW
         w4+Q==
X-Gm-Message-State: AAQBX9eaXtl2BJuVX/blbFI9qWGnmGyTfrQeVcyVpKCpGDao5fPtmB4W
        jw8p3ZOypBQ57O2ie76AXUnpML9C83PddboVGU10Lw==
X-Google-Smtp-Source: AKy350YJqPo1otxXL/nh+lvtQKaxvgidcuG+n/vb1nvt4O6+jD2jRjFmQKAjXsHem58l+h0S0hJIXO82bfEi8bRu3qU=
X-Received: by 2002:a25:d708:0:b0:b8f:448e:2f9a with SMTP id
 o8-20020a25d708000000b00b8f448e2f9amr15016ybg.4.1681335815147; Wed, 12 Apr
 2023 14:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net> <20230412212126.3966502-3-j.neuschaefer@gmx.net>
In-Reply-To: <20230412212126.3966502-3-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Apr 2023 23:43:23 +0200
Message-ID: <CACRpkdYTuE5p5dOZSkp=wi3miC5WqLFU3E_NnxohX4CCued18A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: compressed: Bump MALLOC_SIZE to 128 KiB
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:21=E2=80=AFPM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> The ZSTD compressor needs about 100 KiB.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Fair enough
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
