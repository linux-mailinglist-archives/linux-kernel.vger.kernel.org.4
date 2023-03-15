Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3B6BA91D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCOH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCOH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:28:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0006B945
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:28:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so71682343edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678865297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dz/fDXpIMxHHU9kVKtLHNE3YLna5vRDD/ZQnCdxnzeY=;
        b=vrTQdxb2g7WXprgWj7NulV5Bq7giD1eDu7Ml1IV+d/r1WW0ugEY4ouiMaVWUpPgVRk
         eU9KbIXj/E++1GTyKfvanjnfD1WIvzJ6RZ6HGDhvAIYeTwJW09Z41uHawvPnUUVmdXat
         /aoLO9S0LiN1leslcCLF+QlJUlV+onPnoMG13bU4HL2Rhvmio5wMlDJKuEhL1pxAzwuA
         s0f/SkfvFcNZaEUKtA6jW5D1X3lFiAoOg0ARiVhpQ52tjSzGiGC8BC14RInGqekNxV22
         1L6aW26sLyWgSAJHSCXamT2dea6/S0E1j3/il0dmwimB5zgTEaTKfddn7LXyLEqv/+As
         kI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dz/fDXpIMxHHU9kVKtLHNE3YLna5vRDD/ZQnCdxnzeY=;
        b=iESTELWJ/eOYR86A+nrXys1DQeZH74tBPCs/YVCwIMp5VbgTUPMxy/UJUeE4Ll2NHb
         1kpZb8eQfWym2g8tBSU6NCQnLlMrRkXgEdH3ApUvvLEqHMUUuKLUhd88U0icGmWDZzkf
         UTP+Hd0tOcpKrYLEZ0GgmCGUqo0jPPXQaRDpFIpVs4iGl93D7DjfDn+qbCcIScuhp56i
         26Pe0ht+MTRCBd/ZgX4/ygPrO27E92/XGeP5IfzdIm0KeQOgsMIq6yIYMdXKrSh/1b+E
         rJV+O7gWEuQRoYiVZW7Q1pialwMW6Zkt6K8cvrzse8b0+iv4LJLFhHJiLUfU1K1UTVii
         Z4Zg==
X-Gm-Message-State: AO0yUKWStHScr2STUVO7W22BNcpwxMTmKdgHlRdJfoea5vSM8fVeNiZh
        zjgF9R9zJCW8nYYU/cdd27/tig==
X-Google-Smtp-Source: AK7set+XI6n1AFO0dIXIKy1u4p2umWkZ8SUUz2szxe4/AmFewsgidwYAfU1GDVJTjEjEpaJ4LpHbZQ==
X-Received: by 2002:a17:906:244:b0:92b:6f92:7705 with SMTP id 4-20020a170906024400b0092b6f927705mr5903113ejl.40.1678865297653;
        Wed, 15 Mar 2023 00:28:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090629cb00b008e17dc10decsm2117715eje.52.2023.03.15.00.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:28:17 -0700 (PDT)
Message-ID: <8b5cdb2d-8f3c-add6-1a67-e805b4e03ef7@linaro.org>
Date:   Wed, 15 Mar 2023 08:28:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sdm845: Use the correct BWMON
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
 <20230304-topic-ddr_bwmon-v2-6-04db989db059@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-6-04db989db059@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 12:41, Konrad Dybcio wrote:
> Drop the incorrect msm8998 fallback and use the new qcom,sdm845-cpu-bwmon
> compatible to distinguish the DDR BWMON found on this platform.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

