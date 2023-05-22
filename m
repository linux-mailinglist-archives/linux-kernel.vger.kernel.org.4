Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B875070C4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjEVSCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEVSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:02:33 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7717A94
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:02:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-563874afe98so45206357b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684778551; x=1687370551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aVJBY/8knzMSVZs/V5x+SxD32eOlg+FbYuKoI3xgu5k=;
        b=IiaPqvUFy2+EUG1ROFc6gGPSTDqB+lvZrShUlA59d6U8FYt/+HOiHCfnpsFiTIftXQ
         Q9A3skQlwcdqBzrTwhRn44a2nDlDjB9jJ6u1HC+0Pk7qB7QvsIrHsBbdrwAl1duQYAIa
         JrLcXjAnqtXAywZp5HTN/r7dIHpxCNjCw8it3mJLVin5F23vlrZEJ2GAu4NFDsDOWvbf
         g8gaI7XHdEoU1ykNMnNCx9ulX0ZzwIH/1S4kJtVRhbCqdz3fRU8+5FUsWVvXbJtAYv1m
         MAhsXR/xFUfYOPehmPurjRam44Lm7EnvxmMTVYFAfy7/st3Rt2r1SOZN442KnBYLIrrU
         38fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684778551; x=1687370551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVJBY/8knzMSVZs/V5x+SxD32eOlg+FbYuKoI3xgu5k=;
        b=SNZvn3XLYZOkef7G2qrbNzSyisy2mvkcriwBKzxQdHHh8VePSdPpIlYp5obvU+kK8s
         mxYPooK5zoy6wQVsnyu0YbrBd1PsD96dfNHKFgcz7qOu4mIWpeifuYlKWRrMl+fIbMn7
         DonUtl/KNbkdGigVm4ZDh3QA18pt8G4LtjUPNFipFMG2nVrJrKWwIbqjEsbUWl6lhazt
         IB2TJmMb9HWiWDXzSBhzRMGjZLlShph04Khnhn4na1qVNVS92M4/Pe9P2sTOJtQNTakx
         71E+o3hCEddPtqNM6EFRwtCGwtVz2NGyZeWwLnN06a2GSuaMMZnDIOKuogPVu/2nJTrf
         gfPA==
X-Gm-Message-State: AC+VfDz/jJR1/+U+po4lEHxazqJ3knSi3O8qCiKDQFXuMpT/vOMkr1Uv
        YA30MYYeCkxBSyTwFciM49ysKQWjYOsGjP0nx7RbnQ==
X-Google-Smtp-Source: ACHHUZ5A0/pll2fL/dhzKjSv92cbxqoh0Y0r8v4Nv91Amd9dUVpr+L1YyCF04nMS1kzjLTSw5bsXDQHt/W8MX/vU+kU=
X-Received: by 2002:a81:5289:0:b0:55a:4840:68d with SMTP id
 g131-20020a815289000000b0055a4840068dmr11841891ywb.20.1684778551387; Mon, 22
 May 2023 11:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230503130051.144708-1-y.oudjana@protonmail.com>
 <20230503130051.144708-4-y.oudjana@protonmail.com> <CAA8EJpokUqHRQz=RJnJpvFzCzz+=5TepPraQGvCvjqFL9+GX7w@mail.gmail.com>
 <5UM2VR.7LLGW1RDW4G2@gmail.com>
In-Reply-To: <5UM2VR.7LLGW1RDW4G2@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 22 May 2023 21:02:20 +0300
Message-ID: <CAA8EJpqh7Me9p1oPRZ88KQD4WRqYCswZ-2njYX6tTa6z0o6cGg@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/3] clk: qcom: cbf-msm8996: Add support for
 MSM8996 Pro
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 20:49, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
>
> On Wed, May 3 2023 at 04:20:00 PM +03:00:00, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> > On Wed, 3 May 2023 at 16:02, Yassine Oudjana
> > <yassine.oudjana@gmail.com> wrote:
> >>
> >>  From: Yassine Oudjana <y.oudjana@protonmail.com>
> >>
> >>  The CBF PLL on MSM8996 Pro has a /4 post divisor instead of /2.
> >> Handle the
> >>  difference accordingly.
> >>
> >>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> >>  ---
> >>   drivers/clk/qcom/clk-cbf-8996.c | 121
> >> ++++++++++++++++++++++++++++----
> >>   1 file changed, 106 insertions(+), 15 deletions(-)
> >>
> >>  diff --git a/drivers/clk/qcom/clk-cbf-8996.c
> >> b/drivers/clk/qcom/clk-cbf-8996.c
> >>  index 1bb2cd956d68..a3e96578ddd9 100644
> >>  --- a/drivers/clk/qcom/clk-cbf-8996.c
> >>  +++ b/drivers/clk/qcom/clk-cbf-8996.c
> >>  @@ -65,6 +65,19 @@ static const struct alpha_pll_config
> >> cbfpll_config = {
> >>          .early_output_mask = BIT(3),
> >>   };
> >>
> >>  +static const struct alpha_pll_config cbfpll_pro_config = {
> >>  +       .l = 72,
> >>  +       .config_ctl_val = 0x200d4828,
> >>  +       .config_ctl_hi_val = 0x006,
> >>  +       .test_ctl_val = 0x1c000000,
> >>  +       .test_ctl_hi_val = 0x00004000,
> >>  +       .pre_div_mask = BIT(12),
> >>  +       .post_div_mask = 0x3 << 8,
> >>  +       .post_div_val = 0x3 << 8,
> >>  +       .main_output_mask = BIT(0),
> >>  +       .early_output_mask = BIT(3),
> >>  +};
> >
> > Granted that the difference between this and the non-pro is just the
> > post_div_val, would it be easier to just patch it in the probe()?
>
> I wasn't sure if that approach would've been accepted since it relies
> on the special case that only one instance of the CBF device will exist
> in normal conditions, but if you say it's fine then sure, I can do that.

We do this for other clock controllers, which we know to be singleton.
So this should be fine too.

--
With best wishes
Dmitry
