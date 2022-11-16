Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09162CB86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiKPUwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiKPUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:52:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E1623BC;
        Wed, 16 Nov 2022 12:52:26 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r18so17863745pgr.12;
        Wed, 16 Nov 2022 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gbYnmWfFwp1UDbDUMiegygKv0UO9A8Z8IaNCbOZSzU=;
        b=ZuFm3T0GbXgpL4+Y5uxJ5YntrAhi3/VZhVIbvw9HuLzbn/NxDqFkSZAiTC/sD0VOkg
         RdJF3ZvKPo7k5dW8uwerVP4t9egAF1OxKJfzfa93Ey3/irSC3USBI0Di9f6MxQpIflWK
         fgUQnZcgH/8v0LHckM9iSCV0+/9NA7ayuhdgiWJkmQbMYqSVSntm+e3+O8+bqJGWN5wW
         E389c27RsZrDny3kk2GPGbwptemvo8kwzvm3wJTgFNXDaLC2OY5750YqPc6BPuMco1aU
         lPvfcpcdnFT5r3lCkUPBpBNfObmriOMZIDoJ71xzrvZtv3mAzv43yy3FaYO5u2wwDMZC
         Whtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gbYnmWfFwp1UDbDUMiegygKv0UO9A8Z8IaNCbOZSzU=;
        b=rnnR1PC4LsR1PC1tZE40oF/P8ycBZbu7Wxo+GmpRwfJPRW+od0A2NYb0IxvzxRTivQ
         d8mWMZbZU0Gu6FrRYr+UeHo4UiX7hJCv47q8DX/x62Lg/vC6H+mHabX8IolpFc1tBBxb
         1beuo3VxAH6i8k5xS+H+hMp9wvTJjRZy7d6NWyNmJjeEhYoeDjOejJoUIG7r3gJc841Z
         ujKPcBLMySWy9xj4ZKCxMjdljpWtWf4iXfI4luxAUO2kwMUFt18kRGblMib/924lRsoS
         sW58a8atpj/mn647plAe3b6HK9BqLpSangXNxdzTKffoWVLT1K8Nmjul+05EjMdzFyOD
         taCw==
X-Gm-Message-State: ANoB5pnhAj/muglcjUIGVitFPA6eD7jw4pY6MB9c2L/UtX2YaI/4vj1B
        8RBa8Dkvqmg/XgUM8XGJXQkVme60SAwXUrkt8Zw=
X-Google-Smtp-Source: AA0mqf5h+7Zor/qxsyOAxV1pF12XbZyA9VLwWnUFiQLfL+et20EUzEZe94gNRNqDJ18RD4nbJD3hSt5F9JAhH6lMMcU=
X-Received: by 2002:a63:1e05:0:b0:434:911a:301 with SMTP id
 e5-20020a631e05000000b00434911a0301mr22751990pge.50.1668631945505; Wed, 16
 Nov 2022 12:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Nov 2022 17:52:08 -0300
Message-ID: <CAOMZO5A9dhxtv2di57tkumS5Y7uDvkKqWvt4MfB9bbdH5dTPwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB offsets
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
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

Hi Giulio,

On Wed, Nov 16, 2022 at 5:35 PM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> Fix IMXRT1050_CLK_LCDIF_APB offsets.
>
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Since this is a fix, please add a Fixes tag.
