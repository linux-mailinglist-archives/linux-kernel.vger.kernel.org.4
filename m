Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B96C4499
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCVIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCVIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:05:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466A4C6D7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:05:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t11so22279735lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679472323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyzrL4k/tk1hdwYRkMYQZXDDLGhznLRsEI2TGZxmALg=;
        b=p6fnLlXWRXuN4NI2/dUIXu4CqtUMZrzkLozQt3wrBQH5luwG0/kDPTcRLjnweQ2gip
         B8nrlPdiECaEcqUiTvxUhD4Ve+q+WXlVwrLTB5/SSOt8DXqwIKXt9Xj767cs92okz+ee
         RvrG8D9X1Rron3rR3cYX2/AqorCssE0q0RDTf6Z3yW3wa/24b0Hb0oYhtJQ/huZq4WVn
         WKAGvI72CdJqr+em/NbfhiCPB9dVJSWzcVm3DAHucLX8axl0Bg5k6OZeV83Gmgxg+MiT
         0Jg+5ZPWbFLCpTv0BuCi8lwhvxv/9nFwfCkzzl0oJRyPxSF6TAmf9hCjwhoko2p/CMHh
         tBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyzrL4k/tk1hdwYRkMYQZXDDLGhznLRsEI2TGZxmALg=;
        b=322KQ9UbBPT88ySySk9EF5XSr4AZl39K9k8SIXCH5vxnQ7u6oaognySrbuKopAeN+z
         3D8/lC078ZxWD9nUemHTWguymzPAdeSB+P4eA/AIS0YyNYmtYQdOYxD0vw5+abIK1yWw
         fWHKIuXe4shQFVnCDh4nWxWyCttHZTBTFf+jJEnTSRBcM/IH7ej94aEhv/JpxHr+63yD
         ihMrMVmHOtzjPkXSjCUXey2Sowfg29q0/mz6jWjwtpQoEn2qlQLDSHTyJDmBNwb55UWe
         EZ3kVqdvwmabMc1jKyr86JutCJLbz7DOCTgLmm/YfIXoF/1QsyndVUuMZNJQIdhC4Idt
         V03w==
X-Gm-Message-State: AO0yUKU0hI2v/ShOOGWfqpXpaozMsYO/rRDGkx2Cmpv5ujKJ0LeYEDSd
        kpmSVtEzARzE6/0jR+5PmFT/FQ==
X-Google-Smtp-Source: AK7set/lc0mVMjFlV70JQxo9fEsD0Siv54L0CiaCfzcKXtUwJVpIG8srorElON3TPwY1YgvnILYpZw==
X-Received: by 2002:ac2:5458:0:b0:4d8:8af4:3b2c with SMTP id d24-20020ac25458000000b004d88af43b2cmr1872059lfn.68.1679472323449;
        Wed, 22 Mar 2023 01:05:23 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id j19-20020a19f513000000b004e84b79de9bsm2512923lfb.254.2023.03.22.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:05:22 -0700 (PDT)
Message-ID: <ad7c810a-1915-d112-7d5f-83ebd57a2500@linaro.org>
Date:   Wed, 22 Mar 2023 09:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFT v2 11/14] clk: qcom: smd-rpm: Hook up PCNoC_0
 keep_alive
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-11-ae80a325fe94@linaro.org>
 <20230322031928.vugzh4de2yecd5j2@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230322031928.vugzh4de2yecd5j2@ripper>
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



On 22.03.2023 04:19, Bjorn Andersson wrote:
> On Wed, Mar 08, 2023 at 10:35:27PM +0100, Konrad Dybcio wrote:
>> 14 [1] of our 18 supported platforms need an active keepalive vote on
>> PCNoC_0 so as not to cause havoc on the entire SoC. Guarantee that.
>>
> 
> Given that these are all clocks for peripheral (or peripheral & config)
> noc clocks, doesn't this just ensure that the running CPU is able to
> reach something on the peripheral bus?
> 
> That is, are you encoding a active-only keep-alive interconnect path?
> Could we somehow express that using the interconnect driver on top
> instead?
Qualcomm downstream has a different notion of "keep_alive" on the msm_bus
side, which is basically:

if (bus->keepalive)
	active_vote_freq = max(19200000, aggregated_rate);

Considering that they're doing essentially the same thing, I suppose both
periph/config NoC could be enabled there instead.

Konrad

> 
> Regards,
> Bjorn
> 
>> [1] there are 13 changes to driver data, but 8226 reuses 8974.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/clk/qcom/clk-smd-rpm.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>> index 8e25b3d7d30c..a44b52bd0c83 100644
>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>> @@ -500,6 +500,7 @@ DEFINE_CLK_SMD_RPM(aggre1_noc, QCOM_SMD_RPM_AGGR_CLK, 1);
>>  DEFINE_CLK_SMD_RPM(aggre2_noc, QCOM_SMD_RPM_AGGR_CLK, 2);
>>  
>>  DEFINE_CLK_SMD_RPM_BUS(pcnoc, 0);
>> +DEFINE_CLK_SMD_RPM_BUS_KEEP_ALIVE(pcnoc, 0);
>>  DEFINE_CLK_SMD_RPM_BUS(snoc, 1);
>>  DEFINE_CLK_SMD_RPM_BUS(sysmmnoc, 2);
>>  DEFINE_CLK_SMD_RPM_BUS(cnoc, 2);
>> @@ -558,7 +559,7 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk3, 13, 19200000);
>>  
>>  static struct clk_smd_rpm *msm8909_clks[] = {
>>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
>> @@ -592,7 +593,7 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8909 = {
>>  
>>  static struct clk_smd_rpm *msm8916_clks[] = {
>>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
>> @@ -626,7 +627,7 @@ static struct clk_smd_rpm *msm8936_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
>> @@ -660,7 +661,7 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8936 = {
>>  
>>  static struct clk_smd_rpm *msm8974_clks[] = {
>>  	[RPM_SMD_PNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_CNOC_CLK]		= &clk_smd_rpm_bus_2_cnoc_clk,
>> @@ -712,7 +713,7 @@ static struct clk_smd_rpm *msm8976_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>> @@ -746,7 +747,7 @@ static struct clk_smd_rpm *msm8992_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_OCMEMGX_CLK] = &clk_smd_rpm_ocmemgx_clk,
>>  	[RPM_SMD_OCMEMGX_A_CLK] = &clk_smd_rpm_ocmemgx_a_clk,
>>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>> @@ -804,7 +805,7 @@ static struct clk_smd_rpm *msm8994_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_OCMEMGX_CLK] = &clk_smd_rpm_ocmemgx_clk,
>>  	[RPM_SMD_OCMEMGX_A_CLK] = &clk_smd_rpm_ocmemgx_a_clk,
>>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>> @@ -864,7 +865,7 @@ static struct clk_smd_rpm *msm8996_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
>> @@ -918,7 +919,7 @@ static struct clk_smd_rpm *qcs404_clks[] = {
>>  	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
>>  	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
>>  	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>> @@ -948,7 +949,7 @@ static struct clk_smd_rpm *msm8998_clks[] = {
>>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>>  	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
>>  	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
>> @@ -1010,7 +1011,7 @@ static struct clk_smd_rpm *sdm660_clks[] = {
>>  	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
>>  	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
>>  	[RPM_SMD_CNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_CNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_CNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>>  	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
>>  	[RPM_SMD_MMSSNOC_AXI_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_clk,
>> @@ -1052,7 +1053,7 @@ static struct clk_smd_rpm *mdm9607_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
>>  	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
>>  	[RPM_SMD_QPIC_CLK]		= &clk_smd_rpm_qpic_clk,
>> @@ -1074,7 +1075,7 @@ static struct clk_smd_rpm *msm8953_clks[] = {
>>  	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
>>  	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
>>
>> -- 
>> 2.39.2
>>
