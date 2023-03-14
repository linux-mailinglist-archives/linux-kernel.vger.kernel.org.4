Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8C6B917C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCNLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCNLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:20:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448599EF7A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:19:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so60402234edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678792776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfuSyrbgYklZNRYuX498I2Gj36dx2cQqVAnZUrMSsiA=;
        b=Ez1hwm6zCZNgiJrYGZKnwO37CFP0s9UVxeeQfBZ39E0sRGNdXmc3jXnV52tZZZ+PuF
         quwSnxfxRatAylNCuPoLqO6dcYhQnN2oDSJCm1o8FwICm3zXkspR1ID/uoUaxMoMTgfR
         Oz488I0qrhX06gAHHs1OwJkQC6cl9iYLmw0/2wVwDTbBRss/Hdng46P/LHpkVR9deZV/
         OLFIczi0Qh+PPXrGuv5QQXykifMrO9Sp2BikhVYleI7K6P1Y8WWOpqjt3Gf3APhxKUH8
         ZvuX3g45w/0xsGyIRaWrhSKKzBeSZjCHVOeC8vsuKe01x/S8XZFHast3t4pPWOEjVJOf
         fDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfuSyrbgYklZNRYuX498I2Gj36dx2cQqVAnZUrMSsiA=;
        b=JHVCQc/hgmIYV5nRMOEZC82++oV1KfVpXOYyvxXfHk6/U4+pSQ7MOZx/AJVK4myo5y
         Pln5mu3mc0itNFkD77WH9XBJAcykZFVAAdYF4W0zSPC7juuHqCqsWSz/SGWqRF/tzivI
         1IGYaCyqvdkV+GF6Pyo9GwGxv8YbHvSkbabptdVxPr/+p4ZP7bx5UAMkxl/JtLvYmtb9
         NpCy66WVo6cTID1UKErhueQSGL1/irOWZUqDfbGtQGBcU/lRfPvYX0VihbhbZbNhwXcN
         m9ihWeBU8wAnO6/gTZ1EPpL+8iuHXCN/6PALOoPsW3zmRfR6CY9d+a8z4KHc3jPRIDyy
         5avg==
X-Gm-Message-State: AO0yUKWjEOnYnZoUM/POsoaGCxY3zh/qGUiRv04dR4MqsGSWeZWrXMy+
        uDq7iqD/Q7wzG1/RiTBIwlTAAg==
X-Google-Smtp-Source: AK7set8+S0OeYa45ddASmejw+HGDXlolNs2ImcYbzLEefmpVjwJ95EUrTVXLHu44Ydqk4f2fBgUGDQ==
X-Received: by 2002:a17:907:e8e:b0:92c:a80e:2259 with SMTP id ho14-20020a1709070e8e00b0092ca80e2259mr2174660ejc.1.1678792776356;
        Tue, 14 Mar 2023 04:19:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090634c700b0092be625d981sm1010231ejb.91.2023.03.14.04.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:19:35 -0700 (PDT)
Message-ID: <5ca73037-799b-2110-8a72-cc6a7e71850f@linaro.org>
Date:   Tue, 14 Mar 2023 12:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v3 1/7] dt-bindings: crypto: Add Qualcomm Inline
 Crypto Engine
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
 <20230313115202.3960700-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313115202.3960700-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 12:51, Abel Vesa wrote:
> Add schema file for new Qualcomm Inline Crypto Engine driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

