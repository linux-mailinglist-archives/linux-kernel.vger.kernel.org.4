Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F536C3A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCUT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCUT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:28:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358FEA241
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:28:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 20so9519559lju.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679426911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMKqy4dV1q10fp6DO4XaOGaJtKBDSRJAK3wcc/YHOt4=;
        b=VcNh1MuOGf6GzhKM7QfKzbToetlv9rlIadEcEn247ELWWnafByhA6qLphRLfGfzvh6
         Pc++l38277wu1ciqQYN33c3EI7egpihoR4leJs6feRvA+Gic/+08xQgDPD08Tfe4AnXM
         L1DJaaitXI1vL/lwqnqW+ZZvtv+Inv6KVP/gfdC1wC+onS51XM8DEFIjoM/sPjm18/fI
         7gQgWCVu/YECEr+0HVpHxJD7VrttSI3mVltMWxy0tDHaSX5SEwIA7vK/0UwrG1RLSF8Z
         2OkrQTadKY/99fodN6uux4dp4VHzTzzpn34SwubQPDHz+GqYZMvyjSMzIcXjd6p4CKBp
         gwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMKqy4dV1q10fp6DO4XaOGaJtKBDSRJAK3wcc/YHOt4=;
        b=s2jCB+5QXOuXyvwWSteWfsSZYcdFu7ueUhyVu85U58awIOxZKNJQMOLArH9ORxfa84
         9PES4APibKq3KRmJwekGiu178q1J7/yU8fwLAlVbWUSOU24hLggtotp6nsazqxfd9l2x
         pMmPPYT7qObrDMv/s5ks7F+GhpwAq+C/wgsH76UC8c6JFalXbd5HcqSMYolBKT0QvqQs
         hrBjtqX2W/EpRLsFxRLRRd1U6mMmjeZKrD287FbFEqa4Q+1aUTOrPutF25Cbe0PK+lkj
         DBMXr0WbjmS5iCsUKuHj9WiAwcXautnqnKKp3zYmfOzCsaH1YelpCucu87ihVOS1bTkP
         tAgQ==
X-Gm-Message-State: AO0yUKVdOLuzk9Y9djwxFXGvYPhI1v1J2ysiHQdWqMZd9zL7hR9pefGJ
        gwldTslWDfL4xOjKW1yuv0hsqw==
X-Google-Smtp-Source: AK7set94rggocG8EKaz5IJE/IfppPbxDwCm+rRQhShPGCb+/1i2T9oRpYFMAwryl4pgB0h+pxh5RNg==
X-Received: by 2002:a2e:a0ca:0:b0:298:a7c3:c26a with SMTP id f10-20020a2ea0ca000000b00298a7c3c26amr1465850ljm.25.1679426911422;
        Tue, 21 Mar 2023 12:28:31 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id u9-20020a2e8449000000b00293534d9760sm2378737ljh.127.2023.03.21.12.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:28:31 -0700 (PDT)
Message-ID: <3d00adbb-a19e-3c0e-c25e-fb6accbf2c7a@linaro.org>
Date:   Tue, 21 Mar 2023 20:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/1] dt-bindings: dma: Add support for SM6115 and
 QCS2290 SoCs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org
References: <20230321184811.3325725-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230321184811.3325725-1-bhupesh.sharma@linaro.org>
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



On 21.03.2023 19:48, Bhupesh Sharma wrote:
> Add new compatible for BAM DMA engine version v1.7.4 which is
> found on Qualcomm SM6115 and QCS2290 SoCs.
All compatibles upstream are QCM2290-themed, let's keep it consistent.

[...]

> +      - items:
> +          - enum:
> +              # SDM845, SM6115, SM8150, SM8250 and QRB2290
The robotics SoC is QRB2210, but this should be QCM.

Konrad
> +              - qcom,bam-v1.7.4
> +          - const: qcom,bam-v1.7.0
>  
>    clocks:
>      maxItems: 1
