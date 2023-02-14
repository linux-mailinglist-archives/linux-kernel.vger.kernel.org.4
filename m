Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAB96969BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBNQfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:35:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7751BAEE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:34:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a2so16287453wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sPPHKOJ8BbxBRItJGDJFEQbo+vowRlUP9MhQo5yyu6U=;
        b=WndG3+R/WLWXsLCVrKYQq3f5S1JhiHK6YEppgJ2JzpKDs4+/5KzPfLFMJR69/cw4B/
         uy5mrHDfLJW+EoGhAj45FPfDkVj8J5WMrjsmX1HTVd5wdtDwhBCreTdcnOBdhQI+9NL9
         t0NyERmhK2jC8Epu4L2jDoM2EDK+8XnPf/fOp+SqLY8tZvGUyIxk3U9I7qkyXULUgRKs
         3wEINpbftIWMs1L6WbSxUU1DPSu2owjFrzWcQjWxjxzpGFnm1LZxrabudv2dSdU1OPtf
         ytvZRYN+70PSGLTR+tGjrVk3hgniIrKW859aLi5hJSQ8FKrRS4qimHXrHCab8zHTw+VH
         HXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPPHKOJ8BbxBRItJGDJFEQbo+vowRlUP9MhQo5yyu6U=;
        b=bkqS9Dy5qmJ2re2B/sZyzk7rVbFysTyKbpcAlgRSpX+42BR7Y6/gnK0O5eVkFW6BQy
         FvEhEbjJZf7pZ9p5z125rhfcvonvnf7WkZe9hF/ECQxAv6BBJpZtZYIRF9AN5U7NLv/+
         p+rAGd1NnbhSW4rgoCJFV0NiH2NKCu8QLvEeAPYocU/gdtiNn10VE583KRYIJyamsXtQ
         TfDpaW0ka/GaGtCtSVCFzwsC+ZaC8Jlx5e84SF2uFdri1xWQvktfo4N48CRACZYsq3uc
         GjtcRMey+QCnU+JJvEQaUp/vdmbJyPdvKrnRfRbf1fErEExUHPdIcmSZZT6qvrevYado
         tDoQ==
X-Gm-Message-State: AO0yUKWvaz08EVavy9Si63XN/f6mERPwEh4Zf24Fgpn5XTyZUCe32gae
        5w04wrOgYzf8nwTTmAXTQVNNvQ==
X-Google-Smtp-Source: AK7set9H2cOo3A5cs8oyFfTGJahxgcDiip0YMdeLybuqMzhVfp65ixaIXgXCNSuKOPJU7NTtVq8aUg==
X-Received: by 2002:a5d:6ac5:0:b0:2c5:586b:f53d with SMTP id u5-20020a5d6ac5000000b002c5586bf53dmr2616133wrw.48.1676392472426;
        Tue, 14 Feb 2023 08:34:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4bc0:b2ae:1d81:afec? ([2a01:e0a:982:cbb0:4bc0:b2ae:1d81:afec])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d4d84000000b002c5621263e3sm2451359wru.19.2023.02.14.08.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 08:34:31 -0800 (PST)
Message-ID: <9841fd7d-861c-4b5c-51cf-7b8da53a06c9@linaro.org>
Date:   Tue, 14 Feb 2023 17:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 00/12] The great interconnecification fixation
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
 <e4760caa-2904-7645-920d-cbd07daf657e@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <e4760caa-2904-7645-920d-cbd07daf657e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 17:27, Konrad Dybcio wrote:
> +CC Georgi, linux-pm, linux-kernel (thanks git send-email for not including these)

Time to switch to b4 prep ;-)

> 
> On 14.02.2023 15:37, Konrad Dybcio wrote:
>> Hi!
>>
>> v3 -> v4 changelog:
>> - Drop "Always set QoS params on QNoC", it only causes issues.. this
>>    can be investigated another day, as it's not necessary for operation
>>
>> - Drop "Add a way to always set QoS registers", same as /\
>>
>> - Add a way (and use it) to have no bus_clocks (the ones we set rate on),
>>    as at least msm8996 has a bus (A0NoC) that doesn't have any and does
>>    all the scaling through RPM requests
>>
>> - Promote 8996 icc to core_initcall
>>
>> - Introduce keep_alive (see patch [11/12]) (important!, will be used by at least 6375)
>>
>> - Allow negative QoS offsets in preparation for introducing 8998 icc [12/12]
>>
>> Link to v3: https://lore.kernel.org/linux-arm-msm/20230116132152.405535-1-konrad.dybcio@linaro.org/
>>
>> v2 -> v3 changelog:
>> - Drop "Don't set QoS params before non-zero bw is requested"
>>
>> - Rebase on next
>>
>> - [1/9] ("..make QoS INVALID default.."): remove unused define for
>>    MODE_INVALID_VAL
>>
>> - Pick up tags
>>
>> v1 -> v2 changelog:
>> - reorder "make QoS INVALID default", makes more sense to have it
>>    before "Always set QoS params on QNoC"
>>
>> - Limit ap_owned-independent QoS setting to QNoC only
>>
>> - Add new patches for handling the 8996-and-friends clocks situation
>>    and optional BIMC regardless-of-ap_owned QoS programming
>>
>>
>> [1] https://lore.kernel.org/linux-arm-msm/14e06574-f95e-8960-0243-8c95a1c294e9@linaro.org/T/#m056692bea71d4c272968d5e07afbd9eb07a88123
>> [2] https://lore.kernel.org/linux-arm-msm/20230110132202.956619-1-konrad.dybcio@linaro.org/
>>
>> This series grew quite a bit bigger than the previous [1] attempt, so
>> I decided to also add a cover letter.
>>
>> Link to v2: [2]
>>
>> It addresses a few things that were not quite right:
>>
>> - Setting QoS params before a "real" (non-zero) bandwidth request
>>    makes little sense (since there's no data supposed to flow through
>>    the bus, why would the QoS matter) and (at least newer) downstream
>>    prevents that from happening. Do the same in Patch 1.
>>
>> - QNoC type buses expect to always have their QoS registers set as long
>>    as there's a non-INVALID QoS mode set; ap_owned is not really a thing
>>    on these anymore, Patch 3 handles that.
>>
>> - The recent MSM8996 boot fix was done quickly and not quite properly,
>>    leading to possibly setting the aggregate bus rate on "normal"
>>    hardware interface clocks; this series handles that by limiting the
>>    number of bus_clocks to 2 (which is the maximum that makes sense,
>>    anyway) and handling the rest as "intf_clocks", which are required
>>    to access the   hardware at the other end. Patches 5-8 take care of
>>    that and Patch 10 reverts the _optional moniker in clk_get_ to make
>>    sure we always have the bus scaling clocks, as they're well, kind
>>    of important ;)
>>
>> - Similarly to QNoC, BIMC on "newer" (which can be loosely approximated
>>    by "new enough" == "has only BIMC and QNoC hosts") SoCs expects to
>>    always receive QoS programming, whereas BIMC on "older" SoCs cries
>>    like a wild boar and crashes the platform when trying to do so
>>    unconditionally. Patch 9 adds a way to take care of that for newer
>>    SoCs (like SM6375)
>>
>> - QoS mode INVALID was assumed by developers before to be the default
>>    ("I didn't specify any QoS settings, so the driver can't assume I
>>    did.. right? right!?" - wrong, partial struct initialization led to
>>    0 being set and 0 corresponded to QoS mode FIXED). Make it so, as
>>    that's the logical choice. This allows the "Always set QoS params
>>    on QNoC" patch to work without setting tons of what-should-
>>    -obviously-be-the-default values everywhere, as well as fixes older
>>    drivers that set ap_owned = true but left the QoS mode field unset.
>>    Patch 2 cleans that up.
>>
>> - Some nodes are physically connected over more than one channel
>>    (usually DDR or other high-throughput paths). Patch 4 allows that
>>    to be reflected in calculations. This will be required for at least
>>    MSM8998 and SM6375 (which will be submitted soon after this lands)
>>
>>
>> Konrad Dybcio (12):
>>    interconnect: qcom: rpm: make QoS INVALID default, separate out driver
>>      data
>>    interconnect: qcom: rpm: Add support for specifying channel num
>>    interconnect: qcom: Sort kerneldoc entries
>>    interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
>>    interconnect: qcom: rpm: Rename icc provider num_clocks to
>>      num_bus_clocks
>>    interconnect: qcom: rpm: Handle interface clocks
>>    interconnect: qcom: icc-rpm: Allow negative num_bus_clocks
>>    interconnect: qcom: msm8996: Specify no bus clock scaling on A0NoC
>>    interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks
>>      anymore
>>    interconnect: qcom: msm8996: Promote to core_initcall
>>    interconnect: qcom: icc-rpm: Introduce keep_alive
>>    interconnect: qcom: icc-rpm: Allow negative QoS offset
>>
>>   drivers/interconnect/qcom/icc-rpm.c | 101 ++++++++++++++++++++--------
>>   drivers/interconnect/qcom/icc-rpm.h |  41 +++++++----
>>   drivers/interconnect/qcom/msm8996.c |  35 ++++++----
>>   drivers/interconnect/qcom/sdm660.c  |  16 ++---
>>   4 files changed, 126 insertions(+), 67 deletions(-)
>>

