Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3599B6EB947
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDVNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjDVNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 09:16:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9A1986
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 06:16:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edc114c716so2823284e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682169414; x=1684761414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jncnPx2grC6G7RQ2ee63CUWNqLMx/tnK4MbO+O2gC8=;
        b=WznNI5log6OLCbjQlAgJDM6uaGoe5+ZWNN90yr1TwLrATj5HxPWoXA0nJvRAECdubD
         eYt7BXA9lilWzB+oSXeCec55lmW/W57h4s3Fso8BB1x3oCCetwbfGNNKDMvW3j88LF8d
         lGvdx44Oz4IsNBaNJrcu0adxD5m0vTQORqBq13Ng8B4YIJYGbVOYqQpBaw1KWOjNnqUp
         2P3DBAw91/qdvfmsDL8U8OVUY4qSwG5ZTlzyjCjMBLZddXbUI7f+ipOjOqTA24AJD7OP
         akcZNObRY7dzggSxnw06sJz1fjVr+occq0Q8apN6DZmKb0pIBbdMrw8lyARHGId0lCXW
         ou6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682169414; x=1684761414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jncnPx2grC6G7RQ2ee63CUWNqLMx/tnK4MbO+O2gC8=;
        b=F6ohGAi98aSri08VkcTFJRL61QIV4xUKu1lajT6U5OQlyx3ht3e/CnNk/VsRwC6UbU
         4BsO5UD+jXg+bTJ/hm+4OBumXngvZlEb0KGKp5i87g28dAJikFKpcOuJ3v4FpE9vdqgw
         IYnIww10LLb4LFGcB3TXGR/DkL4f+iGfUuCp4dawNmBygH68ZBZJn1FRP/37xEzWeB24
         v/oPwsfoYsYRr5BVTJBbICJwZtw+fLMJWhKQe+aQ5HFdaQK7Ed3LFgzwpvMYDeM+PmmT
         bMa/mpL6q0g8yorCQEr63R3OYPJIeUzY+/A9J6ubwA6odgHAEuBkyJ+lkMrUTXyWkItR
         y2vA==
X-Gm-Message-State: AAQBX9fmlMqvdPaXyhouFTyaXhh4fd3H9PFIo9JINZtflOoDRNnzPQIl
        7zZS50EJKjplBFT+1fL6BfslwQ==
X-Google-Smtp-Source: AKy350YnsIfKVhADdDt9MtMQHuIgPc/rStDXoyg0rQ3Pw7Ei3do+mb9dXvAAn9bNaoB5X+pr7sQSVQ==
X-Received: by 2002:ac2:52af:0:b0:4b4:8f01:f8b1 with SMTP id r15-20020ac252af000000b004b48f01f8b1mr1982021lfm.31.1682169413906;
        Sat, 22 Apr 2023 06:16:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24e63000000b004eca2b8b6bdsm898504lfs.4.2023.04.22.06.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 06:16:53 -0700 (PDT)
Message-ID: <dac3b12e-8160-2566-5835-996d0b37a52a@linaro.org>
Date:   Sat, 22 Apr 2023 15:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
Content-Language: en-US
To:     Mark Yacoub <markyacoub@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230419154321.1993419-1-markyacoub@google.com>
 <20230419154321.1993419-10-markyacoub@google.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419154321.1993419-10-markyacoub@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 17:43, Mark Yacoub wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Add the register ranges required for HDCP key injection and
> HDCP TrustZone interaction as described in the dt-bindings for the
> sc7180 dp controller.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> 
> ---
Looks like only patch 9 and 10 ever made it to linux-arm-msm and
only patch 9 ever made it to me, even though I'm R: in MAINTAINERS?

Please fix your cc scripts.

Konrad
> Changes in v3:
> -Split off into a new patch containing just the dts change (Stephen)
> -Add hdcp compatible string (Stephen)
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v5:
> -Put the tz register offsets in trogdor dtsi (Rob C)
> Changes in v6:
> -Rebased: Removed modifications in sc7180.dtsi as it's already upstream
> Changes in v7:
> -Change registers offset
> 
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 423630c4d02c7..89d913fa6e3eb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -822,6 +822,14 @@ &mdss_dp {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&dp_hot_plug_det>;
> +
> +	reg = <0 0x0ae90000 0 0x200>,
> +	      <0 0x0ae90200 0 0x200>,
> +	      <0 0x0ae90400 0 0xc00>,
> +	      <0 0x0ae91000 0 0x400>,
> +	      <0 0x0ae91400 0 0x400>,
> +	      <0 0x0aed1000 0 0x174>,
> +	      <0 0x0aee1000 0 0x2c>;
>  };
>  
>  &mdss_dp_out {
