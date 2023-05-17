Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD4706E04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjEQQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:21:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086AD2C9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:21:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f14468ef54so1251205e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684340477; x=1686932477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChIVfbdP674iihHLcCeQgumGx8yk3INFc1OPHf7Gp3M=;
        b=o5+4zGG4vLM3JtsbCVaRv8icO5k4KRyaqLIgm4nNXIEa3NKvVHVNNQ/LQBBsttlcoi
         yHI9soeCj9MPwYzd2qtoP6IyGy1vWUMCpgxOyPXuCVHN8bXONHBEt/213Xy/8Xgezaam
         pQy1ExSn4egGCGveDIgH/YbJ6HdA+PybZnIMZ+c81NseZLUJYelYJGsbSrpIlcnGcM8U
         HJ1kp3Reo9erF5wOFwg+7njtC7+42Ady7kWCYjh3TkcwimZKnnelxqz6kjTFAq7TVyy8
         HxK6fRRFPbwkOEnTqHJlUDHbgYoCVeaf1xx2csw3GRi8NJ5li8cNDXDr3LwoZ6VWI2KO
         tkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340477; x=1686932477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChIVfbdP674iihHLcCeQgumGx8yk3INFc1OPHf7Gp3M=;
        b=HTLOo5BUJh/VXUVNZzOwAVg1cmjlq521IPrZppREpyk4B1BIi+itODyktIapvoB6p6
         r16aw5anGE80A0TQDz7rh1P4w8hO/pIMjBeRiYLjj/Al/mGyN72UOvA/f9XaNPktxcOw
         omtekMINJUqKB/qJxk+4zwUNjcyCMxnL8op8MPP0pwWLpQQInMPpGnH99OSGI1QGT0XH
         Fx0z+WloQT5a/x+u9vNJTbwGDaF0O1xD2q50aY/IXDX1viABbhNuN1czoRgUX0G5JLkM
         xzontvX5JF0jN1hv1pUXOAo8/limQOCAWE0romsRvlk03/ll1wQ1BNWslh71laI+K1xp
         mJJQ==
X-Gm-Message-State: AC+VfDwaxNCmpatF7lEzuOqcONVCl6PVV9WHTY6SMiX6SZhDMJ1Ekzy8
        NL0gYKntWriMvum5MV+DGRvcEA==
X-Google-Smtp-Source: ACHHUZ7Kx9X9WbzBlqUy7R10/6IiExFzx1PtsoTdz59PYW4PPh2JL61/9upryDyHc2SoeR4gUWLw/w==
X-Received: by 2002:ac2:596e:0:b0:4ef:eeaa:e9b9 with SMTP id h14-20020ac2596e000000b004efeeaae9b9mr387519lfp.35.1684340477151;
        Wed, 17 May 2023 09:21:17 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id k27-20020ac257db000000b004e95f53adc7sm3433962lfo.27.2023.05.17.09.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:21:16 -0700 (PDT)
Message-ID: <95f36218-c0eb-eb69-696d-044fd72cf8c4@linaro.org>
Date:   Wed, 17 May 2023 18:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 0/8] The great interconnecification fixation
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.04.2023 22:14, Konrad Dybcio wrote:
> Hi!
Bump!

Konrad
> 
> v7 -> v8:
> - Rebase (dropping has_bus_pd, picked patches from v7)
> 
> - Clean up the QoS-setting functions [3/8]
> 
> - Only set the QoS registers once [4/8] - Georgi talked to some
>   Qualcomm folks and we concluded that it's "good enough" as they
>   should:tm: persist until a full reboot on "almost all" platforms
> 
> - Move the intf clock enabling/disabling to correspond with /\ [5/8]
> 
> - DO NOT switch to associating an interface clock with a given node
>   (instead of a provider), as it makes little sense with the changes
>   with [4/8] and the new iteration of [5/8]
> 
> v7: https://lore.kernel.org/r/20230228-topic-qos-v7-0-815606092fff@linaro.org
> 
> v6 -> v7 changelog:
> - Rebase on Johan's recent patches
> 
> Link to v6: https://lore.kernel.org/r/20230228-topic-qos-v6-0-3c37a349656f@linaro.org
> 
> v5 -> v6 changelog:
> - Completely rewrite the commit message of [1/9], I realized that there
>   was actually no issue with the present upstream setups and the only
>   drivers suffering from ghost votes were.. my own OOT drivers..
>   As a consequence of that, all fixes tags were dropped and the patch
>   has been kept, since it was deemed useful for newer SoCs that don't
>   distinguish ap_owned nodes.
> 
> - Change the number of allowed bus_clocks from (0-2 in the previous
>   revision, 0-inf in the current upstream state) to {0, 2}. Scaling is
>   only possible with a pair of wake-sleep clocks, but some providers
>   don't do scaling at all (see 8996 A0NoC, 660 GNoC). Drop the cheeky
>   -1 / 0 / >0 checks from the previous revision. [7/9]
> 
> - bus_clocks are now forced to be named "bus", "bus_a", as there is no
>   need for variance here - we don't do scaling on non-SMD RPM bus clocks.
>   [7/9]
> 
> - The interface clocks are now only turned on when the associated bus
>   is running at a non-zero frequency [6/9] instead of being always on
>   and leaking power
> 
> Tested on MSM8996 Kagura, SM6375 PDX225 (OOT), MSM8998 Maple (OOT)
> 
> Link to v5: https://lore.kernel.org/linux-arm-msm/20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org/
> 
> v4 -> v5 changelog:
> - Previously the "Always set QoS params on QNoC" contained part of what
>   should have been included in "make QoS INVALID default".. (very bad)
>   Fix it!
> 
> - Drop negative offset and keep_alive, they will be resubmitted with new
>   icc driver submissions
> 
> - use b4 this time.. hopefully the series gets to everybody now
> 
> Link to v4: https://lore.kernel.org/linux-arm-msm/20230214143720.2416762-1-konrad.dybcio@linaro.org/
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
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (8):
>       interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
>       interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
>       interconnect: qcom: rpm: Drop unused parameters
>       interconnect: qcom: rpm: Set QoS registers only once
>       interconnect: qcom: rpm: Handle interface clocks
>       interconnect: qcom: icc-rpm: Enforce 2 or 0 bus clocks
>       interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
>       interconnect: qcom: msm8996: Promote to core_initcall
> 
>  drivers/interconnect/qcom/icc-rpm.c | 110 +++++++++++++++++++-----------------
>  drivers/interconnect/qcom/icc-rpm.h |  22 ++++++--
>  drivers/interconnect/qcom/msm8996.c |  35 +++++++-----
>  drivers/interconnect/qcom/sdm660.c  |  17 +++---
>  4 files changed, 102 insertions(+), 82 deletions(-)
> ---
> base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
> change-id: 20230228-topic-qos-5435cac88d89
> 
> Best regards,
