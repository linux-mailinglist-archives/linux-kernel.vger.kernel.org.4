Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6B60932F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJWM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJWM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:59:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731B75FD4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:58:48 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e15so4893861qvo.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO+UkHP3qSo9wmUlBJFfBvkGAB1uRAOSNGp8xoOurrI=;
        b=YvZNysaJWeZXmGwRSE2ERG+z4YkSQ7oxiBVHH3CwnM1WUYliMDEa5ffWyYnwIMPkEZ
         280Sw1DcoqHlWQKSrDsbnEVb8JnesNbawwpD6K6LO6W+wLJe5U/ZNWwk6KTv5acIt3ps
         MPQHnuVfrBWfUHmKUmLAzwnJJ8TfbrUMkV/TBXLzxvkJva1vMF9vhm5e9G7nYxhm8Ceb
         KqfKC4O7BSDOVEU4I5auAslaK15yGagseRIUVLp1esYrlKgZmD5sPyIbYE4BqWI2CjVb
         goPuTLQcjsnq23M4pUjuSzb4FOv+xCn2DFV7MEvAUHx3Dpf/blPDaeNIUDNpdaTMSirH
         3KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO+UkHP3qSo9wmUlBJFfBvkGAB1uRAOSNGp8xoOurrI=;
        b=YlrmOwKhbM3tJnhs/yb9FzZZ/s1tr9ruB578zfTCAf9qnro0FseWSthOhFE0Gld1cP
         8PyyX8jabO6hxIrkm0XZFaCiB5s+gzhfhzhS5I9ajpo2CjpRK6APIo3XE0IuSW4DDEI0
         TUWZUrQBhr73C+iFB/O9XtqFgzIdwJ+NaSrv73jnUqZC1WRwBTBz4Rsg05mzEx2rFALh
         k2anT1AT8/lvTNEjLTmcRP3Q65orjl1NA2CdCzKFNYsNHOtBvKLMmDHz7ptCunCUOY3O
         Ob4m0r40MqnwEtwjQEbTR9Nl41wxDJ18E2f4x9Nvj/Vy2UvrIZPdPg2A4+oEuy4BQ0fO
         AO6Q==
X-Gm-Message-State: ACrzQf0HpS0SFv2gZ1V5b+ToQT49Ww6LutttNkx7nU6qMr0N8KM5kh2U
        8aL4boxDETm2dsiHEP8Tk64Sqg==
X-Google-Smtp-Source: AMsMyM5mTjlQc9otHHn+rbFqbUkTKUH7bhp15Nul+MkV74Kcw6SG0qrukblCBlQKVCT0fUDqKMLEmQ==
X-Received: by 2002:a05:6214:300e:b0:4bb:717e:72a with SMTP id ke14-20020a056214300e00b004bb717e072amr380735qvb.15.1666529874629;
        Sun, 23 Oct 2022 05:57:54 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85846000000b0039a9b55b829sm11411241qth.29.2022.10.23.05.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:57:54 -0700 (PDT)
Message-ID: <de65f003-511b-2ea4-a39a-5cb1cd409812@linaro.org>
Date:   Sun, 23 Oct 2022 08:57:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: cpus: Add Kryo 660 CPUs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022194218.210941-1-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022194218.210941-1-konrad.dybcio@somainline.org>
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

On 22/10/2022 15:42, Konrad Dybcio wrote:
> Add a compatible for Kryo 660 CPUs found in at least Qualcomm SM6375.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

