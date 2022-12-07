Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC26460D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLGR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLGR7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:59:47 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382375BD53
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:59:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s8so29912786lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzPIIHJ1Rx7W7OD0G8eMenZ9zj+B5F0PnPlpat3xklc=;
        b=UXpgHXTFGYUweNouQpPno29sHtNAL/jhMwxXafo5uOe/iEciVXCYpavftBwknC2my/
         9Uy/VshAP9An+L/tAjUZO+9YtVr9q3Qv89AN17gtRn5w3W67lIBat4fLb3jUVdUs9Tre
         CbwO1c0+95byKcQHD/DUbLqPqzQzl+aEmFLdruPNZYq2IgXeyC/2MpKlueS2ZawASS6A
         a0xSosvGOZIrvIaoS+Shk/ITbARVaB/AtaR0rhmcXeBGilWFd/j8a46LQOiJwAUqi5Zc
         IGvPvyW0irluJ/6KcLPtTXdri0HANvayczkEd/vXHzAdNd2QpBOph3XRaWMBgvZ2SiEJ
         Mr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzPIIHJ1Rx7W7OD0G8eMenZ9zj+B5F0PnPlpat3xklc=;
        b=s9xMsoEoG6LY00xWAdBT5ij9rNztimb6bWf8Z8j7VE+mJUOWoNWBizHAmX5wF5u3Hs
         1XQs/f0C3tOT/MzJ8yGsw0rDznKIHDbx5AgaNFK68APJCBKsVn9OehJUJTtxOxyk9ePD
         ikG/5aTA7RMpConPNxk+XDXRWgnOvCa2T6N/EGNPXxNYO8kApqsiZiQq5qQb6zNYGk5w
         ov3icbjcMWgpZIFpBE8A6CrZ4zpelpu89DBLdJXhkV3ft0eU8XtMDszE373pJ5FdM8b6
         ERGFkd215y9uf+Vru00RWITU30/RyUZEy1Bg05OND2z+1wuq+V4NhOkcz1JOfU82dVEJ
         lRrQ==
X-Gm-Message-State: ANoB5pm0Hzfoaq0XkDnyFO8AxObm9uBFYbyj6pmj5uxXw1iKLdbNYh0+
        kdh44ZEz/zeP1cvGsWWA9IDCkA==
X-Google-Smtp-Source: AA0mqf4bFnRtzANo/1HX9jgQhllGdBce+YDCVO9UkkGvJLPzCy7oV6FOKm1Q22ucoJbhAYuAmzf//w==
X-Received: by 2002:a19:9152:0:b0:4b5:6930:dfab with SMTP id y18-20020a199152000000b004b56930dfabmr5844562lfj.324.1670435984427;
        Wed, 07 Dec 2022 09:59:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h13-20020ac24dad000000b004b1892aa5c8sm2933914lfe.56.2022.12.07.09.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 09:59:43 -0800 (PST)
Message-ID: <3be5ad78-daa9-39aa-9dad-c2234a0a464c@linaro.org>
Date:   Wed, 7 Dec 2022 18:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/4] dt-bindings: regulator: Add mps,mpq7932
 power-management IC
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207173716.123223-1-saravanan@linumiz.com>
 <20221207173716.123223-3-saravanan@linumiz.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207173716.123223-3-saravanan@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 18:37, Saravanan Sekar wrote:
> Document mpq7932 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/regulator/mps,mpq7932.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

