Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E510F666591
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjAKVYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjAKVYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:24:22 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CDA3F126
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:24:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bx6so17408602ljb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E3ouReEkUi6rpeaDUi73MWa8zDe8GfIZfYqDVIXiGL8=;
        b=n1B1osc8MSidHzm9DzPZDwklg/mTFKXmP7yRtNAjdNwX8cQ5ir/AdtR/oCEaTSe7hD
         MaYDksh6tMioZ2uNwNdl5KPR5jpaHMsJNkAFtmSE8LbnkX4ouQw7nkxTXW4ESTiKG/tY
         xRej9CC0YxSKJsvA2gXsdw6sfdbV2/rmtCH5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3ouReEkUi6rpeaDUi73MWa8zDe8GfIZfYqDVIXiGL8=;
        b=7wLtQ0T7sHzMYNfdYcchI6pA9LMiImmzrDviyqGKLR31D3LqZkfkzvieJlZKlLPLKk
         LGERo2X6Z10YCA3oVuiaahPj7l/GrS4D/NmbBi2yPeM64i3KdWGe8YCgCJwiTxcc7Kv5
         XM9f10IwSezNRupKTM/uLuGI21KPTOYFiQiJMsRLjtJK/x46wdMOLz4+y2ctniNb/exd
         xz9mlUGTbdzW6GwgHSNuNp9x+0e1E8ti33ZjfXWqofhNrbSEo3g6+sPuXsA/DTUoGb3e
         4FP60Do8/0hCjc7zPQKXpaAlSLxuq+Gjn3U0uMX0A09EYaRzG1IWQl91L6GX1tLU8p6H
         gQ5Q==
X-Gm-Message-State: AFqh2kqgnScxzlxeef86la4wYX43UDdM2oLqPQdacvyqxoRZB7L01rdm
        Zi74SjM+p8PYwH4weqWKFsKMrdW14QTNzvZp8aKF2TrSY8v7Fg==
X-Google-Smtp-Source: AMrXdXuMNICL9YpyiTa9tdbBFuIGRzDSVubjSkk9E9X3C1ZtxuNdgu97gzWZ8c+eZp/ov7qiTd7PqItMmYqyqc9bz7E=
X-Received: by 2002:a2e:2ac4:0:b0:27f:cc03:496a with SMTP id
 q187-20020a2e2ac4000000b0027fcc03496amr4183575ljq.359.1673472259758; Wed, 11
 Jan 2023 13:24:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jan 2023 13:24:19 -0800
MIME-Version: 1.0
In-Reply-To: <1672849297-3116-5-git-send-email-quic_srivasam@quicinc.com>
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com> <1672849297-3116-5-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 11 Jan 2023 13:24:19 -0800
Message-ID: <CAE-0n51AZCa9K_uY=ikTLqV-g_MsSA6Lv=Zq1LMrF-wVhR8_pg@mail.gmail.com>
Subject: Re: [RESEND v3 4/4] clk: qcom: lpasscc-sc7280: Add resets for audioreach
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-01-04 08:21:37)
> The clock gating control for TX/RX/WSA core bus clocks would be required
> to be reset(moved from hardware control) from audio core driver. Thus
> add the support for the reset clocks in audioreach based clock driver.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  drivers/clk/qcom/lpasscc-sc7280.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
> index 85dd5b9..1efb72d 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -12,10 +12,12 @@
>  #include <linux/regmap.h>
>
>  #include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>
>  #include "clk-regmap.h"
>  #include "clk-branch.h"
>  #include "common.h"
> +#include "reset.h"
>
>  static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>         .halt_reg = 0x0,
> @@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
>         .num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
>  };
>
> +static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
> +       [LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
> +       [LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
> +       [LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },

Why are we adding these resets again? These are already exposed in
lpassaudiocc-sc7280.c
