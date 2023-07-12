Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB687507FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGLMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGLMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:18:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B3FB0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:18:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so8904211fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164320; x=1691756320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRzOGtPl93LqwIcit/8B2J8xTg5w549lcCceqtPK13c=;
        b=tCDrJCD89Wt0gVMdSNhPrGqhUsTLlpFiDzPiy56glkjoByl9oQOJwPYyb4wDnToVd6
         fi47x/wQz9S3njsxCWSqaRT1P4iwEdtMnD1XcGujLV6u1+RZOSHGwU7JOvYafFzjWdm9
         SE3t7IhLbEdpCxYM6Cr+mi2OPJenJwUR5tQ/EYLjDLQC5tjhzYQmjG76SEY0g6Fh3l5z
         nZfkZOpvco9XJg9fL5149zPzCGC0REejpnVteJVrKd1A2n+ueKnLvSMxuue/r3wtb1v8
         Es+B+rZ0OgrUiPynYJdivI00s+xS5ovkE4J2VyKexlqGsYBr5+sVp8nkrRJmAY/eLkUk
         QUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164320; x=1691756320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRzOGtPl93LqwIcit/8B2J8xTg5w549lcCceqtPK13c=;
        b=BHl3aayrtMuy6bd7opH1Wxq+YRVGi5B8ROrRe+OgctjEfsaztHGnUYlqvmsJRFC6TM
         SUuDn3Tv9Qj82wYD3zKKzRVvVSu5YROFr7FUpeVVoaEUzTpSfMJHHcVYElM1ge4BsiSd
         k5j+UqtH/7+0uWUwMBqk5qLwJLebrkkSXs3mWsmSQXOkRsmjqHHUK9P63h9JLX3lfKl6
         qOcwcnWPWeRRKjVqCl3yQNcTsO9pKzuSHpYk8yktJItjGZJGgXpeVN4Q6qp1hg9wVhJH
         GrFGiPgx5EFzxwIEc8lRvQvV+aQFDxq0PkZ7b6DMIWMRPrsWCdr8CU3HrzeWqoU200V8
         Qsuw==
X-Gm-Message-State: ABy/qLZiwuIqkdJ8Mpm7AVNUu4Fhaq8OsALMfZhMfSE3Zhwj3Go07tJH
        ro9w/da9ptl0bM0ZltWNnYNmrg==
X-Google-Smtp-Source: APBJJlEy3ljbiuF/7Y5CJsnpdfh++Sek1AynGnWFOwY7diqxzJeX/scCNlJvvMlSZusU620MBmKZnw==
X-Received: by 2002:a2e:9f08:0:b0:2b4:677e:1433 with SMTP id u8-20020a2e9f08000000b002b4677e1433mr706188ljk.5.1689164319762;
        Wed, 12 Jul 2023 05:18:39 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y21-20020a2e95d5000000b002b6d4a63cfdsm940990ljh.42.2023.07.12.05.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:18:39 -0700 (PDT)
Message-ID: <3523988f-fa51-ce44-ded7-9f3c7acbf65e@linaro.org>
Date:   Wed, 12 Jul 2023 15:18:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/14] UFS: Add OPP and interconnect support
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712104044.GA102214@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712104044.GA102214@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:40, Manivannan Sadhasivam wrote:
> On Wed, Jul 12, 2023 at 04:01:55PM +0530, Manivannan Sadhasivam wrote:
>> Hi,
>>
>> This series adds OPP (Operating Points) support to UFSHCD driver and
>> interconnect support to Qcom UFS driver.
>>
> 
> Missed to cc SCSI folks. Will be resending this series. Sorry for the noise.

I'd say, there is a need for the resend anyway, the series got duplicate 
patch indices.

> 
> - Mani
> 
>> Motivation behind adding OPP support is to scale both clocks as well as
>> regulators/performance state dynamically. Currently, UFSHCD just scales
>> clock frequency during runtime with the help of "freq-table-hz" property
>> defined in devicetree. With the addition of OPP tables in devicetree (as
>> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
>> both clocks and performance state of power domain which helps in power
>> saving.
>>
>> For the addition of OPP support to UFSHCD, there are changes required to
>> the OPP framework and devfreq drivers which are also added in this series.
>>
>> Finally, interconnect support is added to Qcom UFS driver for scaling the
>> interconnect path dynamically. This is required to avoid boot crash in
>> recent SoCs and also to save power during runtime. More information is
>> available in patch 13/13.
>>
>> Credits
>> =======
>>
>> This series is a continuation of previous work by Krzysztof Kozlowski [1]
>> and Brian Masney [2]. Ideally, this could've split into two series (OPP
>> and interconnect) but since there will be a dependency in the devicetree,
>> I decided to keep them in a single series.
>>
>> Testing
>> =======
>>
>> This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
>> development boards.
>>
>> Merging Strategy
>> ================
>>
>> An immutable branch might be required between OPP and SCSI trees because of
>> the API dependency (devfreq too). And I leave it up to the maintainers to
>> decide.
>>
>> Thanks,
>> Mani
>>
>> [1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/
>> [2] https://lore.kernel.org/all/20221117104957.254648-1-bmasney@redhat.com/
>>
>> Krzysztof Kozlowski (2):
>>    dt-bindings: ufs: common: add OPP table
>>    arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
>>
>> Manivannan Sadhasivam (12):
>>    dt-bindings: opp: Increase maxItems for opp-hz property
>>    arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
>>    arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
>>    arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
>>    OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
>>    OPP: Introduce dev_pm_opp_get_freq_indexed() API
>>    PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
>>      APIs
>>    scsi: ufs: core: Add OPP support for scaling clocks and regulators
>>    scsi: ufs: host: Add support for parsing OPP
>>    arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
>>    arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
>>    scsi: ufs: qcom: Add support for scaling interconnects
>>
>>   .../devicetree/bindings/opp/opp-v2-base.yaml  |   2 +-
>>   .../devicetree/bindings/ufs/ufs-common.yaml   |  34 ++++-
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  47 ++++--
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  43 ++++--
>>   drivers/devfreq/devfreq.c                     |  14 +-
>>   drivers/opp/core.c                            |  76 ++++++++++
>>   drivers/ufs/core/ufshcd.c                     | 142 ++++++++++++++----
>>   drivers/ufs/host/ufs-qcom.c                   | 131 +++++++++++++++-
>>   drivers/ufs/host/ufs-qcom.h                   |   3 +
>>   drivers/ufs/host/ufshcd-pltfrm.c              | 116 ++++++++++++++
>>   include/linux/pm_opp.h                        |  26 ++++
>>   include/ufs/ufshcd.h                          |   4 +
>>   12 files changed, 574 insertions(+), 64 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> 

-- 
With best wishes
Dmitry

