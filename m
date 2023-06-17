Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2C733F68
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbjFQIFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346280AbjFQIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:04:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89406272D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:04:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9829b12b80fso237323866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686989084; x=1689581084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJrsf2pwoMXl3PeH2n9Eu8zL86w1f8iDhqh4pji1Kuk=;
        b=TWts4lPBT8wmpu8xEy/41MsKVIzbCajbsglH9p9R9Vu0ARwJfbqMpZ0mmceE6qYCIl
         iMvOYfxplWhTK3W5PdRiXkuZt1/4wTrfQI3dAMxrz9RxGDLDNNOuC3amY5ULF4OvfiVy
         nNFgI/NelFKPxTo860DYlZQm9vOyXAO/Q+AklHg5aYuJABxgVMPpWhDgTz8rnWaaSn16
         Lar82GOunRuu3Pb4QQS/UZEZqVOSzSjFw83q9Zqu01hDBlaq300Xu+ByOhnkwRencpjL
         imlF3HWljBUsO8xbZqsDZfhcVf+Lo6xPLkCk66CpjjUfIGSfKvb2/kaC0LkmANPLPyaa
         RyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989084; x=1689581084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJrsf2pwoMXl3PeH2n9Eu8zL86w1f8iDhqh4pji1Kuk=;
        b=O1LIlL5APJmr+S8Q6z5P+LZ7OJOhy9dk6vnthc7li/eXjWSIvygKBgV2LJuhYQmFph
         CYlXwI3ecumS+WLaCAhB12/t+XEURO7B70vFPEKrPyJrCEb2SmLFOobwuc8nwUvhVqzL
         hjR5R9aXbOR9Bsrru0bxoWmiEFvdleG9W07DAC7ISl1yYHtvAljyrDUB0a0tQMdSlv16
         w4Xjsi+ACGKc4AlXtUMveRKIoiR+uvHvC7u3khIFksV1X6T9CLv+mnChxNuM0PFaA7RP
         S8ze4XKYLmOJH6m8HVBpCiYGlT34KU1Z2WnxARwdkX3cV68QL7xOQNuTTnShIlFyvbMl
         8yVg==
X-Gm-Message-State: AC+VfDy/78koKdql12q1QIhAgmbfh17G8/OlwVWL602ECTSnFedIKfqk
        ZacxuEcsS1CNWv335smw2jFP6A==
X-Google-Smtp-Source: ACHHUZ7tfsqu+22+UNCW+G6AYFrV7goBkQ5VBIhB+LhrccM00EVCmocaQdT96lk/VxA3oP2U6Cofkg==
X-Received: by 2002:a17:907:704:b0:974:e767:e1e7 with SMTP id xb4-20020a170907070400b00974e767e1e7mr3815136ejb.28.1686989084099;
        Sat, 17 Jun 2023 01:04:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n25-20020a170906379900b00977cc473b41sm11917947ejc.142.2023.06.17.01.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:04:43 -0700 (PDT)
Message-ID: <f2c19379-4d1a-e5c4-1452-103dd693735b@linaro.org>
Date:   Sat, 17 Jun 2023 10:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 05/13] dt-bindings: remoteproc: glink-rpm-edge: Use
 "glink-edge" as node name
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
 <20230531-rpm-rproc-v3-5-a07dcdefd918@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v3-5-a07dcdefd918@gerhold.net>
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

On 15/06/2023 18:50, Stephan Gerhold wrote:
> Semantically glink-edge and glink-rpm-edge are similar: Both describe
> the communication channels to a remote processor. The RPM glink-edge is
> a special case that needs slightly different properties but otherwise
> it is used exactly the same.
> 
> To improve consistency use the same "glink-edge" node name also for
> glink-rpm-edge. Drop the $nodename from qcom,glink-edge.yaml to avoid
> matching the wrong schema. qcom,glink-edge.yaml is always referenced
> explicitly from other schemas. This will already ensure that the nodes
> are being checked, so it's not necessary to bind to all nodes named
> "glink-edge".
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

