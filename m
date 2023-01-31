Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDE6834FE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjAaSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:16:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15314234
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:16:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so11318021wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPKrSP4Ne/SNxeLI36oVC9k3148tGOXUA1eFQ1WZK8Y=;
        b=kjKgH5WUo/W1L09w3eQ1emaWqJGQzJPLq0yAWiwSzppFk7snauHaNUm6fdJwN3WMFp
         osmQeaMMdlVpoJOyEhp80n066EhpehO1YAVq8Skef8N90BTp2eF6mJwd+9lMqKiiO9VR
         HQgS1I2agvVmBXXf6NpMGFRfc2yAK3Nje32KvW5LURhIo/BPEQ87E/ztwp18YmBkyaoN
         2ErB5+KoCoqLdVVjT5ZoU8VJ/WrwZfes1uXUXiT9e9YT3XOTgLlB1D+Pca2I+FfvkzQL
         znhq7icCbBagdjZa63x8LBxrppUCBk5rex9IB0Cfxh7JRE7I2hmyRd7L79uYXtQNk3wy
         DwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPKrSP4Ne/SNxeLI36oVC9k3148tGOXUA1eFQ1WZK8Y=;
        b=xZmWhPPXV9318ea8men2KleJqINHiNVSuu2EoFO3Jn29opiuvbKm3UpztYy+qCYNmt
         SnVaZgx9DNJQWjV9ycNW0XJmF3vOH58HcZRZw+r/pwH7g6jFbWmaWjouLXFne/qLxpwU
         SWtQe/4fxft4fYOZxLDpf3XOct+FF3NfaVTMhWEGoum1rrM+FSbiLh3PRiag70avYASc
         2Y2TgoFmY9t5xyhPOlF4ubXAxUIYFcz1QTgZ/9ONaanGXjWnfZ1FUW1Re80J1DzRQokc
         o0/28mQl/Is1a1xGq/TTmNaqXzrpoS5R2ktcXqiWCKRcrxU7RrvMeoDPvQJDaHIquVdK
         /KJA==
X-Gm-Message-State: AO0yUKX6yRilPZ6Q88lBTh1zu/Z84GRPMYrOqtFkSU/WxA0CG/YPVy2m
        ELBOvSRBuP7QF1XElCCkxySpeQ==
X-Google-Smtp-Source: AK7set8bPV+NrF1XZ7KloiOXaXxOlRpzXbUWHITAFZeTAADJ6cGnUcIbU3oPQaEmkbyjZLATQAC3ow==
X-Received: by 2002:a05:600c:a07:b0:3dc:2137:d67d with SMTP id z7-20020a05600c0a0700b003dc2137d67dmr24054500wmp.16.1675188991728;
        Tue, 31 Jan 2023 10:16:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003daf6e3bc2fsm58592wms.1.2023.01.31.10.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:16:31 -0800 (PST)
Message-ID: <871e93e8-5a20-461a-50c0-c7c3c0a7ce8f@linaro.org>
Date:   Tue, 31 Jan 2023 19:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 1/7] dt-bindings: Add ipq9574 clock and reset
 definitions
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230130125528.11509-1-quic_devipriy@quicinc.com>
 <20230130125528.11509-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130125528.11509-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 13:55, devi priya wrote:
> Add clock and reset ID definitions for ipq9574
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---

Subject prefixes: dt-bindings: clock:

>  Changes in V3:
>         - Added a separate clock binding for ipq9574 and reverted the
>           changes from qcom,gcc-other.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

