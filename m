Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23406FD8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjEJHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjEJHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:55:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7C139
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:55:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so10815373a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705318; x=1686297318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oob8w8ofobCi5vSBmyGbDt7IQ2Ps/8J6O1qvcfUAdXw=;
        b=AOIvpkjd/QsRYky8F0xjpBaEpCuRDCwXik8hQIKdGmZTprdNKPydwA7egtHhiHtr+S
         g2DxMuC5mGadrCd2Y1TRlOVFfNCYW/IFQGSiF0YpDgehbAJxB7YXFk8s6Q58OyZ+8eoz
         L+Rws7THJpOxpDSnPsTtc653HLV3t1x50t+nz8rPNGQdU8KuprFbPcIU1UTFiVpSnzce
         z9QeH8IHslagm1hRjPit9r00XaVF/4pP3HFhGCbW9GjU+P0icUPgqqZTGTa9MLnbY6Xc
         27LBZ7EdR0WEKeShlDHohSrXbBWJcu2B7txNGYADsWsWE0x9f0KJwiM6clU6zNI4CWRa
         fW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705318; x=1686297318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oob8w8ofobCi5vSBmyGbDt7IQ2Ps/8J6O1qvcfUAdXw=;
        b=fOb0mr6XXC7yBcamP51LNWgipZOSh8bkMzEkZojx/nthwa8uIG0hz7bc5inzLBOczm
         GOzRpHiU0ll1z5gza3WPoq1Il62rB66KsrXG6L+ML0v9vBb3F9a23ACJwbw7MKPMKgSY
         QobV22v8H72q8QH2JTcNSdZAj4oLOYr7J+YExfqt+3QwPpO7e6KftRvzHeK1ERZ/3WF7
         Mj3fBlMwUwQjvtt/PfbzoXQjJF+3GOL7gl/5+M3JIGt9Yg+QJQOcksPDgMQQJ8EcoojH
         +/YXfyBQxyOl7MiwxgY32t3CExxt16dnADJUvFJmgkxrWJzrrBF+fZdQ7vO8FJnVLa2G
         8nKA==
X-Gm-Message-State: AC+VfDzadJa3bzMt/oKZ/UKj/w6TGuJGbIeAMTYVH3FNk34IEyZXczZw
        o2N4ZOOBQmnP4eGPO34wB1fXIQ==
X-Google-Smtp-Source: ACHHUZ5golxil0e/W6BJ4TEDUe+sdgf27BzQ05eUIRsCUCgqLSWgzqWxOAj1zjkOs3zNleeaZHYFig==
X-Received: by 2002:a17:907:70d:b0:94b:d57e:9d4b with SMTP id xb13-20020a170907070d00b0094bd57e9d4bmr13863359ejb.2.1683705318163;
        Wed, 10 May 2023 00:55:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id de9-20020a1709069bc900b0094e6a9c1d24sm2386066ejc.12.2023.05.10.00.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:55:16 -0700 (PDT)
Message-ID: <7d426635-1d0b-2317-3b45-fb28b068b0da@linaro.org>
Date:   Wed, 10 May 2023 09:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/8] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 ports and orientation-switch
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230510031930.1996020-1-quic_bjorande@quicinc.com>
 <20230510031930.1996020-2-quic_bjorande@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510031930.1996020-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 05:19, Bjorn Andersson wrote:
> The QMP combo phy can be connected to a TCPM, a USB controller and a
> DisplayPort controller for handling USB Type-C orientation switching
> and propagating HPD signals.
> 
> Extend the binding to allow these connections to be described.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Abel Vesa <abel.vesa@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on HDK8450
> Tested-by: Johan Hovold <johan+linaro@kernel.org>	# X13s
> ---
> 
> Changes since v1:
> - Corrected port $ref
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

