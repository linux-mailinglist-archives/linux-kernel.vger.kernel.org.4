Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC9A7060BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjEQHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:06:25 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F84A4EE4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:06:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba76528fe31so7642875276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684307181; x=1686899181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/zxxil+VhAqh7Vb2byWsHY9sGimD5DEVksV2dqzcfQ=;
        b=DYSCAO0HHRjnMcyDD2NtCj8dRPPdYnKvGaaQwh3nXzkVQEEtPcbhawIrokA8sNoCqy
         BeIyICylfUDhdBQfbliRrrL4up+ylxJXLmqfGxAsr+5FuQlzoI5uaecBIOwJLZl2LwGq
         c9MzgOFC1sPFna03ZJCZIeUlURz2Njg59ohazfpovltTJ8dc7NO5/xyYlYu9/hj+PAAu
         RVVPtP7Y5sieZMbKVL58IJvWcIfKnENj8w3N6WoOLtkWpvwX6pw42ykxPgthDckXhZs/
         qf5TOyn1DzLxApkb3wIl3pykIV9gWdFvpMXKApOcPi++HFaK984PHs1rcWLVwwXtIYNT
         Avkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307181; x=1686899181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/zxxil+VhAqh7Vb2byWsHY9sGimD5DEVksV2dqzcfQ=;
        b=TGJNQz5qhdRWCW/91DFJd7sZdhRGa25LM+4Tyevk40lOjw8gu5G3Ca1+Yo/1pDelYQ
         KipM6zkbvSwOhU6WlKCEpZz1lkd+dA1GlxJ2/2u+wKen05QQ5Eqhs0aT5FfFw3MrjMaP
         8IhVCT2VwYNnPtSfnzSb5W/fwEmKj9ZjBYGoASK3EGklkJQRGQPFayjIaKNvHj4JbJ8R
         XRRmgisz+xsfCBGMqs4sUXbhoZ3ghRLVJvSUcesc3zxs0Wtv2PU+RAeBIk9yq8HklgFg
         PAJjdgXkFVHKSVHkti+vS0vqnGHf0R2dh9f40atDj53OVMXc1oT9sm6B5k9ODD9CQtVh
         uFEw==
X-Gm-Message-State: AC+VfDxXqNUPQAh+nGGD4CXKIcABduGCpH7UpXtF0lbmdUXXCn2zzs1+
        I1rzgyNyV2DFcR69OzG10wnoy9Doe8tBge6m2r/QnQ==
X-Google-Smtp-Source: ACHHUZ6piA3LP1edrkxG4tjIbGATpuytH8hZFaArRavh0H4Dg47540oTd8P7OjPHgQMlDaTS8Rdwgp38T0sLiuDWbAI=
X-Received: by 2002:a0d:ea07:0:b0:561:987e:27a with SMTP id
 t7-20020a0dea07000000b00561987e027amr868541ywe.10.1684307181571; Wed, 17 May
 2023 00:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230516200516.554663-1-arnd@kernel.org>
In-Reply-To: <20230516200516.554663-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 09:06:10 +0200
Message-ID: <CACRpkdZvizr_gFHjAPzzmAtjugu4_gO_g53-BurG4+2j8cwfYQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] irqchip: ftintc010: mark all function static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:05=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Two functions were always global but never had any callers
> outside of this file:
>
> drivers/irqchip/irq-ftintc010.c:128:39: error: no previous prototype for =
'ft010_irqchip_handle_irq'
> drivers/irqchip/irq-ftintc010.c:165:12: error: no previous prototype for =
'ft010_of_init_irq'
>
> Fixes: b4d3053c8ce9 ("irqchip: Add a driver for Cortina Gemini")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It's a leftover from when this was called from boardfile code.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
