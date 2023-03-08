Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745756B0744
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCHMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCHMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:37:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D405FBF8CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:36:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j11so45587047edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678279013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GKBb6kXCj8IrQlzVxgZe7N+HQnXLiN6ZWwRdX8kCbc=;
        b=mVcd0/i9/l4WNM5n9E4tDTmyaJABsSm0mjw+4cyaD/uSMbmp+St/B8IxAyUz93mImS
         i+SLwK3l4qf4/QOryd7sv49Fl7S6LHIFxDPEw44TaWFnFkrw2/ebepWMZNjQltIrd0AF
         JIDHscgjW2OPAKvRC2GGd3U1A4TINw8dKO47yXq1hNPYaVf1ENE7/3OaX/MIFoRWMwd2
         T74Pl1E4jOLW5HE5xVllwHdHR1b0kWWGScNi7nZ5BD0pQWo5dW+b08PK/pjR9BGJIoFd
         clq47lzOiomdqr1SUtqwesPpQF24PMj4yB7wVKTQDCqgagJobbyyrzPyN+tJpBcejt9O
         Pqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678279013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GKBb6kXCj8IrQlzVxgZe7N+HQnXLiN6ZWwRdX8kCbc=;
        b=t96G0S6hBfK2dLx24zVzb0hPw5lJpCHeGMJALyQX2laSEHpYYbZkgFPs6+s3Gc2EHo
         sJNe6nibAAKG4pin/Ed02d+dw2hSbbK5JZdO8AX4DNthB3N33GM6DDMQIM5DCitHCyg4
         hLS8Go8+q4jgfKxzoNinLg3g6R3kKtJqCX5fR+Rb45mmnDPC2e+h0MRg5QTbEbM/VRqN
         AngfMhA5owmRC+X61PtZ0K39oF2Qs2BRnfCeMYs10h+kt9yvg6GpbRhu3DYs/4dHDX8M
         OdZ0ixZSb5R6nS1fNkZ59rxQrECxaAQhAl9DP6C6o5XGPy56bKsM8rm3K5ZSlDQVfAte
         eWKg==
X-Gm-Message-State: AO0yUKWxNYE16JOHJNqeYIIFRbzY1wuacOY1HoH0fgqHU37CuMc4RVhf
        W+nETNMPL7XAv/YLQpNVCx5yyg==
X-Google-Smtp-Source: AK7set84lbXKZOJNt3FRVlRb4jkKKSLIkuPEbxq/uASmuTblYP+Gz4gKIodsvXuvbZ1xLWs/64XiSw==
X-Received: by 2002:a17:907:8691:b0:8b1:3009:536b with SMTP id qa17-20020a170907869100b008b13009536bmr22082511ejc.29.1678279013309;
        Wed, 08 Mar 2023 04:36:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id ky24-20020a170907779800b008edf49f10a7sm7398003ejc.100.2023.03.08.04.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:36:52 -0800 (PST)
Message-ID: <8f7bddf8-84de-27b5-26a3-d80b2e2f0097@linaro.org>
Date:   Wed, 8 Mar 2023 13:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: correct name of
 remoteproc_nsp0 firmware
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, quic_shazhuss@quicinc.com, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307232340.2370476-1-bmasney@redhat.com>
 <1a915c33-ef32-852c-a856-10c8d35be151@linaro.org> <ZAh6O9TbX/pnOnxp@x1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZAh6O9TbX/pnOnxp@x1>
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

On 08/03/2023 13:06, Brian Masney wrote:
> On Wed, Mar 08, 2023 at 12:02:04PM +0100, Krzysztof Kozlowski wrote:
>> On 08/03/2023 00:23, Brian Masney wrote:
>>> The cdsp.mbn firmware that's referenced in sa8540p-ride.dts is actually
>>> named cdsp0.mbn in the deliverables from Qualcomm. Let's go ahead and
>>> correct the name to match what's in Qualcomm's deliverable.
>>
>> I don't think vendor deliverables matter. linux-firmware is here more
>> important. The file will be cdsp.mbn in the firmware, won't it?
> 
> cdsp0.mbn and cdsp1.mbn for the sa8540p are not in linux-firmware and I
> far as I know there's no plan for someone to submit those since QC would
> need to approve that. I can ask though since the DTS for these two bits
> has been submitted upstream.

If they are never going to be submitted, vendor is allowed to rename
them all the time in their "deliverables". Are you going to rename the
file every time Qualcomm decides to rename them? There is no single
guarantee the names would be fixed, because vendor is allowed to do
absolutely anything.

Sorry, but any argument in upstream DTS that "someone downstream does
something" is deemed to fail in many cases.

Best regards,
Krzysztof

