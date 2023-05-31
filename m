Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEAC717A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjEaI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjEaI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:26:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D9E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:26:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f588bc322so796032366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521612; x=1688113612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiSiRUaPfzxmVW4AyK57CaN+sPgO62cYU9V0E0mDe2k=;
        b=kd//8LGFfLI9niiw4EUVkHvEYJmrszUnnQdBTrCtve7FiH4ntJDBbwJpY15OuIlntX
         gihVA2iGrOcTK7aI6JPs/zQmfSWRfQ5cewQSgvMYd1nPlmYVhVqADbp49GbabTRZmMur
         dr3ok6seDHaAJDQi0ElPBw7pqiadhK/Tsf6dlLLxCNhuDpj6I61iHQympozOj+Gx+he1
         wAz6EtJwDgEOG2CAyg5G3pfn8IUZasE2JygMO/jMLwesFngO3BVgrw393G8dDSI7cUeB
         mmL4uaT1v4MvOLRWAxziFW/JxqcWjCZArRtTLm+xOPNYhp2UmY01hP1GYGLPXsGSuZgZ
         9+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521612; x=1688113612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiSiRUaPfzxmVW4AyK57CaN+sPgO62cYU9V0E0mDe2k=;
        b=c8nasKkOPXCElbBz8nAfL5QgpirA/v+dZs79irtMXZf2PXxWVvqmLHZ48Uo8opQRQz
         36CyISlGdABwedEl8sG7l7LE8UXr2UW70J/MIUMrETtUG6pK57vW9NKzOp8dtHiRr0uA
         g0l75nyjNlgrYNkZZrvOF/mFrRGoPCf5jiSRX3ufXMJxp0SLB5ZTIpHcnsGLAIpbMLQq
         cKy6bdsLymN0EsKDf4AKmMYuuB6dfyt/PnvDMNsTyWGyMJP2Ou/MNFNdTSeNmnzSDFUX
         hmQ8J3FiByamsJQbA3Hl1SxaP5pAtbFjXXSXonf2LvNHx4uGPXW/7cZjS5yYgzxDs7gW
         pKjQ==
X-Gm-Message-State: AC+VfDysFeXMiRIg/W+3IUBHIQFU8ybrjSyL5C8q2jDAPDQnelyVpsAk
        v+0Ga3qL1kVE7HP8aRo9CTsjpQ==
X-Google-Smtp-Source: ACHHUZ6cHvljWJdQhE7Vzobpf3K9ONLbeeQl0Q1zQG6O9IwFRZg2our6s8BlQOITYKSTCGqnoYE/+A==
X-Received: by 2002:a17:907:9341:b0:973:ea73:b883 with SMTP id bv1-20020a170907934100b00973ea73b883mr4104534ejc.66.1685521612282;
        Wed, 31 May 2023 01:26:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906488a00b0096f6a910ab7sm8564159ejq.190.2023.05.31.01.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:26:51 -0700 (PDT)
Message-ID: <7d4089df-e572-4d3b-6fb7-061d69479dce@linaro.org>
Date:   Wed, 31 May 2023 10:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/15] arm64: dts: qcom: sc8180x: Add interconnects and
 lmh
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-8-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-8-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 18:24, Vinod Koul wrote:
> This add interconnect nodes and add LMH to sc8180x SoC dtsi
> 
> Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

I don't understand why this was split. We talked on IRC many times on
this - artificial splits are not "release early, release often". Your
previous patchset was correct in that approach, but why this is separate
patch?

Best regards,
Krzysztof

