Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F7663CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjAJJZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbjAJJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:25:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2050F5B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:25:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co23so11045645wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAers7RJkSbAqWZ/DY7+7hCFdFQyY7dh3A3KAt7bg78=;
        b=VtvA+tzWqE8zMypNL2S+9CXEyJQCvIqlgLsR/ksThTScdxWGBQEDep0YDbI4/X/C7n
         nDEbb4pkkLaB7HPPgiZvMyZMojFpg/vMYrw/hbyXoeyBJ8HHKlSI046R5gV28zsVB4hV
         862O/H10egIBkpoHw+dxErtUAb/HrstuuCK/ZN+TXb8jLYkB55B8zYr3lcbYI8d4kbkx
         RnAOwgUDjnOzKxNuFbJGTon7FGyNV0QYBbM1GgdxaEPi4finMugql75J/r2L+pQ19Xz9
         l/h5dQ5k0qMdvDkBWbyQ9EN7fhLeV9ZG+bEWvp5b/fZ0XyZDVoQbStsjqvoMQbJhaQjK
         e3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAers7RJkSbAqWZ/DY7+7hCFdFQyY7dh3A3KAt7bg78=;
        b=fho7aZ05wlJUJbfxhcDqovhMBUuQMSVjypjqoKU3FsTjxcoL1rkREROV6HxPeq3aXh
         bBnsLb9PKLLuTrZRZdsCakVGQk6fhhNMhPV/DDZRvBtgO9AC70R72SnYnno4C+bGFyzu
         wNkpCGxq5cZQpO3glS1xEsjiqbriBMnUp8ufqxJ+/b2yfhRIvi9JHt8xUicQ8D4PxPHN
         edwIJjt9C0E6dk3yldLZHll0ZOZ2Hsl3MO+znVKHQREVBCIZP+Fb9WAlbuv/oNrbIq7q
         DF3wsqZMdoVZNCweBXNsMVNJm9z6ojQtnoxc0SxhbfDE+nISE/V+3nlwhzdb795IsTTU
         otwA==
X-Gm-Message-State: AFqh2kpQ4uRAbIVcXib1ddNK4wsiHqzJe3YB9NOjHGALQ2mEtLzWqiHo
        aZBO/OPtHLi4F4EzpefGBp9/Eg==
X-Google-Smtp-Source: AMrXdXurdokXYHTX4nNY+VTIpNAOasrzVAkQZTCeQjZdpnZ0x4w2KMAxce6L5BYg2eiNlLTpQ5J4vw==
X-Received: by 2002:a05:6000:1b0e:b0:28c:44b4:d8ec with SMTP id f14-20020a0560001b0e00b0028c44b4d8ecmr25395500wrz.7.1673342713686;
        Tue, 10 Jan 2023 01:25:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m10-20020a056000008a00b002683695bf97sm10561160wrx.58.2023.01.10.01.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:25:13 -0800 (PST)
Message-ID: <c71d5d68-e81b-048c-c97c-23b235ae377b@linaro.org>
Date:   Tue, 10 Jan 2023 10:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: document SM8550 DISPCC clock
 controller
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-dispcc-v3-0-8a03d348c572@linaro.org>
 <20230103-topic-sm8550-upstream-dispcc-v3-1-8a03d348c572@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-dispcc-v3-1-8a03d348c572@linaro.org>
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

On 09/01/2023 16:47, Neil Armstrong wrote:
> Document device tree bindings for display clock controller for
> Qualcomm SM8550 SoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

