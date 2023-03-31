Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3D6D2099
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjCaMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCaMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:41:25 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E22033D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:41:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5416698e889so412732537b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680266461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRZsZGRSBUttBDdfhkXu+iVZ6M0OXbmk7WZu3FuQ8Jg=;
        b=bHKkubKvpHVbMRxx1j06pm8nus5PdJq7l9RkcGq5ExEKZR2/osMq1YWgwQkIL7fmLJ
         kW26fA9F5tE+XNhM+3jMnlOpQ6srJDId+r356SPXqg8V/i/VdF0o1U1BtiJIqyt1nHYM
         yOqUFFIl3GrWuDrpMHpLAtnTl1AYwkFAd1roVvIiTVzsbcrj6TDqpvmmeT19fCx4BxSG
         iXbP5u5VVhqd6lajF32hLW6wgK832F0brgd+B0fgfM5k7Vu2O5DTAJx7QcQ2vS6FeSB2
         MlJcD2OcrhueOEOgRzI+GbeQmlZ1zMCGdB2SiLD3/9u0iHFfvh/JNniF89XFiqsW8Llz
         5c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRZsZGRSBUttBDdfhkXu+iVZ6M0OXbmk7WZu3FuQ8Jg=;
        b=Um3aQ9zQdHt4Gh2YuKVWYgBAOp85CDZ8ZHFFKCcBY6mR1NFXL6auQmIo+n6NK3JE2H
         j4KHEucGLEZvxI9qqXenM5PwC0w6R+895GLgCiEVzfbsA4n2OnoJfmhqpZDKtmfLG1gE
         nhnVSLn0oXeN4x52ghZvlg9JRIbimhqbLAO4kXwaEq7qOziFQy/WQpyvhKLY37sQz9rY
         zi1mWT0L3GISLscQreWkEhQCDqbHR6y5Fu0NTXdGHop9WjLLDhCyJKC/38t62AHb1bFv
         HeT6P5xWCHwlI3csluY/xBm16t0LyhTAFUQllmDCA3JgvMSFNQ8d7z3kJRZoiVSkgUi7
         e+WA==
X-Gm-Message-State: AAQBX9d5W7NN68ARcvJlqNa1GZjb589HHyAaqxj9G4NrsbeJYqV3pNcj
        Jtex3xSogPxxqqO4etoVgouzCpW/LycnBU99I/+T5w==
X-Google-Smtp-Source: AKy350YEjxPDjbwYwsSFrCU0uQJYztKPQjzwuEM1U/PujPKxlNAw3tq/F6qGz4Sr87IntJwwOldydyNsV49f1QjtAPQ=
X-Received: by 2002:a81:d007:0:b0:546:81f:a89e with SMTP id
 v7-20020a81d007000000b00546081fa89emr7575796ywi.9.1680266460814; Fri, 31 Mar
 2023 05:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230330212225.10214-1-olek2@wp.pl>
In-Reply-To: <20230330212225.10214-1-olek2@wp.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 14:40:49 +0200
Message-ID: <CACRpkdZo4VKixBM9XLsiUVp+wcqQ-irY9DjNCSNeh4CfUYVWwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: xway: drop the deprecated compatible strings
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:22=E2=80=AFPM Aleksander Jan Bajkowski <olek2@wp=
.pl> wrote:

> This code are marked as deprecated since kernel 4.5[1]. Downstream OpenWR=
T
> and upstream switched to the new string compatible 7 years ago. The old
> compatible strings can safely be dropped.
>
> [1] commit be14811c03cf ("pinctrl/lantiq: introduce new dedicated devicet=
ree bindings")
>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Thanks! Patches applied.

Would you be interested in listing yourself as maintainer for the XWAY
driver in the MAINTAINERS file?

If you (or someone else) has spare cycles I would be delighted if you could
look into converting the bindings into YAML.

Yours,
Linus Walleij
