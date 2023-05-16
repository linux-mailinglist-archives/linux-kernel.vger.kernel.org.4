Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1D704E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjEPNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjEPNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:02:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4786585
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:02:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba6d024a196so5046661276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684242119; x=1686834119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Sc2K84pfstCjboanjbniGfPzmMFGM13VBIVkXcnFxo=;
        b=kkhA6X93jXE0QOkWXeaNCjt+xYmw1ynoYM/E43vX77feqRNp/+tuNphUB99f+3kI5U
         jvAL8UusJC6ap2jilpR1/Mr9Gqdx3Ibc5zUWBIhOGCvPZsyF+SDyfwEIcmh0w7Aj69YR
         kEe0+paiUUUEfhscTjd5G+bYtA4pMzrMXYy4hbFSY0GKgI5gbgNg7GOA1mXYwSlZGIYO
         p9XVn4PZvKDNEPV/bYiSEOe5nzVEwb9Kkz/0EntiNtHvOtenxzApN0OSV7UThu40OAEK
         xu4UHaERnptKx0kpGekYkgXYPXENRJ4x4LrOhI2rPNq30z/oCg6XmtMuNhl1kZr36Kil
         hFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242119; x=1686834119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Sc2K84pfstCjboanjbniGfPzmMFGM13VBIVkXcnFxo=;
        b=e/FsoMj+tHX1UWq2ohYvlbb2ZBw6TibxOCArACYr4y570Gwv0mZ3qrd96mCxJl5HPU
         sTnwl0FABUvUC8GziJS2K+O9vaBZ+BCxArkCTb3zeCBPcZ7N1gGVieNApppLfycRaisf
         /WLWCZ1Kl8rtpI4hGw23UvEaCxSJ60IUz00RBuST9eLQ/cODO8IG+CE8proZ6E5kxovK
         Dirx5OMrkRD7+4oSMVAJCUux5czoECSZ6+OrEgPr6zkImknwiXLJUI4P034uDV6ZuXme
         a6iTV134y1RnNb+dKdFiRrtg+omGMliW0JZBn9Jx4TzjBNLJeILmfA2ZL5/aMuM4maoD
         fhGA==
X-Gm-Message-State: AC+VfDxxdP5x9YzIWxtHYAQDiw9L2AoxfbbWqLY/KTgSIFijZuVApejR
        dKRNpiYwoCGKUj+3UZlyDOps2N0E16HdazkPxvplJw==
X-Google-Smtp-Source: ACHHUZ70HnhjnzfnxzsrdJCOY9zjN8osMO4g94aw2jZK8YfrVM4k7BPGrbNplNGvVqzOvuvWLgJ7QJieP0BKKAqNKrU=
X-Received: by 2002:a25:888:0:b0:b92:3f59:26e with SMTP id 130-20020a250888000000b00b923f59026emr30221472ybi.41.1684242119121;
 Tue, 16 May 2023 06:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230512064925.133516-1-martin@geanix.com>
In-Reply-To: <20230512064925.133516-1-martin@geanix.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 15:01:48 +0200
Message-ID: <CACRpkdbbCTGcLarqvzZ11oCrciCWVDs5SwAbf0E9N1M7xm==BA@mail.gmail.com>
Subject: Re: [PATCH RESEND] pinctrl: meson-axg: add missing GPIOA_18 gpio group
To:     =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, stable@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 8:49=E2=80=AFAM Martin Hundeb=C3=B8ll <martin@geani=
x.com> wrote:

> Without this, the gpio cannot be explicitly mux'ed to its gpio function.
>
> Fixes: 83c566806a68a ("pinctrl: meson-axg: Add new pinctrl driver for Mes=
on AXG SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

Patch applied for fixes.

Yours,
Linus Walleij
