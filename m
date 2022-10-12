Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A45FCAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJLSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJLSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:47:10 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5BC45B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:47:09 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id DB41F205A0;
        Wed, 12 Oct 2022 20:47:07 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 12 Oct 2022 20:33:27 +0200
From:   konrad.dybcio@somainline.org
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8996-sony-xperia-tone: drop
 incorrect wlan pin input
In-Reply-To: <20221012151545.39061-1-krzysztof.kozlowski@linaro.org>
References: <20221012151545.39061-1-krzysztof.kozlowski@linaro.org>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <b7b67b4bc7d3cdd5eb27fb1ac68b84e9@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-12 17:15, Krzysztof Kozlowski wrote:
> Pin configuration has no "input-high" property, so drop it from node
> described as Wifi host wake up pin.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Not tested on hw, but it should not matter, as the property was simply 
ignored

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> index ca7c8d2e1d3d..93568fb4bc86 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> @@ -912,7 +912,6 @@ wl_host_wake: wl-host-wake {
>  		function = "gpio";
>  		drive-strength = <2>;
>  		bias-pull-down;
> -		input-high;
>  	};
> 
>  	wl_reg_on: wl-reg-on {
