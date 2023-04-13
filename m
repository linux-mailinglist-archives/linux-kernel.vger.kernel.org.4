Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADC66E07B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDMH1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDMH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:27:47 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F28A72
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:27:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a13so14428948ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681370861; x=1683962861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abfJHn7ZwvAozrqfG1qVzD8XD4gBACYbJZHJhuhNXQE=;
        b=d7BTv/vmtNhnXAx+Il+EBpfKR/J/Xb1OCcaQ/NruFP/cYDcdWB/2E2u7Yjcre+P1L0
         q/ksHFqnvT2cNKvoyzTw8JCJg0lEwsJAHBg/WTWpuo6SIKh3vcIkF0tahvIOwaJQuF3F
         20SyDVfYmgMDtQHUexfuymfONHFU0z3nrJKzHb+NMT3X4ibGYWWcM5Bq1dWq9iZPLEVF
         reubUDf1O3UiX+YdFhAgb3y46zeH2OtiUqqoFWdJAK8LbODr71Pe/8R8hyYeOsfp6GD7
         MdpPSFFaJe2BCftQWFoOesmh85zqtgItDJqcPGT2JLoP93gtVT1he/kkNkedFDfXNsNb
         Wgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681370861; x=1683962861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abfJHn7ZwvAozrqfG1qVzD8XD4gBACYbJZHJhuhNXQE=;
        b=EgZAyAPdFNnhoA0Tkn5vr44ukGciLe9EMNWCTtM524dTWFztKTWgqrmqmlt8Ny4WEL
         p4Sx+IpYp5fgCN7qH4vl+APLXVfXyZhRKF7GKnU/zfvtlDkzRgZe0aSY2LRxB+c8wRxq
         qoWsywWeMyNB4azENvDlSoPIdH0IRJ2rFX9OZv+4C4hfHcwiSLrSNA89zMvZjn9toyqL
         EzAt5e+zcVj0WXOCdDYiCvbh8BC0to2kXNZaotbuJ1PgrnV9ETNvQbw6PtXD3K5tq6xH
         WbC4pqr0cZ6j1k1Kh/rzPMg4WXNZ1RQxoLDVqqTMr34t41DLwahOxwmTNkVkQ/+C2jWY
         DyWA==
X-Gm-Message-State: AAQBX9er7f9E097AX9sLGomTSEUr5SkUJzpZakDs71orkhv+o2qj86w4
        0KaVDiO9fjJQKnuULUsXYxiZU5mhxLLavX5qETp+Hw==
X-Google-Smtp-Source: AKy350bH+ZiTXauAcVY8vTc+xQLvbz0J9sGd7KTjoAKKs3btY4h4QHUcD0S5ToJ0HGl5nKUCZ1NU6OZPPf3mLTTVNZ4=
X-Received: by 2002:a25:748b:0:b0:b8f:567f:4352 with SMTP id
 p133-20020a25748b000000b00b8f567f4352mr548520ybc.3.1681370860855; Thu, 13 Apr
 2023 00:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org> <20230412-topic-lenovopanel-v1-2-00b25df46824@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v1-2-00b25df46824@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Apr 2023 09:27:29 +0200
Message-ID: <CACRpkdb8DqeKHMSQQoNvJKiuUG2rZtHTbyo8rGMJ=L8FY4Y_ow@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: display: panel: nt36523: Add Lenovo
 J606F panel
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 9:46=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:

> Some Lenovo J606F tablets come with a 2K (2000x1200) 60Hz 11" 5:3
> video mode display. Document it and allow rotation while at it (Lenovo
> mounted it upside down!).
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
