Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F9621E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKHVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKHVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:13:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FAC20F5F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:13:46 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u11so22973206ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+TEdIfIt1XEAkSUPk37PpRaSa+HP3u0XbUt51o/R5Q=;
        b=hybL/ifLuD7Lq7OrqxEgPb+C3hZe6Zq/o9AmhBC3t26Y3R8MzxahlatCWAkuQxba6s
         EPuEj4JngMnlo3aeVxau/Z1Qxs+H4hGVSBG+Vb3QnPV5hfRrbg/MhpQmYGnQacNIdzM9
         Uu6BHThBxpHD7xHsdvES0oRgA+K49VywCjvxSo4gmm3bP+1480sreCSqcgLZBxKvDrJY
         LM6qrbd3aMdEqxhBvamfi2ZZhgvEXsf2XQ7R8B9S7kurZ6AkdWCrINjDFXXqvaZJcp68
         em7YdfcJ/kU/5L2Qov073/b188bqObSSwO7qpAa8DbMGNzqeRqKQC2x+LRYKkDk4qxAy
         2NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+TEdIfIt1XEAkSUPk37PpRaSa+HP3u0XbUt51o/R5Q=;
        b=NaStOWCtn7EDpkvmDYTCTbBfgH7SY5a7rh3BX/6wMWX0oJuzrH6LV54Kao/DA7P+ob
         9cykwnAGhiAsdaQuxJrOcaCK47S/STq8gxhrOQq0ZzvtyrV1b3zrb2sIoVDX4+/yrJi2
         9okbpU4VdkYgckJfw1myXPV4UIizr1ahdxEAYBR4/8OQiGOs+cXjpH4DyiCc0XapfU4O
         vjCzqQs4EV2OHiXyNk1CeOedAEnyJtNYSfCWyRXVOwGutoFPkEOTsyfruWq70LcJHIfj
         LcV9L+at+LBRMpfLHRWt/ymk2xr04ThNaJTKe9hiwd/lBxj1HE6qO2n9vqtoUiH3K8pl
         2F4A==
X-Gm-Message-State: ACrzQf06DmGcghijWmhVQnzpR7Pnu7tou9Ocy4XBnst8OocWtqFdogDA
        tGKmzBviOrSR2gtGW71qEBsGbg==
X-Google-Smtp-Source: AMsMyM704MrNlUBJ/82vwUjFUx934aW7BWfazzzhogmQIqSx2TtM8uSFy20O42NaVeF2kUOmlZ6Pqw==
X-Received: by 2002:a2e:b626:0:b0:26e:6fb:4845 with SMTP id s6-20020a2eb626000000b0026e06fb4845mr7126546ljn.120.1667942025342;
        Tue, 08 Nov 2022 13:13:45 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24d48000000b004998d9ccb62sm1939713lfp.99.2022.11.08.13.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 13:13:44 -0800 (PST)
Message-ID: <20aa6301-c576-9221-d084-b11d3e9687e3@linaro.org>
Date:   Tue, 8 Nov 2022 22:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/18] dt-bindings: msm: dsi-controller-main:
 Alphanumerically sort compatible enum
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-7-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107235654.1769462-7-bryan.odonoghue@linaro.org>
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

On 08/11/2022 00:56, Bryan O'Donoghue wrote:
> Sort the order of the compatible strings alphanumerically.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

I think here you can see how the commit msg looks now... One line of
message and 13 lines of CC.

With commit msg fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

