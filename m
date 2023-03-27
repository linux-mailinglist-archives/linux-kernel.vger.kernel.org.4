Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CEB6C9D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC0IAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjC0H74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:59:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C61B4685
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:59:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so32173863edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679903993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHOxcrBXakWRojG1XHykriYxl9yThPhcQl3Zlslh+rU=;
        b=LhgGG6zPEbHJGJ79wJyGVGjbvqnn4JUWIHlOBdJn2QsOz2K+SvTDpb1d6GduKwh7G1
         yKaHcGpSQQsjD21kHuYjx8U/fVT5H76w3frFQmBE9ceUfVJS+g+t7BWl5Bq5SYONZ7AO
         jRcdn69iiBJHY1ZwnzmdrOh4PvdUSdk09Lmg6i5N3pgUS4+3S1Bk8i7ICS9cxmiC8Vma
         HaeqwqVxMfYAu3fOy53Ts9PjU1oH2Y6bCQobdM20nM2YXN/GZjb5peuSOwOgnusM4sN6
         Q7IukYaIV8cYBTJvMh2HKWWzrNUNSNduR7syg6VX4n/Pbd2tdEoudP/NQ+pej062tINk
         AKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHOxcrBXakWRojG1XHykriYxl9yThPhcQl3Zlslh+rU=;
        b=nTX4JS2v/eloWcgt7XaljkC6/xd0xig3grGStKxZOeRWDpNl3tPVj/BC3513zhzKFd
         aDo8wsoG9eOmLDg+c7KT/bl+FAyKWLo3GcA4UzaSCEREAGMGE/1pUqnYxuj6gfsaHyHe
         BQgvYkuhg0+6U64SobjTllWMPjoSLVGmT1n/eyKeG6iy89Xym4p+5q/YV7GdyecaJ715
         0gxoQ1eAiZwPJdHjFDlLGeKDsINQTAELHtd8QL48ZMCD3LvPNvoJh91rca8uMNitCqvT
         dNg9iyEsBVgpXjRjJlX/pFrXl6aG2zso+YSO/ns+U8D2ejW+spOQ8wJZRUAvx8UW+V9f
         SOdw==
X-Gm-Message-State: AAQBX9ezsnw7o4KraGbM/GKLiezsijCm2vSWPe94+rG5jk0X7urcHDRL
        bX64/R7dn5bS50pvcBbzob1f+w==
X-Google-Smtp-Source: AKy350ZR4fWMj690Tnc2FYTASJt2dfXDug5uKrdz2z6SlZyu/+k+wehyWLjwIofAqVQIIn2vgL45VQ==
X-Received: by 2002:a17:906:aec9:b0:930:625d:6a25 with SMTP id me9-20020a170906aec900b00930625d6a25mr11691860ejb.61.1679903993733;
        Mon, 27 Mar 2023 00:59:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id u24-20020a17090657d800b00934823127c8sm10589337ejr.78.2023.03.27.00.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:59:53 -0700 (PDT)
Message-ID: <3e0b3f7b-a4cc-a609-e491-c1f52a49ec7f@linaro.org>
Date:   Mon, 27 Mar 2023 09:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 07/12] dt-bindings: phy: qcom,qmp-ufs: fix the sc8180x
 regs
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-8-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325122444.249507-8-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 13:24, Vinod Koul wrote:
> sc8180x ufs phy requires to describe five reg areas for the phy to work,
> so move the description to the correct place documenting tx, rx lane
> 1, 2 and pcs.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

