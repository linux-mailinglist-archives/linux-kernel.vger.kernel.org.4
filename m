Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E384568213C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAaBEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAaBEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:04:34 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6242303D5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:04:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so21874792lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPb92qw4kjDeI3aHDlTv6TKpmyAS8e7ioXRB2XuSebc=;
        b=I+sKTBPtPSbTSA5QuDoUaZj1ts2qGmKV7O8pkD8QpD/QDp8qnGh/UhpMxXOJOqojoB
         bwSQYmi1mHm5pJ/K01yA3kyTQzW3gjlWuc14L+E/Tv33aPBTJe8MTNFGUXYcVFmDrjnG
         hTSxRVUo5jAlFe1UYfC+fI6LfOXK3mZfkf858=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPb92qw4kjDeI3aHDlTv6TKpmyAS8e7ioXRB2XuSebc=;
        b=XqwQDM+y9vfo9jgXvrLIuJFf1+Nnvgw/R5cgyVoNwR6dm+5PRJyF0QIc0SK57udUZv
         dB7qSowC3LuJiuSQ4Er+xbI+GLrjaphk+xi1JvgfR+w5LG1CbBVRJTyZ1qEXAFttEyW1
         CYf4k8H8yExUjDdeLjx0cMQH9G6WceaSkgps7aYNSe2FMRmHnJQKGg7EudOxkLw+mOLA
         fsTWxP27dccoscsvfRyA70VqAcdoxp1TCKkZEerQQ5vuifIp8prHKksmn1Z3KW1Ht0at
         CsZwpRi/P3A1d5BFBs09EjXbOqjF2IqL03xYA5+VJibaijEUnjyJ+DHkLoi3F9W4nQNe
         HQpw==
X-Gm-Message-State: AO0yUKVOc5OubfkDl/iWNVLvfh2O6/4e3qIlbWV3jEGyhxH4DEhAl1Os
        3POMNBcb8+MxfqAx6NDwQiO4+JpK0w0rAzNJsWZCyg==
X-Google-Smtp-Source: AK7set8liNys4c8rwIc7DLJ2bUrEfqy6w+R3DtR4hUj9/7iNbhNCYO2xfzLnEry5cRkOhnvPllU3+AX1icGV1L98C9U=
X-Received: by 2002:a05:6512:3b9c:b0:4d8:62ec:1ec0 with SMTP id
 g28-20020a0565123b9c00b004d862ec1ec0mr1144990lfv.247.1675127071026; Mon, 30
 Jan 2023 17:04:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jan 2023 17:04:30 -0800
MIME-Version: 1.0
In-Reply-To: <1674728065-24955-6-git-send-email-quic_srivasam@quicinc.com>
References: <1674728065-24955-1-git-send-email-quic_srivasam@quicinc.com> <1674728065-24955-6-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 30 Jan 2023 17:04:30 -0800
Message-ID: <CAE-0n50y4JEQqW2wgS_qoDkdrqP=bzpC6b_LpA6Q9P+jDc00ZQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into lpass_aon
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-01-26 02:14:24)
> Merge lpasscc clocks into lpass_aon clk_regmap structure as they
> are using same register space.
> Add conditional check for doing lpasscc clock registration only
> if regname specified in device tree node.
> In existing implementation, lpasscc clocks and lpass_aon clocks are
> being registered exclusively and overlapping if both of them are
> to be used.
> This is required to avoid such overlapping and to register
> lpasscc clocks and lpass_aon clocks simultaneously.

Can you describe the register ranges that are overlapping?

Here's what I see in DT right now:

                lpasscc: lpasscc@3000000 {
                        compatible = "qcom,sc7280-lpasscc";
                        reg = <0 0x03000000 0 0x40>,
                              <0 0x03c04000 0 0x4>;
                        ...
                };

                lpass_audiocc: clock-controller@3300000 {
                        compatible = "qcom,sc7280-lpassaudiocc";
                        reg = <0 0x03300000 0 0x30000>,
                              <0 0x032a9000 0 0x1000>;
                        ...
                };

                lpass_aon: clock-controller@3380000 {
                        compatible = "qcom,sc7280-lpassaoncc";
                        reg = <0 0x03380000 0 0x30000>;
                        ...
                };

                lpass_core: clock-controller@3900000 {
                        compatible = "qcom,sc7280-lpasscorecc";
                        reg = <0 0x03900000 0 0x50000>;
                        ...
                };

Presumably lpascc is really supposed to be a node named
'clock-controller' and is the node that is overlapping with lpass_aon?

>
> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  drivers/clk/qcom/lpassaudiocc-sc7280.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> index 1339f92..8e2f433 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -826,10 +829,12 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
>                 return ret;
>
>         if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
> -               lpass_audio_cc_sc7280_regmap_config.name = "cc";
> -               desc = &lpass_cc_sc7280_desc;
> -               ret = qcom_cc_probe(pdev, desc);
> -               goto exit;
> +               res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");

We shouldn't need to check for reg-name property. Instead, the index
should be the only thing that matters.

> +               if (res) {
> +                       lpass_audio_cc_sc7280_regmap_config.name = "cc";
> +                       desc = &lpass_cc_sc7280_desc;
