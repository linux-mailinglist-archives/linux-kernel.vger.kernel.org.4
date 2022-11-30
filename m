Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07A263CD35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiK3CNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiK3CNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:13:36 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1434B76B;
        Tue, 29 Nov 2022 18:13:26 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13bd2aea61bso19485581fac.0;
        Tue, 29 Nov 2022 18:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yniSs8Gp8ap1xL/W4FR7VkkouxqMk25DAO1KPxyknP4=;
        b=mKWTm2Mn3IobvxkVApzoZuOACeslebG2wHvE8Ghnd3uCjNFnUhi/O8wW9H47qxmoX0
         Jx0yjkXp0KMUdNosSTe22FxiQ32lMayVfT3ntnIyz2PL8dxal+0x7EtaeA+TxH+W9Qho
         cU7O834g2vfxBigSnPwNHKNCslLwMjLXzb6EJHlz9IVUXPKT0N/7iX6DvdOtNRDy/CLv
         sDh+KaIjy0hNXvqMMbyTQkP6qllKugAF+EuUbPNOGd2w5DNy+w0bLLzt9fbC3Fh5Yez7
         +AX4xWcA+hXFzpdBOX79sZ+jIQHUWr8ZnKiPen3V1h1fueXJqnijxfF8Z2ZFFoUJBQBe
         366g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yniSs8Gp8ap1xL/W4FR7VkkouxqMk25DAO1KPxyknP4=;
        b=GDLzBmU+FuBvDAAePflryUvMZWQ4DqGYnveqRQvBO4l7Zvqdy9mxacCJ3bs53cQSB0
         qFTruplN8zX9G5F1fpA4bZQx2JjU9oh9We+ALUBQ2ByjhoUN8SqmgCE0zzudvWKJGKBF
         qYNBj1NMw9F76hIUuHwaHNpjSbYDZftJAAUsh50mXORXOD1yFTg2mb2IbeE/HS+rtLdY
         mtexIMPNeyWrpr+tBeeX97r2kdl58GaYcBL8jtNE4tnoCS/D+PVdd8Y3p57qlpiJDepx
         Var/c1nNyAwcb+N9wmrdGcig2V6A+2mktjJxs1xWiUapEEvsMeRRmIfXmOczj7+cnNL/
         9aog==
X-Gm-Message-State: ANoB5pkbW1N653GPp8EhIv1UWUn/8CQ4m7b3bL9hHsdjwmeTtNEVA+mZ
        d8PACYGbxNCcGMP0d133PKpsZ0h2sgF/4bEzBzjmk/q8
X-Google-Smtp-Source: AA0mqf4HUzcAj/pGLURaEHyzNGwwqn+mbj7cJh5IYrKc+9+fa1LeK4TxOAyw/oi7Jma3bWhsosAdsaRCoOrjT66wA1k=
X-Received: by 2002:a05:6870:ab86:b0:13c:5763:9411 with SMTP id
 gs6-20020a056870ab8600b0013c57639411mr32180814oab.288.1669774405987; Tue, 29
 Nov 2022 18:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20221129140955.137361-1-gch981213@gmail.com> <20221129140955.137361-2-gch981213@gmail.com>
 <bc1086b2-871e-c540-a276-78ff63debbf4@linaro.org>
In-Reply-To: <bc1086b2-871e-c540-a276-78ff63debbf4@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 30 Nov 2022 10:13:14 +0800
Message-ID: <CAJsYDV+Bm_SjzZ53jdARd3rRGBaai7iKxQp53cLBd30XATOOiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add an entry for WorldSemi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 30, 2022 at 12:46 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/11/2022 15:09, Chuanhong Guo wrote:
> > WorldSemi is well-known for their WS2812B individually-addressable
>
> Drop marketing. If they were well known, they would be already in vendor
> prefixes, right?
>
> Add vendor prefix for WorldSemi that makes WS2812B
> individually-addressable RGB LEDs.
>

 OK. I'll do so in v2.

-- 
Regards,
Chuanhong Guo
