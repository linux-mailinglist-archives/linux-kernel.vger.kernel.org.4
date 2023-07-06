Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD0749F34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjGFOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjGFOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:40:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1AE1737
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:40:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso11759161fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688654444; x=1691246444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fBLCeyDV8gz5W8rqCS0f5i0nF2t1kzIX8PNOEa5TJA=;
        b=I14hGUZ/D+YDpVAsFMLxaW1D3IoTWnNRQl7SDQG6PS2cEh5BghGT5/l8qRWI1UoRJi
         sBQWDxNBy93o6VFCf3NMJdjSBqS44l7/t+MvgeYW5wprFNrn9P/hOHnDnPI5rzB+C2Ir
         0wDbLL302FKEsR/YBj2YQ7pWnFlOssCBQYsTYyKD9/VCe8h69Eqyqt0YjZPKjthZU+H+
         Xl5N8w/xvpDxWU1MEfnX8Q3ZlXn2LWh4hcofaKEsUuhLoNmdGjNkNHpBIAdKfcni/lgn
         Vv7cjckIVi4PJ4AU8XmKxL5e33mvoPw3yZHymp6Kl1bIkMfLN7dozBgk9uM8uLXVxcQk
         MPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688654444; x=1691246444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fBLCeyDV8gz5W8rqCS0f5i0nF2t1kzIX8PNOEa5TJA=;
        b=XuiSyhRBpi43UTQVhL0OUK7V43dxlmO/v1+m2jYLYheDJci3dTtXK3UQT1jpa5vnOp
         kpReNF3BoGMIQK37a2LAGlmicVZXxpSAI/fTJD9q0nxCPNh/GavM0UXtiHJRV5/exl/k
         4+5mu/ecTLc3DvcWAoapEm2uXqbrJIc/14dPQIlxSmLtMELY/gcjB10JYRRazn7zoKII
         6rxkK1w4mhPLcGbRhD/2x3BfSV+905XLhsRGsIgG27E4WeDXT009erSL4ql5+JR6wFsS
         /9nP8vEwiSRLoMjZVPVcwwhdAVo9HQ2QdpB0ZFknvHsVrdL/36GeN6xs+8/LGAIcKxmc
         /w9g==
X-Gm-Message-State: ABy/qLY8VQC2zayCkFRiu9bZRrpjqT8QbbkFQhq0Gxs/R07jtfbrRtHo
        gwk/Ah6oKN3ba4jfLkZstraDvw==
X-Google-Smtp-Source: APBJJlGzDpCn7DV7462QvHiQ7X0BTfS5rvFJ8y//11eUDLorSCqrZ5fF7AS6HL3wWeeNrd77nANB5w==
X-Received: by 2002:a2e:800b:0:b0:2b6:cb0d:56ae with SMTP id j11-20020a2e800b000000b002b6cb0d56aemr1377202ljg.11.1688654444059;
        Thu, 06 Jul 2023 07:40:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651c102900b002b6e973f8cfsm345862ljm.36.2023.07.06.07.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:40:43 -0700 (PDT)
Message-ID: <34b300ea-072a-5c70-904f-db85ff963f3a@linaro.org>
Date:   Thu, 6 Jul 2023 16:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: Allow PCIe GDSCs to enter
 retention state
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230706140842.18059-1-manivannan.sadhasivam@linaro.org>
 <ZKbM4vLpk_T3cGWC@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZKbM4vLpk_T3cGWC@hovoldconsulting.com>
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

On 6.07.2023 16:17, Johan Hovold wrote:
> On Thu, Jul 06, 2023 at 07:38:42PM +0530, Manivannan Sadhasivam wrote:
>> With the minimal system suspend support in place for the PCIe driver that
>> keeps the interconnect path voted, the ALWAYS_ON flag can now be dropped.
>>
>> Also, the PWRSTS_RET_ON flag should be used to allow the GDSCs to enter the
>> retention state when the parent domain get's turned off during system
>> suspend.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>
>> Changes in v2:
>>
>> * Changed the patch from simple revert to changing the ALWAYS_ON flag to
>>   PWRSTS_RET_ON.
>>
>>  drivers/clk/qcom/gcc-sc8280xp.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
>> index 04a99dbaa57e..c59b0f91c87d 100644
>> --- a/drivers/clk/qcom/gcc-sc8280xp.c
>> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
>> @@ -6786,7 +6786,7 @@ static struct gdsc pcie_2a_gdsc = {
>>  		.name = "pcie_2a_gdsc",
>>  	},
>>  	.pwrsts = PWRSTS_OFF_ON,
>> -	.flags = VOTABLE | ALWAYS_ON,
>> +	.flags = VOTABLE | PWRSTS_RET_ON,
>>  };
> 
> This is not correct either. PWRSTS_RET_ON is a pwrsts mask...
This + please rebase atop that:

https://lore.kernel.org/linux-arm-msm/20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org/

Konrad
> 
> Johan
