Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39536688454
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBBQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjBBQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:25:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30958233C3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:25:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1839935wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKkQ/MGYg75Krl7zSnOxIL9rasEvYWJbhYfIJlw/MJE=;
        b=VoppvjbP97+x6wLZbumvfPPdxVNlasPUlw9jNftlxNfy8mPVVNtmggL+2ShSgBe8M2
         5ENqCsAlY6CeslsI5+h+Sv/gTCpznE1L072jzeDK/jPPuFSjZNEWrqeouJpUGmcOO5qW
         0ovjNG1NcTgB+qh663kL+4F1Ub80QHJtnAD7FmpCLDp44UjbHbeExNtVn/yhpCfeuZZf
         gkgSPU7IRjqoEOlCBkQF5otqWDtojKUYTyquE9G/hOsKpw7RS8mwbh5A6tsm77niUfDg
         9NPnTcOgzkiNpJg3ZpE5DCi3sAf0h/5qOPANnFLRr5aHGzCL/gyfhRl68fs0fmBkAu69
         xnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKkQ/MGYg75Krl7zSnOxIL9rasEvYWJbhYfIJlw/MJE=;
        b=mTlkZcbdnh4m8a2i72blANxYDVroqpy7poityXp8R3ubgHzva7gYihMMV9PWDhmmAI
         pphFII43sRzqwKL3NZP31g3vKffrG2Cn/68iSy5YDgZEQn8WmUiqiMBe7/QNNJiAicW7
         BzQlF++3iUCjohThDSOS6ALHpkHqkceAHXSou3yh3zn8OCNUVo+4cNrgk8gDxsOnkYtc
         jiDFLkGrhr+9tubjLwfn+NTcUk5aI1EeLxID0T1OZGsTLRViiUKtHwc3yp/Xb26s2kBL
         yd6/+KWJGMx6/GZ4JJz37Xmlsa2d8ECGt4RhTW9s0Ta3XIhrms81Hk2nfelpNxBFfff6
         U58w==
X-Gm-Message-State: AO0yUKVs2KhOzXYOV2iuYnRNJKiLFlTvKsctH0pA+hUAK8TtfoTJI+4I
        MlNdDpTg/thmIS+QdYPROG45rw==
X-Google-Smtp-Source: AK7set8aBQAyjofXakT1skJQOIhl0iX3vO6X+TF2rtqyHnfL/CNseXBsu8Llf7cxLMReWw7evMX2lg==
X-Received: by 2002:a05:600c:4e55:b0:3d9:e5d3:bf with SMTP id e21-20020a05600c4e5500b003d9e5d300bfmr6521824wmq.32.1675355104701;
        Thu, 02 Feb 2023 08:25:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b003daf7721bb3sm5084687wmq.12.2023.02.02.08.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:25:04 -0800 (PST)
Message-ID: <7ed270eb-decc-3a5d-589f-bf8175fac0d3@linaro.org>
Date:   Thu, 2 Feb 2023 17:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: Add cap-aggressive-pm property
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Hermes Zhang <chenhuiz@axis.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230129023630.830764-1-chenhuiz@axis.com>
 <b43f26c9-f76c-c898-aadc-ce3ee7b7823d@linaro.org>
 <b125f25d-94c7-dd5b-28d3-3948c36ef4e0@axis.com>
 <a1d2ac4c-0763-5c92-be21-22820c376438@linaro.org>
 <CAPDyKFqX+1HBPmgXC9Apdb02F25J9ZTKRByqZQZn6Xx4Kf=Efg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFqX+1HBPmgXC9Apdb02F25J9ZTKRByqZQZn6Xx4Kf=Efg@mail.gmail.com>
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

On 02/02/2023 15:59, Ulf Hansson wrote:
> On Tue, 31 Jan 2023 at 17:57, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/01/2023 07:54, Hermes Zhang wrote:
>>> On 2023/1/29 18:58, Krzysztof Kozlowski wrote:
>>>> On 29/01/2023 03:36, Hermes Zhang wrote:
>>>>> This commit add a new property: cap-aggressive-pm to enable the
>>>> Do not use "This commit/patch".
>>>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>>
>>> Done
>>>
>>>>> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.
>>>> Why this is a property suitable for DT? IOW, why this isn't enabled always?
>>>
>>> This property will benfit for the power consumption, but it also may
>>> degradation in performance as it will prevent the
>>>
>>> the card from executing internal house-keeping operations in idle mode.
>>> So it's better to config it from DT.
>>
>> Why? DT is not for policy. How you described it, this is policy or
>> system tuning choice thus the job for Linux (OS), not for DT. So I will
>> repeat - why this property fits the purpose of DT (describe the hardware).
>>
> 
> I guess the HW perspective here, is that it might not fit all
> platforms nor the actual eMMC/SD card to support this feature.
> However, it still seems like a policy rather than a strict HW
> constraint.
> 
> Perhaps there is a way to figure out in the host driver, to
> conditionally set the MMC_CAP_AGGRESSIVE_PM for the host, when needed
> instead?

What also worries me is that there is no user of this property: no DTS,
no driver, so it is tricky to deduct out when it is applicable.

Anyway things which might be obvious for the submitter, might not be for
the reviewer, thus I would really like to see justification why
different boards (or memories) need this property.

Best regards,
Krzysztof

