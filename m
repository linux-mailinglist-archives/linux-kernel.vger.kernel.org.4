Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF105682141
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjAaBGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAaBG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:06:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA02FCEE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:06:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w11so21866960lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7l9SfpsU7gPkD2ITWTtQ0PTwD1+ui4ywIU8ckmcnNYQ=;
        b=G4ZYGYfb42ToQSdD5S70cpmWxTnnP0JGiS7rGrmF2hWLBP2Cf3nUeTVleMm4iWxUI/
         9PTE8swSJ/ZiqtCAvutL6en8SQs91eHOTLn5n8E/PGR8OaeFXff47I6b4UqSMsWxJjlR
         LdHywOT/X0GB9q/KY/UorHnrak9rl3OR5v1f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l9SfpsU7gPkD2ITWTtQ0PTwD1+ui4ywIU8ckmcnNYQ=;
        b=jtKLxkisVapfkHoyaklaIfIO2TEC/b/KRzo/E26j8ze/rmV2TcBqybvf9XzNaq/C2X
         c9ruY82e0Zo4zVebj1cfhb4NCt+PNT6Pl+kYrhiuupd+s/Eq1Dx5DcMuPcX5DhDeHWtm
         o5QBGcMYJmkN0/H+10ZTG6cBDaOgYvuGC4PpixbD0QmdRrPvZsSqrb3NiCbUfJ4kdtmB
         601OCixgC2MjZjcfzKYwSVgJ+RcqLn1xsKeaoXZIKp8uA6dJICGX2LtepoNcoNxVm8lE
         gSEcpSXu59dupTlKXZNaZg3GG6Gh9x2NVTRmn2/EWNcAMenI9KlRCs3eeXp9aWviZYuR
         b4Og==
X-Gm-Message-State: AFqh2kqcq8Tx09FGLUR9FJjjUHhP2aNCPe9gt/fok5If19/S2EuJkw+j
        kf7KkfbN/bKcRNkD5Sz6KsAgGGjhaSoGmyTdgpPT6Q==
X-Google-Smtp-Source: AMrXdXuXVfXjLQDtXGqMHwkvKPdNqbnRS2N22JU8R0z13bN4i99gqOEAS/nqqyW9B93YQeVYUIb0AdBjd7734Tk63mM=
X-Received: by 2002:a05:6512:1284:b0:4d5:9957:541 with SMTP id
 u4-20020a056512128400b004d599570541mr5020000lfs.52.1675127185605; Mon, 30 Jan
 2023 17:06:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jan 2023 17:06:25 -0800
MIME-Version: 1.0
In-Reply-To: <1674728065-24955-7-git-send-email-quic_srivasam@quicinc.com>
References: <1674728065-24955-1-git-send-email-quic_srivasam@quicinc.com> <1674728065-24955-7-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 30 Jan 2023 17:06:25 -0800
Message-ID: <CAE-0n504ZhYcm73e1kxg0OnOKbUUaU46SKE8JMpwCd-WKh3mTg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] clk: qcom: lpassaudiocc-sc7280: Skip
 lpass_aon_cc_pll config
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-01-26 02:14:25)
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> index 8e2f433..1511337 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -847,7 +847,8 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
>                 goto exit;
>         }
>
> -       clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode"))


Please add a comment like

	/*
	 * ADSP firmware is in control of this PLL frequency when
	 * remoteproc is used. Skip frequency configuration in that
	 * case.
	 */

> +               clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
>
>         ret = qcom_cc_really_probe(pdev, &lpass_aon_cc_sc7280_desc, regmap);
>         if (ret) {
