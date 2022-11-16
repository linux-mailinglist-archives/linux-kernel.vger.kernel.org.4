Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28E62C648
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiKPRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiKPRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:22:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3C5986F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:22:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d6so30580916lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOMV24mvT6Z+gChaVzQ2FKjnamE1RqSiBkM5c6Q63Ew=;
        b=VhC2ELA7YYwkUZb3bqvYlfuPX+1ULotkPGoE39eo+LnfGVW7aZ8ljsvZE+z0Vpmi7F
         b1KPQ+MrZ46lUHBr0s8t8z4SWSgod9aMHBfYI3VA5/ES2GgKDuWV4nGV4sLoPpQVY4Wc
         kJvjktAmoH2Ot9PNLco7SBm+dJbX+EcejjFR/UTsst0qCIwt6W4XtTDFp9ktv3bOO4FT
         CWhfZNm/DFDTbLH6X4+rT9UfZ39SCBOdq1SWE2VP2x6SI/Rundva8d/OFdeoKXCxTcQg
         QqLIl0ac8Y780hl/qi9f1f5mIXblSuLsUWef1q4XyKpriHxBlKPwhbwxIR25EmwdEiFc
         bWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOMV24mvT6Z+gChaVzQ2FKjnamE1RqSiBkM5c6Q63Ew=;
        b=BZhqk3X6XzXUCxnTAcdgrNfcp34BmfnATSm4LW7eV3qfgLXRnlk8l3bhbHQjlukbKG
         rn0bXPGJ97DGrT9Xts19rguFYW80aj0Esp0Ow/LGEoHPzvH8UHSWVwagIV93on1FMRWk
         LM7BMwaWWtGB1+2MvbYXjjJiabqdAQge7LNhyfQd33qMp1NlFZuGzViugUQaAQGJkYJg
         lmLQ2wqAyyZuUrgmHxAfxsfJlK3z+QMiyajoxPTBycU91cy5RbFBGSUUpokf4WT1tTpy
         xoesSILWtFyWybRWwzpecLVCVuDXzEI48vmmkt0qn+sLJdcNYfD6FcHj0Jxe+OismqiK
         drJA==
X-Gm-Message-State: ANoB5pl5SsGZqpFRz7CTrr9CKpaC2bhph8sMiu2WnARqtmIv3toyzFGS
        z3uGOB9QSGD8pJOCAZj2VC3pHMwuw1RKPI4a
X-Google-Smtp-Source: AA0mqf7ZXR3rHAMssv+XBEoFFz7RGw+jMe1K+n1jByylzWyEXI9ntbh5qO3dWE1n3vDXUPNbpNKRfQ==
X-Received: by 2002:a05:6512:252b:b0:4b4:b20c:4b7 with SMTP id be43-20020a056512252b00b004b4b20c04b7mr990804lfb.201.1668619320495;
        Wed, 16 Nov 2022 09:22:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651c10b000b0026bf43a4d72sm3085645ljn.115.2022.11.16.09.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:21:59 -0800 (PST)
Message-ID: <b0fdd995-85c8-0833-9d94-918812005d3a@linaro.org>
Date:   Wed, 16 Nov 2022 18:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Remove unused sleep pin
 control nodes
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
References: <1668591184-21099-1-git-send-email-quic_srivasam@quicinc.com>
 <CAD=FV=Uzky4uxs+qwSH9d7MBBWbXe8sMdvB_-Lqkq+6jbTCciQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=Uzky4uxs+qwSH9d7MBBWbXe8sMdvB_-Lqkq+6jbTCciQ@mail.gmail.com>
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

On 16/11/2022 17:51, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 16, 2022 at 1:33 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>>
>> Remove unused and redundant sleep pin control entries as they are
>> not referenced anywhere in sc7280 based platform's device tree variants.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Chnges Since v1:
>>     -- Update subject prefixes and commit message.
>>
>>  .../qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi   |  8 -----
>>  .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 20 -----------
>>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 20 -----------
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 40 ----------------------
>>  4 files changed, 88 deletions(-)
> 
> Reported-by: Douglas Anderson <dianders@chromium.org>

I guess rather:
Suggested-by: Douglas Anderson <dianders@chromium.org>

It's not a bug, no Fixes tag.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Best regards,
Krzysztof

