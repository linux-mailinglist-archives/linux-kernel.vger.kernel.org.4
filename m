Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A704173CB33
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjFXN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjFXN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:57:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881FBB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:57:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so2205655e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687615029; x=1690207029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aKXFcPZYN71lVrD41n3tvciEk57GS1gmN4aKHDSr8k=;
        b=nh7egyfbs9EQjNOJlyeC3lUbpEBELjaN9kojbnICztH1ZvUQrGYmxTNpJlbcMfTKhE
         LeGMR3dTTFhyZSh5iRSA+56JNd+mJbwnugBeUxCJ+Re0JiC9wWxvz8NqUT5XugumCsa8
         jW3KNXeuwCtcVAnUUCDv6GChuj2NPivSSNnEHUBgqS4D+viapIpsUAyHHe0qFEwz2MUE
         yX0lZbuyJsa+HAc9/KiEvGjA2mOtoabDyz3fJy5Yq+Ynv5kwM4qucf6qNmMrBTo2JB+l
         MvbIfmzsp5NaV4bg/USumfm2z/kDfyKUYH2P3ccB+PAZjSjjxMQLzpYwg0Yy7UjG9ZbL
         GkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687615029; x=1690207029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aKXFcPZYN71lVrD41n3tvciEk57GS1gmN4aKHDSr8k=;
        b=fhkqQY5rAcMhrbVsNvrVRSSVnf6HWPRXOouA5m1kILh/JoZf0413IirK3Sht3N+LkV
         3rFdH789t2PGUviJv1sudqxggPDmU75vnQJB+4T6hFD8SOxrVGJ5YZWIRyCB/IY/0LTR
         KmGQ6WcarJJxJY2ihO5MEzUL7IbPn1yi+TdCgrQkZ5oeC2nrGoWK+6YRbgGqh1XgY2HY
         wOg23QkAJoFnKremWyk3Z68j5EW+X9gOOT1JAcEJS/gv4wZ3yRHAbgOtoTkEKezMHLNz
         SSwHVPlbN2mxpF//AOYGd6wcLZvkYJ9t79VN+A+uHB+eNjyZ0x8Ce7n4Y30Sa0C1UbLk
         5GYA==
X-Gm-Message-State: AC+VfDwciaguiP5Iaf8RUOdoCWbUEj2Ep3ziqG8bqgfziiFE4SyQSFMY
        UxsGf5Pr6sGoUNtuWBkcLEbONQ==
X-Google-Smtp-Source: ACHHUZ6k1LKKBFNt/EX0E7NN433j+xnsZspguI8URc9lAQkFAD13Q5b2hqPG6AkXMdmpgD7FDiPWcQ==
X-Received: by 2002:a19:da02:0:b0:4f8:70d8:28f8 with SMTP id r2-20020a19da02000000b004f870d828f8mr11500375lfg.55.1687615029558;
        Sat, 24 Jun 2023 06:57:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b004f643664882sm287279lfc.147.2023.06.24.06.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 06:57:08 -0700 (PDT)
Message-ID: <5bdb02d7-74c3-2d54-28c5-eb5d33ddbdba@linaro.org>
Date:   Sat, 24 Jun 2023 16:57:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5 5/5] arm64: dts: qcom: sm8550: Add camera clock
 controller
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230623164619.11464-1-quic_jkona@quicinc.com>
 <20230623164619.11464-6-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230623164619.11464-6-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 19:46, Jagadeesh Kona wrote:
> Add device node for camera clock controller on Qualcomm
> SM8550 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since v4:
>   - No changes
> Changes since v3:
>   - No changes
> Changes since v2:
>   - No changes
> Changes since v1:
>   - Padded non-zero address part to 8 hex digits
> 
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

