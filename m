Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409B67B101
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjAYLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjAYLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:18:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173555899A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:17:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m7so3025286wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3c02ZBU/h+VaIjVTCIp0P42TtNnqSC3O7QS/lDp4nw=;
        b=FhZ+VBTOrfqHJrMFjNCmxHuAEEsyY7W/iCoSZN6RCzq6pOVzwh6DzLPNjzFHc7NCfn
         5/b1zSXn4p3pzxCcmfDJ6BjUXKCl0TdNNK4hU9JiJHhi4AZYcpgdJENuHbAG3Pq5X6Ml
         YbeMHH/4X2P0WSCjUSd1JZmBILwkol1xiq9cNbp1wVGsrU9WCmP0wE/86w097Y43/GAD
         6nt+5nZWXCLWBvjrcvkDzukmVH/HLSYwKe3k81YUIZLDyEMcY94s+15IQ7MEszn0+u2X
         9ORE6wjmxjP7CwhhTcJW3M+edG+ZCdi/5AVpENvTPbgxKdnXI3GH7oREMZlDKWq5CQD5
         RR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3c02ZBU/h+VaIjVTCIp0P42TtNnqSC3O7QS/lDp4nw=;
        b=nc9mdErkmoPUeEEi5T3+1D34T5BBPUua+UZkGJE5vuSuR1sZ6yA2iwBvSwbpqPcDeC
         RL/DTeLF+wSUWa0+hOuMwiRZMvDyXnrOLB5HunbhJvKtsHnl4hf0+BEE7GL87YDKYne7
         uT/jRcp5WyRaJOpt7OC7xOgg31gXSFV+R72isMqLY+3swP+RMHHJp7ftQR8FGbjiYbHI
         P/kxD+JUpyBf+haRMO+GcgCchzM7AQR9SGTlwVae5DzrW28ZMY79rTseF32Twbhe2Q+9
         8GAY3LcC4sBsAO14D2e1ByMHrOoxASIhenb7IN2+x1ZWhwQCzgF+iEPPu8SF7KcP39gS
         CM+g==
X-Gm-Message-State: AFqh2kr3iBqoKJ+NPwIgl7ozLCwZBcWM3cf//5SV60AhRgTHpB0DABQ7
        8NtKHkjie1W6q8gkvq2quO2PlA==
X-Google-Smtp-Source: AMrXdXsmfqnIoPGyLHFJFQV2BDh2/vFfd/d9dybfdByvyno2aAG0tGglLwkNmp9AsMlvxFUasIabnQ==
X-Received: by 2002:a5d:6681:0:b0:298:4baf:ac8a with SMTP id l1-20020a5d6681000000b002984bafac8amr27915259wru.44.1674645434310;
        Wed, 25 Jan 2023 03:17:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020adfa4c1000000b002bfbf4c3f9fsm226488wrb.17.2023.01.25.03.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:17:13 -0800 (PST)
Message-ID: <248d6bfb-404f-e2d0-33d1-502c064116e5@linaro.org>
Date:   Wed, 25 Jan 2023 12:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 08/10] dt-bindings: mmc: sdhci-msm: add IPQ5332 compatible
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-9-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125104520.89684-9-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> The IPQ5332 supports eMMC with an SDHCI controller. Add the appropriate
> compatible to the documentation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

