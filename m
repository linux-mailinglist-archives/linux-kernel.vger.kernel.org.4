Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566376A56D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1KfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjB1Kew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:34:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF338A51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:34:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bw19so9142231wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677580490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcIFZ75GszROWVHc6fhuQ2yZDaxcPc/igDnt5Snznss=;
        b=hHB4WHESAJnekEReyf6uGCnczOr42Hhw7lkNkUk4gIPwcgTtyCSljxpqnXB2bTA7IG
         evNkmGEUZ90F7zckzsR2WzojUDk1xfUZrofd693USp+QNttzIv+uLSs9HhYywKNuWYpl
         hwJ3NuIlexGe3Ob6VZRCZeMbwSqeWb1O3uINVwcs21OkxOzaSK1vVYHiRixf3GRJ/Grb
         2dl7cgSyLIM2QJf/FUKm6pQvhwL1iVVsSBJzceJkGHgBpNWiN4CX3vcK3kRW8/dtc+ID
         GOIEROTN3LAiSg1CQzS3u9lHSe4u414Ku7earTvryzXUheZJggMurcPuCRLM/T+qXaMb
         /Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677580490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcIFZ75GszROWVHc6fhuQ2yZDaxcPc/igDnt5Snznss=;
        b=nBxlMcBMfoOAW8+zjZDhJp2CRWbesrpgKm50Y04yJEQn6EfpD0kONwIHLh4yItqBO1
         Ya/kC6yoI1MzkTY0zfxSEIEvSsKa1nz/+CPQLoDFye6FYVpoYZTwzw/CbkE822jpnLn6
         +KJaCVFsZ+vjsn/m1Iv0Ok2QXBDZcV1JYrs+zvNb7e6Av3A++CewEnGNZp1tnXYDPMn+
         M+5HLaW8ZZobEou77Jrh1IO5/V2HKl9YNdVr5aYsLqvbChOA2Qz1gkSP411YBXJsqGeq
         ufuS8mCEyxnsYcel7FkE5CuNrjM7QgbFfZ0FK39f7qz8/euBLEGZHaj/W0ZaMCZsqUyK
         37dg==
X-Gm-Message-State: AO0yUKVnRZ86hbY40JVP3WemyHQSf/hjJXqZ+8u1iC8EGwSHwBDlveAJ
        MVUuionJJ1FQPKKjzSVttKr2JQ==
X-Google-Smtp-Source: AK7set8XI9Z0kByAgnUP5JY/bKFJVG2SMphbFAIpM6vToy46scsdRHYBTPE65nIL2wDnEMD/x8iLBA==
X-Received: by 2002:a05:6000:190:b0:2c6:e744:cf71 with SMTP id p16-20020a056000019000b002c6e744cf71mr1551763wrx.52.1677580489791;
        Tue, 28 Feb 2023 02:34:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p8-20020adfcc88000000b002c55b0e6ef1sm9772120wrj.4.2023.02.28.02.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:34:49 -0800 (PST)
Message-ID: <2e3e0f4d-f7ee-4ce5-272e-c3be13da8c8c@linaro.org>
Date:   Tue, 28 Feb 2023 11:34:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230228063151.17598-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 07:31, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> "reg" property is mandatory.
> Add vdd-supply and #io-channel-cells


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

