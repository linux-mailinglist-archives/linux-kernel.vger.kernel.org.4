Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F069AA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBQLa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBQLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:30:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEAF66679
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:30:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l11so3578248edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v92NiBIjYWfziymAkr6wLKbvWDe+7TdVnIlek7VWKg4=;
        b=aehxZ5CykYoBS2jaabbw30nhDFy3UgG8JrMBcuCW9O+YfUDXX6pii39H9ZcsznmI1T
         qf0FIqy5nT4Vtyt1PUYw0p0mdjCqrE194s+qPTnYjcz9lOHEv0JFVI5Ft/E78PGv+znL
         tMbqplbJwSJuUQAtUvbt1K60YRqjtbk19LcPXiSL+Iz8lwR3vDrrKUgtWCyOoYdeYKnz
         iHccbkLF8IwPh0kXY67uIoE6niDS8GrW1gClhouoUQLTgDh3eo7A8H2e12XT5WR/rSIB
         F8NxsCcQc/OCfpVjei6rL8Z9wY7V3JX0fgvTzUcVD4d3Plimk8AUeQh+r3Cf6NAdf6WO
         j5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v92NiBIjYWfziymAkr6wLKbvWDe+7TdVnIlek7VWKg4=;
        b=1Gc900fCDQBL3L3Kaw+yazLpKGSne6RUEPUEXb0mYg10xXudGPeRKn3nb/T6hsP/rK
         JKzd7XwLCv+pX4gktOsGAxxvWqB+FsCi1QaG80GpLochFs7vp/8GbHeA42vnctGoxohK
         YWLf3ZAFCixDBCBlD4W6RLAb5qRHF4E7Ru654u1mK0Pg93aGl+S3jeTcG0KlRIV6iJ3V
         +U6b1F9wIMchcpefTOWU+m+UbyF096gzZzNtawj0WM4KoPY5HxkZovT8c2SWKpeLPgx1
         9oS1Qzztou74EU/XC9xJmGmHCICnb4j6XYa6KgbmTWS8VyWSTx44ZxpL1+Hjw8x/NnWF
         TRgw==
X-Gm-Message-State: AO0yUKV93isphyLkiYeNyHWYb8qAfkNw3bHVxMq50jSMwBlVHrSwjBc0
        vP4vIHn7kL65RT8zm1iMPisXW6BNLbhR4i1b
X-Google-Smtp-Source: AK7set9c3OK+BsvdM7YtkZ7FTNv0/+Gz+O1m241k5kxQLoB5GvCYK2NYpdilFc927EHUrqk1h15vqQ==
X-Received: by 2002:a17:907:6743:b0:879:d438:4d1c with SMTP id qm3-20020a170907674300b00879d4384d1cmr11441762ejc.21.1676633449765;
        Fri, 17 Feb 2023 03:30:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906529600b0088c224bf5adsm2039261ejm.147.2023.02.17.03.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:30:49 -0800 (PST)
Message-ID: <0284de96-0dba-9336-67f2-d70b5bede8a1@linaro.org>
Date:   Fri, 17 Feb 2023 12:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] dt-bindings: display: msm: sm6115-mdss: Fix DSI
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111316.306241-1-konrad.dybcio@linaro.org>
 <20230217111316.306241-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217111316.306241-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 12:13, Konrad Dybcio wrote:
> Since the DSI autodetection is bound to work correctly on 6115 now,
> switch to using the correct per-SoC + generic fallback compatible
> combo.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Depends on (and should have been a part of):
> 
> https://lore.kernel.org/linux-arm-msm/20230213121012.1768296-1-konrad.dybcio@linaro.org/
> 
> v1 -> v2:
> - Deprecate the old compatible instead of removing it (Krzysztof)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

