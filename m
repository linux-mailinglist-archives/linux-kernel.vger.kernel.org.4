Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A1707705
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjERAkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjERAkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:40:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688630FD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:40:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so15524901fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684370402; x=1686962402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JngQhTfI8Rhrj1ZIfILXfp+eL2PcOd/TsT6KpOwnk48=;
        b=iy8RKNEn+FsGeDYqHGbbnFfumxi/pBF6Sq0+qzowkAO2jW6ExgeF0x7KLhXRmVyHaE
         E5OdaHMBb0n4k5TgxUNG6W5e2Xmscfu2soHhn/JKD0DP3r0NDxgIC2XKDDH9KGACR4hz
         2+LX6Iy7KjNO4eLGEABun++y4U3K4sNRrK1YgP8NWVA8IKput7fxlW5gDOF/9asuHcAn
         S24VwhSPU+0PsN1xLkMnV+0w/lJ8Hfbg3ArU8WzeMEIkuPY6YMFG0c4lF58kscy6Zhh2
         0CtMQhSDR40aNzsQUWbAuGYyZCuJ4T+TO63OzW4zDjhqBjL3+snYgAOguT837aZFiTNi
         UWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684370402; x=1686962402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JngQhTfI8Rhrj1ZIfILXfp+eL2PcOd/TsT6KpOwnk48=;
        b=BWkAIfCdjrBkxLydNXn0OxMELOxbrLovbFgMAX78glzU2RovlB8RXzk8G4zQKiZk9d
         N8hH8+AkMHbWeEs9EyXmaDeF4vqSZhp4B+Q8oBIw9qv8WVxXtaGFQDfWp3/o23BE8ddI
         PON64w0+eXM4Yt8E7HJ7z+uo7xNaUN9OyBTQ/u71celxk8GBtczMcWT82w7KrwVSnhYR
         +qZKYFPk9aFWBjavBS4QC9YXORcivc1g0KqrU5foO7NBoNJfz+vJTXfE36MhekxhGnUQ
         7cOMLiaSTkJ8lduoIWDmB2+y9aKLQLxq9yA0YFfJJDln8mu6Wu4G+4bipg7FMYdWdB/z
         VhPA==
X-Gm-Message-State: AC+VfDxtp7lUzc0B5ce2nP4ffzSfxtfZSdwjGAOnSS0ZeNrc+8o0gIst
        SB9gmVYlUCNbusHqGurFRHvmYQ==
X-Google-Smtp-Source: ACHHUZ6QY9V+7pTA8acpF+FmTwmXPPYTPPVNMX2b6n7ZK3ig3bL5P1d9m5APWgm24EoXfZaAWVwi0A==
X-Received: by 2002:a2e:7004:0:b0:2ab:365b:dc7d with SMTP id l4-20020a2e7004000000b002ab365bdc7dmr10106805ljc.27.1684370402427;
        Wed, 17 May 2023 17:40:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9906000000b002ada45ce1fbsm1345lji.128.2023.05.17.17.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:40:02 -0700 (PDT)
Message-ID: <e3acba8b-3832-3fac-81c2-1b13ef851a3c@linaro.org>
Date:   Thu, 18 May 2023 03:40:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: power: qcom,rpmpd: add missing RPMH
 levels
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
 <20230517-topic-kailua-rpmhpd-v2-1-3063ce19c491@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v2-1-3063ce19c491@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 23:12, Konrad Dybcio wrote:
> There are a lot of RPMh levels that we haven't included yet.. some
> sadly turned out to be necessary, add them!
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   include/dt-bindings/power/qcom-rpmpd.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

