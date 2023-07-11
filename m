Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F016E74F1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjGKOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGKOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:19:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F91FDC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:19:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9121231e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085138; x=1691677138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAR8uoRS5FeFiCTajslFQAyUKPeFFZ/CN3B41KSltDw=;
        b=d97S4hLpnXjrFoFoU/AkOiO/qJHeFCC1aynsEjVDi766PeqLIi8fwV7cZ82DLR+ZvL
         JtWpigPKYaAugw9CJXp2eFifoLcjkyHRWRWJRCYmoKV0R8kokLBsuWrSs2lexYPCmlfw
         0oIrCZJyxD64wfa2+nKEhMhfj1bALpL4jkIpR9poK/SCrIZd3KKJ7Nw/yK6r3gjwOiI5
         thCf3WP+HWYsD/jcSO1i/6KBS2vzi298aUGb+rDr2U+Ch6nF5jtLWIVKNW3+gV3k4UFJ
         idOMkQ/maXZxXbxUJPctnZbbxVxARJz5vmHKQliV8DHCUGkG6pcby5Z7ZpsyTZieVuDo
         FwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085138; x=1691677138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAR8uoRS5FeFiCTajslFQAyUKPeFFZ/CN3B41KSltDw=;
        b=Z8TtCfmVWwCquYcuu1VBpl8eg8ohk2o3FKx4WR4ayn6oEl+FdjHPKc0smWImo4wxrF
         vIB7qFyg2c/kMemiS4epUFqXTAQu0g768efh3aKDbPrtg2HLzw4bSQI2QlytTbGC8eBA
         2yHUbzYjouxzK66no64Y+F2IxD+4+91SoW0V66OJHR0BL/IoIponQCqJWPI2orvTum4r
         vsFOzuvGHM53wUeeBTt1zAmIRPDkIODS/wME7GkPcTKfTOCpKtnc8AmZRizDc1D36vAL
         1nioEhjHxGBWMf4cxK75GX+hwuZaubEt8GqJQ5v5RMMJ4C65k1oHepN0OyiwLaBgYwY4
         PVHA==
X-Gm-Message-State: ABy/qLbD6d7wRYSAmFEY1SfKF4IxO+NRKZPlTGAtpRDtabCKXZOjoMus
        s7d5N72e4B9H2ktXxJStzzbIew==
X-Google-Smtp-Source: APBJJlFXsE/uy86CosdLvo54rOBzSktc/fDik9wZm3dUuDKADi1O/apOggUYPfXWuFdwxjK5WWHlhA==
X-Received: by 2002:a05:6512:3d0f:b0:4f8:58ae:8ea8 with SMTP id d15-20020a0565123d0f00b004f858ae8ea8mr14672133lfv.58.1689085138276;
        Tue, 11 Jul 2023 07:18:58 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id j7-20020ac25507000000b004fb8fa4c7easm333584lfk.302.2023.07.11.07.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:18:57 -0700 (PDT)
Message-ID: <94c17171-0d97-35f0-d876-c705bf3ed864@linaro.org>
Date:   Tue, 11 Jul 2023 16:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 50/53] interconnect: qcom: sm8350: Point display paths to
 the display RSC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-50-b223bd2ac8dd@linaro.org>
 <849dcb13-8059-f50b-4f5c-d8946f7c598c@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <849dcb13-8059-f50b-4f5c-d8946f7c598c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 16:17, Dmitry Baryshkov wrote:
> On 11/07/2023 15:18, Konrad Dybcio wrote:
>> The _DISP paths are expected to go through the DISP RSC. Point them to the
>> correct place.
>>
>> Fixes: d26a56674497 ("interconnect: qcom: Add SM8350 interconnect provider driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/sm8350.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
>> index c48f96ff8575..0466ba5d939a 100644
>> --- a/drivers/interconnect/qcom/sm8350.c
>> +++ b/drivers/interconnect/qcom/sm8350.c
>> @@ -1609,7 +1609,7 @@ static struct qcom_icc_bcm bcm_sn14 = {
>>   static struct qcom_icc_bcm bcm_acv_disp = {
>>       .name = "ACV",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
> 
> Shouldn't this value come from a enum? Otherwise a magic '1' is... a magic.
Yep, rebase mess!

Konrad
> 
>>       .num_nodes = 1,
>>       .nodes = { &ebi_disp },
>>   };
>> @@ -1617,7 +1617,7 @@ static struct qcom_icc_bcm bcm_acv_disp = {
>>   static struct qcom_icc_bcm bcm_mc0_disp = {
>>       .name = "MC0",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
>>       .num_nodes = 1,
>>       .nodes = { &ebi_disp },
>>   };
>> @@ -1625,7 +1625,7 @@ static struct qcom_icc_bcm bcm_mc0_disp = {
>>   static struct qcom_icc_bcm bcm_mm0_disp = {
>>       .name = "MM0",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
>>       .num_nodes = 1,
>>       .nodes = { &qns_mem_noc_hf_disp },
>>   };
>> @@ -1633,7 +1633,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
>>   static struct qcom_icc_bcm bcm_mm1_disp = {
>>       .name = "MM1",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
>>       .num_nodes = 2,
>>       .nodes = { &qxm_mdp0_disp, &qxm_mdp1_disp },
>>   };
>> @@ -1641,7 +1641,7 @@ static struct qcom_icc_bcm bcm_mm1_disp = {
>>   static struct qcom_icc_bcm bcm_mm4_disp = {
>>       .name = "MM4",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
>>       .num_nodes = 1,
>>       .nodes = { &qns_mem_noc_sf_disp },
>>   };
>> @@ -1649,7 +1649,7 @@ static struct qcom_icc_bcm bcm_mm4_disp = {
>>   static struct qcom_icc_bcm bcm_mm5_disp = {
>>       .name = "MM5",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
>>       .num_nodes = 1,
>>       .nodes = { &qxm_rot_disp },
>>   };
>> @@ -1657,7 +1657,7 @@ static struct qcom_icc_bcm bcm_mm5_disp = {
>>   static struct qcom_icc_bcm bcm_sh0_disp = {
>>       .name = "SH0",
>>       .keepalive = false,
>> -    .voter_idx = 0,
>> +    .voter_idx = 1,
>>       .num_nodes = 1,
>>       .nodes = { &qns_llcc_disp },
>>   };
>>
> 
