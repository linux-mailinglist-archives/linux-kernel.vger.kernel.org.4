Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9D6D5CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjDDKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjDDKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:12:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8A30F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:12:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so128415978edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680603128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTheVrrzZgI2UatHNgx/iTW24+oxWTi/GNFmjmsvjoQ=;
        b=ao+ZBWMwwB/pLABUItwEupGXl8poQ6XMbDDiXZ0A7majfEF3uLeXu7lGivbuFdu9IK
         1oMth/fUFT6Ky5hxR6rlbYWGlefSkRJ8bZevmF2xdkO4G86CP9On0eqSVAFE2mg2qF6N
         oqxywNkgi9sS8by7ChDgBpS2u/8XeFV04cIGjhSRzAjGFWqtXf3/jVHUgQT8gD7IdMPB
         OzfqH4qdG/b83IJEzNqEyKM8SKNcfXwxwEiTm704wcvZJAL+a/ai1M2MYjDDly39ulrW
         mq0pTt2VDD6PJjrJ5Ct15h39hHw7NdlgJ006gZphGbRbuNFbWz6les2sAWXHUsYDQnoL
         VPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680603128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTheVrrzZgI2UatHNgx/iTW24+oxWTi/GNFmjmsvjoQ=;
        b=gGDDEXVr1qVw8ImiPq972+mS5Wl1QVIuYUMlZP4Wf1krLz2HZ9+944NoNoebPtREDi
         h6iSOmbEzyCPM+1xdBoIRp5a65tf4xJDUgGmnvtliXo25WpkidkwQoG3UxwPnyFkximp
         5tMLDWDEuJmS6+mWVZhJpSVy0hvuf8hc4KSd24aNOAfd3nMZ6wLb/nnoqEj5+2ixV1Kg
         Y/ITW3X3VbI1/1DgpaWP24x2jnJQ3ZxuV6EZLkkhiig8nCTwlv3QvMQfk1cu3iSHbg6S
         +UiLJdt6sVuvloO2t6RD2thJczfQbt2vWve1/xEk5ANUCuug5fTiBPh3NZYxc6vrGfo4
         8+WA==
X-Gm-Message-State: AAQBX9fW0pts5UgAZIWHiDCnmUhGcb6qQ56e+pN1s8GSD0r4R658TXwh
        Ug8Pi73szlKkN+uJVUXjZM9pfw==
X-Google-Smtp-Source: AKy350bDKkBioiP7BMZu/6m8PZU3hw/V+yKQqTf4KCF46eRor84VbeJ0prTRJhc1ldSMylybV2yl/g==
X-Received: by 2002:a05:6402:2788:b0:500:2cc6:36d5 with SMTP id b8-20020a056402278800b005002cc636d5mr21154431ede.8.1680603128556;
        Tue, 04 Apr 2023 03:12:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:99ed:4575:6001:8bda? ([2a02:810d:15c0:828:99ed:4575:6001:8bda])
        by smtp.gmail.com with ESMTPSA id z21-20020a056402275500b00501d73cfc86sm5647456edd.9.2023.04.04.03.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:12:08 -0700 (PDT)
Message-ID: <c816d432-26b8-2655-adf1-4b72b8645215@linaro.org>
Date:   Tue, 4 Apr 2023 12:12:06 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCvm3fzSh8owVDdc@linaro.org>
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

On 04/04/2023 10:59, Abel Vesa wrote:
> On 23-04-04 07:41:55, Krzysztof Kozlowski wrote:
>> On 03/04/2023 22:05, Abel Vesa wrote:
>>> Starting with SM8550, the ICE will have its own devicetree node
>>> so add the qcom,ice property to reference it.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>
>>> The v4 is here:
>>> https://lore.kernel.org/all/20230327134734.3256974-4-abel.vesa@linaro.org/
>>>
>>> Changes since v4:
>>>  * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
>>>    it while making sure none of the other platforms are allowed to use it
>>
>> Why?
> 
> SM8550 will be the first platform to use the new DT bindings w.r.t ICE.

This I understand, but why other platforms cannot use it?

> 
>>
>> Also, this does not solve my previous question still.
> 
> Well, the clocks are not added for the a few platforms (which include
> SM8550). Same for 'ice' reg range.. So the only thing left is to
> enforce the qcom,ice property availability only for SM8550. I believe
> it solves the mutual exclusiveness of the "ice" reg range along with the
> clocks versus the qcom,ice property, by enforcing at compatible level.

Ah, I think I understand. That would work except I don't understand why
enforcing qcom,qce only for specific, new SoCs. Assuming it is a correct
hardware representation, we want it for everyone, don't we?

Best regards,
Krzysztof

