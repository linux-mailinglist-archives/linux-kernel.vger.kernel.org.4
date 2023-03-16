Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556776BC7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCPHyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCPHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:54:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0F46A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:54:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x13so4130441edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALV8LL9MJenwGh3aNSyyMlcoFKf51FdAxW4ZQ8b6bJE=;
        b=qWKRUG35QHudKj6D2f4L7bXiTNM0Mi41XYEq/jo82eXeIR0bm82L4y+ycX1fAnA6Qu
         v+BZaIKbteNomjxdKdg2Kj6WO6B6qKVvzN56ze7EEPtrgfHoVTkKo3lRoXuzYSo2ZGaB
         Pn8g9WZNHAbBztb3KcSg4pDqpnTsSsDi01sDnVATpxfyVSOAaMZtmQZ7i/to93UBm5ys
         nhSiCxFbtJEMYjYD/1rLwUnCsmyPNHN0cUsoQ+LQEfe+Eyi2er9GQp8Xu441+lF+tYyx
         llNtWNUWsS1pOHYTKFc7t7Uxf/5M4Uj3UxbjFWLTCzMMaRvx4qAEAGpJJFZdOC1sjfjk
         YRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALV8LL9MJenwGh3aNSyyMlcoFKf51FdAxW4ZQ8b6bJE=;
        b=g+GMWz71ERVUv7hAcMANmfv0sRuxRpPDFAlaAD3OroBhvTZUmiPoFYDH/zUgP2HW8y
         1VmJ3c+KKf3G4XNdRvBRrlRvsznK5z18hWXvb9fUV7f6JCDlOxuXTzLRAKEohvvcmbiP
         hNkvFZaHp9krErKBan+Bgsfkq+cX4bEqgmCUFkCoREcxFIKulCeIE6MROe90ZP7caSu0
         E0YiTmZw6ROAecoiNa9pCFgEG3MVHMQr+x/Tayj59Hy/6zI7kT4DTbKcYj7mn424Dvp/
         6iUXXEiKJVNjlY76GzXtckqru7EwICf4qbdcQSzz1R/C8Q+fu6hHHLimgJosXtqUIlin
         qZGA==
X-Gm-Message-State: AO0yUKW7tCkeihYM0zUZplpiEfhL2EKzr/XXN1Age0yDAYzwxUr4jAS5
        H3UBx7ORg8NuU7Z/1QS89yw0gQ==
X-Google-Smtp-Source: AK7set/VfwqOeWBGOCkzjeXGNInorMi0Z3JbnoCqP5GevqgS4Ng7IeSqPAsciPyJ2+3J9ZS/UaZQpw==
X-Received: by 2002:a17:906:17ca:b0:925:5549:f81c with SMTP id u10-20020a17090617ca00b009255549f81cmr10372881eje.6.1678953249705;
        Thu, 16 Mar 2023 00:54:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id q22-20020a1709060f9600b008eabe71429bsm3513395ejj.63.2023.03.16.00.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:54:09 -0700 (PDT)
Message-ID: <17205099-d301-c848-1724-fd3c7fa08192@linaro.org>
Date:   Thu, 16 Mar 2023 08:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for acbel
Content-Language: en-US
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ylakshmi@yahoo.com
References: <20230315184633.766968-1-lakshmiy@us.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315184633.766968-1-lakshmiy@us.ibm.com>
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

On 15/03/2023 19:46, Lakshmi Yadlapati wrote:
> Add a vendor prefix entry for acbel (https://www.acbel.com)
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

