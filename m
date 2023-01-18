Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C0671DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjARNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjARNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:23:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33E11E80
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:50:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so1319007wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6UofrQemZ4+eX1QPPo3KJD1icPLPcDXcolqW+JUoFQ=;
        b=Cuq7EjnurKOrCWygPW2yM9RPlSaKj8NbC5g3CcHISAxiBoQTfL0TxFoby3SalLb0en
         xdJ1dNFPlaVmAyovwRg26cBcjDQX+IK98f1YU/m5Jhq6HmeXtkK5ElIh83pdeHU8UInm
         EIjJw1DMRk3dEm0iTYdO4H/KyEUutsz/7yGkO8u+sK9PdQCMPS8/DKdIfdrC9E2HcbRA
         9CtuZ0M0R5tuR6HWeak7YE/I3dX2k1WfkNeOclyM6G11fTTMkDmehN9Otic4mn5uD+r+
         uG5Qg7VIT0C4pMH79BAOqveRsMP6E1NKDde0LCcfvQVJ2wbAZ2FAvLIMZRnAyPhWug4C
         6kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6UofrQemZ4+eX1QPPo3KJD1icPLPcDXcolqW+JUoFQ=;
        b=5MRg3FPDJm4GoNRetbZNHkucoQfA0sqWeySz/jy97uqBaqb2NrJqUm6caURZXyqm7X
         pIviwSeHyyJS+Sks2bL0Gb2wKE51KO2FQ9wfyvKmWxwhuqjIONn6asuWL98SHvw0Vfzo
         Igm4XXfaOW8k2RoJspqnUN5k9VSHwy0fkRR3Yue2RyREldrBsYolp4wO4YwVLKkANcQD
         kp8FyR88TC4Uh7BWKJeMVUlWYtN689tNmsAgSqzNUS//IqoFgHcXEveJ/RqgmJV+clrL
         KMo6DaY7oPGFmyfFmMwOAYplUa70fC6CtuHINv4nuI50V2ab9aas6R046O3Q9IaLl5Js
         Aihg==
X-Gm-Message-State: AFqh2kotpd69BwrH8QjeIYfZlUxv8FsN0Viz6E2vZl/YMwjdNJBJtrgM
        RmGb97kXqep2PrC6StnjWp9Wsw==
X-Google-Smtp-Source: AMrXdXtQ0z5537FCj9ntjVW+joNiKI3tv3JZd/zlO+3v+/CSF+vqDDmlfBlrEksX79ozb6+vGn0Jiw==
X-Received: by 2002:a05:600c:3d10:b0:3da:e4c:2a3c with SMTP id bh16-20020a05600c3d1000b003da0e4c2a3cmr6874947wmb.41.1674046255745;
        Wed, 18 Jan 2023 04:50:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003cfd4e6400csm2114848wms.19.2023.01.18.04.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:50:55 -0800 (PST)
Message-ID: <8a704b63-9ef1-ed4d-3ee5-35ebfd2a2318@linaro.org>
Date:   Wed, 18 Jan 2023 12:50:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <Y8fC/GCHfENQmBNC@gerhold.net>
 <cf4920e6-c007-20a5-ba3a-5005b22f891b@linaro.org>
In-Reply-To: <cf4920e6-c007-20a5-ba3a-5005b22f891b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 11:50, Bryan O'Donoghue wrote:
>>> +                clocks = <&gcc GCC_MDSS_MDP_CLK>,
>>> +                     <&gcc GCC_MDSS_AHB_CLK>,
>>> +                     <&gcc GCC_MDSS_AXI_CLK>,
>>> +                     <&gcc GCC_MDSS_BYTE1_CLK>,
>>> +                     <&gcc GCC_MDSS_PCLK1_CLK>,
>>> +                     <&gcc GCC_MDSS_ESC1_CLK>;
>>> +                clock-names = "mdp_core",
>>> +                          "iface",
>>> +                          "bus",
>>> +                          "byte",
>>> +                          "pixel",
>>> +                          "core";
>>> +                assigned-clocks = <&gcc BYTE1_CLK_SRC>,
>>> +                          <&gcc PCLK1_CLK_SRC>;
>>> +                assigned-clock-parents = <&dsi_phy1 0>,
>>> +                             <&dsi_phy1 1>;
>>
>> Does this work? Confusingly, BYTE1/PCLK1_CLK_SRC can only have dsi0pll
>> as parent in gcc-msm8939 and not the dsi1pll. <&dsi_phy1 0/1> is not a
>> valid parent for those clocks.
> 
> No you're right, its all wrong. I will correct it
> 
>          mdss_dsi0: qcom,mdss_dsi@1a98000 {
>                  compatible = "qcom,mdss-dsi-ctrl";
>                  label = "MDSS DSI CTRL->0";
>                  cell-index = <0>;
>                  reg = <0x1a98000 0x25c>,
>                        <0x1a98500 0x2b0>,
>                        <0x193e000 0x30>;
>                  reg-names = "dsi_ctrl", "dsi_phy", "mmss_misc_phys";
>                  qcom,mdss-fb-map = <&mdss_fb0>;
>                  qcom,mdss-mdp = <&mdss_mdp>;
>                  gdsc-supply = <&gdsc_mdss>;
>                  vdda-supply = <&pm8916_l2>;
>                  vdd-supply = <&pm8916_l17>;
>                  vddio-supply = <&pm8916_l6>;
>                  clocks = <&clock_gcc clk_gcc_mdss_mdp_clk>,
>                           <&clock_gcc clk_gcc_mdss_ahb_clk>,
>                           <&clock_gcc clk_gcc_mdss_axi_clk>,
>                           <&clock_gcc_mdss clk_gcc_mdss_byte0_clk>,
>                           <&clock_gcc_mdss clk_gcc_mdss_pclk0_clk>,
>                           <&clock_gcc clk_gcc_mdss_esc0_clk>;

Sorry what am I saying that's the wrong dsiX

Here's downstream - byte1, plck1, esc1 exist

         mdss_dsi1: qcom,mdss_dsi@1aa0000 {
                 compatible = "qcom,mdss-dsi-ctrl";
                 label = "MDSS DSI CTRL->1";
                 cell-index = <1>;
                 reg = <0x1aa0000 0x25c>,
                       <0x1aa0500 0x2b0>,
                       <0x193e000 0x30>;
                 reg-names = "dsi_ctrl", "dsi_phy", "mmss_misc_phys";
                 qcom,mdss-fb-map = <&mdss_fb0>;
                 qcom,mdss-mdp = <&mdss_mdp>;
                 gdsc-supply = <&gdsc_mdss>;
                 vdda-supply = <&pm8916_l2>;
                 vdd-supply = <&pm8916_l17>;
                 vddio-supply = <&pm8916_l6>;
                 clocks = <&clock_gcc clk_gcc_mdss_mdp_clk>,
                          <&clock_gcc clk_gcc_mdss_ahb_clk>,
                          <&clock_gcc clk_gcc_mdss_axi_clk>,
                          <&clock_gcc_mdss clk_gcc_mdss_byte1_clk>,
                          <&clock_gcc_mdss clk_gcc_mdss_pclk1_clk>,
                          <&clock_gcc clk_gcc_mdss_esc1_clk>;
                 clock-names = "mdp_core_clk", "iface_clk", "bus_clk",
                                 "byte_clk", "pixel_clk", "core_clk";


Parent clock is gpll0a but they waggle different rcgr addresses

static struct clk_rcg2 byte0_clk_src = {
         .cmd_rcgr = 0x4d044,    <- here
         .hid_width = 5,
         .parent_map = gcc_xo_gpll0a_dsibyte_map,
         .clkr.hw.init = &(struct clk_init_data){
                 .name = "byte0_clk_src",

static struct clk_rcg2 byte1_clk_src = {
         .cmd_rcgr = 0x4d0b0,    <- and here
         .hid_width = 5,
         .parent_map = gcc_xo_gpll0a_dsibyte_map,
         .clkr.hw.init = &(struct clk_init_data){
                 .name = "byte1_clk_src",

It *should* work even with the wrong name but, I will send a GCC update 
to address the naming, which looks wrong.

---
bod
