Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCE637744
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKXLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKXLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:13:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9913E07C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:13:33 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g12so2068752lfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCj2UGwGM6w6ZRGQowdeC2XnWEPWL1uXR/0dltIvUwQ=;
        b=XLX4CK2BN8y+2/Rw9fe9pSJddMHxO4Jj0B8KsBOQcz0Hp4ZyDYIqKp+SeirpiZAFAm
         p6NdrjCcsLOMKZddZ+qRoYura7Sqwgmz3ykLV1v3WGE7sG5ZOeb96+E8usmo1w63l67D
         DpDpGbpJYZ97fs4sRh7JXh+lOWHe7B4BnlC8J9nHMIMjteiplDHLdNKD54v2mpEzeNlH
         MTb+LrBkuFgGX/RqG+MR785N0kdlkPN8tgHeGk1XlY3px26hH6W4aSiUoJUxtdyVjVRg
         RSZNrFjvANfTTGicn3B+26yaSot04M2Xhrct1Iv7rgu2RBHq3xFPfd6kvqW/GP4Xd/kg
         LW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCj2UGwGM6w6ZRGQowdeC2XnWEPWL1uXR/0dltIvUwQ=;
        b=QE1C0BU2XfpQV2pYvBYoYHTRaaqd1iXCXDmqwlwzc+RrhK8VjTF76U7NI0LVVwJ+JI
         7JFmUOzR7yWzvjm1+0UFmypNyCFZEMkMX2IV8b/nwJP7+SO/UnuYTq1OMEZslgHwGTI9
         MfNT/91W/yGgOHUUPnFr/CPc3Fyz6UVXmF/zHnSrH/8n4qYDPBZva6+zdV+r41xGtVc3
         Iw58URLN6bJxn0UVhp8fMCZU3Qt6BE025Lu93b4d2qf9HSQ47As/p82JTUk8DMqtYhiD
         IX0otSnDdfw4+j4nSWlGd0Ch8bso9+OoPwDjk3fInrAjClIt1ugi7KOxD8thgGlXrBrT
         W3UA==
X-Gm-Message-State: ANoB5pkg2VmmGwHlTp9Co5/Nm+Z9D7pM0s4wBt8YzCVigfScQP/hMuMo
        VPU1ZtnWswz65fp9gJ2ehjuDBA==
X-Google-Smtp-Source: AA0mqf77SJcXFxiT+8w1pskHsMFpUj7CdpIorQh3ACsDwCn46PkgObtYNifZNSkbEYo1vZBQPEdkFQ==
X-Received: by 2002:a05:6512:1043:b0:4b0:efed:e3a8 with SMTP id c3-20020a056512104300b004b0efede3a8mr10457783lfb.650.1669288412115;
        Thu, 24 Nov 2022 03:13:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d13-20020a056512368d00b0049496855494sm91047lfs.104.2022.11.24.03.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:13:31 -0800 (PST)
Message-ID: <3cda9005-d7a5-56f0-d1d2-fd6c1cb36fc3@linaro.org>
Date:   Thu, 24 Nov 2022 12:13:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: qcom-scm: Add optional
 interrupt
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, robimarko@gmail.com,
        quic_gurus@quicinc.com, quic_rjendra@quicinc.com
References: <20221123204615.25358-1-quic_sibis@quicinc.com>
 <20221123204615.25358-2-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123204615.25358-2-quic_sibis@quicinc.com>
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

On 23/11/2022 21:46, Sibi Sankar wrote:
> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> Add an interrupt specification to the bindings to support the wait-queue
> feature.

Subject - this is qcom,scm, not qcom-scm.


> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> v5:
> - Pick up R-b
> 
> v4:
> - Qualify bindings [Krzysztoff]
> 
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 25688571ee7c..aea6e0c86a89 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -73,6 +73,12 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  interrupts:
> +    description:
> +      The wait-queue interrupt that firmware raises as part of handshake
> +      protocol to handle sleeping SCM calls.
> +    maxItems: 1

Which devices have interrupts?

We talked about it here:
https://lore.kernel.org/all/2464d90f-64e9-5e3c-404b-10394c3bc302@quicinc.com/
and here:
https://lore.kernel.org/all/c20edd0d-7613-5683-60e7-54317cac6e0b@linaro.org/

But I still don't get which devices support it and which do not.


BTW:
https://lore.kernel.org/all/20221122092345.44369-2-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof

