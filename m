Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2D72BF11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjFLKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFLKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:31:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA3CFFC1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:12:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso4852754e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564672; x=1689156672;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UJOXI7NWxaGlAMXmYuetibwBgSH1F/dmnVvJT284BrM=;
        b=WZe3cOoRLmRd5WydZbwPgyMuPO30VOX9qXsySE8maXc1gouqxBABDP2sOV/d2FyRFM
         X0GeENm21I2E5TNVNmk/hVy7Jk+Sv61i52Yt3Wql8qq2snVh6cWPI1cFgfVXnlXmZvXr
         gCuwZTCpd1Fby6ed0i/qnrR7sLXL0w4go2eYxwTKkxB0lTI+JK7UukmethKN8btYDmab
         9lseNv/aotC5TkfgFvXIQPaOeeiql3iSzREx2+nzgmeUXxPmnbgImeUgpsuyiKMkIFPl
         IZ0dlZFMO1E9o0gapjr1imfykDVN5ZekM6PkCUrGGz8a+N++cV7S5+U3MsORp9h3BIHA
         2iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564672; x=1689156672;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJOXI7NWxaGlAMXmYuetibwBgSH1F/dmnVvJT284BrM=;
        b=ghP1NSOBwFiR3U5lTxP49qyroarIqLO/kLyhVcgcXU19dqfzwt6A2aw2Qpo90IInY5
         Xj+Q6wxKM9OnFWWOfMqqfMtYwF8B7PHupoOCTN79PiMjlN5Hb5Ls/7iCI4R+WX2CX2Gz
         3H16Rg7t0RsY3q6huLNmJcoAxGN1Wntr9Bul8nD0SbD7xpaH9509h5d6DBBXJ0xy1FeR
         45FI4hW7vwzFClitnlwiaP8iV3ZlcxZUkjOY0rJmFcwkI4vZL4pQtfsU6lVamG3rFgD7
         5GF/vXg+BFE83uqeZ+eAsMaE4KT2FEqaGRlJZpl9cpcqJ6HK0Je9I9nPD/l85JVy6Uxr
         XfQw==
X-Gm-Message-State: AC+VfDxPvbz+BqqGFFqArXsDQclMPljfZmp5k5yVd4/OqNJ5VwAfebBB
        7Yf2rOPFEs8IG92/Az2GzwjU8mmoASj9dXdFA4LxHg==
X-Google-Smtp-Source: ACHHUZ4uehM4jQ8rsUJZWcL5ncSWhd7m36oC/WdXiwDlPhdGAUTl4fXk3Aq4tkLkq9IE3ADNKvU8Jw==
X-Received: by 2002:a5d:6b43:0:b0:307:f75:f581 with SMTP id x3-20020a5d6b43000000b003070f75f581mr4652304wrw.18.1686564124203;
        Mon, 12 Jun 2023 03:02:04 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm12009223wrv.108.2023.06.12.03.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:02:03 -0700 (PDT)
Message-ID: <5cb3a029-2452-dbeb-691f-1c29ab7019bc@linaro.org>
Date:   Mon, 12 Jun 2023 12:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] usb: dwc3-meson-g12a: Fix an error handling path in
 dwc3_meson_g12a_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <9d28466de1808ccc756b4cc25fc72c482d133d13.1686403934.git.christophe.jaillet@wanadoo.fr>
Organization: Linaro Developer Services
In-Reply-To: <9d28466de1808ccc756b4cc25fc72c482d133d13.1686403934.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 15:32, Christophe JAILLET wrote:
> If dwc3_meson_g12a_otg_init() fails, resources allocated by the previous
> of_platform_populate() call should be released, as already done in the
> error handling path.
> 
> Fixes: 1e355f21d3fb ("usb: dwc3: Add Amlogic A1 DWC3 glue")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/usb/dwc3/dwc3-meson-g12a.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 365aec00d302..e99c7489dba0 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -796,7 +796,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>   
>   	ret = dwc3_meson_g12a_otg_init(pdev, priv);
>   	if (ret)
> -		goto err_phys_power;
> +		goto err_plat_depopulate;
>   
>   	pm_runtime_set_active(dev);
>   	pm_runtime_enable(dev);
> @@ -804,6 +804,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +err_plat_depopulate:
> +	of_platform_depopulate(dev);
> +
>   err_phys_power:
>   	for (i = 0 ; i < PHY_COUNT ; ++i)
>   		phy_power_off(priv->phys[i]);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
