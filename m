Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C26CA79B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjC0O2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjC0O2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:28:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624216595
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:34 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-544787916d9so173057217b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h24fqvNh2MtFb7EQW++89YiwETI1wexBBZ/Ngv8WZuY=;
        b=WyKIMqF83gDfQPHKM2mPns9a0xHPKCtAJZzvUeMSejBHB5Y5/KspjpvdrsTMSE4QLC
         TTde8JWyxuotuWhFSZSys+TjgmgyIM3vFoAWeTjzZHWaycXuat+vdQnCPR3rSXNfnvfk
         pPgkyDDwF3OYP34jFDgCZ531ITPkQKc80pBl38Aa0jjxo+lQjs4TXFdyd+ExfxeeJdQa
         6RRAJ9jRHz8nTUra7/VM2HvESWFag2w52o1TE4FlQoCsIcaA015TvSmHEc31RrnWGMdY
         NCC/jflH/CfJnCDvjg0SkkFvFWtZpVeDSwNC3OM4kAtYGXWwvymfnHnYjA4ox2U1flpq
         U+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h24fqvNh2MtFb7EQW++89YiwETI1wexBBZ/Ngv8WZuY=;
        b=KjE81lGjNhJry/vJNkABL+iN6k7WVe4GtbVtjTN7hVuUmR0Uzwa0fc24G6OO81TLpw
         upPeU2Kc8A/+b1LIC50h+Ymt2Ouxkik08FQ7mN5Ba5xbCkHNk8UDNBKuWahSoWygOWKy
         dGAooZtUvs6RA911CMzjJkD/mpWoRf+GgB+iyk7UtcGCtgTSXIPcD0jPNKy8qsn2TELY
         ksArjbpqMHuslJWac1Qi9+SqAnSKjE60pM7ZZtDlHKdHiJohtqK1Z/t3aJex8NzWN2/r
         SV2hIZDF+cGoo6HoK5s84iE/5ETrnjnKj1cizkjkYUFOjHMiFnVf6hpDSOZPHQ8SEQ0k
         SclQ==
X-Gm-Message-State: AAQBX9dr9dfTPOb+sE+donb7ipMzkOQ5Uxg1HtisaequlLPGM6ScUhD1
        1D7bLjj5ofhOrfw4kYNAwvr43sKpLhymASh4kpnNPw==
X-Google-Smtp-Source: AKy350YZFQq577NIJqdhEJ032DUk3yv4PKctbFOftvR3jd3zPsZM+9hg0FJS3nIb7X4K14FFmYH2mmR/waEHcrn8e5s=
X-Received: by 2002:a81:b50f:0:b0:544:b8d8:339e with SMTP id
 t15-20020a81b50f000000b00544b8d8339emr5533695ywh.5.1679927253542; Mon, 27 Mar
 2023 07:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org> <20230327140752.163009-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327140752.163009-4-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 17:27:22 +0300
Message-ID: <CAA8EJppZxd31JxcFaMUrEKF7mcCroizdeXePhKZ+i-KtkMyhXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: ipq8074: add compatible fallback
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
> IPQ8074 mailbox is compatible with IPQ6018.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
