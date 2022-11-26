Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70A639859
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 22:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKZV4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 16:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKZV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 16:56:20 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DC217E16
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:56:19 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3c090251d59so16200927b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Go5odiu5QN0tpd3XhStg98Rzff6cbxXg+1YFQ4ZWwYo=;
        b=VxK87r7D5Sxv2QZHnCPvE4e4x1qhGqrLpuZVgn4qXSU9JvMbPhYbjVVENMOBT5WdRD
         fklQTir/LAO3eNyAg0OfIcsoPSKmgmzqRSiM5RvH1jlHba5wJLRaeKxo1awKqC8AMXwh
         uhiLSwdibzbYkd2IdVIN00t9S8ONtPPPAJkZbkQQ/2pIz9Df/wPmGG9h+A8zbkhR1NgY
         NApMdr3RC220prNT64MXiKtuZiMlxFmgXBnqqBMzNNrUqVmwgx21T6IjNwrjdmf7ND8t
         tnE70JzW0/a+cWBGvgPd56JK3UToccvmRmS9Bg8pT6ovV+51Z0h5GTyS8jPimx2YGV1H
         +4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Go5odiu5QN0tpd3XhStg98Rzff6cbxXg+1YFQ4ZWwYo=;
        b=QBUi/gRg4FIOsG4HEDulL8w+tCykJVp6DJ4ZEdMb9WvaIvsMKG+1uQV4PM8q03yyXe
         yrXREi/PYYMN1GCkZGl7y6GZUdvZkjPk71a/gp2Dg0cazv7RlhUIItJ8uPkw+GCRxyYo
         gACt8xPeN/jXPtt9hiFSY5hVVmboTyx/nS9vkxiPeSoE4sLF+jwJUeiITnvceeXpNkxT
         KphRRby1W8th68ggsthHALBMnk18TL+7D2CWSAiBTV0XUbonomSeff8Imm5AQZZole3O
         /JCxTrznNnI7jGIJUdLnna1vxN71bjdBddHys10j+eIUxlfsVK3yg63A1RgyS9wFdHBu
         9Nxg==
X-Gm-Message-State: ANoB5pnvfhgkbpOkqM+ALcI/eWgJ1kcxT2Qfb4ZAcdTimn6q+kGWuEyq
        ZhOiGEFr7VJoLSOM9Licx8q5ZLE0SprkKZQ9C0Xqvg==
X-Google-Smtp-Source: AA0mqf4Kp+n/36uQXBvcHVui04z4w2EPYXS9JeRocw0YK5S2MS3YShCoLZ6/NnEMnLcDFTtF/TOqRBXLvhafrrgWNNo=
X-Received: by 2002:a0d:fdc7:0:b0:37a:e8f:3cd3 with SMTP id
 n190-20020a0dfdc7000000b0037a0e8f3cd3mr41994077ywf.187.1669499778580; Sat, 26
 Nov 2022 13:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20221125144114.476849-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125144114.476849-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Nov 2022 22:56:07 +0100
Message-ID: <CACRpkdZxS-o3+chB4511ReJD=ZsFAGNvM-1MqFgAx-Df8FX0Nw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ste: align LED node names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 3:41 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The node names should be generic and DT schema expects certain pattern.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied to my Ux500 DTS branch!

Yours,
Linus Walleij
