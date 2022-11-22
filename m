Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92896348BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiKVUvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiKVUvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:51:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF18A44F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:51:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g12so26584934wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx+YWWCvKUmbpLOLiEAgZGjZu2bsrwzEPK49+jDiEKo=;
        b=U56Z6HyNr+8U7X+k5HY107gitq8tL55XN2/davLUBfTrDuUK/wgOuxPbIhRlUiIVpO
         DYiWZLrzE8vv1RgqzthucM0LGY5AejmXMIFCceBB+xXVc1q8laevMaTjTSQ1K4+yReCk
         ivjrOu2Q+d1Az+uZFN3rQ3yjeChpiRD0cyV09df3LYnV1bxdwG8wFxGb7KHI+tSJWadR
         lgWzcabIOJAqvnPLLZRT2k9d2q6BylVfP9uIudIU2iVIgFvIf31udR4aXIRRfUQQ7rIx
         WX0fNWjMgCRBHI9FVZzxY8czhxUmgYfgFJzZV+XJ4X1WhNO7rTjq1YrZRlcqmNL9dSPM
         b9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx+YWWCvKUmbpLOLiEAgZGjZu2bsrwzEPK49+jDiEKo=;
        b=qhvW9K+uuhhCb8ZMtCGHXQVuc49aRI1tTgE6Ab/vfrBeFmoecMwTtKrKNY0wr0phgz
         2ZY5COb0mcKnvJv87oXXgenUlgQSnojrQr3bIpmRf0PVHURyU+b88TJ3i3qirxLApwJ8
         xDr9e2kuIza4J1Rgcp9V21oLHAavvY3a4ugpcqrO2OUfWCooT4zFUKj6uoZSq5stGUJ/
         c1iDhl/e5P5f1pNrL5eyX8zTNVxgfuE24CNkXTN++LAiVX3LTL5BjU3T0a+9YMYOOssD
         8JDH0zGopPyISenzklBaxhegvDCTrHSfCoKrRfVmrYibXqV/+sc+7/Sb6c4Oy65K9M6i
         i2LA==
X-Gm-Message-State: ANoB5pl0nOc2RM2KgjJeYHQaRAKOWZPaEPEkSxBqsEJ9etitCtYoiNni
        7hhP3mvKw8jy2qXmyN/Z4pNRaQ==
X-Google-Smtp-Source: AA0mqf5rPIjXhCXwCsxypSw1YhJ5JSXNE50WJhrKBKNpz+S35+WjBJXucChHKXjjj5trZ8uCMH3gUw==
X-Received: by 2002:a5d:6052:0:b0:241:eba1:84fd with SMTP id j18-20020a5d6052000000b00241eba184fdmr168609wrt.696.1669150267102;
        Tue, 22 Nov 2022 12:51:07 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003cf4d99fd2asm17606458wmi.6.2022.11.22.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:51:06 -0800 (PST)
Date:   Tue, 22 Nov 2022 22:51:04 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: Add UFS host
 controller and PHY node
Message-ID: <Y302OBP1f8W6pr5A@linaro.org>
References: <20221116125112.2788318-1-abel.vesa@linaro.org>
 <20221116125112.2788318-3-abel.vesa@linaro.org>
 <22a41a8c-9b4a-ecca-ddd2-5e217d00d20c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a41a8c-9b4a-ecca-ddd2-5e217d00d20c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-16 13:56:36, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 13:51, Abel Vesa wrote:
> > Enable UFS host controller and PHY node on SM8550 MTP board.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> > index d4c8d5b2497e..fef7793a7dec 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> > @@ -417,3 +417,25 @@ data-pins {
> >   &uart7 {
> >   	status = "okay";
> >   };
> > +
> > +&ufs_mem_hc {
> > +	status = "okay";
> Status last, please.

Yep. Will do.

> 
> > +
> > +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> > +
> > +	vcc-supply = <&vreg_l17b_2p5>;
> > +	vcc-max-microamp = <1300000>;
> All these -microamp properties are downstream and do not exist in the
> mainline kernel. Remove them.
> 

Actually, ufshcd-qcom complains if they are missing:

[    3.287836] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: unable
to find vcc-max-microamp
[    3.331904] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: unable
to find vccq-max-microamp
[    3.346766] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: unable
to find vccq2-max-microamp

> Konrad
> > +	vccq-supply = <&vreg_l1g_1p2>;
> > +	vccq-max-microamp = <1200000>;
> > +	vccq2-supply = <&vreg_l3g_1p2>;
> > +	vccq2-max-microamp = <100>;
> > +};
> > +
> > +&ufs_mem_phy {
> > +	status = "okay";
> > +
> > +	vdda-phy-supply = <&vreg_l1d_0p88>;
> > +	vdda-phy-max-microamp = <188000>;

These ones from PHY I can drop, since the driver won't complain.

> > +	vdda-pll-supply = <&vreg_l3e_1p2>;
> > +	vdda-pll-max-microamp = <18300>;
> > +};
