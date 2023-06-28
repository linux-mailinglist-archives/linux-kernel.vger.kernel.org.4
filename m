Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FACD7416A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjF1Qnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjF1Qnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:43:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C726B6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:43:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso1754055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687970614; x=1690562614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wj1y9GfoRe5AkEfUiZaVmCTZXorfAIcagWCYFOl60QA=;
        b=ClbNoVeaJG7dp+YPPc4pjAvljPWJKY8BQVzCRsr4AXdW1jDBGzc8Hrb631QbUOPe/p
         YyHkgLRT8PkSmaDsxTszEDD2R8InsafKzyF872IUbC2239GXZVaMdmYPmmdDRmqmd0VO
         1IVKsAEQ93yCapzsDQDr9fqjuoXirKeekaXE7GNaskeO+ID5CRSbYcIhayG766DB0b04
         GE823axjyfyQAL5B52DV7wJxT3O7xpxlDG4Drb/IdAmm821S3uj4W4jE5NTwa4rW6Qi3
         kM5f8a0JE6Rk3/dHEWxKKOfjP4726QZXBAFD+u/60FoWvs72TfX6RbAshJr9OS1eWw9H
         1FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970614; x=1690562614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj1y9GfoRe5AkEfUiZaVmCTZXorfAIcagWCYFOl60QA=;
        b=gItaNw5JVIHrzCNoie2B2nV8XcGB9Gg8dP8OQWt73dQZYYcstXEmgN9BgWspGzevbT
         YcQZW0CGXBARtTQOrt+uA7jKOZpE8h8y1XfNStTjLQzSjHR/g7/RuQHEGaRK9bKz7jnJ
         WOnZppztHbpUvzNBADxVWBnsKvEctZ9qVWWWBUKFLFOavVPqtRRqfAM99tL88GtJqbSC
         AvtGok0sc/P1KfPB/UAXJyLN9GUo0ukNDjXhLCYIO6cFlhielpdj++WwTngaoiwLQ7Ab
         UPpYSNdWgpv+Xj9/34Q/s0C6wtofEaAfevKa5yFzMbjE1UMzOFAQF4mZSIF8KUMENQH2
         1m8A==
X-Gm-Message-State: AC+VfDyt0c7Te7Nz2empVdkCx5hxPLsPpLytxl1bHAXx2uQ8Oude10yi
        wBM29UYTTTrwRagwtuVFyfDRXw==
X-Google-Smtp-Source: ACHHUZ5y4fpvcnbacCe53RDMiaqa1l8uth1slQyrWOIlpMDUZLIJjBUGmfOf8GS3+Lm0BEwR54z0nw==
X-Received: by 2002:a1c:e90d:0:b0:3f8:fc2a:c7eb with SMTP id q13-20020a1ce90d000000b003f8fc2ac7ebmr25716224wmc.5.1687970614284;
        Wed, 28 Jun 2023 09:43:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z10-20020a7bc7ca000000b003f8f8fc3c32sm14353307wmk.31.2023.06.28.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:43:33 -0700 (PDT)
Message-ID: <9f5b205a-c5d5-e66b-8ba8-57823486eaef@linaro.org>
Date:   Wed, 28 Jun 2023 17:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: q6apm: add firmware-name bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-2-srinivas.kandagatla@linaro.org>
 <20230628155453.GA537917-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230628155453.GA537917-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/2023 16:54, Rob Herring wrote:
> On Wed, Jun 28, 2023 at 11:26:19AM +0100, Srinivas Kandagatla wrote:
>> Add bindings to get firmare-name from DT, this will provide more flexibility
>> to specify platform specific firmware file name and location. Also this brings
>> tplg firmware name inline with other board specific firmware locations.
> 
> tplg?
Topology, will update this in next version.

> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/sound/qcom,q6apm.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>> index ef1965aca254..c783451145ef 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>> @@ -31,6 +31,10 @@ properties:
>>       unevaluatedProperties: false
>>       description: Qualcomm DSP audio ports
>>   
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string
> 
> Already has a type, so you can drop.
thankyou removed this now, but all the existing yaml still have this.

> 
> No default? Or pattern it should match?

no, its going to be hard to come up with a pattern to match file name or 
path for firmware.

> 
>> +    description: Audio Topology Firmware name
>> +
>>     '#sound-dai-cells':
>>       const: 0
>>   
>> @@ -38,6 +42,7 @@ required:
>>     - compatible
>>     - bedais
>>     - dais
>> +  - firmware-name
> 
> Causes warnings. Test you bindings.

yes, examples need updating, will do that in next spin.

--srini
> 
>>   
>>   unevaluatedProperties: false
>>   
>> -- 
>> 2.21.0
>>
