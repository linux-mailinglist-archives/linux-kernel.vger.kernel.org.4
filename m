Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB66C50A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCVQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:27:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2056284B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:27:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so42358236edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679502443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycyENMdFF2CzvQbQDOTRVEeRhFxhD958v+PK2qLS/rA=;
        b=XnwQ71LENmBJUSgIhcJW0wRK5YRU9HunpXIDvks06eW2P56ged43ro5SCA7tEC7rlc
         IZC4F8dJ9psSZcS5rrUUXczjpoJ15xmQ61HqpZ8bODxUiVyID4MDnbccpv2qCqffWKm/
         strkFgHpWhYSxgONwkyqzk2X+lNXnv6/XN3DKlt+NuNLFotcCNsb5mDCQMbJZZ1XHSfc
         bg+vocnKIz0ZiaWI7sw+MqJu8PnYYtR25zC0lu+ugu2QlbHI0TcgycLv6Ftmz+iPNDgu
         qYDiQwAHMJpxNHvNKZl57LjZex1JUt6U9DQpiMvQ9X4Yu0VvX+WPBSP+ehFSbIQhC8dO
         BNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycyENMdFF2CzvQbQDOTRVEeRhFxhD958v+PK2qLS/rA=;
        b=7HzTBjPPKc6l38J63N/5/JkfBDXrfgxotoCl3S07pUiM5f5K8M1xr1FaLj0MEEV+zK
         lAvO3Okkg2M8/EOhXr2aS0kCaXb+gnYJsMlpAouY1dKLFYToGJazt+NYjXpxFw+9K3l9
         9I/jLTlx0vSz/7PI7vlORHeFUdACc54+/VOEhBjHYJtUtgfYf8CsJar5t1uZFdyavWx+
         FfrEpCtUczt7xNdBhUJZIKNoSiKoHKbOVj9L/RWRYEV8i1bNZXkwn9Dvu982UADUco7b
         qUGK63ANIYyLJnwqJBVIzscfjtaIdq3cfrC5JmuY7EJP5d0L0jlskv6bWhjiQ4EiqOAO
         gd5A==
X-Gm-Message-State: AO0yUKX0fwFrvrIe5r9Ha8JUUNQ6i3vb1ZUVO4zQXNDVnYCpkU40/+SH
        DbZPe0eab4yuwe2fQFmaDID57g==
X-Google-Smtp-Source: AK7set8LzK5u+Ph6/0aJMK6sntiDB6rs2QcNpTYFEg1/IjOeLFTvgvc2SMYKGCEqfQgGujE9DLjp+g==
X-Received: by 2002:a05:6402:219:b0:4fb:9fd4:6ac5 with SMTP id t25-20020a056402021900b004fb9fd46ac5mr7449880edv.14.1679502442936;
        Wed, 22 Mar 2023 09:27:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709066a9700b008d53ea69227sm7402394ejr.224.2023.03.22.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:27:22 -0700 (PDT)
Message-ID: <e1d53083-82b6-d193-517e-02af281a066a@linaro.org>
Date:   Wed, 22 Mar 2023 17:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V1 1/4] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <1589f33deda07cb9f9e6c3c26bce6e02e53c168e.1679403696.git.quic_schowdhu@quicinc.com>
 <c0c6c79b-ac77-cdbf-5b08-38b89e4fe481@linaro.org>
 <260cf3ae-1acd-c4ac-a42d-4ca848ec5664@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <260cf3ae-1acd-c4ac-a42d-4ca848ec5664@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 14:34, Souradeep Chowdhury wrote:
>>
>>> +          - const: qcom,imem-boot_stats
>>
>> No underscores in compatibles. Why this is not SoC specific compatible?
> 
> Ack. The boot_stats module is not specific to a device. It is written to
> read some values from this imem region which is present for almost all 
> QCOM SoCs. So SoC specific compatible is not given in this case.

Yeah, but the generic rule is that we always want SoC specific
compatibles. If this is not specific to a device, then you do not need
anything in DT and just instantiate it from some soc-driver...

Best regards,
Krzysztof

