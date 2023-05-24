Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8205070F16F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbjEXIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjEXIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:50:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94EF184
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:50:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-563874afe98so9586897b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684918240; x=1687510240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGfPKtHi5YOURAKsGDBHNQ7Aw/Turw8EB6RVImptoek=;
        b=YIkEN8ATkeNZxa7Mk3mbyV192nlB7YMPJPNSkXfiFqr28AKnkNNRH6A/eTOp8E+BEd
         GSEPeHgc3yW/Jz+W3w4hQXY5E3bpabbgw3llzDDcTe4Mxgmn42vhJdXosJ3oD/Olzy/j
         iGtXTVMWOKbhKlhx5oztIjQutpIodTOXJe3767/fzk6uQemgQEZxcUS3t5fKXi5uoYKU
         i4ztF+p82OUX41uz0wQe+WILZwL+8riedL/zjPEgyJFkuD2XZSQmgSK50Tnh5Xeus6gk
         1os/zGmWbpltBptHUS+8Du/py8fXHvdhzsN/ulLptUWrt/GB0/dUQcqCdFvxCJ+QQBFp
         LrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684918240; x=1687510240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGfPKtHi5YOURAKsGDBHNQ7Aw/Turw8EB6RVImptoek=;
        b=X2EhqK3NvDx0f8h22cDlcgEhzaEYMmdUHsDQj25wifVBCoT5/SK16wgsza69q8RMoO
         SiWAwQBS/UN19mx9U31ap/lFkec5qDC6Qn0vWbgJXgcNkQs6VurEzqkBvVpdcZxpW+OT
         KdWqfayX8v2A8sDb3p/3hrhg8KTei/1o30qQmB9PE1m8pu84smTtxZsk9SC538XkWBe+
         ds4BZeBgqg2ch/lDqxtsqD5ZH9xDNl91NVs77gcEEZrYkyy/TjMIKD7bylwBkc0x+TvI
         Bc24sLtK2la+ZI+IBRe6SgxyxsIxAh+XkIkrmIQl5dh/m8JlhgVLBCC14rsuY8vGwUU7
         Ny7A==
X-Gm-Message-State: AC+VfDzXrLjF1IiFT7MvaE7Lhxq1Zzp5OAUl6feYjB+w6CHqCNigI0DW
        GkZjrvH1tyYERYSB3fzBDAQL5noa4uh2gNB2OYc4Sg==
X-Google-Smtp-Source: ACHHUZ6JMVJuTBYZznceLzTr1vHSBnMxk50VKqVAZA8KovHY2Aqs+HHvUl/yyU49U4TubZXIzY++bmGE7xzSYZjB9M0=
X-Received: by 2002:a81:a50b:0:b0:562:7f3:beec with SMTP id
 u11-20020a81a50b000000b0056207f3beecmr17945345ywg.41.1684918239982; Wed, 24
 May 2023 01:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684313910.git.Ryan.Wanner@microchip.com> <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
In-Reply-To: <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 May 2023 10:50:29 +0200
Message-ID: <CACRpkdZewDs7ZFxjC+Rem57OJ0icdMh_w2q_ReemEBJXb82NQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: at91-pio4: Enable Push-Pull configuration
To:     Ryan.Wanner@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        ludovic.desroches@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 1:54=E2=80=AFPM <Ryan.Wanner@microchip.com> wrote:

> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>
> Enable push-pull configuration. Remove integer value argument from
> open-drain configuration as it is discarded when pinconf function is
> called from gpiolib. Add push-pull do debug and get functions.
>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

I fixed up the two style issues pointed out by Andy and applied.
No need to resend.

Yours,
Linus Walleij
