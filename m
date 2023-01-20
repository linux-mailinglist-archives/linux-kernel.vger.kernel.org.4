Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD81C675FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjATV7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjATV72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:59:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7C518C8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:59:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mp20so17264769ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pgs07PyvKGpksByKsjTcCowCL5vvFmT3PIciH90Z4pw=;
        b=eCe81CaotE8487LI7h3iOTTOKUpUcN9XtqW0R8o/FODQE7Vtjzho8V2Smabu7KZsK5
         zGak5XpliKLCQLiGjO/MjdJ/G6SA7YaFAvb78Q/t2KYXAbahWabv58FleHHpSwCyY8f8
         flo7845GTH3md4yWcpVbDz6c4ufGOZ7K1O+ZqOXobq7hoy2He/o/LcqdZUe/w4e7KNPt
         mbwy0OKJN2v/TTXip1EdzRC0dB8ZMGIKk+QbJqZYXeRUKP3O0Cd1Ub0mzBL57X6udEqS
         fzGqre/RAntbnKiCiGoVj1t4rUsvSk/Lmv94Lh7+6Y6Ds6X6mknYjnf6NPRCDYJsCQOQ
         /VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgs07PyvKGpksByKsjTcCowCL5vvFmT3PIciH90Z4pw=;
        b=3Zk/FJNsy8I0HVBHH/jhkmKZZiAK4uc5H3QF7QQreDwgD8WSL6x5IuE91QQHpE+em0
         YYQ7VUWChODLieZhjH8jBWVc5y0KnCzjEel2kwa7ymn0NEfOHotj/S8nJffHKxKiupH0
         /K0SGzGrPZUGuxgrleJWIBwsAILkFtBA+MvDpr9nrRyzp4noulE10PxXJE2HeDnIDdei
         exo3wOKFkhrAOV4Rdh/39TYES1DJagPT/NcyEgouwwbZwS6LIuZbdws7oPvQryRsCR5E
         uBOcrIJO/+WsCcsMx1IefHWFxjIwbSPs531NzVw1sWnenPMlm2OVgHQ05EGZglL672At
         Bkyw==
X-Gm-Message-State: AFqh2kqNRUNxKhxKKf0zBr3gCDnTlGCamYSNr+xHjqRdLYEaXIBp4JMm
        cj6knmH9wYf+rdGBft5NqmHaLA==
X-Google-Smtp-Source: AMrXdXujuKX9GQSph4XmO5ic2WuK/rHBTeeAl+cwTJR3B0pg8Uv+i3g+jYyo+jTzU4z5DLTg15lZXQ==
X-Received: by 2002:a17:907:94ce:b0:870:ab89:3dd3 with SMTP id dn14-20020a17090794ce00b00870ab893dd3mr16676134ejc.70.1674251964209;
        Fri, 20 Jan 2023 13:59:24 -0800 (PST)
Received: from [192.168.1.101] (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007aee7ca1199sm18666132ejc.10.2023.01.20.13.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:59:23 -0800 (PST)
Message-ID: <bbcdfa45-64c8-72b8-e27c-bea924bf0398@linaro.org>
Date:   Fri, 20 Jan 2023 22:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link for
 clock controllers
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.01.2023 10:11, Dmitry Baryshkov wrote:
> Do not create device link for clock controllers. Some of the clocks
> provided to the device via OF can be the clocks that are just parents to
> the clocks provided by this clock controller. Clock subsystem already
> has support for handling missing clock parents correctly (clock
> orphans). Later when the parent clock is registered, clocks get
> populated properly.
> 
> An example of the system where this matters is the SDM8450 MTP board
> (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> dispcc itself provides clocks to both PHYs, to the PHY parent device,
> etc. With just dsi0_phy in place devlink is able to break the
> dependency, but with two PHYs, dispcc doesn't get probed at all, thus
> breaking display support.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215


Konrad
> 
> This patch has been posted a year ago in January 2022 ([1]). Since that time
> Saravana failed to produce patches to assist in debugging the issue
> ([2]) or to fix the issue ([3]). The issue we observe has been described
> by Abel at ([4]). As we work on adding support for Dual DSI
> configurations, the issue becomes more and more important, since binding
> the whole display subsystem fails.
> 
> Currently the qcom/sdm845-mtp board is already broken and I've just
> posted a patch adding Dual DSI variant for the qcom/sdm845-db845c board
> ([5]).
> 
> [1] https://lore.kernel.org/lkml/20211125183622.597177-1-dmitry.baryshkov@linaro.org/
> [2] https://lore.kernel.org/lkml/CAA8EJpqELXvRMPWJdTLCURjwkcMxyPDPj1tVZPkdOT_JVQb4-w@mail.gmail.com/
> [3] https://lore.kernel.org/all/CAGETcx8F0wP+RA0KpjOJeZfc=DVG-MbM_=SkRHD4UhD2ReL7Kw@mail.gmail.com/
> [4] https://lore.kernel.org/all/YrsdLQrOtg1qdaoE@linaro.org/
> [5] https://lore.kernel.org/all/20230118082048.2198715-1-dmitry.baryshkov@linaro.org/
> 
> ---
>  drivers/of/property.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 134cfc980b70..d323bf26a613 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1297,7 +1297,6 @@ struct supplier_bindings {
>  	bool node_not_dev;
>  };
>  
> -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
>  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
>  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> @@ -1327,6 +1326,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>  
> +static struct device_node *parse_clocks(struct device_node *np,
> +					const char *prop_name, int index)
> +{
> +	/*
> +	 * Do not create clock-related device links for clocks controllers,
> +	 * clock orphans will handle missing clock parents automatically.
> +	 */
> +	if (!strcmp(prop_name, "clocks") &&
> +	    of_find_property(np, "#clock-cells", NULL))
> +		return NULL;
> +
> +	return parse_prop_cells(np, prop_name, index, "clocks",
> +				       "#clock-cells");
> +}
> +
>  static struct device_node *parse_gpios(struct device_node *np,
>  				       const char *prop_name, int index)
>  {
