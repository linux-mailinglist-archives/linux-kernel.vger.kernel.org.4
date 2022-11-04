Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630A6198A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKDN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiKDN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:57:28 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3222F3B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:57:28 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c8so3210381qvn.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxLP2ZLC+RP/EOL4YGnV1q3bUiM48XPDLk7k0dObo0U=;
        b=DNj1ahs3cwXtTKJXBfq3/beiqjXL6kHqoP1SRMGZjxbHB882O00Y8hK8d+TZF8EBSk
         U4sLhyj33nvvANlEMvLCfq8F7x0YObfuu/5Su6pLEpKSkWJAOj+Fw7EkalZNBUjeMU3I
         NL5Hsn03t2Xl23N2CLzl5aky+TdMpdp8bvHcKVCNMuO2CSHW6OGLs7Hv/DNAsQLbb5A0
         gUlzDCiKBtcX/e6j/mm/pRVxG2S4fXx+TxOF3Vrd2RncZstAcTTM63d4KOjwgfHIL3Iu
         rGYVKojtPIRWI7f3VGquF6YaBlRyhxJwI5vf1gCpAtx0VgA4MnNmGVnLjKJSgtmDtoHc
         rQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxLP2ZLC+RP/EOL4YGnV1q3bUiM48XPDLk7k0dObo0U=;
        b=kppp7draWjGvbrypFteHRSfxMqM04DoU+LUGBgGJK5lQwBOhbxBvxpLpczin26G1y3
         SQr+Lf/XeEXIofZ+qC9GmodBx5ejFv8dSgoW15BRJjHc1woiSPNVfuDmXHPSX8l7RcGQ
         jXfTMcRET1ayHg23P/+I/CeZUfJ1pum/f5qbxkCoJjA3UTTwL0s/DGAZCexH/NQqRVFu
         BztymN1p6wQnfPlUTPMci8z4g2yEIqm8IDai09tnSfp2gjZ5GTA2xZPQfqIcEvvk5r3u
         j9nNY4ZDZP9Rw3kw/T2AOcZy6gp1r6bOVVxfxHVZfUoNOMVB45WxQ+/++7nBPmgTrPae
         z5Kw==
X-Gm-Message-State: ACrzQf1p/gXBN2VUSPiLSf/6bBIr6fXgK6sJ8DqCXfUUd/JsgfHqaPpn
        /tQNjOwusCWV0Jh/1X5q1VtJwVHysw2VfQ==
X-Google-Smtp-Source: AMsMyM4B05822UBI4qLyY6s84o/V58iledNRHwC9mHUZccV4GV3swjVUcuNQzdqJWo/5IKhZ7jYMuQ==
X-Received: by 2002:a05:6214:27c1:b0:4b4:9f69:dd5e with SMTP id ge1-20020a05621427c100b004b49f69dd5emr31727587qvb.56.1667570247409;
        Fri, 04 Nov 2022 06:57:27 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id s6-20020a37a906000000b006fa1dc83a36sm2916394qke.64.2022.11.04.06.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:57:26 -0700 (PDT)
Message-ID: <d336ca89-6c88-bf3c-8164-20e1937457a8@linaro.org>
Date:   Fri, 4 Nov 2022 09:57:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8916-alcatel-idol347: add
 GPIO torch LED
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
 <20221104132400.1763218-3-vincent.knecht@mailoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104132400.1763218-3-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 09:23, Vincent Knecht wrote:
> Add support for torch LED on GPIO 32.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

