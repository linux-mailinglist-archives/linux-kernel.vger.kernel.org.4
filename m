Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE9724358
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjFFM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbjFFM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:57:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661C1989
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:56:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b5881734so7657266e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686056181; x=1688648181;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EWLD0Rfz3KKrdobJ//Od8DveKQqxFwChlYWDKvD1K8=;
        b=SbBhSHEsahjkXd38bCYxST+5aWAex60Uxom+t73rO26FYsMtUA8GHsLQyIEVvaXkFt
         ng0u5ww5fjsgdPIghF7GXIDwZJFiQA9nyFmOkc548nUUFIv85QOBp4FDqu5qZNPq7+IR
         bGK71m8g06mpImGo3OQznCh0QOub9i69ViANW919GaLnPRabJZ9UdZUrHT2CAp0AUn+N
         UODuIfhP3qBFqIHJYxf4dMZ97Tu++i9Ar2TEGaVQ3WqzZYC+QqErSaWy3sOqKNk5X5zu
         yGyNHNlP2TnFbYrQ4A2/QkgExbMqde6szux/m+YOUN3rgr0AqdZDvY79X9Yr3AvgQTIc
         9vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056181; x=1688648181;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EWLD0Rfz3KKrdobJ//Od8DveKQqxFwChlYWDKvD1K8=;
        b=CVmqa/1tF4yWeWgRyq8W53V0j6IOUCt7MP2UAbM161wzVuUUO9tNNzJbt/xLvDAvdK
         buZ58e/cJor3u8sg6pby2cldA+vCOEJnhpbnQnE3rSWI3Jg6ZMXaUwHXTKxmgsLd3+Mo
         ZH7TeSxI6lxW3Bl4bz61urTL4v3Qo40rV1KC/wPFGuclo+2tATyFPkrUpOMHrDhlktsW
         utq2EFtsplb1vQzpvdcivmqzcWAaVcUAWHX8ZG9UOiexpHmAONaZaNptQPPyNHInOe5L
         FJvJnySVaKIuir09zh5QTOV6z0qATtel6qkTP1Fs1BFFdciYWH55NaQrJbWOIaJWufMw
         fctQ==
X-Gm-Message-State: AC+VfDzdI/PisRYKYxxUDpzzd7cuBEaiChrfFUuJBjTLzsksI+yrqc/Y
        husu8SzKIHEGaDsz0A+1wMsMkg==
X-Google-Smtp-Source: ACHHUZ4YPYdaGBZxa3Dn0r5wPTNNQKeSBZX8DQxyR3F0zuXXLkW4RYvNg043l1e/Ozz4/jBSIwfjEg==
X-Received: by 2002:ac2:5610:0:b0:4f3:aa09:e7e8 with SMTP id v16-20020ac25610000000b004f3aa09e7e8mr1045270lfd.44.1686056181602;
        Tue, 06 Jun 2023 05:56:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u20-20020ac243d4000000b004eb0c51780bsm1453202lfl.29.2023.06.06.05.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:56:21 -0700 (PDT)
Message-ID: <37c56ce0-3333-7434-2d8b-90d43790db06@linaro.org>
Date:   Tue, 6 Jun 2023 14:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 0/2] Add support for GPIO based leds and buttons
Content-Language: en-US
To:     Sridharan S N <quic_sridsn@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605052907.18837-1-quic_sridsn@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230605052907.18837-1-quic_sridsn@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 07:29, Sridharan S N wrote:
> Add support for wlan-2g led and wps button available on IPQ5332 and
> IPQ9574
Please roughly mention the platform in the series title, e.g.

"Add support for GPIO based leds and buttons on IPQ5332/9574 devices"

otherwise it sounds as if you were just adding support for that to
the kernel ^^

Konrad
> 
> Sridharan S N (2):
>   arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
>   arm64: dts: qcom: ipq9574: enable GPIO based LEDs
> 
>  arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 42 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 42 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 42 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts | 20 ++++++++++
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 20 ++++++++++
>  arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts | 20 ++++++++++
>  arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts | 20 ++++++++++
>  7 files changed, 206 insertions(+)
> 
