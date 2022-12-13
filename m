Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3064B241
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiLMJW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiLMJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:22:17 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25715BFB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:22:16 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3e78d07ab4fso183762877b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBVWcvC1u9pZZ+RLRidAY3qDuAjsE1IgCmnlft6y5gA=;
        b=D9xzxVM6u/qGZ1rHp1JhPMXBxCGZtD7foj/3zej4cipPsElJbjyc/XcC94GX9aIOOT
         z6sWUQLmMeHVughuq7k7+IRSkiyQIRtdVJQ8+afJorVc7L+cyWshvdhVJKASkWpIu0J8
         ZaFnqzlA79slFpYFxLDoYBP+l/D0f0HPim/0Beex52mt/lkXfkDpbZHNwQ/Wfxtj4aaD
         sD33FmQ7ajRIW5cXbJ/duAKO4FmMmV1NxY17eEQiiDETdKczAJDJQrubBohquY6Y9Ge/
         p6K3XTjHjD5kpZ+Cv+53vA9+iHW2mNjshoxvwYQGPr7mEgPufTT601MZXBZymh0/PCa5
         DSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBVWcvC1u9pZZ+RLRidAY3qDuAjsE1IgCmnlft6y5gA=;
        b=PpIusw2IZYLPuNLuIBePpqQAn5VTpKgEus0qIt13cmb4noxtFhaShIxSkH3Ys7ghD/
         VNJhy/ohpy+CSGRtrC5O1W6RItRmXeVtVDLXrb72Fe+PFzJPxZ3jg5Ul9ek0vQVYiESc
         ZP4dhVpOs4NN7A8Xp1gsfo6mEu8YGrrKvT39CsPwW8HsEyXH4nMlTOoct7DdhJVWD0Re
         09bWRyyWRguInTIOMdRU3HFNUkE54aysn9IyawZ3OaECWlhYwAEU2dtQ1x1KgTj5mTNn
         UcYb+KxymCv+sXFHKa5EGTmfaaEMvs97a/5DzkFa5ZmZ7dnuchCuWRW7WX2CQ9+gestx
         NFRA==
X-Gm-Message-State: ANoB5pl0A58N+lHj5h6d6f+LbxXXBSfLut3ZV5r8Fn5itCCNBISvtWDT
        m23mGELaZGEjhDeUjfQJJvSQ87RJE7TZslG1FL2Xcg==
X-Google-Smtp-Source: AA0mqf4qLj/Z38psyROEDntD7BWmQ6BmvZhUitJMG118kXs8N9Obmriyo497ti72O/iSoZkHde1mhe+kvJEkiehpZvg=
X-Received: by 2002:a81:6fd5:0:b0:402:3dcf:a262 with SMTP id
 k204-20020a816fd5000000b004023dcfa262mr5023789ywc.31.1670923335392; Tue, 13
 Dec 2022 01:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-4-vadym.kochan@plvision.eu> <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
 <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com> <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com> <VI1P190MB0317DADE7450282444BFED32951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <44f642bc-8810-80d9-368a-15994de7f50d@intel.com> <VI1P190MB03171A8F65844DB789D85B0495E29@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P190MB03171A8F65844DB789D85B0495E29@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Dec 2022 10:22:03 +0100
Message-ID: <CACRpkdabqqttBmPTQZmV_78oEL7+pgGaKzJcL4CFUA4SU1=tzQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 12:40 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:

> The main restriction is that only lower 2GB can be used for DMA.
>
> I already did send solution based on reserved memory, I can send it again in context of this series.
> Also what about the solution which Linus suggested ?
>
> [cut]
>
> Let's just create a new quirk:
>
> SDHCI_QUIRK_31BIT_DMA_ROOF
>
> Define the semantics such that this will allow DMA for buffers that are below
> the 31st bit, but does not have the semantics to limit scatter-gather buffers to
> be 32-bit aligned.
>
> [/cut]

One does not exclude the other, so you could technically let buffers below
2^31 pass directly to the DMA engine, but bounce any request above that
limit to a low memory bounce buffer.

As Adrian points out there is also the code complexity question, the solution
should be simple and elegant, if possible. I think always using a bounce
buffer might be both nice and efficient.

Yours,
Linus Walleij
