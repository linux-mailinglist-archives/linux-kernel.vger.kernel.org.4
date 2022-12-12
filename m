Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7264A7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiLLTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiLLTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:06:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08877CCA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:06:57 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q6so1025486lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EM/05Cc3+yEloEjGjc5UQU/MPOq745ZmAMz85sM84s=;
        b=i73QzBibvFkOrU42DwPlwW/9RfBTKS/we4ftuamImKWH0BPAJUNUjYNZCxhsroyc2P
         Kki1pxCxYTTwrR0VBmdUA7r2TFcLIfK4fbeB5Lw5nCsEOhE+wLzzfWSjgf763ldSXYVC
         DbCiYro5ndhLg2Q84lJK0DzdNFJvfI7lDxDiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EM/05Cc3+yEloEjGjc5UQU/MPOq745ZmAMz85sM84s=;
        b=ng4SNLf3zNFu43mwq5B4stL11enWxdTn1Lj1Et/ytM6hptQRuuHDk2GY3nMnoI7ZCJ
         jr8a4nSL1yG3C22jVeigZ68pAny9z+eITziBHX/sdQ6OJFb1aneQpnm+zrs+4X8x0Htr
         NoaI1LsjqChCWXUAC8Svd4s9Ws3i9fbpWlmJIQO+gcguNAwtsQ87CLLMIhczAqGIrDIe
         sxWFYAxWp6iJYopRpxSqJzj60SygPhJF8y3u7a9DXcxuQftcVs5vGO12NCEFuo96ZOvj
         1WDX/5Qbj1SDKQcURQb2IxRpe7u5LNtwvN49eSQcD9w9GutBS6FmGBUgEAZDMQc1fZW+
         AxJg==
X-Gm-Message-State: ANoB5pm3cRZHIUbQH8A/YpPz2irNX/i8oD6315y70YAM6lKKIX8CqunN
        ee3FDlqskyrGDrqtAvmGX04Dr2WvkT1H71JOKYr8Aw==
X-Google-Smtp-Source: AA0mqf42l4naUQbzsYPRmgYlQvfVBNLOPdUAqWtkvdeQ364DbIhIiAzh2+KFqsR5q7jLgieCMkWlHl9uTOcK6U47P04=
X-Received: by 2002:a05:6512:b98:b0:4b5:5f2d:1458 with SMTP id
 b24-20020a0565120b9800b004b55f2d1458mr7382572lfv.253.1670872015320; Mon, 12
 Dec 2022 11:06:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Dec 2022 14:06:54 -0500
MIME-Version: 1.0
In-Reply-To: <20221212133303.39610-2-krzysztof.kozlowski@linaro.org>
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org> <20221212133303.39610-2-krzysztof.kozlowski@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 12 Dec 2022 14:06:54 -0500
Message-ID: <CAE-0n52gh51fLyOtLTB-rEc5GZs6NSdZtYU26FjX8nfWFK9wFg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280: correct SPMI bus address cells
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Krzysztof Kozlowski (2022-12-12 05:33:00)
> The SPMI bus uses two address cells and zero size cells (secoond reg
> entry - SPMI_USID - is not the size):
>
>   spmi@c440000: #address-cells:0:0: 2 was expected
>
> Fixes: 14abf8dfe364 ("arm64: dts: qcom: sc7280: Add SPMI PMIC arbiter device for SC7280")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
