Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA0712D64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbjEZT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEZT1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59554E49;
        Fri, 26 May 2023 12:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1021652E4;
        Fri, 26 May 2023 19:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE626C433EF;
        Fri, 26 May 2023 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129213;
        bh=4GZAPINmGGO6pUXYRjc4Tj4oRlXZPVRsIaj2VlbtW5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtTK7ZUiRoFk5OIKCHKTESMdqc1z1tX/j4CJDz++P5a1nXrRr1az/zaO6Ljl1Q8sS
         cXdsgB3FHl8jxzJrh02GZkYooGDyJCfnuvmtBbEKi4YJ0PHlszuYtVt5HE0P0tCFlE
         Orvjyze/WdZs8Hzz2qR/IFaxo058yUQ9b2SIuikbo1sbgdtFCcu1LCFVgw+/EdegZu
         pDHHaCXMl+BZKh35w3ozvT6DlZfUfL1USWZFGnFHvFL8ytvIMeBnx+h+I/TckXzMCL
         /F5/HWZ2J7A43dcd2Rxqc9Wk0hA2vrpfrkSxpFhGsaxSEryCaorZhqOraP3BINVp9X
         JhtwgENlPiNgQ==
Date:   Fri, 26 May 2023 12:30:40 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: ipq9574: add tsens node
Message-ID: <20230526193040.2xto63ajkxsx5k5n@ripper>
References: <cover.1684920389.git.quic_varada@quicinc.com>
 <d507ca1396776782802888e992fcae6ddb72e521.1684920389.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d507ca1396776782802888e992fcae6ddb72e521.1684920389.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:06:10PM +0530, Varadarajan Narayanan wrote:
> IPQ9574 has a tsens v2.3.1 peripheral which monitors temperatures
> around the various subsystems on the die.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v2]:
> 	Add "qcom,ipq8074-tsens" as fallback compatible
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 0ab5556..15c9447 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -958,6 +958,15 @@
>  			status = "disabled";
>  		};
>  
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq9574-tsens", "qcom,ipq8074-tsens";
> +			reg = <0x4a9000 0x1000>, /* TM */

Please pad addresses to 8 digits, and sort nodes by address.

Regards,
Bjorn

> +			      <0x4a8000 0x1000>; /* SROT */
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "combined";
> +			#qcom,sensors = <16>;
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.7.4
> 
