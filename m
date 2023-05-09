Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25AE6FCCD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEIRdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjEIRdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:33:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E74215
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:33:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so61224915a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683653615; x=1686245615;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUawUbEclVkFSWkDdatFwfaD7oPd7xnurWNNOrUMw2g=;
        b=hT0VxclnZ+fQxcynoRFujumgdhltCTC19CxX5DLjnn4pJxulVtw304MJaWUTeRdcXi
         C7dC7FAO+QnpXmHtBVyK1XPid0bEJvGB5W5Bk1UJCoHLLfR4HE/aJB2iALz8ptx1GFAO
         gAp84bF8QSUT4XwkvC8rCMEeZslw1usLGHoojLBEr0YZ4BHBU61PRG1qW3eZBqMZkujG
         xEV+Mz6c+vQ+Aja4zrz0IVaZchCoz/i08ry25J3908NQjVv/PskFEtKuxNLAT23AVtNb
         EDoKWT4qyXhysfpX/WBo5UAVuIzKIgOtVwf3DtgvXMpIoDkdTMJhs7sI74eULaN3Lu3N
         Ryyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683653615; x=1686245615;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUawUbEclVkFSWkDdatFwfaD7oPd7xnurWNNOrUMw2g=;
        b=hv7o0d267Vf4n1nnHdaOQ/V/LFNS3a35TmOA6ApH8CjaPnctp4hc5PzXidvPqjym2f
         l4ZXApGwAscOQOavZ2xCHW5k/eGCu27MN1rWdAf6V9z9hiamNtJBC8AmR3TVytlRQ8nh
         YgYwsTMFnjyYuAYsV0iS4rROdbwhucd/fp2YGRvkA4DrygikHruT1rP0w8O/P4UDWsKx
         eeon9RTTIFaIDNl9qARf+DyGRreRnxMOYpiOuZJjSj2SrkiWbllVkdMYnPVoz0NVoOUx
         5yuE30YwtZ6uJvQd6k/YEaXYUYcdB0ypQfkCIzGzH03oakBUtxyEOo21u8YQ53hyxdqE
         TEjQ==
X-Gm-Message-State: AC+VfDxVGl0M+R6qypcSCLDqH/uO2Yvh5cfouusK8brAShHlpdG92Xu9
        YHtdJJa2Wib7t6za67ujP/tR0g==
X-Google-Smtp-Source: ACHHUZ6WFiMt3dk/BzPRcu3Y6NXiTqRFSfVBopWlJH0LQDMiQjFCxTcqPOgMV+ZWRoTKply56AteKw==
X-Received: by 2002:a17:907:6d22:b0:965:d7c7:24db with SMTP id sa34-20020a1709076d2200b00965d7c724dbmr13312874ejc.32.1683653614751;
        Tue, 09 May 2023 10:33:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id bc15-20020a056402204f00b0050b2f588db6sm980998edb.16.2023.05.09.10.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:33:33 -0700 (PDT)
Message-ID: <6310c7a5-f541-b6b7-10bf-680b7c2458d6@linaro.org>
Date:   Tue, 9 May 2023 19:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5332: add support for the RDP442
 variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230509160133.3794-1-quic_kathirav@quicinc.com>
 <20230509160133.3794-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509160133.3794-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 18:01, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 442 based on IPQ5332 family of SoC. This patch carries
> the support for Console UART, SPI NOR, eMMC and I2C.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 117 ++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

