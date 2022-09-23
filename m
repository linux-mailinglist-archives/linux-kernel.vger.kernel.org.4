Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B95E80AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIWR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIWR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:26:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C414F28F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:26:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so1367984lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=d2aMGH6UHNRKejwJPNEF8etSbQwBB3RTv4C2uFoQ+hQ=;
        b=Rxm2qRqAZnLWxG+kWDcYrS34l/7LustMqorREHAh37L7BpSVEAe75br2Cga0STKUHa
         mBzvUCgSYj1AXSH8JrCJ/PyICy+z6sDl4alwbLljG5XhYTcUSTYIZz00wGLa9XAAO1MY
         HX/IEuup1VLNDKZl23dFQFmkzWB3LE0UwMJ3ptrhrJaHjLKRy/1He8PUQt/J6g84y5e8
         CCcrlnPmk+Wpuu9YJrqd7aj151JMn1O8BQl1DT9E4j6p+xfFDgfP2OY/PRLYsQXsjxEb
         X7NcAO75+UgZr0VdTFCL9mXE0fuXMZhP03tWOBXSS/RXDMgIxg3UwfnyuQsEP5QaimcI
         qbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d2aMGH6UHNRKejwJPNEF8etSbQwBB3RTv4C2uFoQ+hQ=;
        b=Rgz8mQst/MshVNvIvpo5bfTk7Qxz29BCgsScc0ZT4q5VGSKJoy6OD5NCK38NHmo7kT
         jVVy82DSXCXrtjrWookEzhHHQ57dRnm1+Me1WMj9zEMBnFCykSMAzY617MQEG4JL1c9v
         5PNzbTOl0gWVe6C2aHasYJ6lEw1zXH/CN4cvswybeu7MNFEOwh0T5Vsj07bxjnP20yTU
         +qBKP3qj5pGMeVp6M9xH3Cn3fq47srZWGLN/bt8N8TM8A1MXQ+FDIDE4VMPIzBo0DKc8
         f4hbxMnRLfbiKZ2bOd9JdNVRnP6uJKm6Et0RBYyEGseC1/FJedRkaIvuD84InHSnSdfF
         L00A==
X-Gm-Message-State: ACrzQf2xVSrtW7u6Mgc/Yz2JNRV04W3I+SgRI9GmX4JupvVbDumRZT2W
        hn+BWyBiE89X9bMTHKj7Wfxz0Q==
X-Google-Smtp-Source: AMsMyM6RSipJh6L8w0HLJBu4EMBCoIT3+KEpfBtSapvzTG4RRLReX34X6mW4Pz3ej2J0UKIzYk7uBg==
X-Received: by 2002:a19:650f:0:b0:494:827e:5ef5 with SMTP id z15-20020a19650f000000b00494827e5ef5mr3487893lfb.411.1663953990513;
        Fri, 23 Sep 2022 10:26:30 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p9-20020a2eba09000000b0026c037747bfsm1481226lja.3.2022.09.23.10.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:26:30 -0700 (PDT)
Message-ID: <a15fa97e-de7d-c2a6-e39a-2dd7ba8caf31@linaro.org>
Date:   Fri, 23 Sep 2022 19:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v8 7/7] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
 <1663938340-24345-8-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1663938340-24345-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 15:05, Srinivasa Rao Mandadapu wrote:
> Update pil driver with SMMU mapping for allowing authorised
> memory access to ADSP firmware, by carveout reserved adsp memory
> region from device tree file.
> 


Thank you for your patch. There is something to discuss/improve.

> +	if (!rproc->domain)
> +		return -EINVAL;
> +
> +	ret = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);

I think your bindings do not allow iommus property.

Best regards,
Krzysztof

