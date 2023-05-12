Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B718E7006D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbjELLaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjELLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:30:17 -0400
X-Greylist: delayed 2388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 04:30:16 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDBDBE0;
        Fri, 12 May 2023 04:30:15 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 3CA4D140721;
        Fri, 12 May 2023 10:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1683886470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WI5E/TsaFWtEJQz7t3z2GxRm12SujK+7+YwNkKkKtWc=;
        b=PNej8A2subGSVMWllP3l27bMrGnF1v0/K/JFYmhq4//GDzE0+uYA6/e9TXPrBp+EJ8KU4Q
        bSAl4jf+X4LclqQSkpPAK8i8sHHXawMLUa79DtqgvtPW8pM2bk9Dv6lT0QQYfvaSWBMleW
        U+fF5GjINJri1MPitveFyePvZpyELUA=
Message-ID: <ee580939-8334-4d86-e01b-54c6fd0b2f42@postmarketos.org>
Date:   Fri, 12 May 2023 13:14:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: qcom: Add BLSP DMAs for I2C
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.2023 14:39, Luca Weiss wrote:
> MSM8953 has two DMA controllers for the various I2C, SPI and UART
> busses. Add the nodes and configure all the I2C nodes so that the driver
> can use the DMA.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm64/boot/dts/qcom/msm8953.dtsi | 48 +++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 

Hello,

 > arm64: dts: qcom: Add BLSP DMAs for I2C

to all qcom boards? Or only for msm8953? Commit title is unclear.

-- 
Regards
Alexey Minnekhanov

