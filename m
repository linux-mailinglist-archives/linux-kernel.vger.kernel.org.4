Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937EE6D5E91
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjDDLFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjDDLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:05:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7D268B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:03:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so128955298ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680606197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2X3kREg8ClZqoLFGTfMEQlTm6xCmy/glA1Hk2D1aa0=;
        b=vj66DxpITdwlhJH75l7RkUQZ6WiakI8+iJL0HkFajARLadSSmedSCC38T3fau0NSAi
         cuHLk9G6os+2CZPFZVMURrKYJtSV7XCcHUktC2KxBi0JYdJlEn3jIyfrRNS76EsHP+Gc
         vSP5yuFfS0DKENJu13mSmPMXDHrOXQXyXBYgwI3yB8ukOi9+MFNaQF9blxs+UoTs3Txj
         P/UnBYcmSIK9qgN4/80r2zy0VyjYl/ggKEoJFNcam6FWF7UWgHng1XycK5KJiIIpCKFx
         8UCAyfQtf3TLsUcvIFlRm7Fj10RNvbeRR0Jx2rNoMSjsM3v8zioZQ2F1Kxd7kbRj5vr5
         XELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680606197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2X3kREg8ClZqoLFGTfMEQlTm6xCmy/glA1Hk2D1aa0=;
        b=Zkx52/leNpR1DumSoAMELQBLofjzfp3U6ZnGyAkxHXdpyevpoZfaek1HzFQHPUc38L
         ZORP8Tgx48Ju6SZdHdcGwMNBhqcq0DskxgwGy7xW3MdzL3RDXtE9/6mAq8tlPJkyM2uz
         aHwSE0A3iEjzJM59jd5m9V4dxbOirgjob0Y0i1eYKEOwXBK2tAMmSEPCBCfRC49CKtit
         JvS/EzHyS/Wvk1kRxle8cM11Pi8ieEvXtB1lMBGBtiWoUnJW/PxOzuFF/B4gWzLDzKcx
         unGoA/TCVASjMfmFQUH6Mswh0BvNnryJIOkYagQM9htkNITdaBxtFxBWwBK0lzGs3FrE
         eq/g==
X-Gm-Message-State: AAQBX9enohSVeQ4nOWeh0aYdpFHOVUkUlSD+nnecIKlPN5iZMkF49CG2
        ALNxUTc9wqSJlZihqQUW2pKigA==
X-Google-Smtp-Source: AKy350Z6X6wonQ9ndSEeOqk1V1vulMt/+C2VlT2zTtfQjqb1wDbl0iUZQJtUmkPOwDAPJiXlYGDAKA==
X-Received: by 2002:a17:906:1281:b0:947:405a:955f with SMTP id k1-20020a170906128100b00947405a955fmr1842422ejb.31.1680606197540;
        Tue, 04 Apr 2023 04:03:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:99ed:4575:6001:8bda? ([2a02:810d:15c0:828:99ed:4575:6001:8bda])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906d18a00b00923f05b2931sm5796213ejz.118.2023.04.04.04.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 04:03:17 -0700 (PDT)
Message-ID: <5f8692af-700a-a47f-d81c-fe9c905958e1@linaro.org>
Date:   Tue, 4 Apr 2023 13:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/6] dt-bindings: ufs: qcom: Add ICE phandle
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-3-abel.vesa@linaro.org>
 <9fc90c8b-9234-84fa-7dab-fee9de2b9813@linaro.org>
 <ZCvm3fzSh8owVDdc@linaro.org>
 <c816d432-26b8-2655-adf1-4b72b8645215@linaro.org>
 <ZCv+9WjlkA4n9Dwg@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCv+9WjlkA4n9Dwg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 12:41, Abel Vesa wrote:
>>>>
>>>> Also, this does not solve my previous question still.
>>>
>>> Well, the clocks are not added for the a few platforms (which include
>>> SM8550). Same for 'ice' reg range.. So the only thing left is to
>>> enforce the qcom,ice property availability only for SM8550. I believe
>>> it solves the mutual exclusiveness of the "ice" reg range along with the
>>> clocks versus the qcom,ice property, by enforcing at compatible level.
>>
>> Ah, I think I understand. That would work except I don't understand why
>> enforcing qcom,qce only for specific, new SoCs. Assuming it is a correct
>> hardware representation, we want it for everyone, don't we?
> 
> Yes, but they will be added to the subschema (qcom,ice one) when their
> their ICE support (ICE DT) will be added. This way, we keep the bindings
> check without failures (for now).

I understand that then you will rework this if:then case, so I think it
is just easier to make it correct from the first place. If there is
qcom,qce, then reg is maxItems:1. Otherwise - maxItems can be 2. You
achieve the same result, all DTS validate, without any need of further
changes later.


Best regards,
Krzysztof

