Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CC73A221
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjFVNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjFVNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:45:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712C0199B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:45:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9741caaf9d4so852585366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687441537; x=1690033537;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiwdHAe6XoqoXDrL1lEWT9oP4RFFDYjXsF6c8ZBYpVA=;
        b=guQ6fscEqrT0MeMEO+/YsKj/R6bKOyLEHlAgCzpWsoLXxyka/KQPrDT0AlTSkv7n9a
         PXE0d+E2mxo7r6EMIrw2m0ueUOxjZNjNKonOONozKtwPscTuyc/ueJxDCSCPpghuTA4s
         yahxU3PtsdL7zZeI15C1Ms/dJF/TKoRV68YvZ7cJHUJ3W/daVgP7TFzZHdVhOs8e4Vh5
         xW2UD2sSHud3Zy60ffd1zWwoGQI3VLyUpm/E6v4uq/Y8KzCgnlCznwUJ2voR6dYhpzwm
         PGzo9+SyLyxh3Jd53T+oSnBOp9LhGozwQZ8JYSJZZpawD+mHCKuOWLCA8Zrf+SLvwclC
         BC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441537; x=1690033537;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiwdHAe6XoqoXDrL1lEWT9oP4RFFDYjXsF6c8ZBYpVA=;
        b=M01Wb6DIoepBKalQ3q5K4Gjo1HpLiuIRgqDRqGt83NhBxP0dXHDqSduHtyjp0AFTQX
         mv6lI+Pfvwi/V7p1qr/yyWygt/m3Bpop8j9wcgFbImhDmkPvXVr84eBMxAHxHc7ac3DY
         lwYmdy3hamdidHa8hiGaaoJb+FswCJY3wVmzPk4LH44DwJQR/chPpWqRHgPMaoew4tBp
         ybFE/3+iqXtiWe7yzszQCoBiEyShiipPnh9LvMKtyrz2O7pVfNfeZofa965OVfE8ef5V
         e6JQOFGYgdKrWHdk7sLxL/clYfV9BQJ+JYpS7iKpvkqXMS2NaN/FBvD9mm0wVsKydOUP
         CWgg==
X-Gm-Message-State: AC+VfDxbqd9jFZL1repa1dT+ctQ2aVjeX4cmJ7pokWdytp5mbxfbb7db
        XrceknvBp+Rd4+DW4m7Z7ftJpA==
X-Google-Smtp-Source: ACHHUZ5BlBnF2IwMkzv3RLlBauiQZEUUcLcTFIeCXZzbfWdyBpihwjbIzdrwR3RRplsFAzSjSSLY0g==
X-Received: by 2002:a17:907:16a9:b0:98c:e3a1:dbb4 with SMTP id hc41-20020a17090716a900b0098ce3a1dbb4mr3884866ejc.68.1687441536920;
        Thu, 22 Jun 2023 06:45:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jw8-20020a17090776a800b0098866a94f14sm4714518ejc.125.2023.06.22.06.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:45:36 -0700 (PDT)
Message-ID: <fe3b02e4-9f01-eb36-bf99-6bc3b15b28c2@linaro.org>
Date:   Thu, 22 Jun 2023 15:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: Update GCC clocks for QDU1000 and
 QRU1000 SoCs
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
 <20230616104941.921555-2-quic_imrashai@quicinc.com>
 <cee56c57-060a-2fce-a2af-25404b9afe48@linaro.org>
In-Reply-To: <cee56c57-060a-2fce-a2af-25404b9afe48@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 13:33, Krzysztof Kozlowski wrote:
> On 16/06/2023 12:49, Imran Shaik wrote:
>> Update the qcom GCC clock bindings and add v2 compatible string for QDU1000
>> and QRU1000 SoCs.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>  .../devicetree/bindings/clock/qcom,qdu1000-gcc.yaml         | 6 +++++-
>>  include/dt-bindings/clock/qcom,qdu1000-gcc.h                | 4 +++-
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>> index 767a9d03aa32..030953d258c1 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>> @@ -8,6 +8,8 @@ title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
>>  
>>  maintainers:
>>    - Melody Olvera <quic_molvera@quicinc.com>
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +  - Imran Shaik <quic_imrashai@quicinc.com>
> 
> I appreciate adding more maintainers, it is welcomed and needed.
> 
> However many of Qualcomm folks, including some of you, did not care
> enough to fix their old/incorrect email in existing entries, thus we
> have hundreds of wrong addresses and email bounces.
> 
> We already raised this internally and publicly, with just small effect,
> so I am not sure what to do more. For me, allowing to have outdated
> email in maintainers is an easiest proof that maintainer does not care.
> Adding more maintainer entries, while maintainer does not care, would
> not feel right. Maybe let's start with fixing existing entries?

+Cc Alex,

Let me emphasize more, because I did not see any follow up patches since
my previous email - there are many, many stale maintainer entries from
Qualcomm. Several of them have codeaurora.org email. Some have just old
emails of folks who left.

Can we expect fixing these?

Best regards,
Krzysztof

