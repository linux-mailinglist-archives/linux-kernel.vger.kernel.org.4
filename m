Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25F6E29A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjDNRsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:48:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622CAF01
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:48:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e11so24351353lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681494486; x=1684086486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8j1jr5BkH9v0KQPH+g+TSZh3RFTw5oSiPfNJDMkbUI=;
        b=eFVLbYGIciacDsJBsokCs+zDUEpRfZe/mbufuCA7rjpl8voW1F8fW+mDemas8NMbQB
         U+2rhs7A/DGfQBE+5bCXo9w4Vw3mKbqiSDg/qRSx/mZug/YPNnD/f0y3nrqYQJeKlT0R
         xnm8Ipc4zKrkWklZQeU6uIORyrZvw/hnq33b9gNN6dBUcq3bu/Z/fgt7hWFVhug2PYvH
         pSoAE+gz7Gky2f5sev3FQb32VcUO/8BmEcuzEAGMDCZCLe9nsvaNyW1jHuJo8T1ABF3K
         P5HMB5LD/D83HIzJY+7wSBCeDtS9pC54TsViwQSnjELHdeMy0zHq6oc8dfdTrp/DL2xr
         dR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681494486; x=1684086486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8j1jr5BkH9v0KQPH+g+TSZh3RFTw5oSiPfNJDMkbUI=;
        b=Jt8RuYnkkLm4BVRW4SeDfxctQjHUwMTxnOdcUNnYBIBt5hdf4bOeqc45PeOdYKulyg
         YCNrnjxlWjSLGzh0jueN32XDz9iiHmycX5N5lEVwYqznLig88DEon5uZukFSTS6CCz2q
         gPRmUN67e3B3pkbOkLumw9Dcu9PNUZOT6koTTw4IAI0NZt0MkFdudCFbDKuSqDeObQmx
         F6Ou7MLnsYfVJnF4aulDyH0p73v7FdBCIY56ny2J8cu1xkCsO2ThuiawfjE7iIQoDFJ1
         pzkESewy5vkC0CS1N9FnPdaIMXHRQIZCcq7MDX2xGjWbC+oNN7z+zlEAh0nXf5CYD3uj
         OcRQ==
X-Gm-Message-State: AAQBX9cm26Hg7Dcdh7PEh+NjGa8fGjzHzJ0OpWsZJMpbVXGGJWGY7p7E
        pykSewiZA5y/WISdESq1w6GYZA==
X-Google-Smtp-Source: AKy350Y8qOhfBv0DEfMa0AOWbSWbMI2Avxvvgkp83SOAZx+cTkGCMDntuL3v/WIQVj/hLPyMQFsvAw==
X-Received: by 2002:a19:ae17:0:b0:4ec:5607:9055 with SMTP id f23-20020a19ae17000000b004ec56079055mr1962569lfc.31.1681494486467;
        Fri, 14 Apr 2023 10:48:06 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id r13-20020ac252ad000000b004d5a6dcb94fsm901536lfm.33.2023.04.14.10.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 10:48:06 -0700 (PDT)
Message-ID: <34797b11-b654-a9a4-ac26-5287ca582a82@linaro.org>
Date:   Fri, 14 Apr 2023 19:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] clk: qcom: Introduce SM8350 VIDEOCC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org>
 <20230413-topic-lahaina_vidcc-v2-2-f721d507e555@linaro.org>
 <CAA8EJpoxvjWrvJENkFSimfU=CG7C3jZ=ToZep1tnJbtPzCcS9Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpoxvjWrvJENkFSimfU=CG7C3jZ=ToZep1tnJbtPzCcS9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.04.2023 18:31, Dmitry Baryshkov wrote:
> On Fri, 14 Apr 2023 at 14:26, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Add support for the Video Clock Controller found on the SM8350 SoC.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> +static struct clk_rcg2 video_cc_ahb_clk_src = {
>> +       .cmd_rcgr = 0xbd4,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = video_cc_parent_map_0,
>> +       .freq_tbl = ftbl_video_cc_ahb_clk_src,
>> +       .clkr.hw.init = &(const struct clk_init_data) {
>> +               .name = "video_cc_ahb_clk_src",
>> +               .parent_data = video_cc_parent_data_0,
>> +               .num_parents = ARRAY_SIZE(video_cc_parent_data_0),
>> +               .flags = CLK_SET_RATE_PARENT,
>> +               .ops = &clk_rcg2_shared_ops,
>> +       },
>> +};
> 
> Do we need this clock at all? We don't have the child
> video_cc_ahb_clk, so potentially CCF can try disabling or modifying
> this clock.
Hm.. I see a few things:

1. downstream kona has it, upstream does not
2. it's shared so we never actually hard-shut it off..
2a. ..but it'd be good to ensure it's on when it's ready..
2b. ..but we never do anyway..
2c. ..but should we even? doesn't Venus govern it internally?


> 
>> +
>> +static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
>> +       F(720000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>> +       F(1014000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>> +       F(1098000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>> +       F(1332000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>> +       { }
>> +};
>> +

[...]

>> +static struct clk_branch video_cc_mvs1_clk = {
>> +       .halt_reg = 0xdb4,
>> +       .halt_check = BRANCH_HALT_VOTED,
> 
> As a note, sm8250 has BRANCH_HALT here.
No, it does on the div2 clk, and so do we:
[...]

>> +};
>> +
>> +static struct clk_branch video_cc_mvs1_div2_clk = {
>> +       .halt_reg = 0xdf4,
>> +       .halt_check = BRANCH_HALT_VOTED,
>> +       .hwcg_reg = 0xdf4,

[...]

>> +
>> +static const struct qcom_reset_map video_cc_sm8350_resets[] = {
>> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0xe54 },
>> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0xd14 },
> 
> Would it be better to use common VIDEO_CC prefix here (IOW:
> VIDEO_CC_CVP_MVS0_BCR, VIDEO_CC_CVP_INTERFACE_BCR), etc.
My best guess would be that the ones prefixed with CVP_
are actual INTF/INSTANCEn(CORE) reset lines whereas
the ones containing _CLK_ reset their clock sub-branches.

> 
>> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0xc34, 2 },
>> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0xbf4 },
>> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0xd94 },
>> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0xcd4, 2 },
>> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0xc94 },
>> +};

[...]

>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       regmap = qcom_cc_map(pdev, &video_cc_sm8350_desc);
>> +       if (IS_ERR(regmap)) {
>> +               pm_runtime_put(&pdev->dev);
>> +               return PTR_ERR(regmap);
>> +       };
> 
> Extra semicolon
Ooeh!

> 
>> +
>> +       clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
>> +       clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
>> +
>> +       /*
>> +        * Keep clocks always enabled:
>> +        *      video_cc_ahb_clk
>> +        *      video_cc_xo_clk
>> +        */
>> +       regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
>> +       regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
>> +
>> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
>> +       pm_runtime_put(&pdev->dev);
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct dev_pm_ops video_cc_sm8350_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> 
> The driver doesn't use pm_clk at all. Are these PM_OPS correct?
I'm unsure. I see the pm state changing in debugfs when the clocks are
(not) consumed. But let's continue our discussion about using pm_clks
for AHB.

> 
>> +};
>> +
>> +static const struct of_device_id video_cc_sm8350_match_table[] = {
>> +       { .compatible = "qcom,sm8350-videocc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, video_cc_sm8350_match_table);
>> +
>> +static struct platform_driver video_cc_sm8350_driver = {
>> +       .probe = video_cc_sm8350_probe,
>> +       .driver = {
>> +               .name = "sm8350-videocc",
>> +               .of_match_table = video_cc_sm8350_match_table,
>> +               .pm = &video_cc_sm8350_pm_ops,
>> +       },
>> +};
>> +module_platform_driver(video_cc_sm8350_driver);
>> +
>> +MODULE_DESCRIPTION("QTI SM8350 VIDEOCC Driver");
>> +MODULE_LICENSE("GPL");
>>
>> --
>> 2.40.0
>>
> 
> Generic note: the register layout follows closely sm8250. However the
> existing differences probably do not warrant merging them.
No, I don't think merging any designs that are farther away
than 8150 and 8155 or 8992 and 8994 etc. is a good idea..

I don't want to ever look at something like dispcc-sm8[123]50.c
again!

Konrad
> 
