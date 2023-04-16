Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC36E3B22
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDPSWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDPSWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:22:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622662694;
        Sun, 16 Apr 2023 11:22:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so22676102pji.1;
        Sun, 16 Apr 2023 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669362; x=1684261362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaBkSjxGBG3XIJ1FYgsA8G9zRuXKKIggECA7NcbO44k=;
        b=YsKq9g7pMOu6Jquy6xgL2KaNnWh1PnKrCh1V6EENFiuSiFgXtllElRi1s5w2jhw8AL
         WcEbnVp8eaHp+aalSP63m0p9oGY4NcB8xewQWUSR66i2Zfp8uCtvH4aCai+wuJKbbGg2
         r84JkvJJDyng80e5ZbCXoZjOq0j7rx2iIAJ2/g/n60YsJDYtdgu/CmIarrQ06tYliG6Y
         tqHCQ7GvjFbOno5tVeA9dU2LLNqJmZGLw3w1d5qztS12H1BBa8EmupncD0aNnrpPxWy3
         ae/hJROcHRfrF6mvImHqsJY8hghBdYgK04AThlo2QV9oLeRoZuOJFYtj82YIOX+fp1/h
         ZGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669362; x=1684261362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaBkSjxGBG3XIJ1FYgsA8G9zRuXKKIggECA7NcbO44k=;
        b=Bx/aliyxo7XEn8uMCB4qf5Mpg20d1zYQIKp0vwoiJ+LAW7lrhx6P/DW7N3PGEdoL44
         QpUbq9hxwX3qvb2agzc17I27MqkiWJ+p1uB2PsSGPKPKiZq/3fzyN51EUFCAWnuo4xP0
         TaSMwpSQIV7AWDM4HxJmNnYUK5VobbvyeL1JTpXAMJKaaxV/u0GmZh5ETUn34kbAjF2X
         iyhS/x54qeCYaZLyD2PziyzzeY8tYepCul/Zjcf5Gp2h4rWfvtUX2r2c2dt1tdt8Gib7
         RNbz71hNvgCUA5c/ji9S/EvhgF7cZrIfSFUvM+nQUNuQL+a83X8mo6YFLaFS5nKrWBzC
         dvHw==
X-Gm-Message-State: AAQBX9dnCaRnZNUCOottFhfxuC+5uk1z5cA5tEtkBswGdi6qnVbvmK0q
        QQQJp/IUAYrLfmTVDzM1BtlpRJTPoZSChGy9jDqKkSkafI+lb0GdXxM=
X-Google-Smtp-Source: AKy350YzdtmQcz7ajtdhR9XgLKTTKbtjheytgqznDTHe49ewX7nGE8zamjahx07yTFhpnPoyL1cUohgM6nveUa/V54g=
X-Received: by 2002:a17:90a:6a8c:b0:247:5922:aacf with SMTP id
 u12-20020a17090a6a8c00b002475922aacfmr1252117pjj.7.1681669361743; Sun, 16 Apr
 2023 11:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230416173302.1185683-1-mmyangfl@gmail.com> <20230416173302.1185683-2-mmyangfl@gmail.com>
 <c6571a6d-bf55-14b3-102d-814af6763be7@linaro.org>
In-Reply-To: <c6571a6d-bf55-14b3-102d-814af6763be7@linaro.org>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Mon, 17 Apr 2023 02:22:05 +0800
Message-ID: <CAAXyoMO3PXtbc1KxF10+BkMNEKKQuVrHKmR=n8rRPJycbQyxug@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: Add simple-clock-controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=80 01:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 16/04/2023 19:32, David Yang wrote:
> > Add DT bindings documentation for simple-clock-controller, mutex
> > controller for clocks.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  .../clock/simple-clock-controller.yaml        | 50 +++++++++++++++++++
>
> Where is the changelog?

What changelog? Series changelog already included in series cover.
