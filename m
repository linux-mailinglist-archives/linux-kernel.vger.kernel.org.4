Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F30E74EBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGKKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:47:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2916E6C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:47:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so726245166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689072449; x=1691664449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhYjDo7VSwdxshX1nK59fpmU13FY+d9ZhewNClu/GzI=;
        b=YjUWQV+wwKVhRZ5G/Uuk+41jombmfNZOjdC5yg6uriFbLng+AeUNSP2pfFrxeFGWhO
         dH50YZgBj56mB8W6yyK2iSlFk3o6L9t7h/PartCMKqnTDlaT9ei3yZstQA1HD0MCaXkB
         /clYgaR2zHe8V/XXQGxsDjsR7NImg3dCoQJh1A9qxBRDELCbj62suNIpwcpvbz8Vz44f
         kkF+6Zt1i0v8gyE5zAayFVE+Q/0UOKHpHrL3C991cGh8xvetyZrVE0iBf290SMiX5E79
         MT/gUk09yOw9LocjUGoGK8r2nQK1kcm/vKxGn2AstY0D/sNZGzBOJlSjM7i3ajZ9ZkoG
         n88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072449; x=1691664449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhYjDo7VSwdxshX1nK59fpmU13FY+d9ZhewNClu/GzI=;
        b=XqGIi5mHcTLGlkgaxKX9RfbMNcDxnTb93WFaUgkiGdfORAit4YyhGKSrWKeqTJIsuH
         tIMmzHPnaS10DjFB3cdgZSRMSmegTeZC8IASWk4vI4GLIXTc+Ac89sTVrzhPGwXrQ1nB
         XIHUbiEdCnPZF7FgjmlK9sSuLCF8ueB4CSu8cXh54H5EVnTx0rsWJpfc2BelQjt32mxP
         YUUY51rG8rSIgm0LHKWlvDxyA2rQy23/jhOAWzdgxPJORL4bNGoCwfUGWclsTUTOBLaG
         55Ea5u6jnseSC7uX51bJsVp7iBc2W1HaUspyThqvO2K3BLIBBO9xprhuYA7dkCHCtICq
         gWjg==
X-Gm-Message-State: ABy/qLaGtLFfg2QPm+kj7nPVA6Ru13PEg6E7jJdH+HDSy0jvtHCJw+ZU
        uYATxyPmtWVBfYsM2RQ7tzM43w==
X-Google-Smtp-Source: APBJJlGPV035AkQDFa+4NUX6ahiro8/dT4HGrCGmnEJWwuBVg19WZDUBGD7hKaf6DC2YlZs555dtXw==
X-Received: by 2002:a17:906:7393:b0:993:f081:2c58 with SMTP id f19-20020a170906739300b00993f0812c58mr10827815ejl.4.1689072449397;
        Tue, 11 Jul 2023 03:47:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d2-20020a1709064c4200b0099290e2c15esm1005152ejw.75.2023.07.11.03.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:47:28 -0700 (PDT)
Message-ID: <2086b277-2333-1c58-24a4-72fa946a4b96@linaro.org>
Date:   Tue, 11 Jul 2023 12:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Update L4C parameters
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
References: <20230711104255.16488-1-quic_nitirawa@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711104255.16488-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 12:42, Nitin Rawat wrote:
> From: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> 
> L4c is the supply for UFS vccq, As per UFS spec range of vccq is
> 1.14V to 1.26V, There are stability issues when operating at
> marginal voltage. Hence configure the min and max vccq voltages
> to 1.2V.
> 
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>

Thank you for your patch. Please add proper Sign-off-by (yours) when
sending patches.

Best regards,
Krzysztof

