Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75A6480BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLIKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLIKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:13:45 -0500
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174569AAC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:13:44 -0800 (PST)
DKIM-Signature: a=rsa-sha256; b=ZVZ1lBJuDOw6lWG+2dxMDTxxcdf/rSKCSmMz8zN2BW2YvlleGdrkrFhERdyq87fjvdqRPmMD7dz1MSn0B3WbI2IKl1MJhFJ4muMLdKBsTbo7r/65v7FkaxMHQ4rgqtvgGN3K0/XRbTX70GZ+0x34cqAsXq3dldrymgjHuXyHrbK/t26CC4aSrJutEdAOdn+0hLyiVL1bOdX7S6197W7cDqTk5f+nT+eTRl4WsNJ8ZUpHhzWMm7w0qRFV/tBei/OU5Sbk5eoMr2sbQN4BuDhWh3qDD6YbX4G7fKCmHL1BaQDyAOt2Y7r9klpIXN6pwr4Vvpka3CWScPSZPJQNZYMTrQ==; s=purelymail3; d=iskren.info; v=1; bh=QicPjp3sGnItvqW0OSsKwZzeWrXOfWwJ2oxre2/WImY=; h=Received:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=V7+wnrI/mLLm2Z7U3mRP+vuQrOJATYAbFhXzbSq2oSHHML2cXp+ok+Vk94YPM3+Qv11/sm3iwLBZpK2dKzm19G5uxYtrf3bQgEtgO7A3VWBVohZWVZljuSEkYaAkzsBh2htn83zIOy+SfAspnwYYrdAGZbp1N8nUru/bUiz8wQzglrWvtVX+qwg8uwTLi+hO+d5tHhQ7De0uw2q+TOT40bC3nO67SRqaQ/dMxSTP0+UIKrg+xr+T6cWDvqoAKRyJ3gWe1odNg87GGulgXdloytXHFijVO0iugTo3G9ucnY0dEJuIIVL+g3P07HSIlVkTMy310VpJ9d9H6lheTFH5OA==; s=purelymail3; d=purelymail.com; v=1; bh=QicPjp3sGnItvqW0OSsKwZzeWrXOfWwJ2oxre2/WImY=; h=Feedback-ID:Received:Subject:To:From;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -802281199;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 09 Dec 2022 10:13:21 +0000 (UTC)
Message-ID: <8e6a1920-5a7f-1b67-5a68-feb8c1dfad0c@iskren.info>
Date:   Fri, 9 Dec 2022 12:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sm6115: Fix UFS node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208201401.530555-1-konrad.dybcio@linaro.org>
From:   Iskren Chernev <me@iskren.info>
In-Reply-To: <20221208201401.530555-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/22 22:13, Konrad Dybcio wrote:
> In its current form, UFS did not even probe successfully - it failed
> when trying to set XO (ref_clk) to 300 MHz instead of doing so to
> the ICE clk. Moreover, the missing reg-names prevented ICE from
> working or being discovered at all. Fix both of these issues.
> 
> As a sidenote, the log reveals that this SoC uses UFS ICE v3.1.0.
> 
> Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
[for the whole series]
Reviewed-by: Iskren Chernev <me@iskren.info>

> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 572bf04adf90..3f4017bc667d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -704,6 +704,7 @@ opp-202000000 {
>  		ufs_mem_hc: ufs@4804000 {
>  			compatible = "qcom,sm6115-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>  			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
> +			reg-names = "std", "ice";
>  			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>  			phys = <&ufs_mem_phy_lanes>;
>  			phy-names = "ufsphy";
> @@ -736,10 +737,10 @@ ufs_mem_hc: ufs@4804000 {
>  					<0 0>,
>  					<0 0>,
>  					<37500000 150000000>,
> -					<75000000 300000000>,
>  					<0 0>,
>  					<0 0>,
> -					<0 0>;
> +					<0 0>,
> +					<75000000 300000000>;
>  
>  			status = "disabled";
>  		};
