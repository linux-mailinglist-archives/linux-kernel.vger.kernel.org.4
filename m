Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D831465B1AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjABL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjABL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:58:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1087766F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:58:01 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v23so18734176ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjKe+ouqFmney4gz4J6SHYPHIsLZMK7NaXVfT2avl1k=;
        b=UXsH3GlGrxadmYWcGMJkzY/9TwX9cNQKSSHAmQtKXv56o+4NrGmfIMIUNMZJUDyFWS
         AuBjJ1xfwD+PKs3tGYmkwKnPHTpD7c902I0UshUoiK0z9lzGusUqvgOw0PuOf62dkluF
         2K11YJtN/z/N1nOlq5glMHUuBCgJhIVqP5FM6Ol89b0LmYOjiscxLtqRcw+4fk2a5P7e
         JWHCgnojLPqM6eaPgQaFrH4RtCTiyfjCTNxOlpfFwIoaVUnYqX7WbH6wtzLExJ6suWZ3
         JCXu4Rc5WT6UNid0U2wr//bz9RbuQHQEq+rh1xYPBAWhE+q9cB1srHdpa4DqcrY/N1GJ
         h/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjKe+ouqFmney4gz4J6SHYPHIsLZMK7NaXVfT2avl1k=;
        b=5zhHc10mdn19u83hDC+92iCEpIcoEtbh/z6V/CqAAFyq7fkH+TR9S9yyaHaBiIvfNS
         njo+TcUR3AlKhBF89u+XCG0YXvYa59fX1cKvw9uOXzR6YFqkEiTgetdOjSXY9vI5pSEf
         EZd003+AbZLJmi+TkSiG7DgYTWVBLXTWJS/0/+0mxAuU8jq20wdS2ZE5nCa1hvk/sWav
         PfBuJSa40NGCRbyx1/XKynfyIFJEkL2Q+Wy9ds7gWuEcx7XJk+wwai4vDyUtZuJbq6h3
         EC1y2GdR3lUB1ivizgww6J4/UtsPTH2aXmp+mmY9avCCWKCWX56Sk3yJGvwniCzjVLaW
         IEIA==
X-Gm-Message-State: AFqh2kpDPGHEHcvNWHk2vjs++DqVQLRxPj7v0wXXmb8S05IeBazRv2ZH
        QjTnpVn/NOBCt0mxWcpxUmBdnA==
X-Google-Smtp-Source: AMrXdXv6Ac5KSv29i/95NOkXLC/RJjPMui48vUFWG5eX665sqXZIN1p8SE1eDw34nZ4cVRZb124ESg==
X-Received: by 2002:a2e:1454:0:b0:27f:b68e:8e96 with SMTP id 20-20020a2e1454000000b0027fb68e8e96mr8408806lju.26.1672660680074;
        Mon, 02 Jan 2023 03:58:00 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id i11-20020a2ea36b000000b0027fdcc83e1fsm959520ljn.87.2023.01.02.03.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 03:57:59 -0800 (PST)
Message-ID: <9f1d28d9-615d-417e-64d0-3ef2d71a9ea1@linaro.org>
Date:   Mon, 2 Jan 2023 12:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0
 and PCIe1
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpieralisi@kernel.org
References: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
 <20230102105821.28243-4-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230102105821.28243-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.01.2023 11:58, Manivannan Sadhasivam wrote:
> Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
> received from endpoint devices to the CPU using GIC-ITS MSI controller.
> Add support for it.
> 
> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> msi-map-mask of 0xff00, all the 32 devices under these two busses can
> share the same Device ID.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> It should be noted that the MSIs for BDF (1:0.0) only works with Device
> ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # Xperia 1 IV (WCN6855)

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 570475040d95..c4dd5838fac6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
>  			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>  
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			/*
> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> +			 * Hence, the IDs are swapped.
> +			 */
> +			msi-map = <0x0 &gic_its 0x5981 0x1>,
> +				  <0x100 &gic_its 0x5980 0x1>;
> +			msi-map-mask = <0xff00>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>  					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> @@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
>  			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
>  
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			/*
> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
> +			 * Hence, the IDs are swapped.
> +			 */
> +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> +				  <0x100 &gic_its 0x5a00 0x1>;
> +			msi-map-mask = <0xff00>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>  					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
