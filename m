Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136DD6CA797
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjC0O2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjC0O2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:28:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F58A5FF3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r187so10813809ybr.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tkqK4obvAKKEKCiNzlkmm84qkEj5fAtdtI2ghPofQCE=;
        b=bn8nkIoFM0umlYafL9yyBN13DfHICzbaDDNO1Z4T1Y0zFy+oRCFgMlaZl6MGXjunxF
         zw/TIrvLAu3rNruw3++efqtf9AQY4csVJq1XugW69cgd/vkyUe5je+USViRrAyct02jn
         DfAYLbp5N3bk9fRGaYYAqAuwl3sP7o/HjHCZ+l5dHV6/zuPuuPg5gOkIuSA2sT+zvUN5
         IP8tHM/u/MZTmM8oxx3l1xXO15bgNJBXjfRDdLF1FgnRZ1mJ0gI+a0tTjb30V3FnDqoR
         S5zl5haM3bpRPgqDqIXlQwLaYlEt/MisGD0lsWoZ6ododXIw53rN2CHt7bcDgvX1qTg6
         o5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkqK4obvAKKEKCiNzlkmm84qkEj5fAtdtI2ghPofQCE=;
        b=qUKDOjNfPExWDDzd4tElKSkLTvKjRFFO3ufPyIQIQ4mPqz3YuWkN7Rkw0tUR6hmmOu
         5eERINfo/b+1l/wzdH+4D7RuTZiGXHD3S7irfwHjp11gfFXgicV2Np8Xeb5yJF9URm9e
         voqod3AhNITylahdQgPPqNi95pbFjMXyIJDLcH4Gbxi+ITucY71UHnao5mX+ONgUJCm9
         uBVmtmuoPVVYv7HVkzRVifdCFKoK+xl6velr3jq1JMtN0JrpQnNVVjEqKeGbQRSC0McU
         PiVI63BKKTVisyGD9FPeEYCR3Wn/aj4yIHmJmfMDdgdCmf5e6lM7gbMD6L+ks0lyzCWB
         2zmg==
X-Gm-Message-State: AAQBX9fYHlycdz1J+SBHz21OveOqMWDm1uI4hi9ymY2/2Ial5Dg4+tVV
        7O0dRvl3RMT0eLViwLAPZXGrA7mDZUVOBxj/h8808A==
X-Google-Smtp-Source: AKy350b6m432taY2Dabi5h8ZS606fxJYxJL294zTGQP0FXQa9WGY2HHj5mRZyjmIOdDvwsDF6nXcW5L0brPDUlRLYMY=
X-Received: by 2002:a05:6902:1201:b0:b6c:4d60:1bd6 with SMTP id
 s1-20020a056902120100b00b6c4d601bd6mr7735209ybu.9.1679927238657; Mon, 27 Mar
 2023 07:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org> <20230327140752.163009-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327140752.163009-6-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 17:27:07 +0300
Message-ID: <CAA8EJpp_FhV6YTuxQmAV2Ehra-AKGpMtnpHswHpGBQpqFjx7aA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: qcom: sm8150: add compatible fallback
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
> SC8150 mailbox is compatible with SDM845.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
