Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7933A62B6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKPJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiKPJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:44:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC09DEE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:44:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id be13so28660373lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgS+Ovv0eXOJwFTViusXUlwcEa0Tx7ZA7lRyTAv8k4w=;
        b=RCe4P4IceE6ZUqJglE+YVt+Dny9tnUgYpgasdp8+S6rXcaCc7k9FtCvWd5x2Bj/sBV
         NAVASAdFtSlrI+TrToOf3ARBu7wuCOzIF7KDffariJDavuOisxcP1b+91qua69biztg0
         uGsemHhaMQ0pBs0UcTft6qARg9oiPnZVW2nn5ja8UU27z4v/vz42rv/nV2f2ZxqLyCMp
         77qSLcgHngG/Eoh2HjSHgQY/VWAvQWZANyGvy/SbToN+hIU8RQN/ULzpAzOZk0n5d1Vr
         AhDCUuR7iP8in6MICx3X2fC71sp1qR/COkLRjG4njZ8KAuK8zy1cbCpLq1uvSaWGwgS4
         emEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgS+Ovv0eXOJwFTViusXUlwcEa0Tx7ZA7lRyTAv8k4w=;
        b=jD5k+B5V+QEvM8HPI0t+0RAhpoejugJpvRmryxxQa9W2jPyG6asCo0YA1kBMBTXNmN
         MOmK0J+5EY/jYAfOA/D9LB2lLA2GaceAVEbL6PuMJCk0DPGQxjVtxZC519D0cmYns/Ec
         Qa7xoX0DdT5JzCZq5o4FeD0zuN5cPHEFAsoAYbUSbhCF1c6dALn6dbzZNsmLxGIQwvC7
         T/XMDmOg4E4qLjPInPLZt3aLyEK2hlAJgDQKo553ELlSPsvvyPFSO7FGUVkZ6APHCTy/
         DT9t2WYSPhbm3PqdAMoY6GF9tHFe0A4p/E/GErF+O0Y1y6Hnc47Wzt7nRyATXgcOuzjd
         XrNg==
X-Gm-Message-State: ANoB5pn3FZVEed7nAChN0SSp/E6GiBzqDXeQUVnDUj9gE2XOIFozuXYH
        GBqUGSwdK+GUw2jRcGxrKmnZGg==
X-Google-Smtp-Source: AA0mqf6rTJFMk6b2mLxnOY8Sft920fWk28nxriGe7jyDuJtMB+LZZKA6WnYqmqoNq3pFIBP+3eFblg==
X-Received: by 2002:a05:6512:308a:b0:4a2:39e6:4d48 with SMTP id z10-20020a056512308a00b004a239e64d48mr6999988lfd.234.1668591896428;
        Wed, 16 Nov 2022 01:44:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b00496693860dcsm2516397lfr.232.2022.11.16.01.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:44:56 -0800 (PST)
Message-ID: <0ac1f247-be87-0f92-9ef0-c653bcdb6c1f@linaro.org>
Date:   Wed, 16 Nov 2022 10:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 05/11] dt-bindings: mailbox: qcom: Allow syscon on
 qcom,msm8976-apcs-kpss-global
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-6-angelogioacchino.delregno@collabora.com>
 <14947ae2-c8d4-de86-ce9e-29175e73cbb2@linaro.org>
 <9f3e88fa-0aaf-2edd-366e-c3f5b2269dba@collabora.com>
 <513a2dc3-d053-6e4b-a125-394cf1f6c81b@linaro.org>
 <f60ccd79-9c82-0844-2c5f-21ec29c14dcf@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f60ccd79-9c82-0844-2c5f-21ec29c14dcf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 10:00, AngeloGioacchino Del Regno wrote:
> Il 16/11/22 09:57, Krzysztof Kozlowski ha scritto:
>> On 16/11/2022 09:52, AngeloGioacchino Del Regno wrote:
>>> Il 15/11/22 17:44, Krzysztof Kozlowski ha scritto:
>>>> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>>>>> MSM8976 supports SMSM, which needs this node to also be a syscon:
>>>>> move the compatible to allow that.
>>>>>
>>>>> Fixes: bcc8d70f912d ("dt-bindings: mailbox: Add compatible for the MSM8976")
>>>>
>>>> I am not sure if this is still a bug. Maybe just a missing feature?
>>>>
>>>
>>> This changes how you use this mailbox across the entire devicetree (as other
>>> nodes will not use mboxes = xxxx, but qcom,ipc = xxxx as syscon), so I think
>>> that this is not a missing feature?
>>
>> Whether it is a bug depends on existing usage. If none of msm8976 DTSes
>> use it the other way, then it is just incomplete or missing support. Not
>> a bug. If existing DTSes use it as syscon, thus you need to add syscon
>> to compatible, then it would be a bugfix.
>>
> 
> It's not a bugfix then. The Fixes tag shall be dropped.
> 
> Same question like the other commit, should I send a v3 or can it be dropped while
> applying?

Maybe better send a v3.

Best regards,
Krzysztof

