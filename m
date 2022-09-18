Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6B5BBE8B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIRO5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIRO5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:57:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5341220184
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:57:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l14so59165545eja.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dyWurCv6umTff7vcMJzhKPxGOrO7Im/vE4FnLmopayI=;
        b=py+uqmM2y+DHXQXns/qqCb3l7AXNQasq9XD93G7XbAR9QQv3q5oyGJtXTqT34Vvf51
         xteKNPjjHEpK13pUtnGQ96BPNm9dE8/q9Dc/Wb2I67/G07Mv2oqzx177Cqt9RlzxtOQP
         L3rEWs3HRxcMw6sIMHQSSA+mgEy14aHMVxNfC1b2G1zS+NfK/bawJNY8X2MzMM8gE79R
         T75w3FSVsQdpgZ5bLKnQ2CxCIWiIHYl6r9ND2pkxUb45FbOLcFpeBEpMXt/1bzsF818H
         7U7IbNk0yiVsvSDp2Hy35SuLi3KLfxVyuZ66HrqQ7COcfrMT/HFQSFygCHvsfByZkRzX
         Ft/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dyWurCv6umTff7vcMJzhKPxGOrO7Im/vE4FnLmopayI=;
        b=KRKRbyAUvd1TtJL1Kb6R6/Lo1eXrRxA6KRUgcddVDDC0FzxtuTdMxy4iqR5FGLGoc/
         VE/t+uDaI2UMyGhZZ0qm5Km2RrK6Jw6wX9M4TrlU/fkn4MlRi8+yVspYzBJGb/FaY2f+
         R0m92sUHCzJKmgVCzFt2Frw2KuAyDJJiBezkJ3BXX+0mJLB5u6gbh1V1fFMViAuYJci2
         Y+btv+/r3Iy0Fztk8YZIDrVJCqXryjo5egDwJ04Goh+xQyrpaOROmzYS/8Zuear1iMg7
         1hToYAu6rPwchjvwkNO16JGkVH3wPZM/UNJcm66MdJ6AIaCR+RywQvEmBjighGUODWFS
         gVIg==
X-Gm-Message-State: ACrzQf3XfrFzpO+GrswhLP3svJssNMeziORzVzrko+g+lNMPUmNEKsjc
        igHFcsWUssEkO5laZR5WS7Cp3SbxzL6Zh4SOUvgHf9lRki8=
X-Google-Smtp-Source: AMsMyM4gHCdoCTZOpAzWE3ZHy04U3dFyvJdXBikAiGPHZsPCm1QjzXgnd1p3smxr22qT8omxuxygwWfQhAF72ibaRHk=
X-Received: by 2002:a17:907:e9e:b0:77f:9688:2714 with SMTP id
 ho30-20020a1709070e9e00b0077f96882714mr10108201ejc.208.1663513048951; Sun, 18
 Sep 2022 07:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220914071306.3254881-1-s.hauer@pengutronix.de> <20220914071306.3254881-3-s.hauer@pengutronix.de>
In-Reply-To: <20220914071306.3254881-3-s.hauer@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Sep 2022 16:57:17 +0200
Message-ID: <CACRpkdZumA8=dFZ6CzvkQ_SYO62V5YB9JJ32M3-Ta3_6WCheCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: gpio: Add gpio-latch binding document
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 9:13 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> This adds a binding for a GPIO multiplexer driver based on latches
> connected to other GPIOs.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
