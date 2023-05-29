Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72B17151B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjE2WRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE2WRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:17:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB792DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:17:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af28a07be9so38566521fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685398635; x=1687990635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmFbsJmJz59jGjCT949YHD7+Zz7ERnx0QJrjFNPlUZA=;
        b=i5EvsBHz5G8JEAqPFcvFEELd9XeB5Ls2Eq+Z1f4yQWRFHexRenrld94y3lO5ZHhhKv
         cLV3M+JA9pnXjOl7w54K7CZaFifHmqrTz8U1ujltRcnfqsfQTMdZC0xBdNwXk3RDawzU
         a+jNh54XH9EhSii1rhcTFcM2oCq0WpENnmj4fnKZAI8XErV1Hafi9rNiiywyAf9tJJEL
         IRwxes/3cQgOKt5DdWZ86rOhWe3XtTwl1ez7YT1XCfygfSn8Wh4ev2iu4rpr10mOx4oh
         7abjw5DGXoOgh5aOi9CbmKbIvzOUq4g7bphmvSBIu/PAQC+rYJiTwssHckKYzI+h6xve
         kAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685398635; x=1687990635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmFbsJmJz59jGjCT949YHD7+Zz7ERnx0QJrjFNPlUZA=;
        b=hle7ltyuz24rJFZ9VNbTZowq/hhaEybZohlu7m3h4+szPm5L7usJlyIaM9QSCcxaBC
         kLVf1f6+rTcrgUGRCTI6TILrLvJSJfK+RISZIKiabValLio3uFT6gD3i+Am/y6QqfFnp
         DTsL51DnY0qrfDpfEuKqoLAXaYtkY2kkJEMEV73Gx2JYimzMrLY9wbWSYxORm01BP0c7
         IUS3kWWPSiueULtuBKmLjh0zuJGooK8b0HLApU4dfvVacxCVdVTisl+jYMyvpyxVsa5y
         9eGjM8NYrY1rBA/K/SPzIkWY0XOte2CfMmGfO9iiOFKwXY2PWlYZu3C6NOZvpWmzTlH4
         JKEQ==
X-Gm-Message-State: AC+VfDzmvyDDchKJ2dmlQAqkfWkN9nFuECq7r+bQD/zhloRX89CobY1Y
        EGQqcs5L4KIEdNkSkzi9TK7tww==
X-Google-Smtp-Source: ACHHUZ5x5sMBTtbzq3t8Wi/plEwrJ12amn05zxLWrBamdM2rk6uis4SaCwIJ3NKPC/344ExPs1lMyg==
X-Received: by 2002:a2e:8792:0:b0:2a8:bdd3:fcb5 with SMTP id n18-20020a2e8792000000b002a8bdd3fcb5mr4374054lji.39.1685398634976;
        Mon, 29 May 2023 15:17:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e94c2000000b002adc6c2cb3bsm2608036ljh.5.2023.05.29.15.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 15:17:14 -0700 (PDT)
Message-ID: <255ecc1c-d97a-71ad-62b4-de71fd44292f@linaro.org>
Date:   Tue, 30 May 2023 01:17:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony Xperia
 XZ3
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
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

On 30/05/2023 00:11, Marijn Suijten wrote:
> On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
> <snip>
>>> +	if (ctx->dsi->dsc) {
>>
>> dsi->dsc is always set, thus this condition can be dropped.
> 
> I want to leave room for possibly running the panel without DSC (at a
> lower resolution/refresh rate, or at higher power consumption if there
> is enough BW) by not assigning the pointer, if we get access to panel
> documentation: probably one of the magic commands sent in this driver
> controls it but we don't know which.
> 
>>> +		drm_dsc_pps_payload_pack(&pps, ctx->dsi->dsc);
>>> +
>>> +		ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
>>> +		if (ret < 0) {
>>> +			dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
>>> +			goto fail;
>>> +		}
>>> +		ret = mipi_dsi_compression_mode(ctx->dsi, true);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "failed to enable compression mode: %d\n", ret);
>>> +			goto fail;
>>> +		}
>>> +
>>> +		msleep(28);
>>> +	}
>>> +
>>> +	ctx->prepared = true;
>>> +	return 0;
>>> +
>>> +fail:
>>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>>> +	regulator_disable(ctx->vddio);
>>> +	return ret;
>>> +}
> <snip>
>>> +	/* This panel only supports DSC; unconditionally enable it */
> 
> On that note I should perhaps reword this.
> 
>>> +	dsi->dsc = dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), GFP_KERNEL);
>>
>> I think double assignments are frowned upon.
> 
> Ack.
> 
>>
>>> +	if (!dsc)
>>> +		return -ENOMEM;
>>> +
>>> +	dsc->dsc_version_major = 1;
>>> +	dsc->dsc_version_minor = 1;
>>> +
>>> +	dsc->slice_height = 32;
>>> +	dsc->slice_count = 2;
>>> +	// TODO: Get hdisplay from the mode
>>
>> Would you like to fix the TODO?
> 
> I can't unless either migrating to drm_bridge (is that doable?) or
> expand drm_panel.  That's a larger task, but I don't think this driver
> is the right place to track that desire.  Should I drop the comment
> entirely or reword it?

I'd say, reword it, so that it becomes more obvious why this TODO can 
not be fixed at this moment.

> 
>>> +	WARN_ON(1440 % dsc->slice_count);
>>> +	dsc->slice_width = 1440 / dsc->slice_count;
> 
> <snip>
> 
> - Marijn

-- 
With best wishes
Dmitry

