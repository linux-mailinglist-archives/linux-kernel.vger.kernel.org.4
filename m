Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE10E606236
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJTNvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:50:57 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E3C181D83
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:50:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h10so13525641qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70fU6KeNRW7R1LN3rF+HXaUE8gLW+SCCFHePgLIEiVo=;
        b=osFhRyr/lFjJpuhojn5RhI73H7fstQhOUSHj7p97Lqq4Z3VScnVNwB1tSBEq1spM9n
         ODCX4lUpkQbMeC4Ltoyc7+MXY6LxDEvgTIRp5oJAxstVgUzH0kxmzADpyZ/Bn7Q+3ClF
         uDAp6pFPlvxUs/wrcxpNduW1PRMRC6AITgpktEZx1xyU4fIxc4wGKYkVX0HuyO2wl1uJ
         zuAnB25f+uiRmG6MpftLxAHWhSgq9ao7+zG/mGzy85HctJadMDTlJkarYgKfGFMQN06H
         8b1WQd+g6G8qJ2ai34risIZphkyqq37yYvCENAYm6E3Vx0Okrk/OMCInny27kxBinEzo
         9HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70fU6KeNRW7R1LN3rF+HXaUE8gLW+SCCFHePgLIEiVo=;
        b=yIdlCw5mD1D7DFWUOjw9kYxfram+v61yeOX3MoHYjgcJPoLiee1RiWG7QvGAXu47az
         31L10FERqQ1ldB5bw7CxVCJ1GDWMbppvndDt+YRLDMwXYsqHZTTYYhuel8LgpSzXqqeI
         gY/RgLP4GS14wNwpyNa4MO+2a3lCF1xVYDpFxn3sV6ppIEVYU2QIzENOs58ORHBVtGIw
         7QNN/I5z7QpiBhIUXBsQeVJ71lpKSplVqSrlzFkLGGdj/ILUdsiV+6MMGBLzSKlQHVHa
         jlMjCzEbbHB3tHXg8KAUjO3VMV/wop/b+by7ZYabFqoq9X5GD7HqR4w16tKinRg3iHxh
         0PEw==
X-Gm-Message-State: ACrzQf13BA5Knj1xhsQPEn3SYDuKW55x+cNrWP3S86xwQf7TEm5Anm0K
        M1uDjVoeOXyuR4zkk+i4ZP4OWg==
X-Google-Smtp-Source: AMsMyM6QEQctQDmwqUBoOcdguw1tjbsDuu/HyULlZ5GeSKS5bBIxFTQb+FWDzobc57MXkLYUdEP1tg==
X-Received: by 2002:a05:6214:2aa6:b0:4b1:95e9:f948 with SMTP id js6-20020a0562142aa600b004b195e9f948mr10998053qvb.129.1666273855138;
        Thu, 20 Oct 2022 06:50:55 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id bk18-20020a05620a1a1200b006ec771d8f89sm7482932qkb.112.2022.10.20.06.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:50:54 -0700 (PDT)
Message-ID: <53d02cf5-26a3-4e8e-fa62-7a2cfca2dd4c@linaro.org>
Date:   Thu, 20 Oct 2022 09:50:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: spm: Add MSM8939 CPU
 compatible
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 13:10, Vincent Knecht wrote:
> Document the "qcom,msm8939-saw2-v3.0-cpu" compatible for the CPU
> Subsystem Power Manager (SPM) on the MSM8939 SoC.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml | 1 +
>  1 file changed, 1 insertion(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

