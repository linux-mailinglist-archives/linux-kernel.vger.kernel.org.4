Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36166F997B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjEGPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEGPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:45:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04872132A6
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:45:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso23952461fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683474347; x=1686066347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bThKD9Cm9LXr2YLDr552NMQqfympNUCu9WLX9HUvyQk=;
        b=v7PxAYn+0ucODB1TEfj8Pci5XyGXL0dKqIm831rWrZon6MH6JomhC2KCR5SMl/h+Bz
         jJPE+mWAucoR8sINAuL6Mx2DXl+mEi8GQtHg34f8wds+odvPy3G4sLXgBFawuTydUiiT
         rl3MG29NA8Gd17v8xr9MeCHGJ8GFf3n9OFwyXfxyqmbPrqou0VZ4hvvt+Jjd/tVqu56M
         9sgPTrjUS9wkJaHKACDQvLlDPR4GTNo9b7/PDX+VkSPG38xrqgflWKyoKXgmj2B25ywB
         9GlIun3cNw0UkcqyLNl8vP/+qmQfG3U0J7cVA/O1sn/7Yviu4xz24C5Felo0SO5nrrHK
         4u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474347; x=1686066347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bThKD9Cm9LXr2YLDr552NMQqfympNUCu9WLX9HUvyQk=;
        b=iXDgID1cpkNpAP1b1EeOvTlEqsAq+QEv0wittzKrUY0w1t0nynC2YlFo8phkkrUTIN
         0IsR/vZuh/gkGc3GAWRQ5/QaMoMCuKyV+cGZQT7Xz03oyXsyoYiYMFFEHUuI6tWk0A7o
         WxGdtqfk4D4UxMoaUSqHJnQqk5XS33PzREkqWZ05KBSr7d/VLTkudOW9+IYNcY7Ss+aa
         M0NPFy1fwrgMjHklfRAvWsRhzzVAtLgCMDGJ9DgH5dan5k8yi7alfiS8lEDCYUifAU0i
         5nqDitrVJOl77I/Bd8TOGf/1Pl1Q1Nxm+6B3JDbDi6JMUYhNkwEMZ5QPeNZw4E5mPR/C
         TGqA==
X-Gm-Message-State: AC+VfDyR90jf14XPaaCMXaA2ha5qpkqaileK8wXRL7bJEraM337HbVCj
        wL8xXcHFnDguUJas3SHeLEbMTA==
X-Google-Smtp-Source: ACHHUZ4j1Pp8oDApeXeiXwNMTOjH+yYPKR1JOrwncamH3Clz1z6+9Z1B9Z6Ci2O/BhqnlpkyYZ4Irw==
X-Received: by 2002:a2e:6e09:0:b0:2ac:7472:5486 with SMTP id j9-20020a2e6e09000000b002ac74725486mr1893287ljc.17.1683474347236;
        Sun, 07 May 2023 08:45:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l17-20020a05651c10d100b002ab0c9fab23sm845019ljn.79.2023.05.07.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 08:45:46 -0700 (PDT)
Message-ID: <56b464d2-082a-b8a6-860f-e58932a926c0@linaro.org>
Date:   Sun, 7 May 2023 18:45:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 2/5] iio: adc: qcom-spmi-adc5: Use driver
 datasheet_name instead of DT label
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
 <20230502-iio-adc-propagate-fw-node-label-v3-2-6be5db6e6b5a@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-2-6be5db6e6b5a@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 02:17, Marijn Suijten wrote:
> iio_chan_spec::datasheet_name expects a channel/pin name on the hardware
> part, i.e. from its datasheet, instead of a friendly name from DT which
> typically describes the use of said channel.  GPIO channels are commonly
> specialized in QCOM board DTS based on what a - typically thermistor -
> is connected to.
> 
> Also rename adc5_channel_prop::datasheet_name to channel_name to that
> effect.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

