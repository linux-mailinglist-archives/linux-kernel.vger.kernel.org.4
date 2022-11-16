Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0D62BF17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiKPNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiKPNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:10:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011A23E94
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:10:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u2so21757427ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzLTp/uU4VbKo3MNkEDlZ41GKK9cTnY0rK/EndLg5gc=;
        b=GPzKI00ZjLIBVyYqVYEJJZAEvLkmwCubJYFFpd1TXtf324HTOzXBXm2egc8Hw7pDVb
         zvbqKZfE/Xp2r2OSmON9Dkqzt3D+lN9+RrHNWiHVn0GW3Q9CExkGLLF4VD7F/jC9qwr7
         qwkAaBLT31+49aE+8EO/j7wPpZ44MKqptaXgfTHKRvxj+XF72Sxw1ZUsIyAaHbSo1BeN
         Lho4uMpWc9AySh8LWXoWJiVMZ39FDBl7nY2SoUtbkV2zk4VxdbfF9+LbB173lvmqNZ/m
         WIDw4+f+dBau6UcEuqskGXyYbt5Y5yyrfGTPh7rBjFpgrlOYzfP31fCRYpogsL45ZWpx
         HviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzLTp/uU4VbKo3MNkEDlZ41GKK9cTnY0rK/EndLg5gc=;
        b=zmFz2aTgT1StPHRAa7AlSbTfPM/rhDUrKigONBkmqps/bkOll40ZrymLkXyKl5ofD1
         bHf/okTXSiWZxfsLLDpa6JwBc9vs56cq3wxWC5CYWg6C+VZhzlPFji80BWchJ92molxQ
         4yScZuk9vprTATKO4mPQpyuk6ssHnyBNVYES5oQiCxHRbZFMDJupC+O4V2+IGJRY56hF
         qP/8jTvVREuPOSMoxWuL59QJ+H6/lHdUaAkgluWrCHVoISVvmvQGYRlAucScOwvzagnr
         //ZtPB0mghcU2hERwPt4jozxJmDF7tq3PLF4FrvqX3w3lrIdgRNk3xkVDk/Xc3eYIB4O
         UUDQ==
X-Gm-Message-State: ANoB5pkXw/BRPJpG7lUDiu0KKnCVHo7s/Z5bTwAh+z9NBVge37UFqRwS
        kge8nqpvP6Zr6l5Petv2vNMY2Q==
X-Google-Smtp-Source: AA0mqf7/HiTZlKfMlkxf9Nc/zXIaXt8h0LfQcFmRqYUgDv50ZBUlJbONzPMOk4JoS+Kwp1FqxVjrnA==
X-Received: by 2002:a2e:300b:0:b0:277:31c3:c9a3 with SMTP id w11-20020a2e300b000000b0027731c3c9a3mr8129154ljw.473.1668604209609;
        Wed, 16 Nov 2022 05:10:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k3-20020ac257c3000000b004b4ad5ee601sm406738lfo.255.2022.11.16.05.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:10:09 -0800 (PST)
Message-ID: <37650284-77c2-44c0-93bb-d7ef303b62a0@linaro.org>
Date:   Wed, 16 Nov 2022 14:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and
 boards
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116103146.2556846-2-abel.vesa@linaro.org>
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

On 16/11/2022 11:31, Abel Vesa wrote:
> Document the SM8550 SoC binding and the MTP board.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

