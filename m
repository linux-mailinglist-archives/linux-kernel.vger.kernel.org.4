Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD46ABA6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCFJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCFJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:53:20 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322522028
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:53:13 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id x1so5991907uav.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678096393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/i3cW6MMJBIByuoEtssmFxaDechJ+3zIimenSLZRiM=;
        b=NS2ts3hpN1YRglL7KLG89JQvZdG+cW7hr3TuMhfaynmojiStIg2CN+qxP4gDnd0Bq3
         jorGZdOa0CsKtgyLSONYS5m3ivrnVjVgUhRfS0HEyPoiLfefO4Ls0Rim0mWqzSIJuml1
         ijA8cxXCr0xrvqVH1VT2eglhia7XB3VDKmAZbYYbPqJahzcgrhztwOF8QQqvXu0vfin9
         sz2L96ZYpQGcteQUiD3TW4KDuNRmzRu5IZQyA34Cr3fbTB0rOTqzxi3c7QFfq/4ORb3h
         2RVT8sSCqobT7bZXuOyLwPfk7YFrbakJ+OCn8KojZKDBpc74UKvEKaIanowA4xKRSBEg
         gaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678096393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/i3cW6MMJBIByuoEtssmFxaDechJ+3zIimenSLZRiM=;
        b=MWLq01X2JeARbODAq8zxsLDW2XX3U4OFLP2HbqYCFgGK9Ek/gGwp7YSHX2oNg4JFJX
         SYh34aPE3iamRIBhu+DmbSdqGMCe9En6R2tnq2p7KRxO9HmcuSJcd0kc3fUFuIHgyMT9
         i5VBMX4YsozDNTMU/MkTx5AgkHC0VsoFl/iqXT3WP7/eLxJkP9ooEcmbARTYVNzbomEH
         Lm7nsFN76IRJD05Yf6bHgIdBZhPvUWH8VAnfBD7W8SuVjn09ziNG+a1h7n9JqDunF8xG
         U8HdyrsZwgTiUTxN+Hq1DbeoQz5yCDosoeCENnTvy2P5G/pRw+5g2kM0ctig/n0O2CNh
         Cq9Q==
X-Gm-Message-State: AO0yUKWReEnFG+d7WmtMqX7o1UuYXzVV8+58H9CFdGd2bh1VBZSDxM3g
        l0Usla+HNJwwgUnWFrCDwT/iZOkw76iShFL9auZsnA==
X-Google-Smtp-Source: AK7set/7fBg9EQWB5IzC3uIMCPIIVf8xQNyfsnkErID9z0duzV2GaUfOZzTk22xvZxHyseG7IuE46JvgvpbIDYtUMFs=
X-Received: by 2002:a1f:38d6:0:b0:401:a4bf:210d with SMTP id
 f205-20020a1f38d6000000b00401a4bf210dmr6266963vka.1.1678096393022; Mon, 06
 Mar 2023 01:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20230211030646.24549-1-twoerner@gmail.com>
In-Reply-To: <20230211030646.24549-1-twoerner@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 10:53:02 +0100
Message-ID: <CAMRc=MfE_VR4qt8E48NKWF5yXGQibcabJpAzNYQBbp7EGSQquw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio.txt: expand gpio-line-names recommendations
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 4:06=E2=80=AFAM Trevor Woerner <twoerner@gmail.com>=
 wrote:
>
> Provide more guidance to differentiate between recommendations for names =
of
> lines which are hard-wired to on-board devices, versus recommendations fo=
r
> names of lines which are connected to general-purpose pin headers.
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---

Applied, thanks!

Bart
