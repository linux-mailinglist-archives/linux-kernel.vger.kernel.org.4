Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D52673667
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjASLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjASLKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:10:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156E7497A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:10:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so4682858ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFEYKKgVFwVXs5cKTPaIK+MI9cmiPLzvQLxxZZJC6DI=;
        b=Qr+vAkM6UGTyNaXghLE7XaUsVbveKd5dNgLYerCk0CJJfzevvUnYgkJ+QNZg4wvGUn
         DSs31iOTTOUSXpbbN/oqzxDZhkrxQNSVC7ldXNpgLka5gx9kzzlZz5AK5OfgA717jpbe
         nJLEAAP2nrtlpkuskVOlOFLoshkCz1pwXExLCjQ1WGa0/OgjdXThEDBKFhApfD3WjfUW
         0Z3DBLhSQu7BycIKtJRMFKdi3J4pcuSu4/Gm6o1E347IVSlx0L1FnBz1+v2ucruD1XxO
         S/BmHf5BMJsnufxYzQuclNUv4tFIkVwN8TbD+TPtnyyhw1nmD2FigYV6vLr8+yfEgoMF
         xTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFEYKKgVFwVXs5cKTPaIK+MI9cmiPLzvQLxxZZJC6DI=;
        b=BeIs0VF5WkZYP0CeN7EPzv2odCznYHnqMSJo6Ya21e3ESRbHu9GnDgQdscBapGzM55
         9U2oXMHrP9dDBttChWNA2rHAtQEiTWESNKXpcVjnqTyocK1HKh6e4opXz1CNbeamji1u
         e6MOmr9gpOpd4w6SSYxBxs3+UiL0alf4QrwGsACqYQhti/hSCq8dnQfYOaGswR9WMGL0
         7LDNWUZ11+uHbsrA10G3aeOUUmvNQpyhRNCOMA+f9RACtL/4W7DAf+D0mUeFICyYB+0x
         kAKMTmqGaELoT8khhB8IS+2ijJMfCVInotE8xJa6/MkXEWQemFQnGvYqWzcOUjfeDNrP
         cX4A==
X-Gm-Message-State: AFqh2kqu0bJcckI11CLlMxHPcnOnxby9gssGk26Um0GhdM/G+uMaCmEj
        icQD30kUkYZjqOsWxoGjSpWK3A==
X-Google-Smtp-Source: AMrXdXtozZLbb+W8xF3Dp986+miOd8UiFeWHI+JPSTlQ7xSF4mnYc2ha+zsWUatMIGJsaozw4xj+0w==
X-Received: by 2002:a17:906:ad82:b0:872:e6fd:1c79 with SMTP id la2-20020a170906ad8200b00872e6fd1c79mr10246833ejb.77.1674126629791;
        Thu, 19 Jan 2023 03:10:29 -0800 (PST)
Received: from [192.168.1.101] (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709062bcc00b007ae38d837c5sm16520246ejg.174.2023.01.19.03.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:10:29 -0800 (PST)
Message-ID: <8e357341-3cf1-3714-4f5d-f4be94f91438@linaro.org>
Date:   Thu, 19 Jan 2023 12:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/4] Minor cleanup in msm8916 dts files
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230116145053.1412501-1-nikita@trvn.ru>
 <20230119033428.ga6sbu42jaueac5o@builder.lan>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230119033428.ga6sbu42jaueac5o@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.01.2023 04:34, Bjorn Andersson wrote:
> On Mon, Jan 16, 2023 at 07:50:49PM +0500, Nikita Travkin wrote:
>> This series performs some minor cleanup on msm8916/apq8016 files to
>> bring them in line with the current standard and be closer to the new
>> submissions.
>>
>> The series is separated into commits by each specific change made across
>> all files and these commits should not cause any functional difference.
>>
>> Changes in v2:
>> - Rebase on top of newly applied upstream patches
>>
> 
> The first patch looks pretty reasonable, but without documenting the
> guidelines and tools to help others maintain the ordering this
> unfortunately just moves things around arbitrarily.
> 
> Forgive me, but I will ignore this series until this is finalized and
> documented.
Ack, the idea is good, but I rushed enforcing it.

Konrad
> 
> Thanks,
> Bjorn
> 
>> Nikita Travkin (4):
>>   arm64: dts: qcom: msm/apq8x16-*: Move status property last
>>   arm64: dts: qcom: msm/apq8x16-*: Reorder the pinctrl properties.
>>   arm64: dts: qcom: msm/apq8x16-*: Drop empty lines in pinctrl states
>>   arm64: dts: qcom: msm/apq8x16-*: Reorder some regulator properties
>>
>>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 78 +++++++--------
>>  .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 15 ++-
>>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 46 ++++-----
>>  .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 34 +++----
>>  .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 52 ++++------
>>  .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 42 ++++----
>>  .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 30 +++---
>>  arch/arm64/boot/dts/qcom/msm8916-pins.dtsi    | 96 +++++--------------
>>  .../qcom/msm8916-samsung-a2015-common.dtsi    | 64 +++++--------
>>  .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts | 11 +--
>>  .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  5 +-
>>  .../qcom/msm8916-samsung-e2015-common.dtsi    |  5 +-
>>  .../dts/qcom/msm8916-samsung-grandmax.dts     |  3 +-
>>  .../boot/dts/qcom/msm8916-samsung-j5.dts      | 21 ++--
>>  .../dts/qcom/msm8916-samsung-serranove.dts    | 62 +++++-------
>>  .../dts/qcom/msm8916-wingtech-wt88047.dts     | 35 +++----
>>  arch/arm64/boot/dts/qcom/msm8916.dtsi         | 32 +++----
>>  17 files changed, 245 insertions(+), 386 deletions(-)
>>
>> -- 
>> 2.38.1
>>
