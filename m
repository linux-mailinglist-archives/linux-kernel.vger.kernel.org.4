Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68B36622FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjAIKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbjAIKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:16:51 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C917656
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:16:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g13so12183664lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4C+uBeuYJaLIQOjHxSFx74inl8MleJj+0t84zKqd+U=;
        b=gsKFgkaKO0UiC45NxDJvDWSRgSeF7zZQ/ZtxBmTJYSFZfUMKlWgJzDo/cSm5DTmvbq
         SG8E/bTSrZlhJyw/Hzz8MMc8b5nyJaQY12hHE2ZPZxMx/ewOhjvUXBNQNN2XMk3S4viG
         BQAdfq7jhud0o6Gz+xZBx1fnqDKM4FTJLylmaxVW2ZwegnGIQAeEJRXeyYDFrYORZyVN
         HjPikM5ec2P1pSAQTVCTtNxJ+Jb4Rz8QKH81XrT7odQN7yXtTPpb2HnPrY9syMSFTUH7
         8aFcccrjafWvAhCZLVgWo687NPoB/x3M/dfhJaPlnpGSZdhLkYhvQqWDLyUFYX9liYkx
         QKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4C+uBeuYJaLIQOjHxSFx74inl8MleJj+0t84zKqd+U=;
        b=7s+2ekk39cE1KoxhRW7dqp9PGSLWnKtu4eHUn/HPIt/V3ZdZDNgbpi3R7SsiEiEN3u
         434IJFwSfFqiEYQJypKssHCOZmjUkgFmUD6hPnybom6vphSYbuLZiJKV4miMidOeouOG
         kyHWApOJQXRRyzrsHL4Yti84+jmKSPbEruEW9hLgPZWccMF4yGZiwxVqhq0F97f/dfXc
         qVnfB/EcXmpGzoATMNk1+dx4YdtK6Un6W49FO3EFNvTczytrs+K49RRgzXDfiRvEnWXi
         Qj8NmKqnQjc3nLdoQQXfPTv/8CJ6kFQiKnmK3Fj2LFKMspu7mQ0IHfDhAdljVzlKiq7t
         uQ+A==
X-Gm-Message-State: AFqh2kqcHKDvVnau3Ds4MTv28Re2OzdFEN55py9Fpgz5/fF0xZTiQDWu
        JierYgTiWNoS8VDHQ9wmqGad+A==
X-Google-Smtp-Source: AMrXdXvjSeDYGDcKZPl8murhw+Uf5jtlCt6Syj74+J9xEW4u+aYleQcMPLSgokkqZLriQ30WgtgZ/Q==
X-Received: by 2002:a05:6512:340d:b0:4b5:69f1:61b1 with SMTP id i13-20020a056512340d00b004b569f161b1mr18204040lfr.42.1673259401186;
        Mon, 09 Jan 2023 02:16:41 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id b15-20020a05651c032f00b0027fd02c99d4sm848109ljp.75.2023.01.09.02.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:16:40 -0800 (PST)
Message-ID: <1ec4b446-b195-0277-90ba-4a8398fcd729@linaro.org>
Date:   Mon, 9 Jan 2023 11:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] dt-bindings: firmware: qcom: scm: Separate VMIDs
 from header to bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e64d22eb-4c42-b279-b493-972e4a1af1cd@linaro.org>
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



On 9.01.2023 10:54, Krzysztof Kozlowski wrote:
> On 09/01/2023 10:39, Konrad Dybcio wrote:
>> With changes to the rmtfs binding, secure VMIDs will become useful to
>> have in device trees. Separate them out and add to include/dt-bindings.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> v2 -> v3:
>> New patch
>>
>>  include/dt-bindings/firmware/qcom/scm.h | 16 ++++++++++++++++
>>  include/linux/qcom_scm.h                |  7 ++-----
>>  2 files changed, 18 insertions(+), 5 deletions(-)
>>  create mode 100644 include/dt-bindings/firmware/qcom/scm.h
>>
>> diff --git a/include/dt-bindings/firmware/qcom/scm.h b/include/dt-bindings/firmware/qcom/scm.h
>> new file mode 100644
>> index 000000000000..d66818cd57a8
>> --- /dev/null
>> +++ b/include/dt-bindings/firmware/qcom/scm.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Only Codeaurora folks contributed these numbers, thus we can relicense
> it to dual-license, I believe.
> 
> The other topic is what do these numbers represent: hardware interface?
> registers? offsets? firmware?
Arguments for a SCM call, so firmware interface.

IOW, why bindings is the place for them?
> (usefulness for DTS is not the reason)
These defines correspond to mappings in a hardcoded, irreplaceable
and un-omittable firmware which is (unless you steal engineering
samples from the factory) always shipped with these SoCs and they
help clarify some otherwise totally magic numbers.

Konrad

> 
> 
> Best regards,
> Krzysztof
> 
