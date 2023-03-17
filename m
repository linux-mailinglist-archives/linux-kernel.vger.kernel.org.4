Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B26BE2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCQIH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCQIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:07:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE7B3E1E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:06:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so17105251edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679040394;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+zQVHJu8l7P59JbeyfPpLtGuh34ycuLT4Flv/bXsww=;
        b=nMfEAi0YrjKKkwFryzW6ZOl87DIxVZn67A/peRfsfmhMgZTvRTythzbZS58RZKiJtu
         msck1XFqjCVrjpSbIPsldx+Vj/ojqlqET+JZE88FGLCH/SiD3qSNwPHhpaISwvdzwInn
         vO0/dIp5MYDLfcsvBNyALLWwRwPHzn2oLB/TGwG+7BoWDV3SRe8x1xSPbRNtuQ4ezOkA
         2E9XRelwpJxulwrM4XlTRc7djOuf50TZMvelura2zq6A289WFCyUEez7/SmQ58xR44Lp
         ueve7tJT0T6q7UjXRH30G4zbExgj7jwmivgttAJi6wsOQBksRzhDLYml/pD3uTRxOh3l
         3vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040394;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7+zQVHJu8l7P59JbeyfPpLtGuh34ycuLT4Flv/bXsww=;
        b=fHkMZllqMW5e7eLr9Y8p2DuSZcNDBCEXPXFmelfib7PTyROAZLJZcu5jNj4/t180cF
         0Fyq1JPhAAF+bsgMY6IOF4KJVeodsRobN1bLY/OnbnPzt+nsFRSYCR7AStRG7IAkPPbl
         2nAa+2FDJA/kGk6OjY4TsyJj84Yz0GLBEmKAu7ZSE9EIGxLSBTYBUtQInSOqcv31e4vS
         JsrY3Tag3cKTTw6tmh3ohkAlUYFRrureFDRPHXTka2MWsEhPKYDPxoLyPaaCY1Ar/Byb
         P7sTQddmqmcDRuVkbICy0jYAXt5StlZvNv2/qAbeI8ygPzaRWsZrHLXW1ExHqQUPZkPU
         H+wA==
X-Gm-Message-State: AO0yUKVbhXKhu5tWO4Rn49cq3Nm75udGDpEO3LWQ3cahIhUrp8F4av+t
        IAClry2Thhvv4k+2VZQa8pzW6g==
X-Google-Smtp-Source: AK7set+yqglXjNLVzKyGRTytCRz0C9sZT/ippXJidCCN5wp35PK4O4N2eAe4aARudzIKT/KGxziiiQ==
X-Received: by 2002:a17:906:3057:b0:92b:f3d4:33c7 with SMTP id d23-20020a170906305700b0092bf3d433c7mr12493100ejd.53.1679040393995;
        Fri, 17 Mar 2023 01:06:33 -0700 (PDT)
Received: from localhost (2a02-8388-6582-fe80-0000-0000-0000-000b.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::b])
        by smtp.gmail.com with ESMTPSA id z26-20020a17090674da00b009310d4dece9sm669924ejl.62.2023.03.17.01.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:06:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 17 Mar 2023 09:06:32 +0100
Message-Id: <CR8I57ZATTO2.232WHNST3N2YG@otso>
Cc:     "Lee Jones" <lee.jones@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
Subject: Re: [PATCH V15 0/9] Add Qualcomm Technologies, Inc. PM8008
 regulator driver
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Satya Priya" <quic_c_skakit@quicinc.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>
X-Mailer: aerc 0.14.0
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
In-Reply-To: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

On Tue Jun 14, 2022 at 11:48 AM CEST, Satya Priya wrote:
> Satya Priya (9):
>   dt-bindings: mfd: pm8008: Add reset-gpios
>   dt-bindings: mfd: pm8008: Change the address cells
>   dt-bindings: mfd: pm8008: Add regulators for pm8008
>   mfd: pm8008: Add reset-gpios
>   mfd: pm8008: Remove the regmap member from pm8008_data struct
>   mfd: pm8008: Use i2c_new_dummy_device() API
>   regulator: Add a regulator driver for the PM8008 PMIC
>   arm64: dts: qcom: pm8008: Add base dts file
>   arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp

Is there any activity on this patch series? It's been a few months since
this revision. Would be interested in this for the pm8008 found on
sm7225-fairphone-fp4.

Regards
Luca

>
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  69 +++++-
>  arch/arm64/boot/dts/qcom/pm8008.dtsi               |  54 +++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  66 ++++++
>  drivers/mfd/qcom-pm8008.c                          |  60 ++++-
>  drivers/regulator/Kconfig                          |   9 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/qcom-pm8008-regulator.c          | 242 +++++++++++++++=
++++++
>  include/linux/mfd/qcom_pm8008.h                    |   9 +
>  8 files changed, 492 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
>  create mode 100644 drivers/regulator/qcom-pm8008-regulator.c
>  create mode 100644 include/linux/mfd/qcom_pm8008.h
>
> --=20
> 2.7.4

