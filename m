Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3A6CF56E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjC2VdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjC2VdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:33:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58E72681
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:33:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-53d277c1834so318471517b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680125582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=77aE1kl5AxW5dnhUKd38hNJtml97m0aE5tnB/lN600E=;
        b=i2vdiJCs8OxsYMi4QnFnmlGTq4noYB2uicPN41uSGLpFQJ2IresORThV81t27leTc8
         /5wav06JEgmz55mgup6mgnQM5Yl+caCDt8DweO4MgXB/ABQmoHrucQWliJ5O9y52v8NZ
         d0GfdtxmM29B5Xi+CM98p4MlxhXSrZ06nfYJsFeYOzeQ1pQo+f3I3EAEItQZu0ChMCYy
         0sMkBJoaVgcqejy4/J3cb3nmJVfaMDIKHlDyd/mEVGQLWSNSIbbDBdOirqlPY3BeW5E7
         ZAEQuHYnJyvtjtGXZ9fkBXGXaN0pgWeemDXxwN/VQuPJnDqF/FjlqOJ9SzlBYSCMpiHK
         6nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680125582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77aE1kl5AxW5dnhUKd38hNJtml97m0aE5tnB/lN600E=;
        b=0kARVP71DsTVdPDrJLwR1pLXObKybchRurKMMSt6ZyHIC94ybNMUoTIwYYFD/WBuV0
         WnxkVpycrx3/mE29AkZmUm8W+5ueB9NUQw9iSVMKCEUHRKzZeLmxrxTlzWbb07rKhTLq
         SaaNnIoP4aIPwdCVB+ogM0lX4JKMGrxhg/1OqxsGVQr4MJ+o+lGege2L8FN8aqvQhxm0
         sphBlSy9r3Hgr5Rxf3H7IY8TZdd83BWR8lHSFR2xhqWaIy/rPwaAjqALtS9/Ka5jtWZk
         Amp6XoV6wZddfWf6UqFcq6VhjlZ0C3L9lKxXPjvBSX6IH32REDNIr60oZrIwsD9vdE0N
         w9Kw==
X-Gm-Message-State: AAQBX9d9SU1r3LspxgYKQwwhrDEpovMiF72MlthK5KRi89xQMG+yxfD7
        hGEoRhppqp47wQr8ZhuzNXDEFeZcIcAv1kd60cyE+w==
X-Google-Smtp-Source: AKy350aECqTZWW4Ue0d1gn9KWV1hJT6+QVTSAHlpIfYPJ3qKDosToEfJPTTAwuX/Lbj64Vcf3VwLBWSwDMPPhyCKZ1E=
X-Received: by 2002:a81:ac13:0:b0:545:bade:c57e with SMTP id
 k19-20020a81ac13000000b00545badec57emr7967874ywh.5.1680125580993; Wed, 29 Mar
 2023 14:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org> <20230329-topic-adreno_opp-v1-3-24d34ac6f007@linaro.org>
In-Reply-To: <20230329-topic-adreno_opp-v1-3-24d34ac6f007@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Mar 2023 00:32:50 +0300
Message-ID: <CAA8EJpprgiXWZC2W3JSgG3jtTZDtbwoeQ6LBK=pqfpk0oMvNRw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8996: Improve GPU OPP table
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 22:17, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Remove the self-explanatory comment about opp-supported-hw contents,
> add required-opps to ensure reasonable power domain levels are voted
> for (currently we've been piggybacking off of miracles and MDP votes)
> and add newlines between each subnode.

I'm not sure this is 100% correct. The values that you add are correct
for the voltage scaling case. However, based on the vendor kernel
sources I think that MX should only be scaled if the voltage is scaled
too. I might be wrong here.

>
> Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 4dd37f72e018..62ad30e94f40 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1244,37 +1244,45 @@ gpu: gpu@b00000 {
>                         gpu_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
> -                               /*
> -                                * 624Mhz is only available on speed bins 0 and 3.
> -                                * 560Mhz is only available on speed bins 0, 2 and 3.
> -                                * All the rest are available on all bins of the hardware.
> -                                */
>                                 opp-624000000 {
>                                         opp-hz = /bits/ 64 <624000000>;
> +                                       required-opps = <&rpmpd_opp_turbo>;
>                                         opp-supported-hw = <0x09>;
>                                 };
> +
>                                 opp-560000000 {
>                                         opp-hz = /bits/ 64 <560000000>;
> +                                       required-opps = <&rpmpd_opp_turbo>;
>                                         opp-supported-hw = <0x0d>;
>                                 };
> +
>                                 opp-510000000 {
>                                         opp-hz = /bits/ 64 <510000000>;
> +                                       required-opps = <&rpmpd_opp_nom>;
>                                         opp-supported-hw = <0xff>;
>                                 };
> +
>                                 opp-401800000 {
>                                         opp-hz = /bits/ 64 <401800000>;
> +                                       required-opps = <&rpmpd_opp_nom>;
>                                         opp-supported-hw = <0xff>;
>                                 };
> +
>                                 opp-315000000 {
>                                         opp-hz = /bits/ 64 <315000000>;
> +                                       required-opps = <&rpmpd_opp_svs>;
>                                         opp-supported-hw = <0xff>;
>                                 };
> +
>                                 opp-214000000 {
>                                         opp-hz = /bits/ 64 <214000000>;
> +                                       required-opps = <&rpmpd_opp_svs>;
>                                         opp-supported-hw = <0xff>;
>                                 };
> +
>                                 opp-133000000 {
>                                         opp-hz = /bits/ 64 <133000000>;
> +                                       required-opps = <&rpmpd_opp_svs>;
>                                         opp-supported-hw = <0xff>;
>                                 };
>                         };
>
> --
> 2.40.0
>


-- 
With best wishes
Dmitry
