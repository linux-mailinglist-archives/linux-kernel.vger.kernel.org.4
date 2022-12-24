Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739C655887
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiLXFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiLXFwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:52:40 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71527F591;
        Fri, 23 Dec 2022 21:52:39 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v70so6274196oie.3;
        Fri, 23 Dec 2022 21:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=omScPyObEowtBC/T1QHtSgqOgI2Lj6IQSqet7WW+kzE=;
        b=nXWBDzb0j3GKBpNChYC+F/URluQfNHMduC8wte5BNs5w4x61mwl8IaTeO6/r7giLPY
         I9kaXhcIgdvqR5eFoe3/kMAjhS0H5QDjhprLWUAYPGd5yUQqTrl2e+xsckNYgQ7sgrzo
         ew6vUKUmYLXXXPIkaITM2+BECTevh46PaFr82Zg/UGDdlRQtRUN0v6L673qE3O3CVlLG
         fOOZu3rGGdX1HlpdR52/X1u0Qke3PbOsSbYMbsGqjWhAmhKslXQh8kIszM83OI6V+uOU
         UGk1ahXKiQT3OU2+DdSJlQkWY5zQXYcEnb8IwH7JPWJfYtZyGeGN7lee0u708r2xwmqx
         fEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omScPyObEowtBC/T1QHtSgqOgI2Lj6IQSqet7WW+kzE=;
        b=CfyuJke9oDolSwsamd7T4xSXbYuvkmK7j3jNx1GaFpFgSRK47emMyf8ARzHU9ShCfm
         bdP0XMrEani5ZJ/goI0VK9t3V2L3a6sZhRxXVY0U4P7s/dkHSo3YwM87ZWhpvZbqGQ/r
         1WR78NEzS//T/e3Y+Wenkw8giAc4VxGfkdMccn6m7hutISHE2RP5ohprAmH4+AsqrJz4
         QRHTK9U2xbSbd7571ELA4i5PJIZFtJei43HSaPp2uDy1FNciJIO0vYi98TPbC8DnNwDS
         0o/KsLvaxBXa3vzwmQ/lqS7SSur28lkDVoiKJXG4g0sS3frTnY7sy4QN/hl6C476ZyoI
         kbhg==
X-Gm-Message-State: AFqh2kq5WxhKqZAwhcpPLZGTLs9umx0m0JNDXhkOsAVecNX9mFLAuGkW
        AHQve6UPwhHuhCsqTJSfrPtWOqQK/RBbqGsSZDJsMn6a
X-Google-Smtp-Source: AMrXdXsNiOYulPmiBvgsUQC0zRYprLdayUSm0DxDOlYrlx9HYZWL3VwviVbn6BWlRkb/QQiv/MRvHJlODgn4pcXLCBU=
X-Received: by 2002:a54:460e:0:b0:35e:776b:1619 with SMTP id
 p14-20020a54460e000000b0035e776b1619mr468987oip.98.1671861158852; Fri, 23 Dec
 2022 21:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20221212045558.69602-1-gch981213@gmail.com> <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org> <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
In-Reply-To: <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 24 Dec 2022 13:52:27 +0800
Message-ID: <CAJsYDV+Dth6BFhXhhZsWuJvySh92=5++_TA50ZDj+DrHUN1niw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-leds@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Dec 24, 2022 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
> > In general I am fine with it, although there is still question for
> > adding more multi-color defines in binding headers to replace this
> > property - GRB/RBG/GBR and even more for RGBW.
> >
> > Pavel, Lee, any thoughts from your side?
>
> This really needs to mention the name this hardware is known as -- I
> believe it is NeoPixel.

I'll do so in the next version. I'm actually waiting for an answer to the
comment from Krzysztof (whether I should change color-index) before
sending v5 :)

-- 
Regards,
Chuanhong Guo
