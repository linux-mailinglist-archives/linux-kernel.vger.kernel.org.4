Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335D68B91D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBFJ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:57:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A441E294
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:56:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qw12so32589461ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJj/k7VvKB4xlcpK0a5yuk9dzigt45eXUdx0sQo6xgg=;
        b=qsDwnT0oPD/P9o4j2Duza8wQgvkzgjljScz9I+tN/nKujDiQV+aW2idzgUHMhiDIRw
         kSvSp5BvIHehlLXrJuuUpj7R7XDxorcbJluzCHIZBWTIIFNbV9qtgDZtzRWwp7Nja6bD
         ZonZx+Gq0SbVPwQmzv+frswq+zQz6Oj4TpygAw7PdswHd0MMrjgsveDNjyqbCGgXmQSA
         UkNFBDkWvCXANdEORQk7o4AsNc8/fMRQTQdVYdwZPx94e/7M2ys560OCWRIaN8+kiGLz
         VXDlCyPYesZ9OT/lxEeGpZJq09egPzmL1tJJm2tY7ZOV7OPptHaaDtAxOBD194xXzE6x
         C5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJj/k7VvKB4xlcpK0a5yuk9dzigt45eXUdx0sQo6xgg=;
        b=hKmaQz4kMF7ynOtlEYwfyte4XGI6YAa00gKo3EO0WOkyPxujazPOcTFaA0qphuf6ne
         UQAOqKXCb3sWY1g/7IV4VAKABIS1PwwpxNK48ln5BTDT7ioTTQPDBBOmBt0Vdr5TD77i
         VBIK087CdsyKl46z6ya0JmrgvsVVRElpcejiPfZdOQS3DX+FyfaalsZ9Nxys+DB3trdb
         bygqTRxGWdr7n/Vb06X13btle0sLYE4/KB4hm6ZxCmHTpoWnQ3vO2o0ox24ccY/u4T/5
         RFWtWlQgW4D7aP7dtz14UBs8LiRFdNI0FEEes80+ZdQkVrj5byeAIdeQn/WulbqaxL/l
         6+BQ==
X-Gm-Message-State: AO0yUKUp/hjdQIcVKmoy85iPkWphjReAO5P7dDd+TLhYp7/40YD8s8pb
        BC7FFvTTsKCDGH3gKQEeVNvbjg==
X-Google-Smtp-Source: AK7set9ed2vVoyml5BfH5/wSW2iJo5CiLQLMjz3SsKgWAyxlXEuXJJunTyNp1nw51Xm2O2bhzTeTdA==
X-Received: by 2002:a17:906:135a:b0:881:d1ad:1640 with SMTP id x26-20020a170906135a00b00881d1ad1640mr18385618ejb.57.1675677418125;
        Mon, 06 Feb 2023 01:56:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id j2-20020a1709066dc200b008787e94c5ccsm5206943ejt.184.2023.02.06.01.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 01:56:57 -0800 (PST)
Message-ID: <019bf6ae-cdc4-8fa7-4d76-c39403d93b34@linaro.org>
Date:   Mon, 6 Feb 2023 11:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 5/9] clk: qcom: add Global Clock controller (GCC)
 driver for IPQ5332 SoC
Content-Language: en-GB
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        nfraprado@collabora.com, robimarko@gmail.com,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-6-quic_kathirav@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230206071217.29313-6-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 09:12, Kathiravan T wrote:
 > Add support for the global clock controller found on IPQ5332 SoC.
 >
 > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
 > ---
 > Changes in V3:
 >     - As I mentined the bindings, changes need to be done in V2 got
 >       missed out and same has been done in V3, to call out
 >       specifically dropped the CLK_IS_CRITICAL and dropped the
 >       gcc_apss_ahb_clk, its source clock and gcc_apss_axi_clk
 >     - Used gcc_parent_data_xo wherever applicable and dropped the
 >       duplicate entries
 >     - dropped the unused parent_map_10 and parent_data_10
 >     - Used qcom_cc_probe instead of qcom_cc_really_probe
 > Changes in V2:
 >     - Added the 'dependes on' for Kconfig symbol
 >     - Dropped the CLK_IS_CRITICAL flag throughout the file
 >     - Dropped the gcc_apss_ahb_clk and gcc_apss_axi_clk as these are
 >       managed by bootloaders


[skipped]

 > +static const struct freq_tbl ftbl_gcc_pcie_aux_clk_src[] = {
 > +    F(2000000, P_XO, 12, 0, 0),
 > +    { }
 > +};
 > +
 > +static struct clk_rcg2 gcc_pcie_aux_clk_src = {
 > +    .cmd_rcgr = 0x28004,
 > +    .mnd_width = 16,
 > +    .hid_width = 5,
 > +    .parent_map = gcc_parent_map_6,
 > +    .freq_tbl = ftbl_gcc_pcie_aux_clk_src,
 > +    .clkr.hw.init = &(const struct clk_init_data){
 > +        .name = "gcc_pcie_aux_clk_src",
 > +        .parent_data = gcc_parent_data_6,
 > +        .num_parents = ARRAY_SIZE(gcc_parent_data_6),
 > +        .ops = &clk_rcg2_ops,
 > +    },
 > +};
 > +
 > +static struct clk_regmap_mux pcie3x2_pipe_clk_src = {
 > +    .reg = 0x28064,
 > +    .shift = 8,
 > +    .width = 2,
 > +    .parent_map = gcc_parent_map_14,
 > +    .clkr = {
 > +        .hw.init = &(struct clk_init_data){
 > +            .name = "pcie3x2_phy_pipe_clk_src",
 > +            .parent_data = gcc_parent_data_14,
 > +            .num_parents = ARRAY_SIZE(gcc_parent_data_14),
 > +            .ops = &clk_regmap_mux_closest_ops,

Should we use clk_regmap_phy_mux_ops here instead?

 > +            .flags = CLK_SET_RATE_PARENT,
 > +        },
 > +    },
 > +};
 > +
 > +static struct clk_regmap_mux pcie3x1_0_pipe_clk_src = {
 > +    .reg = 0x29064,
 > +    .shift = 8,
 > +    .width = 2,
 > +    .parent_map = gcc_parent_map_15,
 > +    .clkr = {
 > +        .hw.init = &(struct clk_init_data){
 > +            .name = "pcie3x1_0_phy_pipe_clk_src",
 > +            .parent_data = gcc_parent_data_15,
 > +            .num_parents = ARRAY_SIZE(gcc_parent_data_15),
 > +            .ops = &clk_regmap_mux_closest_ops,

And clk_regmap_phy_mux_ops here too?

 > +            .flags = CLK_SET_RATE_PARENT,
 > +        },
 > +    },
 > +};
 > +
 > +static struct clk_regmap_mux pcie3x1_1_pipe_clk_src = {
 > +    .reg = 0x2A064,
 > +    .shift = 8,
 > +    .width = 2,
 > +    .parent_map = gcc_parent_map_16,
 > +    .clkr = {
 > +        .hw.init = &(struct clk_init_data){
 > +            .name = "pcie3x1_1_phy_pipe_clk_src",
 > +            .parent_data = gcc_parent_data_16,
 > +            .num_parents = ARRAY_SIZE(gcc_parent_data_16),
 > +            .ops = &clk_regmap_mux_closest_ops,

And here?

 > +            .flags = CLK_SET_RATE_PARENT,
 > +        },
 > +    },
 > +};
 > +

[skipped]


 > +
 > +static struct clk_branch gcc_pcie3x1_0_pipe_clk = {
 > +    .halt_reg = 0x29068,
 > +    .halt_check = BRANCH_HALT_DELAY,
 > +    .clkr = {
 > +        .enable_reg = 0x29068,
 > +        .enable_mask = BIT(0),
 > +        .hw.init = &(const struct clk_init_data){
 > +            .name = "gcc_pcie3x1_0_pipe_clk",
 > +            .parent_names = (const char *[]){
 > +                "pcie3x1_0_pipe_clk_src"
 > +            },

Nooo. No parent_names please. You have several of them in the driver

 > +            .num_parents = 1,
 > +            .flags = CLK_SET_RATE_PARENT,
 > +            .ops = &clk_branch2_ops,
 > +        },
 > +    },
 > +};
 > +

-- 
With best wishes
Dmitry
