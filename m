Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7576BE48E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCQI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjCQI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:57:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB767817
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:56:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so17548731ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679043406;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tr5k3/w3leHyi4aocCURJSRCZ6+xZ7Mx2vRgpBalJI=;
        b=qTPUX1zDbkh0t+aQ/8gYzvh9TkOeBZPEOeruQc2Ql+n1b62gGuCXmj5KEjR7OLD2tB
         7hR4vEaj4s+bc/AqYrIHyxmpmUC8FFpQtcOT2T6JHDZpWAKeid9vYSZToXSQaDCzcTlb
         4a4OjvKeXxEKUSn54U0Qmv6X6WJe7gP/dkYdpNH1YNKMwaS3PcKB3ZB0mHXOGQAKBiT6
         VDpFM5jRRJgekY3UYR2dOv9r0KZy3KDnRIwNMX7Zi0HAnopnEBlUrs7GgMGieJG/FM8U
         OC2pl98dtD825v4342zKYDWSaYAY5NOZwxTdnMyJ7F3Y1u4xrkACkgEYBu5Xbq3Bfneo
         u1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043406;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4tr5k3/w3leHyi4aocCURJSRCZ6+xZ7Mx2vRgpBalJI=;
        b=xiJoVisGBPdwdeD1DJTtPkQ0nrntctnUBFpAR5CTVbWJkzZtnOPum+Ga3Y72dO8uRg
         LRD7FklPrxo0HCEm2n0Svtrr8cLSoMO2bBsvsZjmnwgZ/XaV4z32nSEubluO99BTR7Lv
         EpX0179byqSNNeZh6kf5qGgSzWNxT07W08cKG9ifJ9mvZUJtME8jQiQh9jTI36WnKsac
         ljQFILVIJo8n4a+xOF79VQmY3wzdRnIOhXbXjW1vMSRmNydLUe5zcjwg/ZNm4JzxGh5d
         6BWOOy1LYB7JDC45bGPP7mIahXrxqUxdGtBwq71jynuKlqJBCs2T/Ebb28eJLvEdXS+s
         42Ag==
X-Gm-Message-State: AO0yUKUQsgfaydfIZKJK0DxW9mrLl8K8vz2bDEzBlH06CbVZtnBvcEjC
        thE4hv26ZAhMAYPsdqPSRXsDOg==
X-Google-Smtp-Source: AK7set+efCng4cHamJNfx7vBd5TB+fXK9PZgEtWM3lu3AIBCbxF4iQ/B6/Rr+A1n/0Xtf5BLRYIplQ==
X-Received: by 2002:a17:906:a04a:b0:8ae:11ca:81de with SMTP id bg10-20020a170906a04a00b008ae11ca81demr15625732ejb.34.1679043405918;
        Fri, 17 Mar 2023 01:56:45 -0700 (PDT)
Received: from localhost ([2a02:8388:6582:fe80::b])
        by smtp.gmail.com with ESMTPSA id lm15-20020a170906980f00b008c76facbbf7sm714385ejb.171.2023.03.17.01.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:56:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 17 Mar 2023 09:56:44 +0100
Message-Id: <CR8J7NPGU3AQ.NUJ64VVNTJYD@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>
Cc:     "Marijn Suijten" <marijn.suijten@somainline.org>,
        "Rob Herring" <robh@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm6350: Fix ZAP region
X-Mailer: aerc 0.14.0
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
 <20230315-topic-lagoon_gpu-v1-5-a74cbec4ecfc@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v1-5-a74cbec4ecfc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 16, 2023 at 12:17 PM CET, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>
> The previous ZAP region definition was wrong. Fix it.
> Note this is not a device-specific fixup, but a fixup to the generic
> PIL load address.
>
> Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index e967d06b0ad4..3fe4a5fa3021 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -466,11 +466,6 @@ pil_ipa_gsi_mem: memory@8b710000 {
>  			no-map;
>  		};
> =20
> -		pil_gpu_mem: memory@8b715400 {
> -			reg =3D <0 0x8b715400 0 0x2000>;
> -			no-map;
> -		};
> -
>  		pil_modem_mem: memory@8b800000 {
>  			reg =3D <0 0x8b800000 0 0xf800000>;
>  			no-map;
> @@ -491,6 +486,11 @@ removed_region: memory@c0000000 {
>  			no-map;
>  		};
> =20
> +		pil_gpu_mem: memory@f0d00000 {
> +			reg =3D <0 0xf0d00000 0 0x1000>;
> +			no-map;
> +		};
> +
>  		debug_region: memory@ffb00000 {
>  			reg =3D <0 0xffb00000 0 0xc0000>;
>  			no-map;
>
> --=20
> 2.39.2

