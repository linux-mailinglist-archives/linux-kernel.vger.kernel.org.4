Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC06219E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiKHQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiKHQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:56:35 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DC5985A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:56:33 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h12so21999875ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC7+VolI2Xokgb3dmDEH4B60P4b9V47rxRyDrGnv7BY=;
        b=Kvh1XU2ygifF8pd1pPYP3ss9QpfF5Pm4e3f1LTjwSDi8McME5MKp5XYnCoKryE5a4L
         LI10oVlOhIkZ5ZAlQa2vWVShH3If5lawcb1l+4YhnVKgTA8vjrdjmExReZS+4dU0xdrY
         29F0K2HTD4i/7U61F2duHKuWHCoVGdoF68T+gklopltu9ERau/FjUceOuEcWiUimBMBj
         vvmcoHNOFd3UBBwUwcbNoA5QloXV3ObbT+WHvHiCmxSSkkTvbkiJ6ttu+amvAHPp960H
         NXVtEsSN9z31KIxQVXmJEMh0L2RgPcpFPHoR+ATjYNAwpRnlKkvEaEtJSTPy88dkPVwC
         dXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hC7+VolI2Xokgb3dmDEH4B60P4b9V47rxRyDrGnv7BY=;
        b=T7mA4J+UTQQuS1meWzd5yxqSw2J2ts/leQujbV7h970K+w6mSajGOAPhTKtX5EeOPT
         hr5SLFsOUKiQbomtWyfWmbK+q12S7SSaGsyqs+UuS0LLnozSUHGfZWeoh6OOQoyLgWpd
         g1BzIxyJPcnGi0OeQGakJxLHzYxp0/bpOypB7mia2x+UG7roW/X78kCdQ2ldHFS0/H2u
         R+WBXGKKyVcZaC5YN7dkEqwwf2WNX5r4lBr9wXJ3lGmrpGO/dbIUgjIKWdSYHbGlXfth
         OMe4a9t+usqLXTB8FHEj712etovZS3nlPrKJel7Q6hXtfiz86ksCDYwJ6EwM6qT8WimO
         FSXw==
X-Gm-Message-State: ACrzQf0HpKqz/3i36/uiVou7c1TemjE0UB7QAk5V8x2oJ2wUxd18PV8s
        cZA9vKJNscyI9oKjLj7iVVHWmA==
X-Google-Smtp-Source: AMsMyM4XfQkuOM+aro7Fw77Bc9UCPCloL04gi1Xnx+NAhUmjFjVBoBMf3JHPikC/1fibOF/L2SZuWQ==
X-Received: by 2002:a2e:a910:0:b0:26a:ed13:cda6 with SMTP id j16-20020a2ea910000000b0026aed13cda6mr18721501ljq.250.1667926591517;
        Tue, 08 Nov 2022 08:56:31 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b0049e9122bd1bsm1841693lfr.164.2022.11.08.08.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:56:30 -0800 (PST)
Message-ID: <34f22ebb-2b9c-080f-697d-b37cd6deeed0@linaro.org>
Date:   Tue, 8 Nov 2022 17:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] clk: qcom: Add SC8280XP display clock controller
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926203800.16771-1-quic_bjorande@quicinc.com>
 <20220926203800.16771-3-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20220926203800.16771-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2022 22:38, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The Qualcomm SC8280XP platform has two display clock controller
> instances, add support for these. Duplication between the two
> implementations is reduced by reusing any constant data between the two
> sets of clock data.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Just a couple of bits:

- Use lowercase hex in constants
- I'm not sure I like hacking clocks up with magic writes.. this
driver can and will be compiled as a module by default and that
prevents a de-facto clean removal.

Other than that:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
