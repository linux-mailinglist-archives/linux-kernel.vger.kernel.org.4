Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6941F5BF92E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiIUI1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIUI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:27:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF989916
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:27:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a8so7894131lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gY2lzq3N2Qe2ssVBMXnL/s3SN8sMkBLrkElMWRrbxsA=;
        b=DziEZGWtHcHI4L/Gz3wfDxdm66CUhwr+qYwy2jz88G11sb0IHdQPEg0QPm9mNALHFi
         WCWgcC7pK3OrLLH5jhaZk1rPcM1wn3HheatWrvhwTM2BUiHTGwZUVsiYGuumE5KpUABx
         e4HHzRHWaE0XysvOCB8tZzUJgUd1PpPUw17eV7/L7fvGTpSirkV7oVGCnRupcQUDpYuw
         EfGz0Y6NgEJOX2b6iGU5LaKH5eT8Loc30hfbaQUgtiRI3YpQKbA7KXwoAvgSretfdhJE
         PKfzKPRx4R25Z4Y3QC1grCq5kHAsZB47xjyeSC8h7W/9l40YVzqZEmYdstJ3jgmDJmeH
         6IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gY2lzq3N2Qe2ssVBMXnL/s3SN8sMkBLrkElMWRrbxsA=;
        b=1cDBQSs3nzQ4/T7No1YwQVf1rbsRx2bExtwvXifqSYjJ6JJhG/l1tL5/4JKoaUDxie
         VYdSLJLjn+Kd2l5Wwni1vCkC+jA8hWXRLjgHalJV2wZjurH6IWT2ONWospNSs5JbyrrH
         V9svRN+/NE6/jvYu6Fir0QRftoHOGG28P6OoQgtFO160wPcpIekAzZNusjwsdohTHuBG
         oCrs/Xr7pB42To6l5Mv4dWH8jY7zGu8sw3kfu/RMu3g4oT2UTZUTd4yTXsYK2QkkgFxO
         H8r4yCPDLMggGcfeGltQDh8opJlY0Ub0gwDADePm0tg+Joswf8W1eNfTKMNYiiG8s1Aj
         QK0g==
X-Gm-Message-State: ACrzQf0l7yWujcG6gEhvRW8tfO+ewKAGe9LeFPixl+7Fb9tVnjoDu0z5
        VT57Kh+/ueixLiit4NjeCFRM8Q==
X-Google-Smtp-Source: AMsMyM4pf0Cx6J3kAlAnrQDlQNIDLladkdySQ9qoP9yZpwNjyJlZIkYXTUAypORtMZkYYohrGTiAkg==
X-Received: by 2002:ac2:4d2b:0:b0:498:fbf0:4f89 with SMTP id h11-20020ac24d2b000000b00498fbf04f89mr9327153lfk.500.1663748830232;
        Wed, 21 Sep 2022 01:27:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b00492e3c8a986sm325857lfs.264.2022.09.21.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:27:08 -0700 (PDT)
Message-ID: <df77a1d2-ee85-75d4-7341-6949d5b82ccf@linaro.org>
Date:   Wed, 21 Sep 2022 10:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/3] dt-bindings: sound: ti,ts3a227e: add control of
 debounce
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>,
        devicetree@vger.kernel.org
References: <20220921081834.22009-1-astrid.rost@axis.com>
 <20220921081834.22009-3-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921081834.22009-3-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 10:18, Astrid Rost wrote:
> Add devicetree parameters to control the insertion, release and press
> debounce times.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
