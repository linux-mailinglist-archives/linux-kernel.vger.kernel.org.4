Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2E5E99B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiIZGlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiIZGk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:40:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567CC192A0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:40:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so9313443lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eEvomUPAbiilR0mKyM+WIzCcrPikO0w/LFnRQciIxbU=;
        b=w60uglZUbrcD3QCNC0WDlhn4fApibMa2aQsWpBwYCibhs1DBWo5EBY/PjL8wxVv26g
         477bVsR22foGesJpe6cgXjXh3fmpoaFaCgZ1soGWKo3GW7FIWSdYRRLPNEVssFg8HB0O
         Lx4oaqIjEOJtNMl4DW/U/RVPRI+ZlWAFgkgLa88o3DJROB0BAgtHDHQgxfO7jyUqh20o
         ciCfTypVKX4vkHxCT+GXFL34RM1AtsrJKCDNvZLPckBvqe7EigRrfkMElWkFCwUoJWzC
         R4yKjVlIBL64SBieqoLefbjdN3LN3bI//9/y+1cGUojltg70VhenDoplBx1L6UJjur42
         4IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eEvomUPAbiilR0mKyM+WIzCcrPikO0w/LFnRQciIxbU=;
        b=E7XPyPKU7FVd4UcdcN7Ip2wTLEi/5QgO5GKdjYNbS9s3YFU1JXcK1W0TgfKW//hwA5
         melVK6yWSZTwlNlBSCeRG+3pKBwR2WUJKYfpCr2h3mMSHi1LlGxDSV9DyRUaULJj+l7b
         RqpdRBFWUnksX4/tB1+NxkNnfInJbk370n4YAWzgBqezirA4gzhgYLQvYiTWYYyDbqpP
         bNSpGcPQ5a8sbTPJPcElFayX9QTs8ZlE/vVXmxQDLfUA9sClyuF38GOYOEg6e7+zbDNO
         wBiqinA+nN75psUfdPBYjNOjMTqh6nW7q0EcXFlT8IXiKFlsFR771Tv40PevVtMaQU/T
         KV4w==
X-Gm-Message-State: ACrzQf32W9/OMWWxumrajeDGs3kRVh34f/9wiS3dPRip48AN6kzFteex
        P2/BEbRBiiFUUJKLg8OTWgoyWQ==
X-Google-Smtp-Source: AMsMyM4ziGPYUJOsSHyxIGY8wGTAbXEUpXp6IRhzzGaBwqcucwGeDucnhnk4DeXgU7z0ZsmqNB8jAQ==
X-Received: by 2002:a19:6b05:0:b0:49f:53b9:abb0 with SMTP id d5-20020a196b05000000b0049f53b9abb0mr8630989lfa.166.1664174454735;
        Sun, 25 Sep 2022 23:40:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a195f4e000000b0048ae316caf0sm2440905lfj.18.2022.09.25.23.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 23:40:54 -0700 (PDT)
Message-ID: <7b5b9f3a-129a-b6b5-4348-cca7381c2d1f@linaro.org>
Date:   Mon, 26 Sep 2022 08:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sdm8458: align node names with DT
 schema
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
 <20220923161453.469179-8-krzysztof.kozlowski@linaro.org>
 <d3218018-45c4-4777-77a7-91947ad48666@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d3218018-45c4-4777-77a7-91947ad48666@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 20:58, Steev Klimaszewski wrote:
>>   				#address-cells = <2>;
>>   				#size-cells = <0>;
> 
> Subject has a typo - sdm8458 -> sdm845

Indeed.

> 
> Tested on Lenovo Yoga C630
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>

Thanks!

Best regards,
Krzysztof

