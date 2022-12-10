Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB306490B1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLJUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:52:53 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDB9591
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:52:49 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3e45d25de97so95974657b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvmi+e21rnUYDcPqPEGtPeb0mB+EMYrDiHDG509o8t0=;
        b=Smjt4z1iWBtjSDhxVUBVrdgEBiemFhe26IcMeNnJl3d4vzh7Jx/+JRWvO5Ppt3/39K
         jHNEsRvkHpUzz2ECW62wN24b4nYbgh9nnu1Tw/NdVJGW2DEeQVxAaX5clIydlksZaKnB
         W1xNrL9B87Oxa+AjuKGiuF4nL9oPt4BwQmmEKgkGNtzSqZdOhx3hAdrvxQkMvBiVxG31
         Euu0P5JHP23O4hkUZzhs6+KeXgogMgVaOhh3rivRF52PMU5ClAJTs2iBekQyZV1QXz/M
         zOLn9hc8CJO23+K32itqlHM0zD6UMINBrjfSDJyD/amH42XKkH2xRlQyrqqGXbQ+FOsJ
         P5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xvmi+e21rnUYDcPqPEGtPeb0mB+EMYrDiHDG509o8t0=;
        b=ODg8ONv2L+Q+7SCeBqYttMXhE1jSme0BeGKHF5ReKuWA7Y1NqaonnalmPyO9SBcTiL
         tBVfJH2Ic5PIYq/yclVP3wdDF7nVoGZb+z5yxc8NAGLeArH6gEABCTUscekYp175zb10
         YrQZkXZHATA4l62rbRVLBFANFZFt0MTtyFiIhwJiCWYAwA8vGmb9qnA5PXkKoFD/B7Ux
         PQn95mWET1k6o+F4rTF/zABcZBvHT89NpsHufJGUAUW6GsCN7yHTU9RB2HSiWmn6pbz/
         3dVJ+LsNAG9AAwOOggshQCyjP4KnUeG0JikZWcYWZmSJcx9RwTnlx6alP5N2RvNV4w81
         u5MA==
X-Gm-Message-State: ANoB5pmMDzSPtaDmVL3+6e7O/j/IRNOhD1lkRTOMQuBGMM1SuqOeGO7m
        +TFz57iJM+cqms3E+vi21we2DIX4F/nVOJK9pXLL+g==
X-Google-Smtp-Source: AA0mqf40HhdX+ecVqW2NUg2PGTBuW4p30UeBPrr+0tVf28XIWQvW8XXYMAxtH4mgaYfkIk29ZntupwKS9P9v8tzmyO0=
X-Received: by 2002:a81:520d:0:b0:3c0:c065:7608 with SMTP id
 g13-20020a81520d000000b003c0c0657608mr56545246ywb.378.1670705568483; Sat, 10
 Dec 2022 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20221210200353.418391-1-konrad.dybcio@linaro.org> <20221210200353.418391-3-konrad.dybcio@linaro.org>
In-Reply-To: <20221210200353.418391-3-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 10 Dec 2022 23:52:37 +0300
Message-ID: <CAA8EJppOWvk5YcNZy6qttfCX4eEiz3eENvnV2HMKecTZMLDhZw@mail.gmail.com>
Subject: Re: [PATCH 2/5] interconnect: qcom: msm8996: Provide UFS clocks to A2NoC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 at 23:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On eMMC devices the bootloader has no business enabling UFS clocks.
> That results in a platform hang and hard reboot when trying to vote
> on paths including MASTER_UFS and since sync_state guarantees that
> it's done at boot time, this effectively prevents such devices from
> booting. Fix that.

The vendor kernel separates bus clocks and QoS clocks, so there is
possibly room for improvement.

Anyway:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/msm8996.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index c2903ae3b3bc..7ddb1f23fb2a 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -33,6 +33,13 @@ static const char * const bus_a0noc_clocks[] = {
>         "aggre0_noc_mpu_cfg"
>  };
>
> +static const char * const bus_a2noc_clocks[] = {
> +       "bus",
> +       "bus_a",
> +       "aggre2_ufs_axi",
> +       "ufs_axi"
> +};
> +
>  static const u16 mas_a0noc_common_links[] = {
>         MSM8996_SLAVE_A0NOC_SNOC
>  };
> @@ -1859,6 +1866,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
>         .type = QCOM_ICC_NOC,
>         .nodes = a2noc_nodes,
>         .num_nodes = ARRAY_SIZE(a2noc_nodes),
> +       .clocks = bus_a2noc_clocks,
> +       .num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
>         .regmap_cfg = &msm8996_a2noc_regmap_config
>  };
>
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
