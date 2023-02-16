Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A978698C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBPFrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBPFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:46:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169927D48
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:46:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so1402566lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXnpNrsFLRDRV5H6+heFUubgTFXomAt3idt+/hXx6hk=;
        b=DR5HTzIRcGCfsQZrTk3dPz403ec4zkZ7v2QGxwWTqW4brRantS4Q8hbkgcqIPGDnZS
         beeohWGG8lv6h/Eaw0k9W4ezb2NlcjU1wrTKlGBQ126PtulC+7xJHPBmlJBQy0gWzNN7
         LKKa59sNKBZIwArta868ZHgo1AHIxCgFw63Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXnpNrsFLRDRV5H6+heFUubgTFXomAt3idt+/hXx6hk=;
        b=orbCXSOv7gp+9sQvIAWm0tb00vywbtfFBXSwa1OWrhCJeL1iWgzT2dZHR69FpOzb+p
         p7IvA1ny2rRKl1Ib9p8wuTJwwRpqXBb7b4LEgD/IuTibsrrrPCECt0cWpHKDaTKwZ9DR
         DSZuYPn5/HVDNqvVa57YChmJVxtFfwcewGFsKrn+DqzIXgJfR0/Ig6TjCQlug/INAIp1
         xGUb5TnpY8sAcUNCl3FKuDmGdpMOrFxeBTMKJKiIx7lcnQBZNF/QcHAarZlBkx668riU
         rL/+i9pRxNhQjqncnd8cDfpaSHPvByFz9meT6IVZZrunX1+BShK6lJDcn6G5A7aolgWh
         PeyQ==
X-Gm-Message-State: AO0yUKXM5xFMrSOgByfk4zFkLhfRlcaKGuCeQG+EaXupbBWlOmpDurRF
        1ciEJbtILuM5/15AmcHDoeTxnTnjxceTnJpVeaE50A==
X-Google-Smtp-Source: AK7set8f23g7p+AR/YkqBF1Ux4RWNPz/KaYIccAQgKR03jXTvlUKhYKx543msIPep5T6lNeGd07g3VsILIOSERAdQrc=
X-Received: by 2002:a05:6512:239a:b0:4db:1809:29a1 with SMTP id
 c26-20020a056512239a00b004db180929a1mr565281lfv.2.1676526412762; Wed, 15 Feb
 2023 21:46:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Feb 2023 21:46:52 -0800
MIME-Version: 1.0
In-Reply-To: <20230213165743.1.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid>
References: <20230213165743.1.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 15 Feb 2023 21:46:52 -0800
Message-ID: <CAE-0n51OSS=Nh2pZmPO3mg4QCvqGZsJ+AFBTAUGr-TZBHCPLCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Fix trogdor qspi pull direction
To:     Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     amstan@chromium.org, mka@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-02-13 16:57:51)
> Though it shouldn't matter very much, we've decided that it's slightly
> better to park the qspi lines for trogdor with an internal pulldown
> instead of an internal pullup. There was a footnote that Cr50 (which
> connects to these lines too) may have pulldowns configured on one of
> the data lines and we don't want to have fighting pulls.

Ok.

> This also
> means that if the pulls somehow get left powered in S3 (which I'm
> uncertain about) that they won't be pulling up lines on an unpowered
> SPI part.

As far as I know, the pulls are maintained in S3. There's verbage about
"keeper" on the pins.

The SPI part is powered in S3 though. I believe it only loses power in
S5. Can you reword this statement?

The fighting pulls should be resolved though. Or maybe it is better to
simply not put any pull on the line? Presumably the pull is there to
avoid seeing 0->1 transitions on the data lines when inactive, but I'm
not really convinced that is going to happen because the SPI chip itself
would have to be doing that driving, and the chip select isn't changing.

>
> Originally the pullup was picked because SPI transfers are active low
> and thus the high state is somewhat more "idle", but that really isn't
> that important because the chip select won't be asserted when the bus
> is idle. The chip select has a nice external pullup on it that's
> powered by the same power rail as the SPI flash.
>
> This shouldn't have any functionality impact w/ reading/writing the
> SPI since the lines are always push-pull when SPI transfers are
> actually taking place.
>

Right.
