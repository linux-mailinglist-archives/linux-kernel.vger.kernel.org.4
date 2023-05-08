Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74DF6F9FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEHGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjEHGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:21:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2601D5599
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:21:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so7506081a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683526861; x=1686118861;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a0zCtbvyuCZv5ZDHktClt14M1N3Yn1Kq3aOXWGII3Xk=;
        b=obRN4lQ7yHzsItWJG4sNNHmfey7iO95l0VBtNkqyNMnl86G7pjomhab75YLbaKbRKD
         d7J1yxq+fKLj4/sPDMuDIXjxAo+SUv5eDxcWFbjTkhF4YWwuvaabWmEy4FhxjwvGo5Wa
         kIsTsi5TImn74gKb5GZs00vVaOQFMt7OBK3FnzxmzS6qRN/koqzTeZ6wtAyJs8u+qhVb
         XMuUo7E/lgFVbOdcPWdUUXwiF3kHyGJ147q+SuJyTul+JVYJ6NxNu0xQPEEJBoc4jRdH
         qQr9j3XOsFF8lSiK+LDLQfUSWjNDTbsSlk6mZv+slmqmJmSh+gIR82sZNW2/xsjw6VCj
         yvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526861; x=1686118861;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0zCtbvyuCZv5ZDHktClt14M1N3Yn1Kq3aOXWGII3Xk=;
        b=YJRQ8gwfhaoXlIijHcZAExDuBAxvnDHraJ6NSkWOQ4fO46/Rp2cHFA5/R/saM4Yc6G
         TqqCwrWl6PcEepPCLkX8of4wDDTpA+MmgN6ra0lNNUXCzd7/r895QJeOJrf2BAL60Cjr
         sVfPy4w19YFCVLPHBVEQCjIxjFXUeShmMJqRE7P8ujRVgzNEPusgkOGLBfQ+RKAhpSOI
         nvjhMaIzNnnXzM769aHQEdUupQ/OwWt6qtnbkbWIcwgBeQAcnbTRTGxJV1EvB+uSX00I
         1C3hrYShw9TRNiMDFY6TCrEBxQhifRLOs6RpPPhgUUUHWKiDGZuZQ7E0mD+3JMCMj4RQ
         +M1Q==
X-Gm-Message-State: AC+VfDzOa7/CwwaepSChCaBG1oEViutYDTd1TVXidx7s6pi2eFVVAYS+
        COQNIUBiCUyxQdi+/0lToiXm9Q==
X-Google-Smtp-Source: ACHHUZ7imTk2GtOBXkQpqz9YJxyQfy/GWd7QwSAHeIMqTup1BE9EF/jBA4+9QziBnqdNtVPsmJ/Q3w==
X-Received: by 2002:a17:906:58c5:b0:966:58ad:d934 with SMTP id e5-20020a17090658c500b0096658add934mr2980785ejs.0.1683526861596;
        Sun, 07 May 2023 23:21:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id kg20-20020a17090776f400b0094f3e169ca5sm4511506ejc.158.2023.05.07.23.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:21:00 -0700 (PDT)
Message-ID: <df471efa-9ec5-f323-3892-2505ba782512@linaro.org>
Date:   Mon, 8 May 2023 08:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
References: <20230408214041.533749-1-abel.vesa@linaro.org>
 <20230408214041.533749-2-abel.vesa@linaro.org>
 <316e9ee5-fccc-e199-f727-7b8187e965ff@linaro.org>
Content-Language: en-US
In-Reply-To: <316e9ee5-fccc-e199-f727-7b8187e965ff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 20:47, Krzysztof Kozlowski wrote:
> On 08/04/2023 23:40, Abel Vesa wrote:
>> Starting with SM8550, the ICE will have its own devicetree node
>> so add the qcom,ice property to reference it.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>
>> The v6 is here:
>> https://lore.kernel.org/all/20230407105029.2274111-3-abel.vesa@linaro.org/
>>
>> Changes since v6:
>>  * Dropped the minItems for both the qcom,ice and the reg in the
>>    qcom,ice compatile subschema, like Krzysztof suggested
>>
>> Changes since v5:
>>  * dropped the sm8550 specific subschema and replaced it with one that
>>    mutually excludes the qcom,ice vs both the ICE specific reg range
>>    and the ICE clock
>>
>> Changes since v4:
>>  * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
>>    it while making sure none of the other platforms are allowed to use it
>>
>> Changes since v3:
>>  * dropped the "and drop core clock" part from subject line
>>
>> Changes since v2:
>>  * dropped all changes except the qcom,ice property
>>
>>
>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 24 +++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
> 
> I see dt_binding_check errors after applying this patch. Are you sure
> this was tested?

False alarm, it was other patch in my tree.

This one is good.

Best regards,
Krzysztof

