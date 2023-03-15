Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6E6BAA05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjCOHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjCOHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:52:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914F6A40C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:51:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53d277c1834so351815557b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPU5bcvN+ja57Qzk1OnQ4trOOvPreLQcmcg5Zu2zilQ=;
        b=UJTj1dCSg+Z62dlbx8pj3dwfcAbcyNHMBwadqrIn9NocqJ9+puYm6DrSGct4BWwBnc
         /z3xNiQavF6wS0LUfmGqhXAxx3yWcVEZ62DiL/fe6t5l74W7LHc9er5wZhMxTYsUtTg7
         22VJm/Ed5Vmdj5Nu8pBEMdiLOlXoYPbjV1/NqVOQB3+6iE2X06t6Mg6/51hMTvmcUD7L
         2L9ToyGfVVy+GrHBsgoLQx9SJfK6Uu6oqq0+O60p5mujVY8CflORh7xAkF60RDYL1X/B
         BDfQ2a+yNv2YAdd+lk46c7xCi6F8ZUWSspZVOhkM2ZWYiFEfaor+OAvvFq+mmwP4m4l6
         mb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPU5bcvN+ja57Qzk1OnQ4trOOvPreLQcmcg5Zu2zilQ=;
        b=Q586XnpLleBdwc5cLKY3g9CgIM3MkV7xv/Ytp+S96oP6N9v91EOAzQWyEPZt7BWbrN
         KR+lx2OkawWNy3091w1dEBgjjTyNTLdJ9iDTYRhDJ9lK9mXRhxSm8ORtjzuvmmUYkA1z
         ET/eqAcTIOZTk69v2YoxvFzIDwc0I89QcNELgKxRJUXhiBkvopBEjWXwiT+Ymb5zNc/f
         VdXXgui/sUOhg/duDNM9ajPnbgrVb93R2mvuRO8huEGgOKHH43Q0TmsDOjHRU4W87Rqu
         iT58FJt8e/O2c+K+Z//VJxfGYzxHuD90YTwGo0qaPeK0uCW6Ysz5UaBnYQl2XbW8G7vw
         x4RA==
X-Gm-Message-State: AO0yUKW3ZpaK/Kw76Xem5RyuKf5MfjszTnM1W//V2kFhlWzg1jFqyg1i
        aKir3qyilT2c0J1JMhshe9xIgiAqrbcSGdRTvklXMQ==
X-Google-Smtp-Source: AK7set+lw7STkN/UzFTL+w4n8eTYmXxFvByHlAw57fOJHTZl6Hi6EDky+/gbK/7+FXjNUJLNEQvylbtWi71VdnW8ntw=
X-Received: by 2002:a81:ae04:0:b0:534:d71f:14e6 with SMTP id
 m4-20020a81ae04000000b00534d71f14e6mr8975707ywh.9.1678866682275; Wed, 15 Mar
 2023 00:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230314225535.1321736-1-sre@kernel.org> <20230314225535.1321736-2-sre@kernel.org>
In-Reply-To: <20230314225535.1321736-2-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2023 08:51:10 +0100
Message-ID: <CACRpkdaunUeHRcOrGw8UjXSquuEXAzdawis4jffQXBJHv8DqDA@mail.gmail.com>
Subject: Re: [PATCHv2 01/12] dt-bindings: power: supply: adc-battery: add binding
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:55=E2=80=AFPM Sebastian Reichel <sre@kernel.org>=
 wrote:

> Add binding for a battery that is only monitored via ADC
> channels and simple status GPIOs.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
