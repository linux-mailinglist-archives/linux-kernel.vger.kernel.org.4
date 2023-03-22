Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC46C4521
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCVIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCVIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:36:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F3C5DEFC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:35:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so69462497edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679474137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DntXGXvr8H/rQ6dM4/EUrhiL65qM60t+UtrrOzvHSo=;
        b=GsJlggwAIG7TtATrtOuWrAS5Phb1YH+82ht27aTMSh6RvkGNQQtlWYuWM+Zk/1N75R
         2ztnLRIIGzbFK++utgCU5OE7Eo1xNJAj7CS1jb+ihKNBaDdrXcoimJpq20zWyAnU8+sZ
         Tb2XGt9XgDiD3od+z/d3EjJh+XUkprbgWT/9pzaDQGwuuplK1jD24KvCvf4Dzk407t9M
         8g+4AKORzxllippydprSyUXSDKQ4SzHVvFWJyRubwTb02LS90kwZt6/9uM/d3pC8PEK6
         Hz5/9HwzRyIRderXzulqMO+kPGO5/UgyajJ5wcX99zid+D8gSb7YJ5xxX5nfZKuno5HM
         2/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DntXGXvr8H/rQ6dM4/EUrhiL65qM60t+UtrrOzvHSo=;
        b=xJEnf4aIhjogONfeSUuboqp4ILBtF13hiJb3vZfp0ZD73NlEE4DHhzxe1WET/D9ISY
         IZhUxt2shVDyo7CT3uT3/Izo777mBColyqJynIKnx12ibzmI8rbOaL08X+kqewfjEnIV
         fc2/uITwG7zKy7z8e8xVIHQuvXcAAAhlgzy8jY7+uost4MmvstJ4s+V3Dq8zF1h8xn+V
         2dq7P1dx3upwlY1o4xeNqWZPyEBCcIs5hvQkanzutUBXp/Qvas0roWxKdjHThUFpf3/L
         mxQZDn2rQSX4btUD/ZjzXuoixhpfQFV7fyLmQtu+PBc0J6TZoKhdgLJH38AYlV6X+LOx
         LYhw==
X-Gm-Message-State: AO0yUKWdC/SM67xD4efu1Wnkn0QvVHBU+7HwD7EZZ4vn0Lk6PT4wcfrQ
        Rqy1NuXrP7FQZ3zGvEwiV3bf3w==
X-Google-Smtp-Source: AK7set/YphAfz81YC4ks4tfTIhsNWkCbCmBVjJL/CegkBZNDsqvqDlYbhPGAzWIK8D5Ygyc2YoDi2g==
X-Received: by 2002:aa7:c44d:0:b0:4fa:ac78:7f2a with SMTP id n13-20020aa7c44d000000b004faac787f2amr5186649edr.41.1679474137076;
        Wed, 22 Mar 2023 01:35:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id e23-20020a50d4d7000000b004bf28bfc9absm7202223edj.11.2023.03.22.01.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:35:36 -0700 (PDT)
Message-ID: <ea863eac-58bd-cd61-ce5c-a0393bb4e4a8@linaro.org>
Date:   Wed, 22 Mar 2023 09:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] arm64: dts: qcom: Enable Crypto Engine for a few
 Qualcomm SoCs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
 <41111f93-ef02-0e57-98af-01327213d854@linaro.org>
 <CAH=2NtziWx2g_4K92iH+9DLo8XV0P32NNnEpxy6f0G_dQOVs+Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH=2NtziWx2g_4K92iH+9DLo8XV0P32NNnEpxy6f0G_dQOVs+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 09:33, Bhupesh Sharma wrote:
> On Wed, 22 Mar 2023 at 00:57, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 21.03.2023 20:01, Bhupesh Sharma wrote:
>>> This patchset enables Crypto Engine support for Qualcomm SoCs like
>>> SM6115, SM8150, SM8250 and SM8350.
>>>
>>> While at it, also fix the compatible string for BAM DMA engine
>>> used in sdm845.dtsi
>>>
>>> Note that:
>>> - SM8250 crypto engine patch utilizes the work already done by myself and
>>>   Vladimir.
>>> - SM8350 crypto engine patch utilizes the work already done by Robert.
>>>
>>> This patchset depends on the dt-bindings patch which added support for
>>> SM6115 and QCS2290 SoCs:
>>> https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/
>> You could have included that one here for easier tracking!
> 
> Err.. the dt-binding maintainers have been asking to split the
> dt-binding patches from
> the dts ones in the past. So, let's stick to that for now :)

For submissions? No, we did not.

Best regards,
Krzysztof

