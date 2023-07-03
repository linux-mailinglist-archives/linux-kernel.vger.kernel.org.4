Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5668746064
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGCQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGCQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:08:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA80138
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:08:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so548887766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688400502; x=1690992502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMy5f5UAlkpwoJfGh6eHdCIVkE3bUt8q/rsNd2kKE8s=;
        b=UGKqTMRBAtyVp5pgAmkxT75D0CQPLssCpjFChszpccrgTpOLYtSr5W9ztTdklAAex0
         ce84rZ41ungjJrgrPjbauA+bpjwgrdwax9ApOV1IhU4bH0BHaYGIhuyk/m01av4JcGgu
         EDT50ok/FKfji2yTcitS8kDYYLi4Q4R2Zf1QVtqrKUpA8isngOpwvDN+WD4a2FbdxZUv
         AmaIqX+cLulWVxMQQhUNS/UXP9s/03d0IXZ+C7wXBYaUQofHRHWXDFVIruQ/lqmiewjt
         KTqF0cIwpSHw3Pq5m/3yUcWfzcneqvGLSFA66Vjr6kUA9sdbItO8s8Wd1NUnglOOcoBl
         bFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688400502; x=1690992502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMy5f5UAlkpwoJfGh6eHdCIVkE3bUt8q/rsNd2kKE8s=;
        b=j3pQ+zNGEwU9tDF3fzVH6YDm/TGbePm1vVuO8maBHDAH6oSkrQiDeTcLKByC4UlCu8
         T7bzS54pJDz2etLl9QY5V+/1VfCXhcDkvTJuGGJ2AD5vqRSWLld4w+zxyEeI/h8pwBgv
         2ESlJfeCEmomqI0apxoBlRo8CUy5DwlB+eMerZLgp8tMt/749NFTKLjKEOQE+pQwNj8+
         +O+svc/LSaQo/lDBQo3CheJYBVsG064I3ev3r6K8K6+uZwCuNFqYcdnSnODNdK2NGl9q
         APf0/Trqk+XD/3f0ceAQn4AyxYje3UBAZihT3+CqW4ljbycDSfiaCqUwOdzVupj2E2Nm
         hfUA==
X-Gm-Message-State: ABy/qLbla5njK7y7Af53bMeNqdkRoLyU/KXnGVUJV8ep7R8pMznHAd8L
        ee38CItbc933Zd9MD8IbowXToA==
X-Google-Smtp-Source: ACHHUZ6isdj4HxxbQJE0IHSa57oIooe2Y408nw88R+omZyGzHejSCAB4UlXeus8irququq5dd4sPAg==
X-Received: by 2002:a17:906:af79:b0:98e:1deb:cb03 with SMTP id os25-20020a170906af7900b0098e1debcb03mr6895761ejb.56.1688400502033;
        Mon, 03 Jul 2023 09:08:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906938b00b00991dfb5dfbbsm9564650ejx.67.2023.07.03.09.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 09:08:21 -0700 (PDT)
Message-ID: <5a9e7dd9-8cc7-eeb9-cc63-3ec5d63c3a15@linaro.org>
Date:   Mon, 3 Jul 2023 18:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
 <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
 <ZKKXGE95Sv-eLQa8@hovoldconsulting.com>
 <0f4f5a4d-379b-c00c-6bf2-58c08fcc4551@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0f4f5a4d-379b-c00c-6bf2-58c08fcc4551@linaro.org>
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

On 03/07/2023 11:56, Konrad Dybcio wrote:
>>>> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>>>> index 895cafc11480..c4209e2d4b4e 100644
>>>> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>>>> @@ -155,7 +155,7 @@ CPU7: cpu@3 {
>>>>  
>>>>  		idle-states {
>>>>  			CPU_SLEEP_0: cpu-sleep-0 {
>>>> -				compatible ="qcom,idle-state-spc", "arm,idle-state";
>>>> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
>>> Will conflict with:
>>>
>>> https://lore.kernel.org/linux-arm-msm/20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org/
>>>
>>> there are also a couple of entries with property =\n\t{n}[a-z]
>>>
>>> Otherwise lgtm
>>  
>> Konrad, please remember to trim irrelevant context from your replies
>> (e.g. so that we don't have to skim through thousands of lines to find
>> a single comment).
> My actual reply begins at line 77, which is considerably less than
> thousands and is concluded by my signoff, which signifies the end
> of the message.

Your reply did not start at first scroll page. I had to scroll. Since
you put your reply inside big chunks of quote, it's very easy to miss
it. So I keep scrolling, keep scrolling, and so on, so on. Till I reach
end of email and I still don't see your reply.

Now in this email it was easy to find, because it was more than one
line. But in other responses I waste some time to find yours. Johan's
comment is here perfectly valid. Reading your responses is more time
consuming than required.

Best regards,
Krzysztof

