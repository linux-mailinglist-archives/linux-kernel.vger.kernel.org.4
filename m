Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E96FF040
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjEKKzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjEKKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:55:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B559E0;
        Thu, 11 May 2023 03:55:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9659f452148so1499533366b.1;
        Thu, 11 May 2023 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683802548; x=1686394548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81PfiIAOB6o7ocCEVHYOG4+GJvEfp09Ty/xcIjn/9Zc=;
        b=rcRGQfoS6CROG+cVqCV9G7zA5KbHmSg2RMJpn/phzdzapfNru0D74IxjbYDlMJs5ZV
         +EI3qqPNdBu0SiKMLDUyRykJvmxtfY2RXRwamHWS55D/CC9pvvIZ0PxTz6G3Hui7Gxu3
         AA2nw/n5HpGjnXXux9ILHlYRR8aK/5bAaV/kUWuyPLeVTIiDz/2jpzvxYMVWKPT6P6qa
         0/QvBBjQU5NzDyOW5Iy/qR6MeK72khRBCPJxe9KrZ/NeYMITl18W4Jk/FniQWchzq4Ml
         nU7ydGsW3GOF7QqiAPmoH+JegPp9Vnd93uLwjWPSbuIMz3h+/fZ4J4xfTdDKc1UCGPX4
         KCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802548; x=1686394548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81PfiIAOB6o7ocCEVHYOG4+GJvEfp09Ty/xcIjn/9Zc=;
        b=Q0VybAihUF6f63hrC8LekfCPK2KkPB39vxEGb0+gbSMYtOXRYPVCEdIib6nWrjDemV
         GiS7awVcwNN5bEZlUoyOVIP2x3UFvchiq+3MllAc8AvFxswosPA65iiNohUyrYnZb6yt
         hVfUEaD1CJZUkwLrnAQ5Pews2PePRbeEsBzhfMLEGqtqEy+V0vd3ZUssjoT8hImo1yeq
         gqT3kRzfFypqakBMbj0EZ2FhD+srCQo1evjK6PGNkyf/e4qTa5lOHD6GGqYFsgXY9bFr
         aD07ETCGTXdd9Bcuqotp0jr6khm8k/btQ6fbqH0UPs3tp0eGS8KV58ucI+tBoIJUrndy
         92iA==
X-Gm-Message-State: AC+VfDwq1SKGeVNQ5FJb5f85LwKTMCknLwTm5Y5LOncT7zUlk7BRzFbh
        ZWaPotYwea/2xsJngL+lDaQ=
X-Google-Smtp-Source: ACHHUZ6PhnfMnG0rhx0icLa3+l6/5s6aWS5R+dCEeAPXSEBdEycqJCXv5jeGQ2aDI6Yascq94U7G3g==
X-Received: by 2002:a17:906:dc93:b0:965:9602:1f07 with SMTP id cs19-20020a170906dc9300b0096596021f07mr20061808ejc.39.1683802547856;
        Thu, 11 May 2023 03:55:47 -0700 (PDT)
Received: from [192.168.3.32] (dh207-99-190.xnet.hr. [88.207.99.190])
        by smtp.gmail.com with ESMTPSA id gi31-20020a1709070c9f00b0095728081944sm3924919ejc.146.2023.05.11.03.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 03:55:47 -0700 (PDT)
Message-ID: <db104b16-2d28-7e09-e195-6de5e1653ce1@gmail.com>
Date:   Thu, 11 May 2023 12:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-3-quic_srichara@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230510134121.1232286-3-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
> +	F(143713, P_XO, 1, 1, 167),
> +	F(400000, P_XO, 1, 1, 60),
> +	F(24000000, P_XO, 1, 0, 0),
> +	F(48000000, P_GPLL2, 12, 1, 2),
> +	F(96000000, P_GPLL2, 12, 0, 0),
> +	F(177777778, P_GPLL0, 1, 2, 9),
> +	F(192000000, P_GPLL2, 6, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 sdcc1_apps_clk_src = {
> +	.cmd_rcgr = 0x42004,
> +	.freq_tbl = ftbl_sdcc1_apps_clk_src,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll2_gpll0_out_main_div2_map,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "sdcc1_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2_gpll0_out_main_div2),
> +		.ops = &clk_rcg2_ops,
Hi,
SDCC clocks should be using "clk_rcg2_floor_ops" to round down and avoid 
overclocking
the cards and kernel will warn about it:
[    1.016194] mmc0: Card appears overclocked; req 52000000 Hz, actual 
96000000 Hz
[    1.016278] mmc0: Card appears overclocked; req 52000000 Hz, actual 
96000000 Hz

Regards,
Robert

