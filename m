Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D8704F86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjEPNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjEPNlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:41:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15E469A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:41:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30935d343f7so583296f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684244459; x=1686836459;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NRNEl/MqAqI2a0pkYYgoXHoSa3CJRStAtHPW4r96AW4=;
        b=kTPnIKD+FObRRxgBNXWoWsBv634tqiKJNauxFYEh8LAqp9ECYA4oGYXIF3zGEyiaW5
         0Iov+UlfwB5HtD6j7uG8smCY6DQ8py+AS7ZGwXLrVuQ6nwflU9Ogre3pgJ7X2UMMFqer
         sOsIxUN4ji2rfY5W5YiOs7F/m9q+ysGcWN68tgrE08kCY7leSSr0OUGz3Am7YdNaI8gQ
         yWwlXL7ZpKJag+DFCA+1fifCcShQ3sgpS50xFvjBynj5qTDpcIHWg3iny9j1X7KGna1f
         ztUt+Xnk+7wzQpVF++w5ch/8KdAx3IcZpkB8XRJVo66qWdIvIQXfkbWl+aewPOz16yLL
         IOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244459; x=1686836459;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRNEl/MqAqI2a0pkYYgoXHoSa3CJRStAtHPW4r96AW4=;
        b=FFEZ5AD+asWhp7k/T0KBSdrbmAAwa3C8ru4Ebsz0nammO6N3ar8IUjGcgBM+x0jgzV
         pIkvgW4jyEdKN/ycZ1PTUnjDsry+p3JPn5sLGv4d57t6/Entp2mCxnpjyQ+Ap/o83Bi+
         jWHXlCrsSB7NgTOIvjZE/Pp3TPfl8r+R5+uYIUA8jw9jKizUT5No1/6jbY7kMMgBHSNZ
         GIfl6CrhnAB/Li0hRTKrE90QzOSPLRy38voPGDDBDsMQ2iQP0KhM58jdH0cnqVhAGIlZ
         UEghhVguIgUQ6k9CbXOerCJWVtVfOZVCwZbjLudbaFQ8RRGNJsHnsFvlxUJrXqtO7cE5
         w85Q==
X-Gm-Message-State: AC+VfDw6KH5f45JEE7gIMjVKuyucxmhRBwG1MGE6ydvvU4aIFVoLH/TM
        iihOpGCU4tdRrGDpsaPo2mD9hA==
X-Google-Smtp-Source: ACHHUZ6Ra2ftdDR5wXJ58KjHyxYdCy/0gQISxSlOVsbtyGaRD0unxDoXq/7TShVwBISxQUowJzlEng==
X-Received: by 2002:adf:f245:0:b0:306:2db9:cc26 with SMTP id b5-20020adff245000000b003062db9cc26mr25449400wrp.25.1684244459198;
        Tue, 16 May 2023 06:40:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d44c5000000b00309257ad16csm2696522wrr.29.2023.05.16.06.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:40:58 -0700 (PDT)
Message-ID: <5c2667ed-bcb6-3f05-a5c4-aec254f401b9@linaro.org>
Date:   Tue, 16 May 2023 15:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add PCIe0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:30, Krzysztof Kozlowski wrote:
> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
> thus skip pcie_1_phy_aux_clk input clock to GCC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 32 +++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

