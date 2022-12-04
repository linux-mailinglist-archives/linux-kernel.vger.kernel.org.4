Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC7641C83
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiLDLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLDLCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:02:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53509186F3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:02:09 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b16so2367214yba.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn+nbs+RDzrDXBxlojnttncQWKHcSpNeFAwKRSBXAnE=;
        b=r2FlI3KjtvmuBbQyyEaY9cYIb4moQCz857LYXKTaDhBPpvxL8D36S5hHA/4907gU2S
         25C3pgqrmtkeXmCAgzH+ua+9/gG8xC6vW5ERoRZTRGDfLP+wPjvSnIR1pCYT1h3qJaI0
         Or7pM2vn7ViJfujeUpnva5dKeF7FC/H+JMOuWFRsQemgNT36MwPwfZNVWo6nwRqO+cH4
         eijE+HExz9ft7r5m8Qvi6p20HkDVIVwdR1OGoao4NaGTY6swwsWiZiaB0TasAi/ONx72
         zyZDlIgO8DmAI3c2iaUqoKM7zTgoqgwyxIAlWnQe54ecK3TD3o4LBTaWJ9gMr+3aT/qN
         OGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn+nbs+RDzrDXBxlojnttncQWKHcSpNeFAwKRSBXAnE=;
        b=g15SHzChu0VozQfLQjN0WoObmykhHttPP0bNff6ta4uf37AFL4ZRyRiFQex7x7G/GK
         VEZLOLhmRzEeeQDFVEzW6/YWBDH2zEqZl1wwHpnMtgLM/h7O+wQm4+2WQiSJ0nYcEz7V
         c/7eAVKqEZokklGeErEYpDe8iFrswztBGzMLKao/mJ6k0tYjwP3WcRqDZMgjWeZw1+sl
         WPb9aDmjU4NncEEic5uxrmyclSQ1ZsullSmeBb0CssqO3ZASbmO55HPbCMZTERpXfzJW
         xE9953S6mn9fOPgF3imGPFRWFMY0hgZXgTVMbKu1QfIOr7M7D3k1s4pzUmV5Oy97J6Bc
         UsCg==
X-Gm-Message-State: ANoB5pm3d+CcLagYRP6jCNef7mDlKVuydGM/NWQ5IWdsc1qvTR54lzAW
        3s9YOnwXYAtc0Jl5sW/LEAoBSHDxLeqXoh7RGFJvRQ==
X-Google-Smtp-Source: AA0mqf7bYv2aOUUhxWfhY2Np7NlPUwWF9GQeGNtMkZjSrBoguiBQFtbgLVUFrLUslWKVy6Ia6IvwAOH4SlUZWsl0pgU=
X-Received: by 2002:a25:dbcf:0:b0:6ff:f96f:2fd3 with SMTP id
 g198-20020a25dbcf000000b006fff96f2fd3mr2322289ybf.288.1670151728535; Sun, 04
 Dec 2022 03:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org> <20221204094438.73288-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204094438.73288-3-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 4 Dec 2022 13:01:57 +0200
Message-ID: <CAA8EJprZFOnbdch5E5yO8CZq+5zEGQ2S_6OVwjmskArAqGHC1w@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sa8155p-adp: fix no-mmc property
 for SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 at 11:44, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There is no "no-emmc" property, so intention for SD/SDIO only nodes was
> to use "no-mmc":
>
>   qcom/sa8155p-adp.dtb: mmc@8804000: Unevaluated properties are not allowed ('no-emmc' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
