Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0679460B3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiJXRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiJXRPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:15:40 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B98B2D750;
        Mon, 24 Oct 2022 08:50:43 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id E0BFE1F9D7;
        Mon, 24 Oct 2022 17:21:46 +0200 (CEST)
MIME-Version: 1.0
Date:   Mon, 24 Oct 2022 17:06:02 +0200
From:   konrad.dybcio@somainline.org
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
In-Reply-To: <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <59859752dbafda83c801c6a7bf0a06e1@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-24 16:56, Krzysztof Kozlowski wrote:
> On 09/12/2021 05:35, Vinod Koul wrote:
>> Add the spmi bus as found in the SM8450 SoC
>> 
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index f75de777f6ea..b80e34fd3fe1 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>  			interrupt-controller;
>>  		};
>> 
>> +		spmi_bus: spmi@c42d000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
>> +			      <0x0 0x0c500000 0x0 0x00400000>,
>> +			      <0x0 0x0c440000 0x0 0x00080000>,
>> +			      <0x0 0x0c4c0000 0x0 0x00010000>,
>> +			      <0x0 0x0c42d000 0x0 0x00010000>;
> 
> This is a patch from December 2021. Is there anything blocking it from
> being merged?
I think it depended on a series of changes to the driver, as 8450 has a 
newer SPMI ver

Konrad
> 
> The same applies to several other patches here.
> 
> Best regards,
> Krzysztof
