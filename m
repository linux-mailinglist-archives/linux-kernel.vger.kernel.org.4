Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86B6D033D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjC3Lcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjC3Lcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:32:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5086AB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:32:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j11so24059615lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680175959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ML54njYnRDk7o4HcEtvBM1tdyqleAobA4f6MiXOsND0=;
        b=a/g+QQMgnVz1l1tCLbVoEfKvVrzG4Xjf9B/g2JnuhGkNI4tS1LKGp1kHbW4YojKXJP
         Ku6fYadkn41YpAXh6gfuoR19XBByfRsf+RL7L7hWXCOUEeYxV0AYmurCdxeKIpD8RPss
         PH8d1/1V+EoHMV+xfrP1f0DwGPhHQNgfzWwGZJD4KkBOBxZIIMv7oURArB/WMsSkHX3h
         VVSDTx9HY6t6ViPQAbDKHYyxvr+oLuos8cOinpMc9vfwWqUQF8ktCMuSXpObwAIhahoG
         +bwkrBcFsuOwsueSArm8r8Tws1djOqLQ/+dDrJIGdhdWTFRY8hRcyi5iOcB8tHeyAbtC
         /kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ML54njYnRDk7o4HcEtvBM1tdyqleAobA4f6MiXOsND0=;
        b=6WqgCK9w+MiX/tTY1JAkXrML4YmA7MV7hHxzgBNtudyCkTdvEzCvLaUjHF3V5UKWD3
         mnSM/W/NYonXbyCncexc4syOTvhYv4XswDnQKMGDfw4gd4PwG+lRRQA4s+rB5VR5/DiQ
         RwpZIH+h0MSis0NM/EoWVQSWZnFFObG2h5WkXNXfCoDCsjnKp7ZXjPxNMNZOcHD1WHx7
         YTrtQmwBBbCPetudvS9wdzwQUrN/tQlYmQTJbGEV6beSrRgElX7rp4rTEZRO+eda7H4g
         3N+rgC/bQFg8QU6xKDOxidFVgGeRxolfdBUhsiozfgisAKVDfe8GPTRfQqCWSaXZVvca
         KWdg==
X-Gm-Message-State: AAQBX9ds0yDPxqOCXstTpx7u59UiPwZm575fpQRCy3qn7kWBlq1kRNKw
        Rz+b2VJ4bZH0VCFW7kx4SeOT4g==
X-Google-Smtp-Source: AKy350bMZjydyBjP+bF1x8VvhUrc9aWFBhqR/qTQGnyb2aqUrAWzyEDsIgUBBXfUgRNjjkMMx0iANw==
X-Received: by 2002:ac2:4903:0:b0:4db:3928:d66d with SMTP id n3-20020ac24903000000b004db3928d66dmr6644024lfi.42.1680175959204;
        Thu, 30 Mar 2023 04:32:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r17-20020a056512103100b004e8483bff82sm5830343lfr.271.2023.03.30.04.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 04:32:38 -0700 (PDT)
Message-ID: <e10bb710-3515-8350-b3be-cb740751c130@linaro.org>
Date:   Thu, 30 Mar 2023 13:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing
 NPL clock
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330070342.19448-1-krzysztof.kozlowski@linaro.org>
 <ZCVxTlb+qQXXuaay@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCVxTlb+qQXXuaay@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 13:23, Mark Brown wrote:
> On Thu, Mar 30, 2023 at 09:03:42AM +0200, Krzysztof Kozlowski wrote:
>> Several devices (e.g. SC8280XP and SM8450) expect a NPL (Near Pad Logic)
>> clock.  Add the clock and customize allowed clocks per each variant.
>> The clocks are also required by ADSP in all variants.
> 
> This doesn't apply against current code, please check and resend.

Indeed, there is a minor change going through Rob's tree. I'll rebase.

Best regards,
Krzysztof

