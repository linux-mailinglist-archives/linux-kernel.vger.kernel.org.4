Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25407600A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiJQJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiJQJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:25:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683544DB22
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:25:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g27so15108676edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99HDygkhlYlkJy1VPrT+X4XIR81rX8ldiYCS5Kh+i58=;
        b=awdS55iHEq9m/YsVeL8VJ4ffB/Rg1E3V1Lwv7O9z+YegdEb/YN4Ww52mVvg+Yr/B/o
         bbm6f22xCqM5kevCff8qhZoHz8Jk5QZWYi485SKSlr0rDZbGWF/GQjFD0ElBdPcHdbnS
         3ttKCFg/71s0SSxUpHgESfp0lS9hPKIcJLKR3rGSLiHI2gacCbNDijhVh0xWNItpcFlm
         L6WDOxy/Ng4hCFG1I3KZE1GnpRa2ZfQELYAXmW326WZJhceEglOm+bgp9GkBAwTLdCOP
         PmwkZiy8cJFvNTQUKOCxan6i4aylVXBUXyY6ZoEh9JYFdJnXBid0PmgCB2aCTAFY5uyo
         UxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99HDygkhlYlkJy1VPrT+X4XIR81rX8ldiYCS5Kh+i58=;
        b=QteEmZiFevMWuvAQ1Ugv7Um2gRTB73gxw4w73LlRoFta/Vhu5i97MV57a1f3JWCMSW
         1+uYEMcFX7wnCnnNA6Ip1w5cc4/5c3KKYI3c8hMCJ2qO19+NRvXaaaHpNP2qAFA+zlnB
         jnos/lmKhLAXFrm+DzXKaUZZjWxHP9Fju99cbaG93U4kY3k3UuJoZ1AkFeG6uWqboyTD
         zI7f2XGbHhLmyRormMQgid4PkImR5bqif8fx018W448nXW/Tc/3LLP22JKZJ5Iis6tVO
         V6lJQnGw13LbR2fPagQd3SW2sczslrP+Ueogci1tjI3eaE2/dKl1W2lu84ISoJQdk1H5
         P+Dg==
X-Gm-Message-State: ACrzQf2bIagftCl+l68+siHknxbDCUhNNMoDaNzAXPHlmKiAEdCY3G5k
        T7YqZhs98hsD9yotIUdADwRPzwrTvWF6ElD+P7Rd2Q==
X-Google-Smtp-Source: AMsMyM7/azQg/5PEExog+1KORHtKOVrMXyY6GoCgMPlspSuXgL5EjVNSsRaF5/QTUPBBst867ntPiBH0ZWsO/2OcPmA=
X-Received: by 2002:a50:eb8f:0:b0:458:482d:43de with SMTP id
 y15-20020a50eb8f000000b00458482d43demr9417498edr.205.1665998703017; Mon, 17
 Oct 2022 02:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 11:24:51 +0200
Message-ID: <CACRpkdYMa=bG3R4yfS25JZ=70=dOveFy1JocJBs2BOiBWP06PQ@mail.gmail.com>
Subject: Re: [PATCH 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM
 pinctrl schema warnings (5th set)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 6, 2022 at 4:06 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Patches are organized not by file, but rather type of change
> 1. First patches is for common TLMM schema and dropping unneeded refs.
> 2. Last patches are pure cleanups without functional impact.
>
> Overview
> ========
> This is the *fifth* patchset around Qualcomm pinctrl in recent days:
> 1. First round of TLMM fixes: merged
> 2. LPASS fixes:
>    https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/
> 3. ARMv7 TLMM fixes:
>    https://lore.kernel.org/linux-devicetree/20221006124659.217540-1-krzysztof.kozlowski@linaro.org/
> 4. ARMv8 remaining TLMM fixes:
>    https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/
> 5. Fifth clean - styles and using common TLMM schema: *THIS PATCHSET*

Blanket:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please send me pull requests for any parts that need to go into
the pinctrl tree.

Yours,
Linus Walleij
