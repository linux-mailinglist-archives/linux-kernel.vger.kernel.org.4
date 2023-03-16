Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31D76BC276
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjCPA24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjCPA2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:28:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A2937F0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:28:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o14so100144ioa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678926526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+3iisH6t5Ueb2KR5EZXrrMYfkePZJoMbpht3Sd8moI=;
        b=U5/VG1SBf7qH1kLBLQatmPKpbV54uzTKNbUM8BSZgRUX2P04L5Wgq8Ws8UlMsGKgPT
         Y2T15fzcomdDkBZEM2nTXFr662TgxuVbVsWtVqdpw+xXD8GZZ/zjyZlsHOoXBOsTJflq
         Pl83zXvG5cwVwsLnSKfoRBxl91U04fiaSnHNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+3iisH6t5Ueb2KR5EZXrrMYfkePZJoMbpht3Sd8moI=;
        b=vdqRPUX6LtzVRyEoS/ie46smjMVzBK+GVRbcOp6au2McbjdbS8nuYKZFfr4/atk+Zg
         HTdHt/XsY3Cyd8vVMCnKYfqbgUwWbNi6XbUGsIuGBSMxw2HPov+2jwHsAKViyhAvFbVv
         oxPgwoesqCoH9EzJXVP+Tbe2IdHCkCvAcNcNNqWluJIeK/jSjmJQ4iTsM31Zu8GYIjVb
         nUt+L9L9L6CcAKJTGC2ntg/t9ebQ4jWjm7tExwKbboc27eQphpZvodtORwuqkGKjnwUZ
         yTwq7C0JE1VfOcEqceqsphlzwiFaReeRfRfClYUcCEf+teY/+QeHDWmE6jsjVqxtbmOE
         GAQQ==
X-Gm-Message-State: AO0yUKX9lFsLr91VsgsiwqiqIv7TQYpfS1sfFzCfpZ8D22mx5lbtJAL3
        XjGRw8PoxfoWp5yjEYDlfTLo7BFxvbadHoPHAIM=
X-Google-Smtp-Source: AK7set9RhH1d5Lq9Jsr7ebQ9J3ZQbytmwMlERg8tigtRbLmht4l3Wkq+ta8ci3PgM4PIUZah77lT8w==
X-Received: by 2002:a6b:6303:0:b0:753:22cc:b0a6 with SMTP id p3-20020a6b6303000000b0075322ccb0a6mr229585iog.16.1678926526237;
        Wed, 15 Mar 2023 17:28:46 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id g6-20020a056602248600b0073d7d30fb3dsm2084218ioe.54.2023.03.15.17.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:28:45 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:28:45 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc7180: Don't enable lpass
 clocks by default
Message-ID: <ZBJivckYK+JrGdG2@google.com>
References: <20230315154311.37299-1-nikita@trvn.ru>
 <20230315154311.37299-2-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315154311.37299-2-nikita@trvn.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:43:08PM +0500, Nikita Travkin wrote:
> lpass clocks are usually blocked from HLOS by the firmware and
> instead are managed by the ADSP. Mark them as reserved and explicitly
> enable in the CrOS boards that have special, cooperative firmware.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 423630c4d02c..26def6e12723 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -785,6 +785,14 @@ alc5682: codec@1a {
>  	};
>  };
>  
> +&lpasscc {
> +	status = "okay";
> +};
> +
> +&lpass_hm {
> +	status = "okay";
> +};
> +
>  &lpass_cpu {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 53f0076f20f6..f0de177981f9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3623,6 +3623,8 @@ lpasscc: clock-controller@62d00000 {
>  			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			status = "reserved"; /* Controlled by ADSP */

Why not "disabled"? I see "reserved" is used in a couple of other
instances, but it doesn't appear in Documentation/devicetree/bindings/,
so it doesn't seem to have a well defined meaning that distinguishes it
from "disabled".

>  		};
>  
>  		lpass_cpu: lpass@62d87000 {
> @@ -3671,6 +3673,8 @@ lpass_hm: clock-controller@63000000 {
>  
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			status = "reserved"; /* Controlled by ADSP */
>  		};
>  	};
>  
> -- 
> 2.39.2
> 
