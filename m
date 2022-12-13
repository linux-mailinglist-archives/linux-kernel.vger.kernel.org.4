Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C264BC59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiLMSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiLMStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:49:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E61135
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:49:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so6442660lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z8/bxp7Ru0IcqP+97HvHKf6Od5YpO4Un+/bdWoueMc=;
        b=ZkoMwQxtEEojprY96HRl/tPEfZWV7bVmiXJe4tw/+7qOovalFjORxVvvghy4oWol6h
         P2GIVMB0WPB+zdXaS4i7zrlmFwJ9lVDaKy5Gap7VsaxOMTeBqwC0lcG/os7GynCgJpC1
         NbeTQ6E+yWZjVe7Mbz64I4Pnvx9Ym1pmXOM2Ty7449ysG4Ds3bfFUHRVpp05o/lJ1gJN
         reHMIgbEZ5cd6e/8jbbbZ9tmtufHl/NyWa8STQjaxBYG7gOg/FxI4rNCyhcGx8ZWBhMB
         /XEWqIn1YIkfAwleMof+oiKyjnDLOBkvNWFlwJsxoIFHpEU7oWloc75oUcoR8zNWlASQ
         A66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Z8/bxp7Ru0IcqP+97HvHKf6Od5YpO4Un+/bdWoueMc=;
        b=H6hq5dJDTqljSNsEncASpey3VdCUN9XvOGpJ91ikLGY/ECaQ/ZW5SLhueo7PExcBUD
         PQW8HIrb3Pdv4WHmzM2Dnwc4xTyQQ+y+5wMCJnOADBcWbIIYex6ubjfhZbt0rVLx5jsH
         UbIcuIMdTqNgDS3DazsbdUNNWL2oUWNjDm7fPpxkdKVbCNDmxcC3EuFk+u8TFs+bs/tW
         xe1eD57GJ5P+G2YbCnsF+0vTrdcp1HQLw/VHzX0gNubf2aVbpKU+jq+6xVaME5qbR452
         vhY5fbZRbRP7gcSoo+/dkgFd092SZXxQWMyoaUjLTwjMkcALF/751el4h/keIycB5gW7
         B6Ww==
X-Gm-Message-State: ANoB5pk/ycPqNrB6I9M8nAHGeyMu+x0eYmwXDU2KxT2h1i+lJ6EHrrEd
        t9ckp6VBwpS9L0pGJdvqq2yTnKhoFUr0ICiv78SufQ==
X-Google-Smtp-Source: AA0mqf4gjU1kOVSsoaBjvy/V2YZbYMOlGdh5ZjsKuFUhJUtzP+rj9UE7xulfafzBMNTNvmGzgZasr6u8pOSrMv7ne4Y=
X-Received: by 2002:ac2:55b5:0:b0:4b5:b787:623c with SMTP id
 y21-20020ac255b5000000b004b5b787623cmr1499532lfg.328.1670957362414; Tue, 13
 Dec 2022 10:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-2-bhupesh.sharma@linaro.org> <0152d45d-75ed-db44-69b2-d7736600f120@linaro.org>
In-Reply-To: <0152d45d-75ed-db44-69b2-d7736600f120@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 14 Dec 2022 00:19:10 +0530
Message-ID: <CAH=2Ntxh8pj9XEtrxM3UG3Z8zRQHeFEGBac_WU3+e2LXZkMiPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm6115: Cleanup USB node names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 13 Dec 2022 at 18:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/12/2022 13:38, Bhupesh Sharma wrote:
> > There is only one USB controller present on SM6115 / SM4250
> > Qualcomm SoC, so drop the numbering used with USB nodes
>
> The node names remain unaffected, so please mention you do it only for
> the labels. Labels do not matter for the code, has no impact.

Fair point. Let me fix it in v2.

> > in the dtsi and the related sm4250-oneplus-billie2.dts.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 4 ++--
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi                | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > index a3f1c7c41fd73..fa57f4bf58256 100644
> > --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > @@ -225,11 +225,11 @@ &ufs_mem_phy {
> >       status = "okay";
> >  };
> >
> > -&usb_1 {
> > +&usb {
> >       status = "okay";
> >  };

Regards,
Bhupesh
