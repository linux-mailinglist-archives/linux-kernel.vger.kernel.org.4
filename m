Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112537201EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjFBMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjFBMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:20:42 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99891E5C;
        Fri,  2 Jun 2023 05:20:32 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352BlvWf001792;
        Fri, 2 Jun 2023 14:20:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HUWKSuHZrzgUnoi71cTR3/6/dID27U1wLtLLZQsF0CM=;
 b=B7C4UDgTJomLvJx5rWWctxdnL4K1ivach7+2A0d/Oy+ltYGEzL9QUsn3Z+4e/4lArv1d
 QUlzaNpF6HIlCsHN/crnCfOrkX/cRjOG+Pr0gDJqeSi3QLKw022GCUpgNiZA5OUcK0Jk
 d2nrlZIi005Xo3Q/nMmNGOiolkjE61PSiHNVyH8/uu4KGzgZveba5BVmK0bKFMbqCCfO
 cLq5JdZ/QWCstYyCqpTJeR0mFy1fmIERDilE5P0imf98uHTGAvQlGXknWHlqPEffobKw
 xRO51LrMZw47etqsaDHFF1BqKymvtTVlLFj7RODhhOmf1MNspGkvPo56+lvVTawQhFh/ cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qweqep5s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 14:20:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B7E910002A;
        Fri,  2 Jun 2023 14:20:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2340423151D;
        Fri,  2 Jun 2023 14:20:19 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 14:20:18 +0200
Message-ID: <7c5ca6cf-59aa-50f9-c127-a3dc81eb245c@foss.st.com>
Date:   Fri, 2 Jun 2023 14:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ARM: dts: stm32: add required supplies of ov5640 in
 stm32mp157c-ev1
Content-Language: en-US
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230601065222.2594700-1-alain.volmat@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230601065222.2594700-1-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 6/1/23 08:52, Alain Volmat wrote:
> Correct the following warnings by adding the required supplies (AVDD, DVDD)
> for the ov5640 node.
> 
> arch/arm/boot/dts/stm32mp157c-ev1.dtb: camera@3c: 'AVDD-supply' is a required property
>  From schema: Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> arch/arm/boot/dts/stm32mp157c-ev1.dtb: camera@3c: 'DVDD-supply' is a required property
>  From schema: Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index ba8e9d9a42fa..f27d6dcb6651 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -185,7 +185,9 @@ ov5640: camera@3c {
>   		reg = <0x3c>;
>   		clocks = <&clk_ext_camera>;
>   		clock-names = "xclk";
> +		AVDD-supply = <&v2v8>;
>   		DOVDD-supply = <&v2v8>;
> +		DVDD-supply = <&v2v8>;
>   		powerdown-gpios = <&stmfx_pinctrl 18 (GPIO_ACTIVE_HIGH | GPIO_PUSH_PULL)>;
>   		reset-gpios = <&stmfx_pinctrl 19 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
>   		rotation = <180>;

Applied on stm32-next.

Thanks.
Alex
