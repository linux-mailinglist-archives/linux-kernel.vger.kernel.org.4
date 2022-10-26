Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8A60E99B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiJZTvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiJZTvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:51:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10769258D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:51:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b18so23728464ljr.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl2nAO5gy8gHX4P+zkYYuzR2j2HMszdyI0HmA3G3Bnc=;
        b=R1stc9QNfLnbxcxfkLORrgbpZ/mok3CtKuqE8VQVvzf3iIbPBg7c94FRZfAVCa6y7t
         ya0/7JuIltoLG9E2HdFQZyweeZT8l01mXCHveZpdhKiEISaNMy7qvRjIacjULL46fgHD
         2Y0+7JXBqQqUPBZCExLJiKTNo0/G6F0BTa1jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl2nAO5gy8gHX4P+zkYYuzR2j2HMszdyI0HmA3G3Bnc=;
        b=vpuhw0/Juh39jT4zB8Fn7xV/ujAq7Tj6bmWw/rzepd55W5FkjzBYhuOh0X0sv4IFE0
         juShTy9/b1gKSROBeBrOfaz92uflz7FAZyylb0xmWnhAcx090w4LCWWBaJYuKUhyD4Nq
         FQt5mcFQGTsSH41h6JUJYqu/PkuZnSwsfFFGXinXFpM7jsoRH7qAs/RVOMetX1uypcuZ
         YZ03GKSDZd4/rDiVy5mdQ5d/MPVyaCYrZHU9izX3692TqDJVHwyrievMXdQf1w3h8R5Z
         QeqydoIq/lKDclkN5tOArDMzLxz8OWqTNv3tZ9nxv0BxgV8si2or46mH1kjAggUNIHS5
         FTtw==
X-Gm-Message-State: ACrzQf3dSI4KXHUDT8ajEf1OWR1sN1LH/ko3iwVsbu3OQzwMJRNj67KK
        aSqGqq35Y0A4ouupDmhgDpHO8YkjpNuXR7DGxpqfPQ==
X-Google-Smtp-Source: AMsMyM55CS75cu8NCEEPadabnoMEL99YmG6yPMjuNP5NL1tM/On6r7BFU8Sbpa+YufOLkxQaZK5M9EqTtc6+ppTty1w=
X-Received: by 2002:a2e:a98b:0:b0:26f:c755:ae8e with SMTP id
 x11-20020a2ea98b000000b0026fc755ae8emr16098044ljq.27.1666813865392; Wed, 26
 Oct 2022 12:51:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Oct 2022 15:51:04 -0400
MIME-Version: 1.0
In-Reply-To: <20221020225135.31750-2-krzysztof.kozlowski@linaro.org>
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org> <20221020225135.31750-2-krzysztof.kozlowski@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 26 Oct 2022 15:51:04 -0400
Message-ID: <CAE-0n51d82iShZKanS6e+-yrctm03k+w6HPm=g8B+1SKTN_C2g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7180-trogdor-homestar: fully
 configure secondary I2S pins
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

Quoting Krzysztof Kozlowski (2022-10-20 15:51:33)
> The Trogdor Homestar DTSI adds additional GPIO52 pin to secondary I2S pins
> ("sec_mi2s_active") and configures it to "mi2s_1" function.
>
> The Trogdor DTSI (which is included by Homestar) configures drive
> strength and bias for all "sec_mi2s_active" pins, thus the intention was
> to apply this configuration also to GPIO52 on Homestar.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Fixes: be0416a3f917 ("arm64: dts: qcom: Add sc7180-trogdor-homestar")
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
