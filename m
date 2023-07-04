Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE20D74764D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGDQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGDQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:18:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5B8DC;
        Tue,  4 Jul 2023 09:18:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d3a8so61082245e9.2;
        Tue, 04 Jul 2023 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688487492; x=1691079492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nI8tUMgDhEdpyNYB/YO1aEnXiY794w1w4iPgAjar+34=;
        b=ItTeBv4l15fG2/2aUpz7byKAn5g0biOiC/fx8+A6NBIWO8KVs4BNjHVlPBGm22NT5q
         dxkovBfNoZvC8kQSyTBi+izaSMGhQhi3W/Bp2IfnIqfaVZyosX6+iVO6CDznnfG+L1vs
         m6fpZyC7RRcXMpkH0UnOQy+NdiqQKYwqWSiwHHsILiBF8re3Dwx+ajIPVPV6IM6Cv+or
         AyLsrnrQBrTBWde4PVvAEuVIw6r2R0IBWqgOX6sJg+HHNktC+CoeZ7OaHMuWK8xh9RhK
         G66/YQXM1tU8urtYqHr0zgUlIpYaiGZzd7Ux6W9MI88eOmG4Pptf+XV7cIZwLciPd7eE
         WaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487492; x=1691079492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI8tUMgDhEdpyNYB/YO1aEnXiY794w1w4iPgAjar+34=;
        b=e1OMAXV5F4SkEeYUlF4I5T5GKDHY0dNd4+zF3YX8q5QgfUhhuhkuwhf+KS/gYszLw0
         6qYnekOQoODeAjJL9r+vsW7HhDxyycopk+Cd9Xwd9kTGGslyFTxIPBgA+5E8yiL7z1c9
         xah1KOUVpPDwO96Ks3GJAJ7tnu0MD7PHrtCC9IqYiAG9/iiSOsLrpEtV8HLPsFT+b9IC
         XPrfSr92kdyGQrGqnr1CkGfAVNb1eQqlhleVZ0I/AUXg0715CjwKYG/oKkUiMcQnSl5F
         E/grMZhDSap1iiOwst125bbf7zSkUlIqIAd37+4R0aFQmvgDa9THnSizETJEgffGv5oC
         ILgA==
X-Gm-Message-State: ABy/qLY2oUF+MInCfdLJIHsjsr1HrZGd8fLtZia+ksVl1xFBjsZIiYHl
        xPX/gt2W6AJB0hSXHEM754pLNAhcKhlWDeo/NiA=
X-Google-Smtp-Source: APBJJlG+cnJ/93rVQl1tJXhZpFezKYLGiip0i1kztanotmE2J9rqGcQeahjruTDeuYbCKyVOFI3sSF8cQlR+B99bhrU=
X-Received: by 2002:adf:ee41:0:b0:314:4db:e0b2 with SMTP id
 w1-20020adfee41000000b0031404dbe0b2mr10971046wro.15.1688487491565; Tue, 04
 Jul 2023 09:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230628164759.67594-1-dg573847474@gmail.com> <b6d3a872-f32e-bfcd-b603-c08339737045@linaro.org>
 <CAAo+4rUzusAyyffkCvEq+wJQacqfrcTx-SviqXaTzPsqOkjB7w@mail.gmail.com>
In-Reply-To: <CAAo+4rUzusAyyffkCvEq+wJQacqfrcTx-SviqXaTzPsqOkjB7w@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 00:18:00 +0800
Message-ID: <CAAo+4rV1gFhCpS0=bQa-nBmDLrQ2tensXii5GDfEkTb=9SvbhA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alim.akhtar@samsung.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please kindly note that I am resending the last email since it did not
reach maillist.

> Hi, Krzysztof
> Thanks for the reply.
> > This interrupt is a threaded interrupt. Therefore the
> > s3c2410wdt_keepalive() will be called again from process thread. Are you
> > sure there is deadlock?
> Is it really that s3c2410wdt_irq is a threaded interrupt? I could be wrong but I can
> see that the interrupt is registered via the following code. It is the third argument
> of devm_request_irq but not devm_request_threaded_irq or request_threaded_irq,
> as far as I know, it should be an interrupt handler for the interrupt line wdt_irq
> executed under irq context.
> ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0, pdev->name, pdev);
> > Anyway, please also strip unrelated paths and rather use function names,
> > not references to lines, because these might be not accurate.
> No problem, I will provide a new patch with the function name soon.
> Best Regards,
> Chengfeng
