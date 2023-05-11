Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C096FF52A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjEKOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjEKOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:53:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36312124B0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:52:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f4b911570so1375761266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683816759; x=1686408759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVhW7oIL1jRdPCYTqsMhef8LndoBvPQL+ReNt7bJQu4=;
        b=Y/g1hfEQ9rQE8qtFk8NmF0/bqZvbHqqp1OCicrEgzlD+czGRyB7Fi1CKRDz4GVd++N
         bKFGo9bhalQNhyXP2dCDtRgCNzP09C0PKL3a33gJqvDIcL/kF/plkfiSWGU3QmdoKjuz
         mfO01osj8J28ersqJeRAJ8L56Hot7/4MGlnha/qNnJpNm9v2eoHD8LDLxB+rGukuH4uh
         WEtK+ZUjMLDq6BA1wBCRLGCBOzestyHJ04JUcOXCrqAP3e+rdDYzEE/lM5T3rRJ1DLvl
         TWjiqlJuSBP+1OzQ0b70xEEkyT1cYVLVdPTww3dfOPmpcbQ9E3myS9s4ImY5PoxHlf1T
         snCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683816759; x=1686408759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVhW7oIL1jRdPCYTqsMhef8LndoBvPQL+ReNt7bJQu4=;
        b=bZPXjopHVFCgEe0Ie/9x3jxNKVc9Sld6lb+Vzedni0qhdYgA879XHqBI2IimMb15L4
         WoZUCBjLaUCurrqeMg7Ipl3xh1i2606lyt2/uPyqdH5DpklixlCsxXo0aHmhootwHMLA
         lX2folEQU40nUtc8Y1Ccsx+fsO3hchY8LZVHyBY1h/Zcy4LQz0xhoebCtUhgVcaKtQzK
         hcZANop3PlieXGM4sv5I0LCBfln5Y/I6YSHqMK024wcgl40SxRLE3Eq2P8ySm2FzXQuy
         yGKCAoYVA9mTHSoO9b8wd9gJ8TqA5w6i4RYUHkBjm2ZY26it1uYH2pE++vjmczfEQa3P
         TguA==
X-Gm-Message-State: AC+VfDzo7/nleU6/UIjyg93yiyfIKpKQx58Yd55YMwsjRD+/MHRYlsV1
        jhb7u4iMOeFU7KdQJKRcN8QWBBUEHbXxZz+9Gs17XQ==
X-Google-Smtp-Source: ACHHUZ4zVc6Q56vu/0naIlUZrWHwA0g33q4AGmldBKSbAbh8H7/sQxMe6PYhcuM2U8pli/PWhlOn6t+8iv06dhBVTqQ=
X-Received: by 2002:a17:907:2d90:b0:966:40ad:3af1 with SMTP id
 gt16-20020a1709072d9000b0096640ad3af1mr16481130ejc.1.1683816758894; Thu, 11
 May 2023 07:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230511135503.198538-1-krzysztof.kozlowski@linaro.org>
 <016ab311-cc66-b1c7-4099-f63e8f3644b8@linaro.org> <ca7a8499-0ac9-43d3-45ab-c974b1a2a564@linaro.org>
In-Reply-To: <ca7a8499-0ac9-43d3-45ab-c974b1a2a564@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 11 May 2023 17:52:27 +0300
Message-ID: <CAA8EJpptzh1w5-WgybEOOa59PTgo5z7CEr5vstWwhH7naBttjw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable TYPEC_QCOM_PMIC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 17:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/05/2023 16:14, Neil Armstrong wrote:
> > On 11/05/2023 15:55, Krzysztof Kozlowski wrote:
> >> Enable CONFIG_TYPEC_QCOM_PMIC necessary for full USB Type-C support on
> >> Qualcomm QRD8550 and MT8550 boards.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   arch/arm64/configs/defconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >> index a24609e14d50..8b6407d2059d 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -991,6 +991,7 @@ CONFIG_TYPEC_TCPCI=m
> >>   CONFIG_TYPEC_FUSB302=m
> >>   CONFIG_TYPEC_TPS6598X=m
> >>   CONFIG_TYPEC_HD3SS3220=m
> >> +CONFIG_TYPEC_QCOM_PMIC=m
> >>   CONFIG_TYPEC_UCSI=m
> >>   CONFIG_UCSI_CCG=m
> >>   CONFIG_TYPEC_MUX_GPIO_SBU=m
> >
> > This driver isn't used on SM8550, only CONFIG_TYPEC_UCSI is needed.
>
> Indeed, apparently I messed something with config while looking for
> other options. Patch can be skipped, the driver has no users in upstream
> (and bindings are still missing :( ).

... And it will be hopefully removed by landing Bryan's patches.

-- 
With best wishes
Dmitry
