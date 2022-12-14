Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300D64C4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiLNISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbiLNIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:17:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE121AB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:16:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so9183369lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UKZNjTqFrLvhRemtcdNoCB2Yb7eyan1hhE+/D3cqyw=;
        b=WzQYvdUpcVCIY8r49pKw4TmMj0zCwaoz0S+fOCn+Q5sS3RAnv6gyWXvTKY4QMBU0I9
         7LeApndVFzgMN1mwaPX0iVrkUOukNRrVSDd5SjAeS3/0+JDdnbv8CvPmL1OAcoQzhoSp
         5wy5/Z88nk0rGM66d0zQNjqjQCxEx0iFfoSI1x7UzwE6p5ZNwHbMC7jfOrIYc+xJs9+a
         6uHkXPj2IFkY3nlD/KRYKXenKtqInLjxhdN2tC+hmLiQRUVmhRcOjt8TBggo3YzCPXjF
         HBoThopw3nqjHE393bPSk5gDWCaHb/fIC+B4DdEWfd+WmTLWXglZeW7YPFmJK2+xyAVa
         DBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UKZNjTqFrLvhRemtcdNoCB2Yb7eyan1hhE+/D3cqyw=;
        b=CjQ8kIIqNMhdMoWc/ucap1AchLI48gdMdExFqoat6HfG7XXNFDvtok5SbSX/BpGxAZ
         W1P50nmIXJGg7AbqP1DMywPTKRyXU6EU8UqLGMm/calLzjyDxsw0sVAqqGtklO781RRb
         Z0RuQaQ+4XVF8XotjyT85EHBsl0JQXRv091fTDnSMhhgX98zaThQWUmgrLIuH+OvtkJu
         2UM7Qa0EcBXnnGPAukA/UE8KKPmbhFqBpR+7DsBv/Cs7TdGqBZeER0kCId2Xv7483Vyb
         R+YPE2MjfyJpjZSbyFcbxEo0EdEFVRGXm7EteBO70SiUAFI1edRKABlEbrHoNPQtq7MA
         cVZQ==
X-Gm-Message-State: ANoB5pmBVPEbpCN2O7pu163lJWM0fxAmNxeMUSqs+03+kDnjqxf0caVZ
        /jv46ITfRjLws6GXv30rJgLCUg==
X-Google-Smtp-Source: AA0mqf6oRwBiuLp8UTnYhW4a/Om4d3rqzJCebsNT+DJ8fM0u910PQvWiQp7S/cJaU1TYB24GwQ0tFA==
X-Received: by 2002:a05:6512:3691:b0:4b6:fddc:1fcd with SMTP id d17-20020a056512369100b004b6fddc1fcdmr1407648lfs.23.1671005812316;
        Wed, 14 Dec 2022 00:16:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v2-20020a05651203a200b004b5323639d8sm711192lfp.155.2022.12.14.00.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 00:16:51 -0800 (PST)
Message-ID: <1f347914-4ecc-42c3-d268-87700ff689d8@linaro.org>
Date:   Wed, 14 Dec 2022 09:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add zombie with NVMe
Content-Language: en-US
To:     Owen Yang <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 04:47, Owen Yang wrote:
> Add entries in the device tree binding for sc7280-zombie with NVMe.
> 
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 12 ++++++++++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

