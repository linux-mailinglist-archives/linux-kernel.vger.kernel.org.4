Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92D3623E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKJJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKJJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:12:34 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD7A68C6E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:12:32 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id k13so1644160ybk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ0zoYzFDslrILFuWLllOLpBV7AGCbxKTB4yqbkqbTU=;
        b=tWIDsNsPLPVHZEUozYnvLCa4EWhx/j6ljw3pP3nqoGByY+EaOfGp7EoZdND0d8M7M/
         9PAV7GXHe8oYHkowL8cFpBAazx+t2vwrFAPeRDlPzUJIB4nrYogvIxSrYPueSfuTXCmI
         Y4UHd8Un3UcEW7awvppHlmmGY7bu4y+hpBIh2STn7wKoK+6CPblfqlR7+RvWUyNuo5IT
         ZjEXwNI3z03e8LGKrfHOnQBRr7osVT/7R1h1RsLwlNpH+kNitVT0XyDUthSbMLLRJeAQ
         BAk0MsCR1qh3Cz5rHauXJfYmuNYIRhi0QX53mruVuXWKXKyE0rIAbg0ixr12RyaPTVD0
         jyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQ0zoYzFDslrILFuWLllOLpBV7AGCbxKTB4yqbkqbTU=;
        b=PycudqHYCwl1x+iigt9zSHcZGpcnpuXnVotznMlsDETfRxnHGBXz4jFywwhReCiqwR
         a/ei5Uc6lr6TvJMf6m6xOY+zlVmbkV+0y27fnonb0rPNVenlEOafQa/34xTC4yH9L6Ui
         wKmER932/Yt1MB6pOanKib0nS/gLe92X1bxPuq6zbbSogz5VJ24TNgdmVjFku3aK/nTx
         pS1Hk2yF1K8m/UzhxjDpP61j+D74XX1yCKc8Bx3Q6c/1yzy/kFMb/dGACIds9HQyajpp
         wGLgmaY4Oy/p79AIa0LKkQxoQSN/Z2i+M+D/WL1BLw+lheBepYxczENJlFppc7FqBHR+
         xTHg==
X-Gm-Message-State: ACrzQf2yd/fMP+ascf1OsyFJwtTCyUsBeUkmfJmTlSY6mnzw3BhdAZ0e
        MpXhLc24hqxe4bYHQPeC9CST0yR4nGMXvUXkJR5j8w==
X-Google-Smtp-Source: AMsMyM7nhmyQ8LtPmvjO9u+KJIVYQkWp4KWCkKOaEBMIJ0/1qUWLH5LMFNwWkp/Q+6XpbcqRvPc1/EfNcwjtdSpjP7g=
X-Received: by 2002:a25:8a0f:0:b0:6c2:4ea4:69e5 with SMTP id
 g15-20020a258a0f000000b006c24ea469e5mr62811315ybl.153.1668071550711; Thu, 10
 Nov 2022 01:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20221109111236.46003-1-konrad.dybcio@linaro.org> <20221109111236.46003-4-konrad.dybcio@linaro.org>
In-Reply-To: <20221109111236.46003-4-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 10 Nov 2022 12:12:19 +0300
Message-ID: <CAA8EJprNszfyyN9HLYoRK2Y-yUU-NuGd0QacqJ3UhkDjpvokdg@mail.gmail.com>
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add a device tree for PMK8350 on SID6
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 9 Nov 2022 at 14:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> PMK8350 is shipped on SID6 with some SoCs, for example with SM6375.
> Add a DT with the SID changed to allow it to work.
>
> Unfortunately, the entire DT needs to be copied even if the diff is
> very little, as the node names are not unique. Including pm6125 and
> pmk8350 together for example, would make pmk8350 overwrite the pm6125
> node, as both are defined as 'pmic@0'.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi

Just to throw my 2c. If I was doing this myself, I'd allow pmk8350 to
receive external SID using the cpp #define (And to default to 0 if one
didn't use it).




-- 
With best wishes
Dmitry
