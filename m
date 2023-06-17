Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B75734303
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjFQSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjFQSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:25:28 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC81988;
        Sat, 17 Jun 2023 11:25:27 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C80E1403BF;
        Sat, 17 Jun 2023 23:25:23 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1687026325; bh=NVr5zqTY1mDtHMB78oPRbydthVKLtEeaG30EM0hMmOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kbwrF+wCekEYweVgQp3Ra4I4bpNl6JBIlxp53BktyjKApgqTjnm4D+zeYW2G8zoPa
         vTVrNGow9zSXolQsWoRvRYTZDVwq33LbSwAN4NhSZgIzCM4vAoXf8Eoqi/Y3q+4UvE
         q1JUBYb5MGdt6kxUUObXZ/Vglp/fsXQAm66TeT/7ZiW5Nw8/WN//TypmPQJqMRtMRN
         /4DB2ESs8x8YJ0DjIAmjDWEoDIlA2+/OqI3jCHqKh2Mzld5jxi/xmsH+1OU/ADLj9n
         clnF0S7F9TbY4OZlQgbYwV5Jx67XdeFpbqY51GYYrcWkTKGFmTcMID/BzOLFTKYDJX
         5rSYAGCJycvdw==
MIME-Version: 1.0
Date:   Sat, 17 Jun 2023 23:25:17 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] arm64: dts: qcom: msm8916-gt5: drop incorrect
 accelerometer interrupt-names
In-Reply-To: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
Message-ID: <5ee33fb02f4e411d21aaf356230dd496@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 17.06.2023 22:15:
> st,lis2hh12 accelerometer binding does not allow interrupt-names:
> 
>   msm8916-samsung-gt58.dtb: accelerometer@1d: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This indeed seems redundant... Thanks!

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

> ---
>  arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> index 7943bb619116..54d648972d35 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> @@ -101,7 +101,6 @@ accelerometer@1d {
>  
>  		interrupt-parent = <&tlmm>;
>  		interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "INT1";
>  
>  		st,drdy-int-pin = <1>;
>  		mount-matrix = "0", "1", "0",
