Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C664DBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLOM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLOM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:58:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D8C2B25E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:58:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so15550714lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIBwRolseRlQyxesY8sTAQheK8aBa7/oVUq9/enWQ6o=;
        b=Q94t3/KzkXkpPxJQbOmE4YrSLR4zyV9SKQQ5qn8rYnyfP3hqi/Jbmapgdc2cW2eZn/
         dbgbAln8lgnMtm87aS1BAKVl4yrUSZCju8EPEgdovlbOUgrFxscGvKWqSyk149jEUAUP
         OwXwfKb+2h58VfNr5pBwW6F+o0o+OMlJaXoArnK2czv6mjh1sHljJ1A39d5t3r3kGDcy
         mrpAqNDZZbC6sghskoxhfDa4YJeODl/BT0NGISbVscZXr3ZIKtm6rps5KKxz8Qm10mWf
         JymXVEiWtTWVmHr7Oz8nDDEJtB9Trk7srt8HcgyyOw6OVXecHGXCbz0DURA+oJacrfLd
         YFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIBwRolseRlQyxesY8sTAQheK8aBa7/oVUq9/enWQ6o=;
        b=rJ3U7W2mqPjBhwRx64VfSim3JSJPF5z82Pe2THSjSgtYEMTNeVmesG+nWAhn81lgZu
         sh15vVQ3YwD6GMoPvbZJ0NfiM+MCLs2/USMOInqKEAsA6dGbppO5CE7CS8QNsHmCRZcT
         UG56fmDKOX6sjOBzoF+F6xSSitaYVoTNzcgarlSnqPd2/l/1U2kPXwdUrg8HThp0P562
         3J5FeEUdzbJbhOz1RAciB8QUrtMCAclgpzSXN32KM96ChEYi9IaCxMD5WKfxHgupw1+p
         YjIn128VfJlOsAXtyMp3AOy2ybLXj7wi0Ezh5eiMUGkFTtBT8/gdYmxLXwn1giWeXl/c
         xeiA==
X-Gm-Message-State: ANoB5pm1RVn2njJ76wV1hmih8eiub231CizweEjWh1IVenilsxJuGclC
        ugI3e+6MEYvNem+JZukwFlA5qw==
X-Google-Smtp-Source: AA0mqf5lS3Xg1ExI6CuNoOnR7UBnh+b2wCihPjNodluWrl40i+A4uDDPNweEHXPPM3mrcBx50SvS8g==
X-Received: by 2002:a05:6512:151a:b0:4b2:28c7:b2bb with SMTP id bq26-20020a056512151a00b004b228c7b2bbmr10333773lfb.1.1671109122388;
        Thu, 15 Dec 2022 04:58:42 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id r7-20020ac24d07000000b004aab0ca795csm1146606lfi.211.2022.12.15.04.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:58:41 -0800 (PST)
Message-ID: <c0d65eb4-8dfd-7f77-b130-953fb3539336@linaro.org>
Date:   Thu, 15 Dec 2022 13:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] clk: qcom: dispcc-sm6115: Shrink single-parent
 definitions
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213104333.27548-1-konrad.dybcio@linaro.org>
 <20221213222421.7B112C433D2@smtp.kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213222421.7B112C433D2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 23:24, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2022-12-13 02:43:33)
>> @@ -284,12 +268,13 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
>>         .cmd_rcgr = 0x20a4,
>>         .mnd_width = 0,
>>         .hid_width = 5,
>> -       .parent_map = disp_cc_parent_map_1,
>>         .freq_tbl = ftbl_disp_cc_mdss_esc0_clk_src,
>>         .clkr.hw.init = &(struct clk_init_data){
>>                 .name = "disp_cc_mdss_vsync_clk_src",
>> -               .parent_data = disp_cc_parent_data_1,
>> -               .num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
>> +               .parent_data = &(const struct clk_parent_data){
>> +                       .index = DT_BI_TCXO,
>> +               },
>> +               .num_parents = 1,
>>                 .flags = CLK_SET_RATE_PARENT,
>>                 .ops = &clk_rcg2_shared_ops,
> 
> Is clk_rcg2_shared_ops and clk_rcg2_ops prepared for a NULL
> 'parent_map' pointer? _freq_tbl_determine_rate() is never called?
I didn't notice any regressions empirically, but perhaps it was
just by luck, you're right, disregard this patch..

Konrad
