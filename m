Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8060E9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJZUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiJZUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:01:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB4A0311
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:01:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx35so17845728ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnXS8TIFkJvQIC9t/oWLC9m0IY5PsGt6PFcCSazh+EE=;
        b=NoATqSyjyoZ0XjlODJBeT9cHHsqAM2AVwGBmWXRRujd9v2bdLkUQbipXunJ20k4uBt
         4wMJU94eAilLuaYHBdvt2Zc5znZa0NiSUUXHQEkvxTQPbNRJrQ9Gz5qNUYPdzOJvZdIu
         nGWCO+g9ii0L2RLSXZbEQF8ckQ9dtNqTQ8Tz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnXS8TIFkJvQIC9t/oWLC9m0IY5PsGt6PFcCSazh+EE=;
        b=lofxM0Q0/OmiQzmxRjtH7qTYFvrNadRmfB0n47g+0JrqkAnosFoACt5D2ZV60f0uq7
         9WiFVgbaXp3V4Gz3NU7sNys4id50f4WJCPo8nJIeSUvJS2aVSroiaiwurWXKul9bqv66
         pRrhR6MB1/9oexwjufv5jqbQnZjL5WFpOJ15Enzb4dpypj+fbzbTR1+8My2azh4WkgYN
         t2DyJljePD/p9EOfc+cuULUsg7GMmdiNDUk0CAfmxbWqE7VPYLNJIrazVIwanlRONGwb
         h4HDw7f9diGN9CRStOVCSasWyW3E2wLptHDyK+VCSNTss6NLqEedKKz0m2WTKzaIlIhY
         9Q2Q==
X-Gm-Message-State: ACrzQf0XZFe5lj0xeUbH59aEYnSvOg5J0M7Fzlbt5MHTkMkKP7e7r7/7
        rv8vuA00QuiCrAHVW7vq5YwJEkj8WEuNPefFG+/KPw==
X-Google-Smtp-Source: AMsMyM6kBWiilqKfJ9EC2Ru879bM6yYh3y91TcLcmREOeIgiBGIeh9jfiVqNlw2kYndIw2Tlcudg9REgr+OEBl4ylEA=
X-Received: by 2002:a2e:8081:0:b0:277:b:33db with SMTP id i1-20020a2e8081000000b00277000b33dbmr9186348ljg.228.1666814511330;
 Wed, 26 Oct 2022 13:01:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Oct 2022 16:01:50 -0400
MIME-Version: 1.0
In-Reply-To: <20221020225135.31750-3-krzysztof.kozlowski@linaro.org>
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org> <20221020225135.31750-3-krzysztof.kozlowski@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 26 Oct 2022 16:01:50 -0400
Message-ID: <CAE-0n53yX4Q8cxLWGK1wG2veMNUb_aHSgFxBiRzuBRtPm3UPpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: sc7180: revert "arm64: dts:
 qcom: sc7180: Avoid glitching SPI CS at bootup on trogdor"
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-10-20 15:51:34)
> This reverts commit e440e30e26dd6b0424002ad0ddcbbcea783efd85 because it
> is not a reliable way of fixing SPI CS glitch and it depends on specific
> Linux kernel pin controller driver behavior.
>
> This behavior of kernel driver was changed in commit b991f8c3622c
> ("pinctrl: core: Handling pinmux and pinconf separately") thus
> effectively the DTS fix stopped being effective.
>
> Proper solution for the glitching SPI chip select must be implemented in
> the drivers, not via ordering of entries in DTS, and is already
> introduced in commit d21f4b7ffc22 ("pinctrl: qcom: Avoid glitching lines
> when we first mux to output").
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
