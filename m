Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D166FCCC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjEIRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjEIRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:32:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F140C4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:31:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so11535862a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683653518; x=1686245518;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgudkpE/XXuEJbi6kVtZntpRgZwfZvwHa+KTpRSfG84=;
        b=qi5aQvnnWPOLinC/jLCZf13CBVkM6FG3QOcdLfbuvwQP4XQbi7o7O9GhxbouDNwiRe
         myoPeE50qKEbJpB6arQ+03tEkTQeoceaqezgivj7x5hWepxoTWm+eEbJtW18WDF+Alxb
         R6TreSItd4esRPPLxX9Lm9M8AdHnW1hEwZRvQY+MSkzn1NQl6fzMJF6Trng6CcdBemqI
         BvodfS5PH6gEiGqgwEi7qDi4coExA1XOvLPNiySbDiva15i38Z/EldMz1n7Up9ju7fY8
         AIpwLJkgz6fyHqLSgZCFNAF12KnTYrdpHnwYDRP028+TVb5/WGuE6ds3VzuOlXRw3tAw
         ixFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683653518; x=1686245518;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgudkpE/XXuEJbi6kVtZntpRgZwfZvwHa+KTpRSfG84=;
        b=XNWFcsj50aiWDpjs96G7ghZtLE1fFV0r1k+wt10/kHwlwXTp//A6224zLMqkUXEGKX
         fY5Gdk8xuNjcaQPVmRge+MTtVRt6IDnW8hTpzsCY6jQ25RhNtn6iyuG5KsCwausMtl43
         Xe+2jYh+gCFX5cvCu2UHBaJmlPwB4yHvQ1ANDbpWhsJQ+FfLMpQFRr4Fs/LY9slBTMzc
         EUk8+XNeGxdGf5MicMqnRoi0J0exGK3vb8cKdpY8O1998SNflRrKJAcriJxlL7MwinDo
         nAz3mrcwBXj8RJaZ9pC+MIS0sIFl8kbCRyy5k380aX2/X6HA37VxDcdqdaFB1TLbJA0b
         QFuw==
X-Gm-Message-State: AC+VfDxHlgt+haaPZc3R9GTtXW2oVFmiMQWIDK/YM19iPOvrhV7S70QX
        JWQXB9N6ooRBxg5Z1XxAEknZVg==
X-Google-Smtp-Source: ACHHUZ6xfvURHYmwCA0rkcPEIbdWHaDDrsTw1yTug0O3WbxYCOy7Dpv+vT71lqkBRT29ssdlLeZXqw==
X-Received: by 2002:aa7:c24c:0:b0:50b:c582:7be2 with SMTP id y12-20020aa7c24c000000b0050bc5827be2mr12287972edo.29.1683653518253;
        Tue, 09 May 2023 10:31:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7cd51000000b0050daa883545sm976490edw.64.2023.05.09.10.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:31:57 -0700 (PDT)
Message-ID: <75e66496-6a54-1430-7344-fa816400fa7c@linaro.org>
Date:   Tue, 9 May 2023 19:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 2/9] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1683630932.git.quic_varada@quicinc.com>
 <064614c5b28f6d813634ad14a59b0bf94ac334b7.1683630932.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <064614c5b28f6d813634ad14a59b0bf94ac334b7.1683630932.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 13:54, Varadarajan Narayanan wrote:
> * Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> 
> * Making power-domains as optional since IPQ9574 doesn't have GDSCs
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v11:
> 	- Have power-domains as required for non ipq9574 SoCs

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

