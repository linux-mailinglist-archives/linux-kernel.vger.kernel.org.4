Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF8611A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJ1SwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJ1SwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:52:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531FD22B3B5;
        Fri, 28 Oct 2022 11:52:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id k19so9122189lji.2;
        Fri, 28 Oct 2022 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gdWn4WdaMz/orHTAzTV9G0nntj7JTXh23bqgGD28ww=;
        b=IlIMFaVvVPTKibfA9BQgsl6WlDe6xi3m4idFQLiURGOQyhN8GFQQQFzvvyRXnD8he2
         T21zJmDFV5DckThnOPksEsSfiJFBvQMprH0xtSSfAtSpn6zO0Cjc0Yxtp+LtKIrGQg/y
         PLw1kC73/9lVhboHHGzJAx4oKBDtFV5mbkgd2T+lfZZcj8x2kiEVbX7den29NDjlH8g2
         9BMCYYXGQDcCy/6qYq3d07fXwrupU0vQ+syCzOwFPxgcAl/EBYglrHaJ7NSuzDZzavN6
         w7yLPQSUXCBZbsXsiYpnc+oaYjOvAffoqDkuxgGmsLUoVgfxJxYbbzG+x36N03gai0sN
         OWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gdWn4WdaMz/orHTAzTV9G0nntj7JTXh23bqgGD28ww=;
        b=ydRyn2UZF7Dl8xRFyUxLc0yiEHGZMeboatwrYo6/gGsjkZfD47HGXBMV0EOGVW/Ea5
         Uf9iVR+0i24MH5a9iqz/9GZnTcPw8rcREzIXzMaEKmJNhQ1jL1hTVK9DJDwMHlxAZEn0
         qy4/z0nWQsas00sgCwqJw1BhxH3a+rA8q8Z5OdQZRCgx4ysVeHZY9g6ICxPdQxxl8BIS
         8GN2l68cr2K0pde5bYOpexRIcfLiS7wC49G9ZZVBVnziVyUX2qPgqKTrXkGPGWBr6riq
         mFICsPCLP6Sd/mkxixs3nBUZgPiilTIgiJvp/LgqdLpauzWxm73iWlZNj4a6y9bWUpQ5
         HaRA==
X-Gm-Message-State: ACrzQf12COXC12eQHERvYMTuYxGsQKTBr6eVh51cfnWFfL/CtiMU3KQY
        F/VuLl5NV6BKpk1GgvPzX94xHAqCX+2hmPuM99g=
X-Google-Smtp-Source: AMsMyM5VRH4ZpCY4vOTfbRgY2tlY1P3ky5WrY7Fz0QRermYZFqN2uaE/zebFoOjmW7Y2t2HShLgeo8qoKuu7FMxmtTc=
X-Received: by 2002:a05:651c:1073:b0:277:35ca:5eef with SMTP id
 y19-20020a05651c107300b0027735ca5eefmr372209ljm.150.1666983126676; Fri, 28
 Oct 2022 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165215.43662-1-fnkl.kernel@gmail.com> <20221028165215.43662-3-fnkl.kernel@gmail.com>
 <02523fe5-bf99-9891-d00c-347893d5dabe@linaro.org>
In-Reply-To: <02523fe5-bf99-9891-d00c-347893d5dabe@linaro.org>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Fri, 28 Oct 2022 21:51:55 +0300
Message-ID: <CAMT+MTTE84XDf8c0D3MLxZ92HiDP6DhXfpHVyQZ7hfYMUkL7dg@mail.gmail.com>
Subject: Re: [PATCH 2/4] pwm: Add Apple PWM controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 28 Oct 2022 at 20:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/10/2022 12:52, Sasha Finkelstein wrote:
> > +config PWM_APPLE
> > +     tristate "Apple SoC PWM support"
> > +     depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
>
> Why this code cannot be build on 32-bit?
It uses 64-bit divisions, which causes it to fail to build on 32-bit
mips. It should not be a
problem, since this hardware is only present on 64-bit SoCs.
