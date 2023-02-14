Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97B696975
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBNQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBNQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:27:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDAC179
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:27:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml19so41625961ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvNHQRlfXDnwN7/aozLZXMLlUQIZLqbXP/Yn1Rtm2eI=;
        b=DeEMDg2dlwqcy+oZi20ihpgqzr5qkR8phwgck4GlvbMhS3jOnC9PjN78z6N68T6Tiv
         WAsKXcfJNYjZdi8IQ9u8QmXHfzWLb1GPforuCOv5D7qYJOJ5s9Qx16HpqNd2Q4HpSLl5
         ZJszlcznEEKrNTRqV4bmtuw/FeYDh77SmimqvLF1KbA0hH2WN+Fqr5/1q9BJpzj+Wdfb
         TtAZgufQKkxplCzeBjF/9PAmmu2uoN7qEZ8URZ9Hs66mBJ99t15/VQHEI2BkOOmMpJWj
         lePNteSv+cOaidUY5xLYxn3swJ7KSQY9Ae6d8JfGqRp3miRAnIpW69Qw8fhpaBOUpKqY
         eEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvNHQRlfXDnwN7/aozLZXMLlUQIZLqbXP/Yn1Rtm2eI=;
        b=PTvFg1KOLazTnYj1eAPeTxPWWnju0WwBlUgbYtcLZUIe5nBHCp+ShyLM+vAIdJAXnR
         xPBgdqTV1pCPTl/ebnlvzyrEh8HTxt1pz94ekmCQljapG0DL/dHJU1b7KTXGVQMGDWF4
         W+5m5pPJKY7qyaSZf2y7mUmUwKi8tiL1zcUNutuIpFq4Rw9qjd4eoGYggznOUMuNDdTM
         Z1i6avWN+EIo+Tiz6m9Tld/1ZXlo9DgIo65hW8BPp/fhLG46tlbQMJzLMAEwKz/aRpaB
         E/Cj3A2iynF33oKqlf9AkGCj94bU25X6GCf9rY69vtffT4E7nVh/AlNwIgTlvNmQzltp
         3FFg==
X-Gm-Message-State: AO0yUKWP+Fwc1sJJxLERbgasybbJlFaJsok18J77uQ0Y/xHA8+MIeBeZ
        8NoA4KF5bek8vicRRd7voXVqMA==
X-Google-Smtp-Source: AK7set/BAV4TZmiXAFRIXk8igD4wwJ7rJ9t/fiQLbdJ8E/KSeSl+5/e4kFNdvIYXEl92r4d745nreA==
X-Received: by 2002:a17:906:616:b0:878:4a5e:3a56 with SMTP id s22-20020a170906061600b008784a5e3a56mr3387532ejb.15.1676392072613;
        Tue, 14 Feb 2023 08:27:52 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b008b112db78f9sm2725072ejx.51.2023.02.14.08.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 08:27:52 -0800 (PST)
Message-ID: <e4760caa-2904-7645-920d-cbd07daf657e@linaro.org>
Date:   Tue, 14 Feb 2023 17:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 00/12] The great interconnecification fixation
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Georgi, linux-pm, linux-kernel (thanks git send-email for not including these)

On 14.02.2023 15:37, Konrad Dybcio wrote:
> Hi!
> 
> v3 -> v4 changelog:
> - Drop "Always set QoS params on QNoC", it only causes issues.. this
>   can be investigated another day, as it's not necessary for operation
> 
> - Drop "Add a way to always set QoS registers", same as /\
> 
> - Add a way (and use it) to have no bus_clocks (the ones we set rate on),
>   as at least msm8996 has a bus (A0NoC) that doesn't have any and does
>   all the scaling through RPM requests
> 
> - Promote 8996 icc to core_initcall
> 
> - Introduce keep_alive (see patch [11/12]) (important!, will be used by at least 6375)
> 
> - Allow negative QoS offsets in preparation for introducing 8998 icc [12/12]
> 
> Link to v3: https://lore.kernel.org/linux-arm-msm/20230116132152.405535-1-konrad.dybcio@linaro.org/
> 
> v2 -> v3 changelog:
> - Drop "Don't set QoS params before non-zero bw is requested"
> 
> - Rebase on next
> 
> - [1/9] ("..make QoS INVALID default.."): remove unused define for
>   MODE_INVALID_VAL
> 
> - Pick up tags
> 
> v1 -> v2 changelog:
> - reorder "make QoS INVALID default", makes more sense to have it
>   before "Always set QoS params on QNoC"
> 
> - Limit ap_owned-independent QoS setting to QNoC only
> 
> - Add new patches for handling the 8996-and-friends clocks situation
>   and optional BIMC regardless-of-ap_owned QoS programming
> 
> 
> [1] https://lore.kernel.org/linux-arm-msm/14e06574-f95e-8960-0243-8c95a1c294e9@linaro.org/T/#m056692bea71d4c272968d5e07afbd9eb07a88123
> [2] https://lore.kernel.org/linux-arm-msm/20230110132202.956619-1-konrad.dybcio@linaro.org/
> 
> This series grew quite a bit bigger than the previous [1] attempt, so
> I decided to also add a cover letter.
> 
> Link to v2: [2]
> 
> It addresses a few things that were not quite right:
> 
> - Setting QoS params before a "real" (non-zero) bandwidth request
>   makes little sense (since there's no data supposed to flow through
>   the bus, why would the QoS matter) and (at least newer) downstream
>   prevents that from happening. Do the same in Patch 1.
> 
> - QNoC type buses expect to always have their QoS registers set as long
>   as there's a non-INVALID QoS mode set; ap_owned is not really a thing
>   on these anymore, Patch 3 handles that.
> 
> - The recent MSM8996 boot fix was done quickly and not quite properly,
>   leading to possibly setting the aggregate bus rate on "normal"
>   hardware interface clocks; this series handles that by limiting the
>   number of bus_clocks to 2 (which is the maximum that makes sense,
>   anyway) and handling the rest as "intf_clocks", which are required
>   to access the   hardware at the other end. Patches 5-8 take care of
>   that and Patch 10 reverts the _optional moniker in clk_get_ to make
>   sure we always have the bus scaling clocks, as they're well, kind
>   of important ;)
> 
> - Similarly to QNoC, BIMC on "newer" (which can be loosely approximated
>   by "new enough" == "has only BIMC and QNoC hosts") SoCs expects to
>   always receive QoS programming, whereas BIMC on "older" SoCs cries
>   like a wild boar and crashes the platform when trying to do so
>   unconditionally. Patch 9 adds a way to take care of that for newer
>   SoCs (like SM6375)
> 
> - QoS mode INVALID was assumed by developers before to be the default
>   ("I didn't specify any QoS settings, so the driver can't assume I
>   did.. right? right!?" - wrong, partial struct initialization led to
>   0 being set and 0 corresponded to QoS mode FIXED). Make it so, as
>   that's the logical choice. This allows the "Always set QoS params
>   on QNoC" patch to work without setting tons of what-should-
>   -obviously-be-the-default values everywhere, as well as fixes older
>   drivers that set ap_owned = true but left the QoS mode field unset.
>   Patch 2 cleans that up.
> 
> - Some nodes are physically connected over more than one channel
>   (usually DDR or other high-throughput paths). Patch 4 allows that
>   to be reflected in calculations. This will be required for at least
>   MSM8998 and SM6375 (which will be submitted soon after this lands)
> 
> 
> Konrad Dybcio (12):
>   interconnect: qcom: rpm: make QoS INVALID default, separate out driver
>     data
>   interconnect: qcom: rpm: Add support for specifying channel num
>   interconnect: qcom: Sort kerneldoc entries
>   interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
>   interconnect: qcom: rpm: Rename icc provider num_clocks to
>     num_bus_clocks
>   interconnect: qcom: rpm: Handle interface clocks
>   interconnect: qcom: icc-rpm: Allow negative num_bus_clocks
>   interconnect: qcom: msm8996: Specify no bus clock scaling on A0NoC
>   interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks
>     anymore
>   interconnect: qcom: msm8996: Promote to core_initcall
>   interconnect: qcom: icc-rpm: Introduce keep_alive
>   interconnect: qcom: icc-rpm: Allow negative QoS offset
> 
>  drivers/interconnect/qcom/icc-rpm.c | 101 ++++++++++++++++++++--------
>  drivers/interconnect/qcom/icc-rpm.h |  41 +++++++----
>  drivers/interconnect/qcom/msm8996.c |  35 ++++++----
>  drivers/interconnect/qcom/sdm660.c  |  16 ++---
>  4 files changed, 126 insertions(+), 67 deletions(-)
> 
