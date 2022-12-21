Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4EB6533B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLUPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:53:57 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F571AF11;
        Wed, 21 Dec 2022 07:53:56 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id k185so15165119vsc.2;
        Wed, 21 Dec 2022 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=leprLY9JD3/hXcu+XjENQSWTu9dUrPT/h210JNfsY7I=;
        b=Yo9YFpUUPfeSzsi52VA89DrS3Gu4vMpE8XGrs//6FMNcq7Fp/Q88KpvI0PCRZJAafQ
         0lvPg37xG3dp1Yl9gDtCwlXmbGuJNxjYwfrjskPDcDTKHBeGiCDv3mQ5bHDA5AtjTU91
         hgrXPvNB7YWxUZJfRSqgnO+hxzt65LaTkWGU3LQBl92HwO46R1keIGrFzKniHv5mJmNz
         5PkJoVkCNgzKTsUjE55zrDkfiVCXMLCQCiho/+0Ws2FBRsirNrIKQ9bCzeqmsW/KcMeV
         oJAwrsRx0z/Iy3pdGJrBZFocz2Y9AmlKz7x5+QSlzaecVKAgIEVrz3Nrdrkit0AJEuiG
         gUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leprLY9JD3/hXcu+XjENQSWTu9dUrPT/h210JNfsY7I=;
        b=FqxEplPOTMo7LkQBcDv02bGujlv771b4HlPIaLOJKGl3nqssUI2rgrj49fukA4EerB
         rPzpkdh5zabuZQKw0N+hdJBSkOQQmriRGjpZ6kh5KT+sPJGnNHElg+wYuXuBFnh9TFVu
         Eziu1bPFKn0tGdOBX/FhGcWcdCn8silbDReQTao5fdC7uk4wG4nereVci3zACrPtQTwa
         7YZUFuGW3Usm8f8nLfvJCSoVfiiyHJ8HcM/45Y6lIvMt2YfEdYWR5ytZn9VOZw4eWdjE
         l6ZqxMktyrRROH3XwXkHbVHsYMivqGmJ/Yi5XqV+u30rfNPhm12ozVx7Gp0f5uRiBbGy
         sXwA==
X-Gm-Message-State: AFqh2ko0Mwx4T37SAvyqq9OHVabjYbKPJbYlbllbrPhpDa8+hkpZoiQY
        SFKGdfUP0gwj7K+LzQT9mwh6K2/jq+V7Yl9TGOY=
X-Google-Smtp-Source: AMrXdXtY7iB+hlGGOUUTBu75bJP0tWHEsDLn2MDc+7yYHIKKMUhin6llZ7uqIRbIkOtFY9cfcD6tGaCRsSKDkaoZHY8=
X-Received: by 2002:a05:6102:5d:b0:3b5:32d1:bbb8 with SMTP id
 k29-20020a056102005d00b003b532d1bbb8mr307989vsp.24.1671638035679; Wed, 21 Dec
 2022 07:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20221220152237.1125178-1-hugo@hugovil.com> <167155487539.723236.827037175847349918.robh@kernel.org>
In-Reply-To: <167155487539.723236.827037175847349918.robh@kernel.org>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Wed, 21 Dec 2022 16:53:39 +0100
Message-ID: <CAH+2xPDbqh5qXALhyNOcEEN0zQGpvm=Crm4GW3NRO3QdPHi6Dg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: remove pca/pcf2129 from
 trivial RTC devices list
To:     Rob Herring <robh@kernel.org>
Cc:     Hugo Villeneuve <hugo@hugovil.com>, linux-rtc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tir. 20. dec. 2022 kl. 17.48 skrev Rob Herring <robh@kernel.org>:
>
>
> On Tue, 20 Dec 2022 10:22:37 -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > pca/pcf2129 devices can also have the 'reset-source' property, so
> > remove them from the trivial RTC devices list.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
> >  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 --
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
