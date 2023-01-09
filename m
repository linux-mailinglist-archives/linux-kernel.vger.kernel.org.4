Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC2662354
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbjAIKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjAIKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B746B85E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:31:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8642480wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so3LT4U+ZoJ1eZnTaolUTvcAbQxqMlDxRxAJLkMVUuo=;
        b=EwmcOpQzOr5gPiLRCOzHxIGK8Dj4TwG3Y3qGt+m8UGBi6gKqlFt9BNMBG/E01i7cM1
         lhpmlDl06VphEa40q1M9PjS5qFtjQLan/nuRf7EfuVDoulwfoIL5c2M2ccLiQzPVRQ6s
         rLR8S47jAZM6UI4JQEhT1+NKyRH2tZExpVTUpYZSSFp6GoM4QA50Q2krW1f7mB7fYLvp
         v2G9ZWyt4Sw+oJm4X8udKmN328+4ZXYAslcNT32XBeeCsWlRZUQjg15xV+k4MS5qw+E2
         7ICD9Uq1r/SIDaO4QOgrLVW+6lrDFtvyse26DibEZ1AoU5HiNFC1P2jh5JFsUIpIDzQr
         mJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so3LT4U+ZoJ1eZnTaolUTvcAbQxqMlDxRxAJLkMVUuo=;
        b=DOvlQLIDaGVyFvLEjKFKkAv8tdNT13Cfx734ENgC3e1YDXQ4QrDcnpUsKE+qcmVr6q
         VueFKRsgCzip4YdJUm1UOH/Qbou8wadINocCedujV0aYWhZfpZhjnxpbS+25OHDscNco
         9VQq+7YqAAl/pX+hKA8JEdxcu8fpkEO3XkaSImmFMdpBmvLX3yItfNlHA4bjVS9MDsID
         KjbMJYvlLq4Xxo0GtR+1WkJraJqemt5SIanYWjLJj3tg93xh/CxQNkBhPO6jXGS4R2I9
         yfCAwyNRq9R4RyqroGJTeynfZjEXInh6szxNfIeIm0dZ4W5MCUf0xO3sMPB7Og+htMQ9
         Glhg==
X-Gm-Message-State: AFqh2kq4mwjEHzFvUeMzpzunJyWV3F6P5RERTWnQn1SjTWYVYdmzTcEK
        Ya40fnir3cFvygUZda28GMrc6A==
X-Google-Smtp-Source: AMrXdXsyOQjSKTpDh9OjrDHr26MfWyU5bN8o4UqAftezKDrAsGS18wFatrw2BcSwdUIVKc6vUMqKjQ==
X-Received: by 2002:a05:600c:6016:b0:3d3:3c93:af5e with SMTP id az22-20020a05600c601600b003d33c93af5emr46120492wmb.35.1673260275919;
        Mon, 09 Jan 2023 02:31:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm15349208wmb.14.2023.01.09.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:31:15 -0800 (PST)
Message-ID: <f6c4f47d-8a08-fcff-9d68-d905942f0d83@linaro.org>
Date:   Mon, 9 Jan 2023 11:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] dt-bindings: firmware: qcom: scm: Separate VMIDs
 from header to bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@linaro.org>
References: <20230109093947.83394-1-konrad.dybcio@linaro.org>
 <20230109093947.83394-3-konrad.dybcio@linaro.org>
 <e64d22eb-4c42-b279-b493-972e4a1af1cd@linaro.org>
 <1ec4b446-b195-0277-90ba-4a8398fcd729@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1ec4b446-b195-0277-90ba-4a8398fcd729@linaro.org>
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

On 09/01/2023 11:16, Konrad Dybcio wrote:
> 
> 
> On 9.01.2023 10:54, Krzysztof Kozlowski wrote:
>> On 09/01/2023 10:39, Konrad Dybcio wrote:
>>> With changes to the rmtfs binding, secure VMIDs will become useful to
>>> have in device trees. Separate them out and add to include/dt-bindings.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> v2 -> v3:
>>> New patch
>>>
>>>  include/dt-bindings/firmware/qcom/scm.h | 16 ++++++++++++++++
>>>  include/linux/qcom_scm.h                |  7 ++-----
>>>  2 files changed, 18 insertions(+), 5 deletions(-)
>>>  create mode 100644 include/dt-bindings/firmware/qcom/scm.h
>>>
>>> diff --git a/include/dt-bindings/firmware/qcom/scm.h b/include/dt-bindings/firmware/qcom/scm.h
>>> new file mode 100644
>>> index 000000000000..d66818cd57a8
>>> --- /dev/null
>>> +++ b/include/dt-bindings/firmware/qcom/scm.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>
>> Only Codeaurora folks contributed these numbers, thus we can relicense
>> it to dual-license, I believe.
>>
>> The other topic is what do these numbers represent: hardware interface?
>> registers? offsets? firmware?
> Arguments for a SCM call, so firmware interface.
> 
> IOW, why bindings is the place for them?
>> (usefulness for DTS is not the reason)
> These defines correspond to mappings in a hardcoded, irreplaceable
> and un-omittable firmware which is (unless you steal engineering
> samples from the factory) always shipped with these SoCs and they
> help clarify some otherwise totally magic numbers.

OK, makes sense. Please mention this in commit msg to justify adding
them to bindings.

Best regards,
Krzysztof

