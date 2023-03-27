Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D56CA79E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjC0O2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjC0O2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:28:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FABCD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:46 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k17so10778727ybm.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgiisWdAkK9TZByL6qo6IqTFGMxPn6Lsp6OHLkAuwu4=;
        b=sWUOgoKORUJyz6il5vhJZSTWG2/9Re59WLZ8D5hSzxihnW7ewbqtooTLxWT+ZrgVjo
         w4MC2Gphns5ot05nr+eNMYLbiiVZWR0th/Er7M+3ZaLSc4v85G7BW2JhkZzSdVHu/sIJ
         C6YAPuWvdAsqjcuN/Aq2qL9XsAJxg8dn4nb4YUHTCmKeFiWRZlOqQmh4Ty3ZcPTb3qoV
         C29hR+WGvHT0mDuYtLj+DC9I1psnQB2nyLP1QiXzJh82ThNa71JiQiQdPrArQJ1i7wNs
         6S7Jaq3tXUBceY3vv/JmHsbkf1mQl/Jl1Qezo7SAdX8W+K1eGHVbWZocV3G7nVljn0C3
         y5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgiisWdAkK9TZByL6qo6IqTFGMxPn6Lsp6OHLkAuwu4=;
        b=qeBq09a/SBVs0K8KHNECwhc94N/KIOnDf16nJ0ICpflkIWM5qo36bYvBE01Zsz7YG+
         6JDmc38cng89wR7bcMrNBtCd9HRrUCx4crMMOc+M5ylW1edQBX0TtQLoRYOOLgKJ7fmY
         yl131EZyEkYarZbg6O8q0IJKm4mCluqCt2r0u/sPSFt1uN0H4T/quUiG+32PmX1ioO3y
         KYDsqPcyNoiigjBcftuSee+xHhv+LbTtYGvsw06f7EV/CSct0i1I88t/MHK3m3eIjbRN
         7kpFCpwuQmNVBdXmp4kWs8ipH2+rcYqp3jXnDM8FzpENoyd/oS4wWNasCm/0lcGU0Qlk
         As3A==
X-Gm-Message-State: AAQBX9fhhxol2GagKQW9Vje6BumULBWrxPz0xgGE8Lw7pPeJopXNPYxw
        aXTjR4/0Af1b+5CVUibgqiLwCrc38XuTeRUIyVXY/w==
X-Google-Smtp-Source: AKy350YLZ8BJ7UVOhyWMGjbJZVGwlJuUQmqILqBjohAFBFlpR3qOR5Llb1TnhXzJFqWNNKEUZGMBqr3nzj1e1QM1opY=
X-Received: by 2002:a05:6902:102b:b0:b46:4a5e:3651 with SMTP id
 x11-20020a056902102b00b00b464a5e3651mr7197095ybt.9.1679927265147; Mon, 27 Mar
 2023 07:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org> <20230327140752.163009-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327140752.163009-5-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 17:27:34 +0300
Message-ID: <CAA8EJprfS_xfiu8v_GPcTkspV1hoyGYkKnufaX7G1SW8X7vfzw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: sc7180: add compatible fallback
 to mailbox
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 17:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> SC7180 mailbox is compatible with SDM845.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry
