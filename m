Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A436E5058
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDQSlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:41:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0C446BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:41:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fc337a650so176695527b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681756891; x=1684348891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zh2NygFtkr3VUedMSETAcg+PkAMPbYO4qgRvEzIpFdA=;
        b=GGkR4g/uPZVqgebfVFZrVET/qxYmJ9p02R7SCDBUn2CObHnoLTJmwYYk6SYFZdRz9q
         xDN9bgfRttmR2K4LyLZcNcAGZ42DqgO5vye8FBXvwTE+gStEO/k3od+sgMQfpB3zvjbs
         6RSSQ6mj/IxXr9H2rDYIQpogoEbLYppiQWgngTNRa92HGLhMO07FW7r0lJdXpMmOCXum
         nZhDot+xgEjqhA+uK+zeKrt/f+pRG6ZqNtNRD9AeNwV645wF29Rqb1rWXi6ek3YTzHaE
         vKUO81VLqrb0I86Jr4EmHD3pne1XUyESmOSJhLlmWDJ8U67kdGl7oovlXzlwqg86Nefm
         74hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756891; x=1684348891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh2NygFtkr3VUedMSETAcg+PkAMPbYO4qgRvEzIpFdA=;
        b=YTCxRXZz2xxyyn8hpGDW9sPoKNBuC+XeLC6KffRK1fkOuGVYKuV/HGZyNGiYI4vC7S
         C+a8gALxNgmk7Lg5nrWfE14ONgN1+yIBcUaC+pL7nQjlk+Q15/7cmlibPBmx2y0YDXvd
         zSVLIFNxrAspGwpcKM/RO0cm38oIAMy4q+tMdkpwBCWWBhbvNMKTb0p2VczG6Mkn0BY1
         bGjmkGg9L47XKxM/peXEjE5g/bPD+ai5qLotIXqAaFvxQfaRfW4biJLQWFGZdf+1c4xz
         iq9yfkQe/iP5wWvidRH3cG9bhNTURXKkuGByR1+QXhnDFU3+ul/eu3TFYx0R+XDg4EQu
         dmqQ==
X-Gm-Message-State: AAQBX9dDH0MGYhBT9EGWNdrVXgudFBeMOMTzzk5C+FAP+jJmz/I0Pamh
        ONujHOaKRKq8w7jbp5qUr6g7Kqs4V5vIkWNjhm7/1g==
X-Google-Smtp-Source: AKy350Z6FWj4zKvPDAxvAHo/deDE8tFqv0ceNT9dCNYRALo/7GspKAKMsq1sb5MY9YeaPfrjuaaJaItelRDkE6wuACA=
X-Received: by 2002:a81:af62:0:b0:54c:bdc:ef18 with SMTP id
 x34-20020a81af62000000b0054c0bdcef18mr9977412ywj.5.1681756891046; Mon, 17 Apr
 2023 11:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org>
 <20230413-topic-lahaina_vidcc-v2-2-f721d507e555@linaro.org>
 <CAA8EJpoxvjWrvJENkFSimfU=CG7C3jZ=ToZep1tnJbtPzCcS9Q@mail.gmail.com>
 <34797b11-b654-a9a4-ac26-5287ca582a82@linaro.org> <CAA8EJppVUddvAp=3H7oGntE-5XqJkHc7=2mcgpBBnRcsHCDZQg@mail.gmail.com>
 <5cf16897-0670-78b9-a1c0-2f6ecb086987@linaro.org>
In-Reply-To: <5cf16897-0670-78b9-a1c0-2f6ecb086987@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 17 Apr 2023 21:41:19 +0300
Message-ID: <CAA8EJppW+QRq=uKQwCToMg8PmHmEgAz=bYg-_sD2UpfH_Li2RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: qcom: Introduce SM8350 VIDEOCC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 at 21:10, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 14.04.2023 22:54, Dmitry Baryshkov wrote:
> > On Fri, 14 Apr 2023 at 20:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 14.04.2023 18:31, Dmitry Baryshkov wrote:
> >>> On Fri, 14 Apr 2023 at 14:26, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>> Add support for the Video Clock Controller found on the SM8350 SoC.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>
> >> [...]
> >>
> >>>> +static struct clk_rcg2 video_cc_ahb_clk_src = {
> >>>> +       .cmd_rcgr = 0xbd4,
> >>>> +       .mnd_width = 0,
> >>>> +       .hid_width = 5,
> >>>> +       .parent_map = video_cc_parent_map_0,
> >>>> +       .freq_tbl = ftbl_video_cc_ahb_clk_src,
> >>>> +       .clkr.hw.init = &(const struct clk_init_data) {
> >>>> +               .name = "video_cc_ahb_clk_src",
> >>>> +               .parent_data = video_cc_parent_data_0,
> >>>> +               .num_parents = ARRAY_SIZE(video_cc_parent_data_0),
> >>>> +               .flags = CLK_SET_RATE_PARENT,
> >>>> +               .ops = &clk_rcg2_shared_ops,
> >>>> +       },
> >>>> +};
> >>>
> >>> Do we need this clock at all? We don't have the child
> >>> video_cc_ahb_clk, so potentially CCF can try disabling or modifying
> >>> this clock.
> >> Hm.. I see a few things:
> >>
> >> 1. downstream kona has it, upstream does not
> >> 2. it's shared so we never actually hard-shut it off..
> >> 2a. ..but it'd be good to ensure it's on when it's ready..
> >> 2b. ..but we never do anyway..
> >> 2c. ..but should we even? doesn't Venus govern it internally?
> >>
> >>
> >>>
> >>>> +
> >>>> +static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
> >>>> +       F(720000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> >>>> +       F(1014000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> >>>> +       F(1098000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> >>>> +       F(1332000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> >>>> +       { }
> >>>> +};
> >>>> +
> >>
> >> [...]
> >>
> >>>> +static struct clk_branch video_cc_mvs1_clk = {
> >>>> +       .halt_reg = 0xdb4,
> >>>> +       .halt_check = BRANCH_HALT_VOTED,
> >>>
> >>> As a note, sm8250 has BRANCH_HALT here.
> >> No, it does on the div2 clk, and so do we:
> >
> > Excuse me, I got confused by all the syllables. I was looking at the
> > video_cc_mvs1c_clk. On sm8250 it is _VOTED, in this patch it is not. I
> > can not say that either one of those is incorrect, but such a
> > difference looks a bit suspicious for me. Maybe Tanya or somebody else
> > can comment here.
> I'd say this could be a design decision, with div2 clocks being
> treated differently, but it's how downstream does it on shipping
> devices and while generally it's not a great thing to say, it seems
> to be the "right enough" thing..

Ack. Fair enough.

>
> >
> >> [...]
> >>
> >>>> +};
> >>>> +
> >>>> +static struct clk_branch video_cc_mvs1_div2_clk = {
> >>>> +       .halt_reg = 0xdf4,
> >>>> +       .halt_check = BRANCH_HALT_VOTED,
> >>>> +       .hwcg_reg = 0xdf4,
> >>
> >> [...]
> >>
> >>>> +
> >>>> +static const struct qcom_reset_map video_cc_sm8350_resets[] = {
> >>>> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0xe54 },
> >>>> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0xd14 },
> >>>
> >>> Would it be better to use common VIDEO_CC prefix here (IOW:
> >>> VIDEO_CC_CVP_MVS0_BCR, VIDEO_CC_CVP_INTERFACE_BCR), etc.
> >> My best guess would be that the ones prefixed with CVP_
> >> are actual INTF/INSTANCEn(CORE) reset lines whereas
> >> the ones containing _CLK_ reset their clock sub-branches.
> >
> > Note, again, on sm8250 all resets start with VIDEO_CC, even CVP ones.
> > I think we can follow that.
> Or get rid of that, as it's always called with a phandle to videocc..
>
> Thoughts?

I'd say, switch to VIDEO_CC prefix, please. We can not drop the
prefix, as we risc getting conflicts otherwise.

>
> >
> >>
> >>>
> >>>> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0xc34, 2 },
> >>>> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0xbf4 },
> >>>> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0xd94 },
> >>>> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0xcd4, 2 },
> >>>> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0xc94 },
> >>>> +};
> >>
> >> [...]
> >>
> >>>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>> +       regmap = qcom_cc_map(pdev, &video_cc_sm8350_desc);
> >>>> +       if (IS_ERR(regmap)) {
> >>>> +               pm_runtime_put(&pdev->dev);
> >>>> +               return PTR_ERR(regmap);
> >>>> +       };
> >>>
> >>> Extra semicolon
> >> Ooeh!
> >>
> >>>
> >>>> +
> >>>> +       clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
> >>>> +       clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
> >>>> +
> >>>> +       /*
> >>>> +        * Keep clocks always enabled:
> >>>> +        *      video_cc_ahb_clk
> >>>> +        *      video_cc_xo_clk
> >>>> +        */
> >>>> +       regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
> >>>> +       regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
> >>>> +
> >>>> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
> >>>> +       pm_runtime_put(&pdev->dev);
> >>>> +
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static const struct dev_pm_ops video_cc_sm8350_pm_ops = {
> >>>> +       SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> >>>
> >>> The driver doesn't use pm_clk at all. Are these PM_OPS correct?
> >> I'm unsure. I see the pm state changing in debugfs when the clocks are
> >> (not) consumed. But let's continue our discussion about using pm_clks
> >> for AHB.
> >
> > Well, those are two separate questions. One is that w/o additional
> > pm_clk calls this string is useless (and should be removed). Another
> > on is a possible restructure of our cc drivers to use pm_clk for AHB
> > clocks (which would require adding more than that).
> Right, I had an impression that you needed any sort of pm ops at
> all to be registered with pm_genpd correctly, but that seems not to
> be the case.. With that commented out, I still see "suspended" / "active"
> and not "unsupported"..

Let's just drop them for now.


>
> Konrad
> >
> >
> >>
> >>>
> >>>> +};
> >>>> +
> >>>> +static const struct of_device_id video_cc_sm8350_match_table[] = {
> >>>> +       { .compatible = "qcom,sm8350-videocc" },
> >>>> +       { }
> >>>> +};
> >>>> +MODULE_DEVICE_TABLE(of, video_cc_sm8350_match_table);
> >>>> +
> >>>> +static struct platform_driver video_cc_sm8350_driver = {
> >>>> +       .probe = video_cc_sm8350_probe,
> >>>> +       .driver = {
> >>>> +               .name = "sm8350-videocc",
> >>>> +               .of_match_table = video_cc_sm8350_match_table,
> >>>> +               .pm = &video_cc_sm8350_pm_ops,
> >>>> +       },
> >>>> +};
> >>>> +module_platform_driver(video_cc_sm8350_driver);
> >>>> +
> >>>> +MODULE_DESCRIPTION("QTI SM8350 VIDEOCC Driver");
> >>>> +MODULE_LICENSE("GPL");
> >>>>
> >>>> --
> >>>> 2.40.0
> >>>>
> >>>
> >>> Generic note: the register layout follows closely sm8250. However the
> >>> existing differences probably do not warrant merging them.
> >> No, I don't think merging any designs that are farther away
> >> than 8150 and 8155 or 8992 and 8994 etc. is a good idea..
> >>
> >> I don't want to ever look at something like dispcc-sm8[123]50.c
> >> again!
> >
> > Me too!
> >



-- 
With best wishes
Dmitry
