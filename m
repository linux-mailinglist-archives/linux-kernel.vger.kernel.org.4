Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FF6DAA5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjDGIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbjDGIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:45:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3E4900B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:45:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g18so6988361ejx.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680857137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkzZhTvOzLRcCGpfrge05I6LlNCd0VLnVsi76p0/Q9Y=;
        b=tidL1h228tOzQTBOUqn76zpPuR/cmWNKWhR2GufNT0+O1y7j3oF2OSRoqiUVqkC5qI
         vY2BAyE2ubUgiRQ2Y/O6RRY9teFunLs7RVjucHn5es55NYCvw3LpQtTL9VsogpVwPWq4
         xXrUU3p05SPEeWazhXCGVXFC5Q2AmP7aABD7xTd/FRcPSVoY904UT6oYaJHBglQaqG0K
         5WBajTPFS/M+EtIoWUjcbVLVQpRJev7tEJwrrmHuJT0nmhKdJ+QVgMJ9TUDx1/yF9iVx
         R/nDMN+yvJtQHUv0nltGy5t/JpoOdTa1RdJaAjbPTGZXVsiNlDx916SCzNqMW7Wzfqbp
         bMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkzZhTvOzLRcCGpfrge05I6LlNCd0VLnVsi76p0/Q9Y=;
        b=cPPKq7KcacIStVqF5B30bFk8P39P0Xc8RzwvGljM9vqdwd8VeLlM2yOgwNt9Ks+l2L
         Eh907DCP5PTvo0OVL86bxAiAdJ3IXVfsTF5/spT4Qf9tDV6O/TBX7NOlmKWFTmF4ZT7n
         89b5InNnPPP+C4ZkwSRaqqcOXd0y9VTNmRgyIwnNSm0WkLlHzD3C3TsQbsO97nYJuHMS
         hG7BlzeVROXXU8yYRh30RPvd5C54x5qPwbUd3WBgi3A7lD6nPz2z98HUbSf1dAsrywDL
         ae/p0q199qimewCRS9O2u7omZefbE5lTLlYVaDbXt2iCWQrKFl8czF+NrzQVhIqh56Kw
         1AmA==
X-Gm-Message-State: AAQBX9eBEOob+E6qVvehfgGHWC9iK5gAZVnzifwqXC1+F8+g9GQhy7UT
        D9K8xn0K7y+s45QN6FCMbced6g==
X-Google-Smtp-Source: AKy350brdfe8nxr1JYdpIW6N0eS4YwtysVwTUFW03OaK40Lq1FF//oAXxsoNoLZ77c3KBnpLWspb/g==
X-Received: by 2002:a17:907:7608:b0:8b1:7ae9:647 with SMTP id jx8-20020a170907760800b008b17ae90647mr1063441ejc.76.1680857136910;
        Fri, 07 Apr 2023 01:45:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:14a3:366:3172:3c37? ([2a02:810d:15c0:828:14a3:366:3172:3c37])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906a20d00b008d044ede804sm1802700ejy.163.2023.04.07.01.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 01:45:36 -0700 (PDT)
Message-ID: <0762cb76-a1cb-d25d-2a8f-8f9eda21cc81@linaro.org>
Date:   Fri, 7 Apr 2023 10:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/5] dt-bindings: ufs: qcom: add compatible for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230406194703.495836-1-brgl@bgdev.pl>
 <20230406194703.495836-2-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406194703.495836-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:46, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the compatible string for the UFS on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

