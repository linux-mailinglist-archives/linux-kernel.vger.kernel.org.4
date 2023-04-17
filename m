Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104146E4FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDQSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:11:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C372B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:10:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8b8aea230so15001371fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681755050; x=1684347050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uqtAfQlYGu+vY2Plp4hxP/KFfqrrJzRhSyUGXHc1vs=;
        b=QdK0kQD+iSTNBhJLDqmF0w9Qdi1xrnAchVb/Fo8lTXhDrwmpcNo2+9/cCQ/gm8hbjx
         Lp2ON4MuBgKpTi052EOri08cGSE+7yHlf/KCzY+CNvLN5TMJYMyLZh45X7mMNH2WjObw
         dXXqhGZo32AdQKfyNR4rT/jMbYhUr05MRkmEL10Pl4vIvngsSR7tqX87Vi9TP0scqqsI
         CpmM/6R34Xxq8bI56KH4ydzxgyZrQQlnL/mCHtKiThMYzotI5iKFquESkD4BIv5w1Q5u
         nPkefT8whaHgjlezIS6V35f8dGCag8ArsPQw+lXJsiq3OPHkTLc0ANVv8zfOmfLNtxMB
         ppXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681755050; x=1684347050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uqtAfQlYGu+vY2Plp4hxP/KFfqrrJzRhSyUGXHc1vs=;
        b=cTA+IDUITLVdaP3x/i75DKIruY2vKM6DiXm6ZR5fCt4n28ftsmyz4vmDB+YcDMPH+o
         JG/vHAIdoJdyZl9rW/RHh0QvVy+PhrhjeDtts1nImpVqG9EEeJgOglnX9icqMR9RoTiD
         H8tqx4172O3kRQOQe3x6utI4B17FSZeYDDN5Ksby6Sx3yevH/O6nsmcfjvhrRR2Mird8
         O9dcDH0zVD/8y9uqf5FkHig2mtEHi9Lmtz1BRnEaFRQAbLgVXey6XvtzHoy2/FUuZ9++
         1qRWCk7vevVf0JAiNJ+4DqAT9EFsPEdsqLiBMGH4D25MFzGVe5PMd88VDTExGX7HDCKZ
         8f0Q==
X-Gm-Message-State: AAQBX9eC9efjyr6sxsuX71SnK1I3wV1oqVGqqede3vHiCvQlKvVIA6Pw
        UcC6WDnLC2xkZWooYhHlFpCbAA==
X-Google-Smtp-Source: AKy350YaPTMslaFvtrHA2Nfq2hFNykocPsuzJB0IVo7rkjUVCi3GtslMvx+lU2eO6rxt1C0Hal/g9Q==
X-Received: by 2002:a19:f60d:0:b0:4ec:8615:303e with SMTP id x13-20020a19f60d000000b004ec8615303emr2249053lfe.33.1681755050135;
        Mon, 17 Apr 2023 11:10:50 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id l20-20020a19c214000000b004ed149acc08sm1969009lfc.93.2023.04.17.11.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 11:10:49 -0700 (PDT)
Message-ID: <5cf16897-0670-78b9-a1c0-2f6ecb086987@linaro.org>
Date:   Mon, 17 Apr 2023 20:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] clk: qcom: Introduce SM8350 VIDEOCC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
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
 <34797b11-b654-a9a4-ac26-5287ca582a82@linaro.org>
 <CAA8EJppVUddvAp=3H7oGntE-5XqJkHc7=2mcgpBBnRcsHCDZQg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppVUddvAp=3H7oGntE-5XqJkHc7=2mcgpBBnRcsHCDZQg@mail.gmail.com>
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



On 14.04.2023 22:54, Dmitry Baryshkov wrote:
> On Fri, 14 Apr 2023 at 20:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 14.04.2023 18:31, Dmitry Baryshkov wrote:
>>> On Fri, 14 Apr 2023 at 14:26, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> Add support for the Video Clock Controller found on the SM8350 SoC.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>
>> [...]
>>
>>>> +static struct clk_rcg2 video_cc_ahb_clk_src = {
>>>> +       .cmd_rcgr = 0xbd4,
>>>> +       .mnd_width = 0,
>>>> +       .hid_width = 5,
>>>> +       .parent_map = video_cc_parent_map_0,
>>>> +       .freq_tbl = ftbl_video_cc_ahb_clk_src,
>>>> +       .clkr.hw.init = &(const struct clk_init_data) {
>>>> +               .name = "video_cc_ahb_clk_src",
>>>> +               .parent_data = video_cc_parent_data_0,
>>>> +               .num_parents = ARRAY_SIZE(video_cc_parent_data_0),
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +               .ops = &clk_rcg2_shared_ops,
>>>> +       },
>>>> +};
>>>
>>> Do we need this clock at all? We don't have the child
>>> video_cc_ahb_clk, so potentially CCF can try disabling or modifying
>>> this clock.
>> Hm.. I see a few things:
>>
>> 1. downstream kona has it, upstream does not
>> 2. it's shared so we never actually hard-shut it off..
>> 2a. ..but it'd be good to ensure it's on when it's ready..
>> 2b. ..but we never do anyway..
>> 2c. ..but should we even? doesn't Venus govern it internally?
>>
>>
>>>
>>>> +
>>>> +static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
>>>> +       F(720000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>>>> +       F(1014000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>>>> +       F(1098000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>>>> +       F(1332000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
>>>> +       { }
>>>> +};
>>>> +
>>
>> [...]
>>
>>>> +static struct clk_branch video_cc_mvs1_clk = {
>>>> +       .halt_reg = 0xdb4,
>>>> +       .halt_check = BRANCH_HALT_VOTED,
>>>
>>> As a note, sm8250 has BRANCH_HALT here.
>> No, it does on the div2 clk, and so do we:
> 
> Excuse me, I got confused by all the syllables. I was looking at the
> video_cc_mvs1c_clk. On sm8250 it is _VOTED, in this patch it is not. I
> can not say that either one of those is incorrect, but such a
> difference looks a bit suspicious for me. Maybe Tanya or somebody else
> can comment here.
I'd say this could be a design decision, with div2 clocks being
treated differently, but it's how downstream does it on shipping
devices and while generally it's not a great thing to say, it seems
to be the "right enough" thing..

> 
>> [...]
>>
>>>> +};
>>>> +
>>>> +static struct clk_branch video_cc_mvs1_div2_clk = {
>>>> +       .halt_reg = 0xdf4,
>>>> +       .halt_check = BRANCH_HALT_VOTED,
>>>> +       .hwcg_reg = 0xdf4,
>>
>> [...]
>>
>>>> +
>>>> +static const struct qcom_reset_map video_cc_sm8350_resets[] = {
>>>> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0xe54 },
>>>> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0xd14 },
>>>
>>> Would it be better to use common VIDEO_CC prefix here (IOW:
>>> VIDEO_CC_CVP_MVS0_BCR, VIDEO_CC_CVP_INTERFACE_BCR), etc.
>> My best guess would be that the ones prefixed with CVP_
>> are actual INTF/INSTANCEn(CORE) reset lines whereas
>> the ones containing _CLK_ reset their clock sub-branches.
> 
> Note, again, on sm8250 all resets start with VIDEO_CC, even CVP ones.
> I think we can follow that.
Or get rid of that, as it's always called with a phandle to videocc..

Thoughts?

> 
>>
>>>
>>>> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0xc34, 2 },
>>>> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0xbf4 },
>>>> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0xd94 },
>>>> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0xcd4, 2 },
>>>> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0xc94 },
>>>> +};
>>
>> [...]
>>
>>>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       regmap = qcom_cc_map(pdev, &video_cc_sm8350_desc);
>>>> +       if (IS_ERR(regmap)) {
>>>> +               pm_runtime_put(&pdev->dev);
>>>> +               return PTR_ERR(regmap);
>>>> +       };
>>>
>>> Extra semicolon
>> Ooeh!
>>
>>>
>>>> +
>>>> +       clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
>>>> +       clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
>>>> +
>>>> +       /*
>>>> +        * Keep clocks always enabled:
>>>> +        *      video_cc_ahb_clk
>>>> +        *      video_cc_xo_clk
>>>> +        */
>>>> +       regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
>>>> +       regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
>>>> +
>>>> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
>>>> +       pm_runtime_put(&pdev->dev);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops video_cc_sm8350_pm_ops = {
>>>> +       SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
>>>
>>> The driver doesn't use pm_clk at all. Are these PM_OPS correct?
>> I'm unsure. I see the pm state changing in debugfs when the clocks are
>> (not) consumed. But let's continue our discussion about using pm_clks
>> for AHB.
> 
> Well, those are two separate questions. One is that w/o additional
> pm_clk calls this string is useless (and should be removed). Another
> on is a possible restructure of our cc drivers to use pm_clk for AHB
> clocks (which would require adding more than that).
Right, I had an impression that you needed any sort of pm ops at
all to be registered with pm_genpd correctly, but that seems not to
be the case.. With that commented out, I still see "suspended" / "active"
and not "unsupported"..

Konrad
> 
> 
>>
>>>
>>>> +};
>>>> +
>>>> +static const struct of_device_id video_cc_sm8350_match_table[] = {
>>>> +       { .compatible = "qcom,sm8350-videocc" },
>>>> +       { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, video_cc_sm8350_match_table);
>>>> +
>>>> +static struct platform_driver video_cc_sm8350_driver = {
>>>> +       .probe = video_cc_sm8350_probe,
>>>> +       .driver = {
>>>> +               .name = "sm8350-videocc",
>>>> +               .of_match_table = video_cc_sm8350_match_table,
>>>> +               .pm = &video_cc_sm8350_pm_ops,
>>>> +       },
>>>> +};
>>>> +module_platform_driver(video_cc_sm8350_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("QTI SM8350 VIDEOCC Driver");
>>>> +MODULE_LICENSE("GPL");
>>>>
>>>> --
>>>> 2.40.0
>>>>
>>>
>>> Generic note: the register layout follows closely sm8250. However the
>>> existing differences probably do not warrant merging them.
>> No, I don't think merging any designs that are farther away
>> than 8150 and 8155 or 8992 and 8994 etc. is a good idea..
>>
>> I don't want to ever look at something like dispcc-sm8[123]50.c
>> again!
> 
> Me too!
> 
